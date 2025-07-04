# Cloud Function Module 輸出

output "function_name" {
  description = "Cloud Function 名稱"
  value       = google_cloudfunctions_function.function.name
}

output "function_url" {
  description = "Cloud Function HTTPS 觸發 URL"
  value       = google_cloudfunctions_function.function.https_trigger_url
}

output "scheduler_name" {
  description = "Cloud Scheduler Job 名稱"
  value       = google_cloud_scheduler_job.scheduler.name
} 