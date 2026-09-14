<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>登录 - 实验室设备管理系统</title>
            <style>
                /* 页面样式优化，与个人信息页面保持一致 */
                body {
                    font-family: 'Microsoft YaHei', sans-serif;
                    background-color: #f8f9fa;
                    color: #333;
                    margin: 0;
                    padding: 0;
                }

                .container {
                    max-width: 400px;
                    margin: 100px auto;
                    padding: 0 20px;
                }

                h3 {
                    color: #2c3e50;
                    margin-bottom: 25px;
                    font-size: 24px;
                    font-weight: 600;
                    text-align: center;
                }

                /* 卡片样式 */
                .card {
                    background: white;
                    border-radius: 8px;
                    box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                    padding: 25px;
                    margin-bottom: 20px;
                }

                /* 表单样式 */
                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    width: 100%;
                    font-weight: 600;
                    color: #5a6c7d;
                    margin-bottom: 8px;
                }

                .form-control {
                    width: 100%;
                    padding: 10px 15px;
                    border: 2px solid #e0e0e0;
                    border-radius: 6px;
                    font-size: 14px;
                    transition: border-color 0.3s ease, box-shadow 0.3s ease;
                    box-sizing: border-box;
                }

                .form-control:focus {
                    outline: none;
                    border-color: #4CAF50;
                    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
                }

                /* 按钮样式 */
                .btn {
                    padding: 10px 20px;
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
                    width: 100%;
                }

                .btn-primary:hover {
                    background-color: #45a049;
                    box-shadow: 0 2px 8px rgba(76, 175, 80, 0.3);
                }

                /* 提示信息 */
                .alert {
                    padding: 12px 20px;
                    margin-bottom: 20px;
                    border-radius: 6px;
                    font-size: 14px;
                }

                .alert-error {
                    background-color: #f8d7da;
                    color: #721c24;
                    border: 1px solid #f5c6cb;
                }

                /* 链接样式 */
                .link {
                    text-align: center;
                    font-size: 14px;
                    margin-top: 15px;
                }

                .link a {
                    color: #2196F3;
                    text-decoration: none;
                }

                .link a:hover {
                    text-decoration: underline;
                }
            </style>
            <script>
                window.onload = function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const success = urlParams.get('success');
                    if (success === '1') {
                        alert('信息更新成功，请重新登录');
                    }
                };
            </script>
        </head>

        <body>
            <div class="container">
                <div class="card">
                    <h3>实验室设备管理系统</h3>

                    <!-- 错误提示 -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">${error}</div>
                    </c:if>

                    <form action="/login" method="post">
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" name="username" required placeholder="请输入用户名" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>密码</label>
                            <input type="password" name="password" required placeholder="请输入密码" class="form-control">
                        </div>
                        <button type="submit" class="btn btn-primary">登录</button>
                        <div class="link">
                            还没有账号？<a href="/register">注册新用户</a>
                        </div>
                    </form>
                </div>
            </div>
        </body>

        </html>