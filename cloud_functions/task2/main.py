"""
Task 2: 資料處理 Cloud Function
"""

import logging
from datetime import datetime
from typing import Dict, Any
import functions_framework

# 設定日誌
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@functions_framework.http
def main_task(request) -> Dict[str, Any]:
    """
    Task 2 的主要入口點
    """
    try:
        logger.info("開始執行 Task 2")
        
        # Task 2 的業務邏輯
        result = {
            'task': 'task2',
            'message': 'Task 2 執行成功',
            'timestamp': datetime.now().isoformat(),
            'description': '這是第二個定時任務 - 資料處理'
        }
        
        logger.info("Task 2 執行完成")
        return result
        
    except Exception as e:
        logger.error(f"Task 2 執行失敗: {str(e)}")
        return {'error': str(e)}, 500 