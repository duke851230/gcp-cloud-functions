# 區域資訊
output "region" {
  description = "部署區域"
  value       = var.region
}

# 服務帳戶郵箱
output "scheduler_service_account_email" {
  description = "Cloud Scheduler 服務帳戶的郵箱"
  value       = google_service_account.shared_scheduler_sa.email
}

# Task 1 輸出
output "task1_function_name" {
  description = "Task 1 Cloud Function 名稱"
  value       = module.task1.function_name
}

output "task1_function_url" {
  description = "Task 1 Cloud Function HTTPS 觸發 URL"
  value       = module.task1.function_url
}

output "task1_scheduler_name" {
  description = "Task 1 Cloud Scheduler Job 名稱"
  value       = module.task1.scheduler_name
}

# Task 2 輸出
output "task2_function_name" {
  description = "Task 2 Cloud Function 名稱"
  value       = module.task2.function_name
}

output "task2_function_url" {
  description = "Task 2 Cloud Function HTTPS 觸發 URL"
  value       = module.task2.function_url
}

output "task2_scheduler_name" {
  description = "Task 2 Cloud Scheduler Job 名稱"
  value       = module.task2.scheduler_name
}

# 未來可以添加更多輸出
# output "task3_function_name" {
#   description = "Task 3 Cloud Function 名稱"
#   value       = module.task3.function_name
# } 