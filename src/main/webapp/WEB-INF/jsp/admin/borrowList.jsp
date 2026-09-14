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
            margin-right: 5px;
          }

          .btn-primary {
            background-color: #4CAF50;
            color: white;
          }

          .btn-primary:hover {
            background-color: #45a049;
            box-shadow: 0 2px 8px rgba(76, 175, 80, 0.3);
          }

          .btn-danger {
            background-color: #f44336;
            color: white;
          }

          .btn-danger:hover {
            background-color: #da190b;
            box-shadow: 0 2px 8px rgba(244, 67, 54, 0.3);
          }

          /* 表格样式 */
          .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
          }

          .table th,
          .table td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
          }

          .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            text-transform: none;
          }

          .table tr:last-child td {
            border-bottom: none;
          }

          .table tr:hover {
            background-color: #f8f9fa;
          }

          /* 无数据提示 */
          .no-data {
            text-align: center;
            padding: 40px 20px;
            color: #999;
            font-size: 14px;
          }
        </style>

        <!-- 全量借出记录内容 -->
        <div class="container">
          <div class="card">
            <h3>全量借出记录（管理员）</h3>

            <table class="table">
              <tr>
                <th>记录ID</th>
                <th>用户名</th>
                <th>设备名称</th>
                <th>借出日期</th>
                <th>应还日期</th>
                <th>实际归还日期</th>
                <th>状态</th>
              </tr>
              <c:choose>
                <c:when test="${empty borrowList}">
                  <tr>
                    <td colspan="7" class="no-data">暂无借用记录</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach items="${borrowList}" var="borrow">
                    <tr>
                      <td>${borrow.id}</td>
                      <td>${borrow.username}</td>
                      <td>${borrow.equipmentTitle}</td>
                      <td>
                        <fmt:formatDate value="${borrow.borrowDate}" pattern="yyyy-MM-dd" />
                      </td>
                      <td>
                        <fmt:formatDate value="${borrow.dueDate}" pattern="yyyy-MM-dd" />
                      </td>
                      <td>
                        <c:if test="${not empty borrow.returnDate}">
                          <fmt:formatDate value="${borrow.returnDate}" pattern="yyyy-MM-dd" />
                        </c:if>
                        <c:if test="${empty borrow.returnDate}">--</c:if>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${borrow.status == 'PENDING'}">
                            <a href="/admin/borrow/approve?borrowId=${borrow.id}" class="btn btn-primary">通过</a>
                            <a href="/admin/borrow/reject?borrowId=${borrow.id}" class="btn btn-danger">拒绝</a>
                          </c:when>
                          <c:when test="${borrow.status == 'BORROWED'}">
                            <span style="color: orange;">已借出</span>
                          </c:when>
                          <c:when test="${borrow.status == 'RETURNED'}">
                            <span style="color: green;">已归还</span>
                          </c:when>
                          <c:when test="${borrow.status == 'REJECTED'}">
                            <span style="color: red;">已拒绝</span>
                          </c:when>
                        </c:choose>
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </table>
          </div>
        </div>