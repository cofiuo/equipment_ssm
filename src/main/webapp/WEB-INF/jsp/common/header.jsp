<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
      /* 导航栏样式（抽离到公共片段，避免重复） */
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      .nav-bar {
        display: flex;
        align-items: center;
        background-color: #333;
        padding: 12px 20px;
        color: white;
        font-family: "Microsoft YaHei", sans-serif;
      }

      .nav-item {
        margin: 0 15px;
        text-decoration: none;
        color: white;
        font-size: 14px;
      }

      .nav-title {
        font-size: 16px;
        font-weight: bold;
        margin-right: 20px;
      }

      .nav-divider {
        color: #999;
        margin: 0 10px;
      }

      .nav-user {
        margin-left: auto;
        color: #ccc;
      }

      .nav-logout {
        color: #ff6347;
        cursor: pointer;
      }

      .nav-item:hover {
        color: #4CAF50;
      }
    </style>

    <!-- 公共导航栏（仅登录后显示） -->
    <c:if test="${not empty loginUser}">
      <div class="nav-bar">
        <a class="nav-item nav-title" href="/index">实验室设备管理系统</a>
        <a class="nav-item" href="/equipment/list">设备列表</a>
        <a class="nav-item" href="/user/info">个人信息</a>
        <a class="nav-item" href="/user/borrowHistory">我的借用记录</a>

        <!-- 管理员专属导航 -->
        <c:if test="${loginUser.role == 'ADMIN'}">
          <a class="nav-item" href="/admin/equipment/manage">设备管理</a>
          <a class="nav-item" href="/admin/user/manage">用户管理</a>
          <a class="nav-item" href="/admin/borrow/list">全量借用记录</a>
        </c:if>

        <span class="nav-user">
          欢迎您：${loginUser.username}（${loginUser.role == 'ADMIN' ? '管理员' : '普通用户'}）
          <span class="nav-divider">|</span>
          <a class="nav-item nav-logout" href="/logout">退出登录</a>
        </span>
      </div>
    </c:if>