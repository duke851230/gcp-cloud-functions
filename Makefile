# Google Cloud Function 定時執行 Terraform 專案 Makefile
# 使用方式: make <target>

# 顏色定義
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# Terraform 目錄
TF_DIR := terraform

# 預設目標
.DEFAULT_GOAL := help

# 初始化 Terraform
.PHONY: init
init: ## 初始化 Terraform
	@echo "$(BLUE)🚀 初始化 Terraform...$(NC)"
	cd $(TF_DIR) && terraform init

# 格式化 Terraform 檔案
.PHONY: fmt
fmt: ## 格式化 Terraform 檔案
	@echo "$(BLUE)📝 格式化 Terraform 檔案...$(NC)"
	cd $(TF_DIR) && terraform fmt

# 驗證 Terraform 配置
.PHONY: validate
validate: ## 驗證 Terraform 配置
	@echo "$(BLUE)✅ 驗證 Terraform 配置...$(NC)"
	cd $(TF_DIR) && terraform validate

# 顯示部署計畫
.PHONY: plan
plan: init fmt validate ## 顯示部署計畫
	@echo "$(BLUE)📋 顯示部署計畫...$(NC)"
	cd $(TF_DIR) && terraform plan

# 部署資源
.PHONY: deploy
deploy: init fmt validate ## 部署所有資源
	@echo "$(BLUE)🚀 開始部署...$(NC)"
	cd $(TF_DIR) && terraform apply -auto-approve
	@echo "$(GREEN)✅ 部署完成！$(NC)"

# 更新部署
.PHONY: update
update: ## 更新已部署的資源
	@echo "$(BLUE)🔄 更新部署...$(NC)"
	cd $(TF_DIR) && terraform apply -auto-approve
	@echo "$(GREEN)✅ 更新完成！$(NC)"

# 顯示 Terraform 狀態
.PHONY: status
status: ## 顯示 Terraform 狀態
	@echo "$(BLUE)📊 顯示 Terraform 狀態...$(NC)"
	cd $(TF_DIR) && terraform show

# 顯示輸出值
.PHONY: output
output: ## 顯示 Terraform 輸出值
	@echo "$(BLUE)📤 顯示輸出值...$(NC)"
	cd $(TF_DIR) && terraform output

# 清理資源並清理本地檔案
.PHONY: destroy-clean
destroy-clean: ## 刪除所有資源並清理本地檔案
	@echo "$(RED)⚠️  警告：此操作將刪除所有相關的 Google Cloud 資源和本地檔案！$(NC)"
	@bash -c 'read -p "確定要刪除所有資源並清理本地檔案嗎？(輸入 y 確認): " reply; \
	if [ "$$reply" != "y" ]; then \
		echo "$(YELLOW)操作已取消$(NC)"; \
		exit 1; \
	fi' || exit 1
	@echo "$(BLUE)🧹 開始清理資源...$(NC)"
	cd $(TF_DIR) && terraform destroy -auto-approve
	@echo "$(BLUE) 清理本地檔案...$(NC)"
	rm -rf $(TF_DIR)/.terraform
	rm -f $(TF_DIR)/*.tfstate*
	rm -f $(TF_DIR)/.terraform.lock.hcl
	rm -f $(TF_DIR)/modules/cloud-function/*.zip
	@echo "$(GREEN)✅ 資源和本地檔案清理完成！$(NC)"

# 顯示幫助
.PHONY: help
help: ## 顯示此幫助訊息
	@echo "$(BLUE)Google Cloud Function 定時執行 Terraform 專案$(NC)"
	@echo
	@echo "$(GREEN)可用的命令:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo
	@echo "$(GREEN)範例:$(NC)"
	@echo "  make deploy     # 部署所有資源"
	@echo "  make output     # 查看輸出值"
	@echo "  make destroy    # 刪除所有資源"

# 生產環境相關命令
.PHONY: prod-deploy
prod-deploy: init fmt validate ## 生產環境部署
	@echo "$(RED)🚨 生產環境部署$(NC)"
	@echo "$(YELLOW)請確認以下事項:$(NC)"
	@echo "  1. 專案 ID 正確"
	@echo "  2. 地區設定正確"
	@echo "  3. 排程設定正確"
	@echo "  4. 環境變數設定正確"
	@echo
	@read -p "確認所有設定正確嗎？(y/N): " -n 1 -r; \
	if [[ ! $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "$(YELLOW)部署已取消$(NC)"; \
		exit 0; \
	fi
	@echo
	cd $(TF_DIR) && terraform apply -auto-approve
	@echo "$(GREEN)✅ 生產環境部署完成！$(NC)" 