# 🚀 Google Cloud Function 定時執行專案

這是一個使用 Terraform 部署 Google Cloud Functions 並設定定時執行的完整專案。專案包含兩個 Cloud Functions 任務，可以透過 Cloud Scheduler 進行定時執行。

## 📁 專案結構

```
cloud-function-cronjob/
├── .gitignore
├── Makefile
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── tasks.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── modules/
│       └── cloud-function/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
└── cloud_functions/
    ├── task1/
    │   ├── main.py
    │   └── requirements.txt
    └── task2/
        ├── main.py
        └── requirements.txt
```

### 🔧 根目錄檔案

- **`Makefile`**: 提供便捷的命令列介面，包含初始化、部署、清理等自動化腳本

#### 🏗️ Terraform 配置檔案

- **`main.tf`**: 定義專案的核心資源，如 Google Cloud 專案、API 啟用、服務帳戶等
- **`variables.tf`**: 宣告所有 Terraform 變數，定義變數類型、描述和預設值
- **`outputs.tf`**: 定義部署後要輸出的重要資訊，如函數 URL、服務帳戶郵件等
- **`tasks.tf`**: 專門配置 Cloud Functions 和 Cloud Scheduler 資源
- **`provider.tf`**: 設定 Google Cloud Provider 版本和認證方式
- **`terraform.tfvars`**: 設定變數的實際值，包含專案 ID、地區、函數名稱等

#### 🔄 Terraform 模組

- **`modules/cloud-function/`**: 可重複使用的 Cloud Function 模組
  - **`main.tf`**: 模組核心邏輯，定義 Cloud Function 資源
  - **`variables.tf`**: 模組輸入變數定義
  - **`outputs.tf`**: 模組輸出值定義

#### 📋 Cloud Functions 程式碼

- **`task1/`** 和 **`task2/`**: 兩個獨立的定時任務
  - **`main.py`**: Python 函數主程式，包含實際的業務邏輯
  - **`requirements.txt`**: 列出 Python 套件依賴，如 `google-cloud-storage`、`requests` 等
