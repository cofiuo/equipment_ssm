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

        /* 搜索表单样式 */
        .search-form {
          margin: 20px 0;
          display: flex;
          align-items: center;
          gap: 10px;
          flex-wrap: wrap;
        }

        .search-form select,
        .search-form input[type="text"] {
          padding: 8px 12px;
          border: 2px solid #e0e0e0;
          border-radius: 6px;
          font-size: 14px;
          transition: border-color 0.3s ease;
        }

        .search-form select:focus,
        .search-form input[type="text"]:focus {
          outline: none;
          border-color: #4CAF50;
        }

        .search-form input[type="submit"] {
          padding: 8px 20px;
          background-color: #4CAF50;
          color: white;
          border: none;
          border-radius: 6px;
          cursor: pointer;
          font-size: 14px;
          transition: background-color 0.3s ease;
        }

        .search-form input[type="submit"]:hover {
          background-color: #45a049;
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
          overflow: auto;
          background-color: rgba(0, 0, 0, 0.9);
        }

        .modal-content {
          margin: auto;
          display: block;
          max-width: 90%;
          max-height: 90%;
        }

        .close {
          position: absolute;
          top: 15px;
          right: 35px;
          color: #f1f1f1;
          font-size: 40px;
          font-weight: bold;
          transition: 0.3s;
          cursor: pointer;
        }

        .close:hover,
        .close:focus {
          color: #bbb;
          text-decoration: none;
          cursor: pointer;
        }

        /* 卡片容器 */
        .equipment-container {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
          gap: 20px;
          margin-top: 20px;
        }

        /* 设备卡片 */
        .equipment-card {
          background-color: white;
          border-radius: 8px;
          box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
          overflow: hidden;
          transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .equipment-card:hover {
          transform: translateY(-5px);
          box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }

        /* 卡片图片区域 */
        .card-img-container {
          position: relative;
          width: 100%;
          height: 200px;
          overflow: hidden;
          cursor: pointer;
          background-color: #f5f5f5;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .card-img {
          width: 100%;
          height: 100%;
          object-fit: cover;
          transition: transform 0.3s ease;
        }

        .card-img-container:hover .card-img {
          transform: scale(1.05);
        }

        /* 卡片内容区域 */
        .card-content {
          padding: 16px;
        }

        .card-title {
          font-size: 18px;
          font-weight: 600;
          margin-bottom: 8px;
          color: #2c3e50;
        }

        .card-info {
          font-size: 14px;
          color: #5a6c7d;
          margin-bottom: 4px;
        }

        .card-info strong {
          color: #2c3e50;
        }

        /* 卡片底部操作区 */
        .card-footer {
          padding: 0 16px 16px;
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .quantity-info {
          font-size: 14px;
        }

        .total-quantity {
          color: #666;
        }

        .available-quantity {
          color: #4CAF50;
          font-weight: 600;
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

        .borrowed-text {
          color: #999;
          font-size: 14px;
        }

        /* 无图片提示 */
        .no-img {
          color: #999;
          font-size: 14px;
        }
      </style>

      <!-- 设备列表内容 -->
      <div class="container">
        <div class="card">
          <h3>设备列表</h3>

          <!-- 搜索框和分类筛选 -->
          <form action="/equipment/list" method="get" class="search-form">
            <select name="category" style="width: 150px;">
              <option value="">全部分类</option>
              <option value="实验仪器" ${category=='实验仪器' ? 'selected' : '' }>实验仪器</option>
              <option value="电子设备" ${category=='电子设备' ? 'selected' : '' }>电子设备</option>
              <option value="玻璃器皿" ${category=='玻璃器皿' ? 'selected' : '' }>玻璃器皿</option>
              <option value="化学试剂" ${category=='化学试剂' ? 'selected' : '' }>化学试剂</option>
              <option value="其他" ${category=='其他' ? 'selected' : '' }>其他</option>
            </select>
            <input type="text" name="keyword" placeholder="设备名称/厂商" value="${keyword}" style="width: 250px;">
            <input type="submit" value="搜索" class="btn btn-primary">
          </form>

          <!-- 设备卡片列表 -->
          <div class="equipment-container">
            <c:forEach items="${equipmentList}" var="equipment">
              <div class="equipment-card">
                <!-- 设备图片 -->
                <div class="card-img-container" onclick="openModal('${equipment.imgPath}')">
                  <c:if test="${not empty equipment.imgPath}">
                    <img src="${equipment.imgPath}" class="card-img" alt="${equipment.title}">
                  </c:if>
                  <c:if test="${empty equipment.imgPath}">
                    <span class="no-img">暂无图片</span>
                  </c:if>
                </div>

                <!-- 设备信息 -->
                <div class="card-content">
                  <div class="card-title">${equipment.title}</div>
                  <div class="card-info"><strong>分类：</strong>${equipment.category}</div>
                  <div class="card-info"><strong>厂商：</strong>${equipment.manufacturer}</div>
                  <div class="card-info"><strong>编号：</strong>${equipment.equipmentNo}</div>
                </div>

                <!-- 底部操作区 -->
                <div class="card-footer">
                  <div class="quantity-info">
                    <span class="total-quantity">总：${equipment.quantity}</span>
                    <span style="margin: 0 8px;">|</span>
                    <span class="available-quantity">可借：${equipment.available}</span>
                  </div>
                  <div>
                    <c:if test="${equipment.available > 0}">
                      <button class="btn btn-primary"
                        onclick="openBorrowModal(${equipment.id}, '${equipment.title}')">借用</button>
                    </c:if>
                    <c:if test="${equipment.available <= 0}">
                      <span class="borrowed-text">已借完</span>
                    </c:if>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>

        <!-- 图片预览模态框 -->
        <div id="imageModal" class="modal">
          <span class="close">&times;</span>
          <img class="modal-content" id="modalImage">
        </div>

        <!-- 借用设备模态框 -->
        <div id="borrowModal" class="modal">
          <div class="modal-content"
            style="background-color: white; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 400px; border-radius: 8px;">
            <span class="close" onclick="closeBorrowModal()">&times;</span>
            <h3 style="margin-top: 0;color: #2c3e50;">借用设备</h3>
            <form id="borrowForm" action="/borrow/add" method="post" style="margin-top: 20px;">
              <input type="hidden" id="borrowEquipmentId" name="equipmentId">
              <div style="margin-bottom: 15px;">
                <label for="borrowEquipmentName"
                  style="display: block; margin-bottom: 5px; font-weight: 500;">设备名称：</label>
                <span id="borrowEquipmentName"
                  style="display: inline-block; padding: 8px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 4px; width: 100%; box-sizing: border-box;"></span>
              </div>
              <div style="margin-bottom: 15px;">
                <label for="borrowDueDate"
                  style="display: block; margin-bottom: 5px; font-weight: 500;">请选择归还日期：</label>
                <input type="date" id="borrowDueDate" name="dueDate" required
                  style="padding: 8px; border: 1px solid #ddd; border-radius: 4px; width: 100%; box-sizing: border-box;">
              </div>
              <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
                <button type="button" onclick="closeBorrowModal()"
                  style="padding: 8px 16px; border: 1px solid #ddd; background-color: white; border-radius: 4px; cursor: pointer;">取消</button>
                <input type="submit" value="确认借用"
                  style="padding: 8px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer;">
              </div>
            </form>
          </div>
        </div>

        <script>
          // 图片预览模态框功能
          const imageModal = document.getElementById('imageModal');
          const modalImg = document.getElementById('modalImage');
          const imageCloseBtn = document.getElementsByClassName('close')[0];

          // 打开图片模态框
          function openModal(imgSrc) {
            if (imgSrc) {
              imageModal.style.display = 'block';
              modalImg.src = imgSrc;
            }
          }

          // 关闭图片模态框
          function closeModal() {
            imageModal.style.display = 'none';
          }

          // 点击图片模态框关闭按钮
          imageCloseBtn.onclick = closeModal;

          // 借用设备模态框功能
          const borrowModal = document.getElementById('borrowModal');
          const borrowEquipmentId = document.getElementById('borrowEquipmentId');
          const borrowEquipmentName = document.getElementById('borrowEquipmentName');
          const borrowDueDate = document.getElementById('borrowDueDate');

          // 打开借用模态框
          function openBorrowModal(equipmentId, equipmentTitle) {
            borrowEquipmentId.value = equipmentId;
            borrowEquipmentName.textContent = equipmentTitle;
            // 设置最小日期为今天
            borrowDueDate.min = new Date().toISOString().split('T')[0];
            borrowModal.style.display = 'block';
          }

          // 关闭借用模态框
          function closeBorrowModal() {
            borrowModal.style.display = 'none';
          }

          // 点击模态框外部关闭
          window.onclick = function (event) {
            if (event.target == imageModal) {
              closeModal();
            } else if (event.target == borrowModal) {
              closeBorrowModal();
            }
          }


          // ESC键关闭模态框
          document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
              closeModal();
              closeBorrowModal();
            }
          });

          // 借用表单提交事件处理
          document.getElementById('borrowForm').addEventListener('submit', function (e) {
            // 显示借用成功提示
            alert('借用成功，待管理员审核');
          });
        </script>
      </div>