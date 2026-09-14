package com.lab.service.impl;

import com.lab.entity.Borrow;
import com.lab.entity.Equipment;
import com.lab.mapper.BorrowMapper;
import com.lab.service.BorrowService;
import com.lab.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class BorrowServiceImpl implements BorrowService {

    @Autowired
    private BorrowMapper borrowMapper;
    @Autowired
    private EquipmentService equipmentService;

    @Override
    public boolean borrowEquipment(Borrow borrow) {
        // 1. 检查设备是否可借
        Equipment equipment = equipmentService.findById(borrow.getEquipmentId());
        if (equipment == null || equipment.getAvailable() <= 0) {
            return false;
        }
        // 2. 设置默认值
        borrow.setBorrowDate(new Date());
        // 如果用户没有设置归还日期，则默认设为借出后7天
        if (borrow.getDueDate() == null) {
            Date dueDate = new Date();
            dueDate.setTime(dueDate.getTime() + 7 * 24 * 60 * 60 * 1000);
            borrow.setDueDate(dueDate);
        }
        borrow.setStatus("PENDING");
        // 3. 新增借出记录
        boolean result = borrowMapper.add(borrow) > 0;
        // 4. 待审核期间设备可借数量减1
        if (result) {
            equipmentService.updateAvailable(borrow.getEquipmentId(), -1);
        }
        return result;
    }

    @Override
    public boolean returnEquipment(Integer borrowId) {
        // 1. 查询借出记录
        Borrow borrow = borrowMapper.findById(borrowId);
        if (borrow == null) {
            return false;
        }

        // 2. 更新归还记录
        borrow.setReturnDate(new Date());
        borrow.setStatus("RETURNED");
        boolean result = borrowMapper.returnEquipment(borrow) > 0;

        // 3. 更新设备可借数量（加1）
        if (result) {
            equipmentService.updateAvailable(borrow.getEquipmentId(), 1);
        }
        return result;
    }

    @Override
    public List<Borrow> findByUserId(Integer userId) {
        return borrowMapper.findByUserId(userId);
    }

    @Override
    public List<Borrow> findAll() {
        return borrowMapper.findAll();
    }

    @Override
    public boolean approveBorrow(Integer borrowId) {
        // 1. 查询借出记录
        Borrow borrow = borrowMapper.findById(borrowId);
        if (borrow == null || !"PENDING".equals(borrow.getStatus())) {
            return false;
        }

        // 2. 更新审核状态为已借出
        boolean result = borrowMapper.updateStatus(borrowId, "BORROWED") > 0;
        // 3. 设备数量已在借用时减少，这里不需要再调整
        return result;
    }

    @Override
    public boolean rejectBorrow(Integer borrowId) {
        // 1. 查询借出记录
        Borrow borrow = borrowMapper.findById(borrowId);
        if (borrow == null || !"PENDING".equals(borrow.getStatus())) {
            return false;
        }

        // 2. 更新审核状态为拒绝
        boolean result = borrowMapper.updateStatus(borrowId, "REJECTED") > 0;

        // 3. 拒绝后恢复设备可借数量
        if (result) {
            equipmentService.updateAvailable(borrow.getEquipmentId(), 1);
        }
        return result;
    }

    @Override
    public boolean hasUnreturnedBorrows(Integer userId) {
        return borrowMapper.countBorrowedByUserId(userId) > 0;
    }
}