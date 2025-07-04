# Cloud Function Module 變數定義

variable "project_id" {
  description = "Google Cloud 專案 ID"
  type        = string
}

variable "region" {
  description = "Google Cloud 區域"
  type        = string
}

variable "task_name" {
  description = "任務名稱 (例如: task1, task2)"
  type        = string
}

variable "description" {
  description = "Cloud Function 描述"
  type        = string
}

variable "source_dir" {
  description = "Cloud Function 程式碼目錄路徑"
  type        = string
}

variable "entry_point" {
  description = "Cloud Function 入口點函數名稱"
  type        = string
  default     = "main_task"
}

variable "runtime" {
  description = "Cloud Function 執行環境"
  type        = string
  default     = "python39"
}

variable "memory_mb" {
  description = "Cloud Function 記憶體配置 (MB)"
  type        = number
  default     = 256
}

variable "environment" {
  description = "環境名稱"
  type        = string
  default     = "production"
}

variable "cron_schedule" {
  description = "Cron 排程設定"
  type        = string
}

variable "environment_variables" {
  description = "環境變數"
  type        = map(string)
  default     = {}
}

variable "scheduler_service_account_email" {
  description = "Cloud Scheduler 共享服務帳戶 Email"
  type        = string
} 