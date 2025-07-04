# Cloud Function Module
# 這個模組可以重複使用來創建多個 Cloud Functions

# 建立 Cloud Storage bucket 用於存放 Cloud Function 程式碼
resource "google_storage_bucket" "function_bucket" {
  name                        = "${var.project_id}-${var.task_name}-function-source"
  location                    = var.region
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}

# 壓縮 Cloud Function 程式碼到指定本地路徑
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/function-${var.task_name}.zip"
}

# 上傳壓縮後的程式碼到 Cloud Storage（Terraform 版的一定要使用 Bucket 來保存程式碼）
resource "google_storage_bucket_object" "function_code" {
  # 使用壓縮檔的 MD5 作為物件名稱，terraform 才能辨識是否需要重新上傳（因爲程式碼有變動時，MD5 會不同）
  name   = "function-${var.task_name}-${data.archive_file.function_zip.output_md5}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_zip.output_path
}

# 建立 Cloud Function
resource "google_cloudfunctions_function" "function" {
  name        = "${var.project_id}-${var.task_name}"
  description = var.description
  runtime     = var.runtime

  available_memory_mb   = var.memory_mb
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_code.name
  trigger_http          = true
  entry_point           = var.entry_point

  environment_variables = merge(var.environment_variables, {
    TASK_NAME = var.task_name
    ENVIRONMENT = var.environment
  })
}

# 只允許 Cloud Scheduler 的 service account 呼叫 Cloud Function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${var.scheduler_service_account_email}"
}

# Cloud Scheduler Job 設定
resource "google_cloud_scheduler_job" "scheduler" {
  name        = "${var.project_id}-${var.task_name}-scheduler"
  description = "定時觸發 ${var.task_name}"
  schedule    = var.cron_schedule

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.function.https_trigger_url

    headers = {
      "Content-Type" = "application/json"
    }

    body = base64encode(jsonencode({
      message   = "來自 Cloud Scheduler 的定時觸發",
      task      = var.task_name,
      timestamp = "{{.Timestamp}}"
    }))

    oidc_token {
      service_account_email = var.scheduler_service_account_email
    }
  }
} 