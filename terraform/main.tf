# 啟用必要的 API
resource "google_project_service" "required_apis" {
  for_each = toset([
    "cloudfunctions.googleapis.com",
    "cloudscheduler.googleapis.com",
    "cloudbuild.googleapis.com",
    "storage.googleapis.com"
  ])

  service                    = each.value
  disable_dependent_services = false
  disable_on_destroy         = false
}

# 獲取專案資訊
data "google_project" "project" {
  project_id = var.project_id
}

# 內建的 Cloud Scheduler 服務帳戶也需要 serviceAccountTokenCreator 權限
resource "google_project_iam_member" "cloud_scheduler_impersonate" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}

# 創建自定義的單一服務帳戶，供 Cloud Scheduler 使用
resource "google_service_account" "shared_scheduler_sa" {
  account_id   = "cloud-scheduler-shared-sa"
  display_name = "Cloud Scheduler Shared Service Account"
}

# 授予自定義帳戶 serviceAccountTokenCreator 權限
resource "google_project_iam_member" "shared_scheduler_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.shared_scheduler_sa.email}"
}
