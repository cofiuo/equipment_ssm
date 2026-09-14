package com.lab.entity;


import java.util.Date;

public class Equipment {
    private Integer id;
    private String title; // 设备名称
    private String manufacturer; // 生产厂商
    private String equipmentNo; // 设备编号
    private Integer quantity; // 总数量
    private Integer available; // 可借数量
    private Date createdAt;
    private String category; // 分类
    private String imgPath; // 图片路径


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getEquipmentNo() {
        return equipmentNo;
    }

    public void setEquipmentNo(String equipmentNo) {
        this.equipmentNo = equipmentNo;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    @Override
    public String toString() {
        return "Equipment{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", manufacturer='" + manufacturer + '\'' +
                ", equipmentNo='" + equipmentNo + '\'' +
                ", quantity=" + quantity +
                ", available=" + available +
                ", createdAt=" + createdAt +
                ", category='" + category + '\'' +
                ", imgPath='" + imgPath + '\'' +
                '}';
    }
}