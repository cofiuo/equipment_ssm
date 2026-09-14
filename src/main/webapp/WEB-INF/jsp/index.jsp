<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- 引入公共导航栏 -->
    <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

      <style>
        /* 简单的UI优化 */
        .main-content {
          width: 1200px;
          margin: 0 auto;
          padding: 30px 20px;
          font-family: 'Microsoft YaHei', sans-serif;
        }

        .welcome-card {
          background-color: #f9f9f9;
          border-radius: 8px;
          padding: 30px;
          border: 1px solid #e0e0e0;
        }

        .welcome-title {
          color: #2c3e50;
          margin: 0 0 20px 0;
          font-size: 26px;
        }

        .welcome-text {
          color: #666;
          line-height: 1.8;
          font-size: 16px;
        }

        .admin-text {
          color: #3498db;
          font-weight: bold;
        }

        .user-text {
          color: #27ae60;
          font-weight: bold;
        }
      </style>

      <!-- 首页内容区域 -->
      <div class="main-content">
        <div class="welcome-card">
          <h2 class="welcome-title">欢迎使用实验室设备管理系统</h2>
          <p class="welcome-text">
            <c:if test="${loginUser.role == 'ADMIN'}">
              <span class="admin-text">您当前为管理员权限</span>，可进行设备的增删改查和全量借出记录查看操作。
            </c:if>
            <c:if test="${loginUser.role != 'ADMIN'}">
              <span class="user-text">您当前为普通用户权限</span>，可查看/借出设备、管理个人借出记录。
            </c:if>
          </p>
        </div>
      </div>