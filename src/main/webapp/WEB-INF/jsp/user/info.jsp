<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!-- 引入公共导航栏 -->
            <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

                <style>
                    /* 页面样式优化 */
                    body {
                        font-family: 'Microsoft YaHei', sans-serif;
                        background-color: #f8f9fa;
                        color: #333;
                    }

                    .container {
                        max-width: 800px;
                        margin: 0 auto;
                        padding: 30px 20px;
                    }

                    h3 {
                        color: #2c3e50;
                        margin-bottom: 25px;
                        font-size: 24px;
                        font-weight: 600;
                    }

                    /* 卡片样式 */
                    .card {
                        background: white;
                        border-radius: 8px;
                        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                        padding: 25px;
                        margin-bottom: 20px;
                    }

                    .card-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                        padding-bottom: 15px;
                        border-bottom: 1px solid #e0e0e0;
                    }

                    .card-title {
                        margin: 0;
                        font-size: 18px;
                        font-weight: 600;
                        color: #2c3e50;
                    }

                    /* 信息展示区域 */
                    .info-item {
                        display: flex;
                        margin-bottom: 15px;
                        padding: 10px 0;
                        border-bottom: 1px dashed #f0f0f0;
                    }

                    .info-label {
                        width: 120px;
                        font-weight: 600;
                        color: #5a6c7d;
                    }

                    .info-value {
                        flex: 1;
                        color: #333;
                    }

                    /* 按钮样式 */
                    .btn {
                        padding: 8px 20px;
                        border: none;
                        border-radius: 6px;
                        cursor: pointer;
                        font-size: 14px;
                        font-weight: 500;
                        transition: all 0.3s ease;
                        text-decoration: none;
                        display: inline-block;
                    }

                    .btn-primary {
                        background-color: #4CAF50;
                        color: white;
                    }

                    .btn-primary:hover {
                        background-color: #45a049;
                        box-shadow: 0 2px 8px rgba(76, 175, 80, 0.3);
                    }

                    .btn-secondary {
                        background-color: #2196F3;
                        color: white;
                    }

                    .btn-secondary:hover {
                        background-color: #1976D2;
                        box-shadow: 0 2px 8px rgba(33, 150, 243, 0.3);
                    }

                    /* 表单样式 */
                    .form-group {
                        margin-bottom: 20px;
                        display: flex;
                        align-items: center;
                    }

                    .form-group label {
                        width: 120px;
                        font-weight: 600;
                        color: #5a6c7d;
                    }

                    .form-control {
                        flex: 1;
                        padding: 10px 15px;
                        border: 2px solid #e0e0e0;
                        border-radius: 6px;
                        font-size: 14px;
                        transition: border-color 0.3s ease, box-shadow 0.3s ease;
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: #4CAF50;
                        box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
                    }

                    /* 操作区域 */
                    .action-buttons {
                        margin-top: 20px;
                        display: flex;
                        gap: 10px;
                    }

                    /* 提示信息 */
                    .alert {
                        padding: 12px 20px;
                        margin-bottom: 20px;
                        border-radius: 6px;
                        font-size: 14px;
                    }

                    .alert-success {
                        background-color: #d4edda;
                        color: #155724;
                        border: 1px solid #c3e6cb;
                    }

                    .alert-error {
                        background-color: #f8d7da;
                        color: #721c24;
                        border: 1px solid #f5c6cb;
                    }

                    /* 折叠面板 */
                    .collapse {
                        max-height: 0;
                        overflow: hidden;
                        transition: max-height 0.3s ease;
                    }

                    .collapse.show {
                        max-height: 500px;
                    }

                    /* 注册时间格式化 */
                    .date-format {
                        color: #666;
                        font-size: 14px;
                    }
                </style>

                <!-- 个人信息内容 -->
                <div class="container">
                    <h3>个人信息</h3>

                    <!-- 提示信息 -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">${error}</div>
                    </c:if>

                    <!-- 个人信息卡片 -->
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">基本信息</h4>
                            <button id="editBtn" class="btn btn-secondary">修改信息</button>
                        </div>

                        <!-- 信息展示区域 -->
                        <div id="infoDisplay">
                            <div class="info-item">
                                <span class="info-label">用户名：</span>
                                <span class="info-value">${user.username}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">用户ID：</span>
                                <span class="info-value">${user.id}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">角色：</span>
                                <span class="info-value">${user.role == 'ADMIN' ? '管理员' : '普通用户'}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">注册时间：</span>
                                <span class="info-value date-format">
                                    <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                </span>
                            </div>
                        </div>

                        <!-- 修改表单（默认隐藏） -->
                        <div id="editForm" class="collapse">
                            <form action="/user/update" method="post">
                                <div class="form-group">
                                    <label>用户名：</label>
                                    <input type="text" name="username" value="${user.username}" required
                                        class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>新密码：</label>
                                    <input type="password" name="password" placeholder="请输入新密码" class="form-control">
                                </div>
                                <div class="action-buttons">
                                    <button type="submit" class="btn btn-primary">保存修改</button>
                                    <button type="button" id="cancelBtn" class="btn btn-light">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script>
                    // 页面加载完成后执行
                    document.addEventListener('DOMContentLoaded', function () {
                        const editBtn = document.getElementById('editBtn');
                        const cancelBtn = document.getElementById('cancelBtn');
                        const editForm = document.getElementById('editForm');
                        const infoDisplay = document.getElementById('infoDisplay');

                        // 点击修改按钮，显示表单
                        function showEditForm() {
                            editForm.classList.add('show');
                            infoDisplay.style.display = 'none';
                            editBtn.textContent = '取消修改';

                            // 移除原事件监听，添加取消事件
                            editBtn.removeEventListener('click', showEditForm);
                            editBtn.addEventListener('click', hideEditForm);
                        }

                        // 隐藏表单，恢复信息显示
                        function hideEditForm() {
                            editForm.classList.remove('show');
                            infoDisplay.style.display = 'block';
                            editBtn.textContent = '修改信息';

                            // 移除取消事件，恢复原事件监听
                            editBtn.removeEventListener('click', hideEditForm);
                            editBtn.addEventListener('click', showEditForm);
                        }

                        // 初始绑定事件
                        editBtn.addEventListener('click', showEditForm);

                        // 点击取消按钮，隐藏表单
                        cancelBtn.addEventListener('click', hideEditForm);
                    });
                </script>