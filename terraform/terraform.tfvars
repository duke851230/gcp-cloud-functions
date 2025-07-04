# 您的 Google Cloud 專案 ID
project_id = "tagtoo-staging"

# 部署地區 (預設為台灣)
region = "asia-east1"

# 任務配置
tasks = {
  task1 = {
    description   = "定時執行的任務"
    cron_schedule = "*/1 * * * *"
    environment_variables = {
      TASK_TYPE = "scheduled"
    }
  }
  task2 = {
    description   = "資料處理任務"
    cron_schedule = "*/5 * * * *"
    environment_variables = {
      TASK_TYPE = "data_processing"
    }
  }
} 