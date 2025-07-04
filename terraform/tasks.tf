# 使用模組創建多個 Cloud Functions
module "task1" {
  source = "./modules/cloud-function"

  project_id                      = var.project_id
  region                          = var.region
  task_name                       = "task1"
  description                     = "Task 1: 定時執行的 Cloud Function"
  source_dir                      = "../cloud_functions/task1"
  entry_point                     = "main_task"
  cron_schedule                   = var.tasks.task1.cron_schedule
  environment_variables           = var.tasks.task1.environment_variables
  scheduler_service_account_email = google_service_account.shared_scheduler_sa.email

  depends_on = [google_project_service.required_apis]
}

module "task2" {
  source = "./modules/cloud-function"

  project_id                      = var.project_id
  region                          = var.region
  task_name                       = "task2"
  description                     = "Task 2: 資料處理 Cloud Function"
  source_dir                      = "../cloud_functions/task2"
  entry_point                     = "main_task"
  cron_schedule                   = var.tasks.task2.cron_schedule
  environment_variables           = var.tasks.task2.environment_variables
  scheduler_service_account_email = google_service_account.shared_scheduler_sa.email

  depends_on = [google_project_service.required_apis]
} 