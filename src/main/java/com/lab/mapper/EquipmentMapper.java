package com.lab.mapper;

import com.lab.entity.Equipment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface EquipmentMapper {

        // 分页查询所有设备（支持模糊搜索和分类筛选）
        @Select("<script>" +
                        "SELECT * FROM equipment " +
                        "WHERE 1=1 " +
                        "<if test='keyword != null and keyword != \"\"'>" +
                        "AND (title LIKE CONCAT('%', #{keyword}, '%') OR manufacturer LIKE CONCAT('%', #{keyword}, '%'))"
                        +
                        "</if>" +
                        "<if test='category != null and category != \"\"'>" +
                        "AND category = #{category}" +
                        "</if>" +
                        "</script>")
        List<Equipment> findAll(@Param("keyword") String keyword, @Param("category") String category);

        // 根据ID查询设备
        @Select("SELECT * FROM equipment WHERE id = #{id}")
        Equipment findById(Integer id);

        // 添加设备
        @Insert("INSERT INTO equipment(title, manufacturer, equipment_no, quantity, available, category, img_path) " +
                        "VALUES(#{title}, #{manufacturer}, #{equipmentNo}, #{quantity}, #{available}, #{category}, #{imgPath})")
        @Options(useGeneratedKeys = true, keyProperty = "id")
        int add(Equipment equipment);

        // 修改设备
        @Update("UPDATE equipment SET title=#{title}, manufacturer=#{manufacturer}, equipment_no=#{equipmentNo}, " +
                        "quantity=#{quantity}, available=#{available}, category=#{category}, img_path=#{imgPath} WHERE id=#{id}")
        int update(Equipment equipment);

        // 删除设备
        @Delete("DELETE FROM equipment WHERE id = #{id}")
        int delete(Integer id);

        // 更新设备可借数量
        @Update("UPDATE equipment SET available = available + #{num} WHERE id = #{id}")
        int updateAvailable(@Param("id") Integer id, @Param("num") Integer num);
}