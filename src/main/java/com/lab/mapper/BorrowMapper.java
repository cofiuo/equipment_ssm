package com.lab.mapper;

import com.lab.entity.Borrow;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BorrowMapper {

        // 新增借出记录
        @Insert("INSERT INTO borrows(user_id, equipment_id, borrow_date, due_date, status) " +
                        "VALUES(#{userId}, #{equipmentId}, #{borrowDate}, #{dueDate}, #{status})")
        @Options(useGeneratedKeys = true, keyProperty = "id")
        int add(Borrow borrow);

        // 更新归还记录
        @Update("UPDATE borrows SET return_date=#{returnDate}, status=#{status} WHERE id=#{id}")
        int returnEquipment(Borrow borrow);

        // 查询用户借出记录
        @Select("SELECT b.*, u.username, e.title as equipmentTitle " +
                        "FROM borrows b LEFT JOIN users u ON b.user_id=u.id " +
                        "LEFT JOIN equipment e ON b.equipment_id=e.id " +
                        "WHERE b.user_id = #{userId}")
        List<Borrow> findByUserId(Integer userId);

        // 查询所有借出记录（管理员）
        @Select("SELECT b.*, u.username, e.title as equipmentTitle " +
                        "FROM borrows b LEFT JOIN users u ON b.user_id=u.id " +
                        "LEFT JOIN equipment e ON b.equipment_id=e.id")
        List<Borrow> findAll();

        // 根据设备ID和状态查询未归还记录
        @Select("SELECT COUNT(*) FROM borrows WHERE equipment_id=#{equipmentId} AND status='BORROWED'")
        int countBorrowedByEquipmentId(Integer equipmentId);
        
        // 根据用户ID和状态查询未归还记录
        @Select("SELECT COUNT(*) FROM borrows WHERE user_id=#{userId} AND status='BORROWED'")
        int countBorrowedByUserId(Integer userId);

        // 根据ID查询单个借还记录
        @Select("SELECT b.*, u.username, e.title as equipmentTitle " +
                        "FROM borrows b LEFT JOIN users u ON b.user_id=u.id " +
                        "LEFT JOIN equipment e ON b.equipment_id=e.id " +
                        "WHERE b.id = #{id}")
        Borrow findById(Integer id);

        // 更新审核状态
        @Update("UPDATE borrows SET status=#{status} WHERE id=#{id}")
        int updateStatus(@Param("id") Integer id, @Param("status") String status);
}