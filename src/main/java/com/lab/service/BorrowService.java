package com.lab.service;

import com.lab.entity.Borrow;

import java.util.List;

public interface BorrowService {
    // 借出设备
    boolean borrowEquipment(Borrow borrow);

    // 归还设备
    boolean returnEquipment(Integer borrowId);

    // 查询用户借出记录
    List<Borrow> findByUserId(Integer userId);

    // 查询所有借出记录
    List<Borrow> findAll();

    // 审核借用请求
    boolean approveBorrow(Integer borrowId);

    // 拒绝借用请求
    boolean rejectBorrow(Integer borrowId);
    
    // 检查用户是否有未归还的借阅记录
    boolean hasUnreturnedBorrows(Integer userId);
}