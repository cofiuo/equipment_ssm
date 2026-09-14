package com.lab.service;

import com.lab.entity.Equipment;

import java.util.List;

public interface EquipmentService {
    // 查询所有设备（支持搜索和分类筛选）
    List<Equipment> findAll(String keyword, String category);

    // 根据ID查询
    Equipment findById(Integer id);

    // 添加设备
    boolean add(Equipment equipment);

    // 修改设备
    boolean update(Equipment equipment);

    // 删除设备
    boolean delete(Integer id);

    // 更新可借数量
    boolean updateAvailable(Integer id, Integer num);
}