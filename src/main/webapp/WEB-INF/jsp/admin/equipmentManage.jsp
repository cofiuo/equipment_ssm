<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- 引入公共导航栏 -->
    <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

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

          .btn-danger {
              background-color: #f44336;
              color: white;
          }

          .btn-danger:hover {
              background-color: #da190b;
              box-shadow: 0 2px 8px rgba(244, 67, 54, 0.3);
          }

          .btn-light {
              background-color: #f8f9fa;
              color: #2c3e50;
              border: 1px solid #e0e0e0;
          }

          .btn-light:hover {
              background-color: #e9ecef;
              box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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

          .modal-content {
              position: relative;
              background-color: white;
              margin: 5% auto;
              padding: 0;
              border-radius: 8px;
              width: 500px;
              max-width: 90%;
              box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
              animation: modalSlideIn 0.3s ease;
          }

          @keyframes fadeIn {
              from { opacity: 0; }
              to { opacity: 1; }
          }

          @keyframes modalSlideIn {
              from { transform: translateY(-50px); opacity: 0; }
              to { transform: translateY(0); opacity: 1; }
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

          .form-control-file {
              padding: 8px 12px;
              font-size: 14px;
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

          /* 设备图片样式 */
          .equipment-img {
              width: 50px;
              height: 50px;
              object-fit: cover;
              border-radius: 4px;
          }
      </style>

      <!-- 设备管理内容 -->
      <div class="container">
          <div class="card">
              <h3>设备管理（管理员）</h3>

              <!-- 错误信息显示 -->
              <c:if test="${not empty error}">
                  <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 20px;">
                      ${error}
                  </div>
              </c:if>

              <!-- 添加设备按钮 -->
              <button id="addEquipmentBtn" class="btn btn-primary" style="margin-bottom: 20px;">
                  添加设备
              </button>

              <!-- 设备列表 -->
              <table class="table">
                  <tr>
                      <th>ID</th>
                      <th>设备名称</th>
                      <th>生产厂商</th>
                      <th>设备编号</th>
                      <th>总数量</th>
                      <th>可借数量</th>
                      <th>分类</th>
                      <th>设备图片</th>
                      <th>操作</th>
                  </tr>
                  <c:choose>
                      <c:when test="${empty equipmentList}">
                          <tr>
                              <td colspan="9" class="no-data">暂无设备数据</td>
                          </tr>
                      </c:when>
                      <c:otherwise>
                          <c:forEach items="${equipmentList}" var="equipment">
                              <tr>
                                  <td>${equipment.id}</td>
                                  <td>${equipment.title}</td>
                                  <td>${equipment.manufacturer}</td>
                                  <td>${equipment.equipmentNo}</td>
                                  <td>${equipment.quantity}</td>
                                  <td>${equipment.available}</td>
                                  <td>${equipment.category}</td>
                                  <td>
                                      <c:if test="${not empty equipment.imgPath}">
                                          <img src="${equipment.imgPath}" class="equipment-img" alt="设备图片">
                                      </c:if>
                                      <c:if test="${empty equipment.imgPath}">--</c:if>
                                  </td>
                                  <td>
                                      <button
                                          onclick="editEquipment(${equipment.id}, '${equipment.title}', '${equipment.manufacturer}', '${equipment.equipmentNo}', ${equipment.quantity}, ${equipment.available}, '${equipment.category}')"
                                          class="btn btn-secondary" style="margin-right: 5px;">修改</button>
                                      <a href="/admin/equipment/delete?id=${equipment.id}" onclick="return confirm('确定删除该设备吗？')">
                                          <button class="btn btn-danger">删除</button>
                                      </a>
                                  </td>
                              </tr>
                          </c:forEach>
                      </c:otherwise>
                  </c:choose>
              </table>
          </div>
      </div>

      <!-- 新增设备模态框 -->
      <div id="addEquipmentModal" class="modal">
          <div class="modal-content">
              <div class="modal-header">
                  <h4 class="modal-title">新增设备</h4>
                  <button type="button" class="close" id="closeModalBtn">&times;</button>
              </div>
              <div class="modal-body">
                  <form action="/admin/equipment/add" method="post" enctype="multipart/form-data">
                      <div class="form-group">
                          <label>设备名称：</label>
                          <input type="text" name="title" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>生产厂商：</label>
                          <input type="text" name="manufacturer" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>设备编号：</label>
                          <input type="text" name="equipmentNo" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>总数量：</label>
                          <input type="number" name="quantity" min="1" value="1" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>设备分类：</label>
                          <select name="category" class="form-control">
                              <option value="实验仪器">实验仪器</option>
                              <option value="电子设备">电子设备</option>
                              <option value="玻璃器皿">玻璃器皿</option>
                              <option value="化学试剂">化学试剂</option>
                              <option value="其他">其他</option>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>设备图片：</label>
                          <input type="file" name="file" accept="image/*" class="form-control-file">
                      </div>
                      <div class="form-actions">
                          <button type="submit" class="btn btn-primary">添加</button>
                          <button type="button" id="cancelModalBtn" class="btn btn-light">取消</button>
                      </div>
                  </form>
              </div>
          </div>
      </div>

      <!-- 修改设备模态框 -->
      <div id="editEquipmentModal" class="modal">
          <div class="modal-content">
              <div class="modal-header">
                  <h4 class="modal-title">修改设备</h4>
                  <button type="button" class="close" id="closeEditModalBtn">&times;</button>
              </div>
              <div class="modal-body">
                  <form action="/admin/equipment/update" method="post" enctype="multipart/form-data">
                      <input type="hidden" name="id" id="editEquipmentId">
                      <div class="form-group">
                          <label>设备名称：</label>
                          <input type="text" name="title" id="editTitle" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>生产厂商：</label>
                          <input type="text" name="manufacturer" id="editManufacturer" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>设备编号：</label>
                          <input type="text" name="equipmentNo" id="editEquipmentNo" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>总数量：</label>
                          <input type="number" name="quantity" id="editQuantity" min="1" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>可借数量：</label>
                          <input type="number" name="available" id="editAvailable" min="0" required class="form-control">
                      </div>
                      <div class="form-group">
                          <label>设备分类：</label>
                          <select name="category" id="editCategory" class="form-control">
                              <option value="实验仪器">实验仪器</option>
                              <option value="电子设备">电子设备</option>
                              <option value="玻璃器皿">玻璃器皿</option>
                              <option value="化学试剂">化学试剂</option>
                              <option value="其他">其他</option>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>设备图片：</label>
                          <input type="file" name="file" accept="image/*" class="form-control-file">
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
          // 添加设备模态框交互
          document.addEventListener('DOMContentLoaded', function () {
              // 添加设备相关元素
              const addEquipmentBtn = document.getElementById('addEquipmentBtn');
              const addEquipmentModal = document.getElementById('addEquipmentModal');
              const closeModalBtn = document.getElementById('closeModalBtn');
              const cancelModalBtn = document.getElementById('cancelModalBtn');

              // 修改设备相关元素
              const editEquipmentModal = document.getElementById('editEquipmentModal');
              const closeEditModalBtn = document.getElementById('closeEditModalBtn');
              const cancelEditModalBtn = document.getElementById('cancelEditModalBtn');

              // 显示添加设备模态框
              function showAddModal() {
                  addEquipmentModal.style.display = 'block';
                  document.body.style.overflow = 'hidden';
              }

              // 隐藏添加设备模态框
              function hideAddModal() {
                  addEquipmentModal.style.display = 'none';
                  document.body.style.overflow = 'auto';
              }

              // 显示修改设备模态框
              window.editEquipment = function (id, title, manufacturer, equipmentNo, quantity, available, category) {
                  // 填充设备数据到模态框表单
                  document.getElementById('editEquipmentId').value = id;
                  document.getElementById('editTitle').value = title;
                  document.getElementById('editManufacturer').value = manufacturer;
                  document.getElementById('editEquipmentNo').value = equipmentNo;
                  document.getElementById('editQuantity').value = quantity;
                  document.getElementById('editAvailable').value = available;
                  document.getElementById('editCategory').value = category;

                  // 显示模态框
                  editEquipmentModal.style.display = 'block';
                  document.body.style.overflow = 'hidden';
              };

              // 隐藏修改设备模态框
              function hideEditModal() {
                  editEquipmentModal.style.display = 'none';
                  document.body.style.overflow = 'auto';
              }

              // 点击添加设备按钮显示模态框
              addEquipmentBtn.addEventListener('click', showAddModal);

              // 关闭添加设备模态框
              closeModalBtn.addEventListener('click', hideAddModal);
              cancelModalBtn.addEventListener('click', hideAddModal);
              addEquipmentModal.addEventListener('click', function (event) {
                  if (event.target === addEquipmentModal) {
                      hideAddModal();
                  }
              });

              // 关闭修改设备模态框
              closeEditModalBtn.addEventListener('click', hideEditModal);
              cancelEditModalBtn.addEventListener('click', hideEditModal);
              editEquipmentModal.addEventListener('click', function (event) {
                  if (event.target === editEquipmentModal) {
                      hideEditModal();
                  }
              });

              // 按ESC键关闭所有模态框
              document.addEventListener('keydown', function (event) {
                  if (event.key === 'Escape') {
                      if (addEquipmentModal.style.display === 'block') {
                          hideAddModal();
                      }
                      if (editEquipmentModal.style.display === 'block') {
                          hideEditModal();
                      }
                  }
              });
          });
      </script>