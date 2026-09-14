<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!-- 引入公共导航栏 -->
            <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

                <style>
                    /* 页面样式优化，与设备管理页面保持一致 */
                    body {
                        font-family: 'Microsoft YaHei', sans-serif;
                        background-color: #f8f9fa;
                        color: #333;
                        margin: 0;
                        padding: 0;
                    }

                    .container {
                        max-width: 1200px;
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

                    /* 按钮样式 */
                    .btn {
                        padding: 8px 16px;
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
                        transform: translateY(-1px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
                    }

                    .btn-warning {
                        background-color: #ff9800;
                        color: white;
                    }

                    .btn-warning:hover {
                        background-color: #f57c00;
                        transform: translateY(-1px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
                    }

                    .btn-danger {
                        background-color: #f44336;
                        color: white;
                    }

                    .btn-danger:hover {
                        background-color: #da190b;
                        transform: translateY(-1px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
                    }

                    .btn-light {
                        background-color: #f1f1f1;
                        color: #333;
                    }

                    .btn-light:hover {
                        background-color: #e0e0e0;
                        transform: translateY(-1px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
                    }

                    /* 表格样式 */
                    .table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                    }

                    .table th,
                    .table td {
                        padding: 12px 15px;
                        text-align: left;
                        border-bottom: 1px solid #e0e0e0;
                    }

                    .table th {
                        background-color: #f8f9fa;
                        font-weight: 600;
                        color: #5a6c7d;
                        font-size: 14px;
                    }

                    .table tr:hover {
                        background-color: #f5f5f5;
                    }

                    /* 模态框样式 */
                    .modal {
                        display: none;
                        position: fixed;
                        z-index: 1000;
                        left: 0;
                        top: 0;
                        width: 100%;
                        height: 100%;
                        background-color: rgba(0, 0, 0, 0.5);
                        animation: fadeIn 0.3s ease;
                    }

                    .modal.show {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .modal-content {
                        background-color: white;
                        border-radius: 8px;
                        width: 90%;
                        max-width: 500px;
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
                        transform: translateY(-20px);
                        opacity: 0;
                        animation: slideUp 0.3s ease forwards;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                        }

                        to {
                            opacity: 1;
                        }
                    }

                    @keyframes slideUp {
                        to {
                            transform: translateY(0);
                            opacity: 1;
                        }
                    }

                    .modal-header {
                        padding: 15px 20px;
                        background-color: #2c3e50;
                        color: white;
                        border-radius: 8px 8px 0 0;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .modal-title {
                        margin: 0;
                        font-size: 18px;
                        font-weight: 600;
                    }

                    .close {
                        background: none;
                        border: none;
                        font-size: 24px;
                        color: white;
                        cursor: pointer;
                        opacity: 0.8;
                        transition: opacity 0.3s ease;
                    }

                    .close:hover {
                        opacity: 1;
                    }

                    .modal-body {
                        padding: 20px;
                    }

                    /* 表单样式 */
                    .form-group {
                        margin-bottom: 15px;
                        display: flex;
                        align-items: center;
                    }

                    .form-group label {
                        width: 100px;
                        font-weight: 600;
                        color: #5a6c7d;
                    }

                    .form-control {
                        flex: 1;
                        padding: 8px 12px;
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

                    /* 表单操作按钮 */
                    .form-actions {
                        margin-left: 100px;
                        display: flex;
                        gap: 10px;
                        margin-top: 20px;
                    }

                    /* 无数据提示 */
                    .no-data {
                        text-align: center;
                        padding: 40px 20px;
                        color: #999;
                        font-size: 14px;
                    }
                </style>

                <!-- 用户管理内容 -->
                <div class="container">
                    <div class="card">
                        <h3>用户管理（管理员）</h3>

                        <!-- 错误信息显示 -->
                        <c:if test="${not empty error}">
                            <div
                                style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 20px;">
                                ${error}
                            </div>
                        </c:if>

                        <!-- 添加用户按钮 -->
                        <button id="addUserBtn" class="btn btn-primary" style="margin-bottom: 20px;">
                            添加用户
                        </button>

                        <!-- 用户列表 -->
                        <table class="table">
                            <tr>
                                <th>ID</th>
                                <th>用户名</th>
                                <th>角色</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            <c:if test="${empty userList}">
                                <tr>
                                    <td colspan="5" class="no-data">暂无用户数据</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${userList}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.username}</td>
                                    <td>${user.role == 'ADMIN' ? '管理员' : '普通用户'}</td>
                                    <td>
                                        <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                    </td>
                                    <td>
                                        <button class="btn btn-warning btn-sm"
                                            onclick="editUser(${user.id}, '${user.username}', '${user.role}')">编辑</button>
                                        <a href="/admin/user/borrowHistory?id=${user.id}"
                                            class="btn btn-primary btn-sm">查看借用记录</a>
                                        <a href="/admin/user/delete?id=${user.id}" class="btn btn-danger btn-sm"
                                            onclick="return confirm('确定要删除该用户吗？')">删除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>

                <!-- 添加用户模态框 -->
                <div id="addUserModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">添加用户</h5>
                            <button type="button" class="close" id="closeAddModalBtn">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="/admin/user/add" method="post">
                                <div class="form-group">
                                    <label>用户名：</label>
                                    <input type="text" name="username" required class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>密码：</label>
                                    <input type="password" name="password" required class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>角色：</label>
                                    <select name="role" class="form-control">
                                        <option value="USER">普通用户</option>
                                        <option value="ADMIN">管理员</option>
                                    </select>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">添加</button>
                                    <button type="button" id="cancelAddModalBtn" class="btn btn-light">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- 编辑用户模态框 -->
                <div id="editUserModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">编辑用户</h5>
                            <button type="button" class="close" id="closeEditModalBtn">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="/admin/user/update" method="post">
                                <input type="hidden" name="id" id="editUserId">
                                <div class="form-group">
                                    <label>用户名：</label>
                                    <input type="text" name="username" id="editUsername" required class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>密码：</label>
                                    <input type="password" name="password" id="editPassword" required
                                        class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>角色：</label>
                                    <select name="role" id="editRole" class="form-control">
                                        <option value="USER">普通用户</option>
                                        <option value="ADMIN">管理员</option>
                                    </select>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">修改</button>
                                    <button type="button" id="cancelEditModalBtn" class="btn btn-light">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script>
                    // 添加用户模态框交互
                    document.addEventListener('DOMContentLoaded', function () {
                        // 添加用户相关元素
                        const addUserBtn = document.getElementById('addUserBtn');
                        const addUserModal = document.getElementById('addUserModal');
                        const closeAddModalBtn = document.getElementById('closeAddModalBtn');
                        const cancelAddModalBtn = document.getElementById('cancelAddModalBtn');

                        // 显示添加用户模态框
                        addUserBtn.addEventListener('click', function () {
                            addUserModal.classList.add('show');
                        });

                        // 关闭添加用户模态框
                        function closeAddModal() {
                            addUserModal.classList.remove('show');
                        }

                        closeAddModalBtn.addEventListener('click', closeAddModal);
                        cancelAddModalBtn.addEventListener('click', closeAddModal);
                        window.addEventListener('click', function (e) {
                            if (e.target === addUserModal) {
                                closeAddModal();
                            }
                        });

                        // 编辑用户相关元素
                        const editUserModal = document.getElementById('editUserModal');
                        const closeEditModalBtn = document.getElementById('closeEditModalBtn');
                        const cancelEditModalBtn = document.getElementById('cancelEditModalBtn');

                        // 关闭编辑用户模态框
                        function closeEditModal() {
                            editUserModal.classList.remove('show');
                        }

                        closeEditModalBtn.addEventListener('click', closeEditModal);
                        cancelEditModalBtn.addEventListener('click', closeEditModal);
                        window.addEventListener('click', function (e) {
                            if (e.target === editUserModal) {
                                closeEditModal();
                            }
                        });
                    });

                    // 编辑用户函数
                    function editUser(id, username, role) {
                        // 设置表单值
                        document.getElementById('editUserId').value = id;
                        document.getElementById('editUsername').value = username;
                        document.getElementById('editPassword').value = '';
                        document.getElementById('editRole').value = role;

                        // 显示编辑模态框
                        document.getElementById('editUserModal').classList.add('show');
                    }
                </script>