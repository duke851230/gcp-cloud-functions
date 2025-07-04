"""
Task 1: 定時執行的 Cloud Function
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
    Task 1 的主要入口點
    """
    try:
        logger.info("開始執行 Task 1")
        
        # Task 1 的業務邏輯
        result = {
            'task': 'task1',
            'message': 'Task 1 執行成功',
            'timestamp': datetime.now().isoformat(),
            'description': '這是第一個定時任務測試'
        }
        
        logger.info("Task 1 執行完成")
        return result
        
    except Exception as e:
        logger.error(f"Task 1 執行失敗: {str(e)}")
        return {'error': str(e)}, 500 