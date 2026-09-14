package com.lab.service.impl;

import com.lab.entity.Equipment;
import com.lab.mapper.BorrowMapper;
import com.lab.mapper.EquipmentMapper;
import com.lab.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class EquipmentServiceImpl implements EquipmentService {

    @Autowired
    private EquipmentMapper equipmentMapper;

    @Autowired
    private BorrowMapper borrowMapper;

    @Override
    public List<Equipment> findAll(String keyword, String category) {
        return equipmentMapper.findAll(keyword, category);
    }

    @Override
    public Equipment findById(Integer id) {
        return equipmentMapper.findById(id);
    }

    @Override
    public boolean add(Equipment equipment) {
        // 初始化可借数量为总数量
        if (equipment.getAvailable() == null) {
            equipment.setAvailable(equipment.getQuantity());
        }
        return equipmentMapper.add(equipment) > 0;
    }

    @Override
    public boolean update(Equipment equipment) {
        return equipmentMapper.update(equipment) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        // 检查该设备是否有未归还的借阅记录
        int borrowedCount = borrowMapper.countBorrowedByEquipmentId(id);
        if (borrowedCount > 0) {
            throw new RuntimeException("该设备有" + borrowedCount + "条未归还的借阅记录，无法删除");
        }
        // 执行删除操作
        return equipmentMapper.delete(id) > 0;
    }

    @Override
    public boolean updateAvailable(Integer id, Integer num) {
        return equipmentMapper.updateAvailable(id, num) > 0;
    }
}