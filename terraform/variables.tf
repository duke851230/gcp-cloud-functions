# 專案 ID
variable "project_id" {
  description = "Google Cloud 專案 ID"
  type        = string
}

# 地區
variable "region" {
  description = "Google Cloud 區域"
  type        = string
  default     = "asia-east1"
}

# 任務配置
variable "tasks" {
  description = "定義多個 Cloud Functions 任務"
  type = map(object({
    description           = string
    cron_schedule         = string
    environment_variables = map(string)
  }))
} 