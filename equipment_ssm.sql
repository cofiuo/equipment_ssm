/*
 Navicat Premium Dump SQL

 Source Server         : library
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : equipment_ssm

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 06/01/2026 17:58:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for borrows
-- ----------------------------
DROP TABLE IF EXISTS `borrows`;
CREATE TABLE `borrows`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '借出记录ID',
  `user_id` int NOT NULL COMMENT '关联用户ID',
  `equipment_id` int NULL DEFAULT NULL COMMENT '关联设备ID',
  `borrow_date` date NOT NULL COMMENT '借出日期',
  `due_date` date NOT NULL COMMENT '应还日期（新增字段，原return_date改为实际归还日期）',
  `return_date` date NULL DEFAULT NULL COMMENT '实际归还日期',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'BORROWED' COMMENT '状态：BORROWED-已借出，RETURNED-已归还，OVERDUE-逾期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_equipment_id`(`equipment_id` ASC) USING BTREE,
  CONSTRAINT `fk_borrows_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of borrows
-- ----------------------------
INSERT INTO `borrows` VALUES (27, 1, 13, '2026-01-06', '2026-01-10', NULL, 'REJECTED');
INSERT INTO `borrows` VALUES (28, 1, 13, '2026-01-06', '2026-01-09', '2026-01-06', 'RETURNED');
INSERT INTO `borrows` VALUES (29, 1, 12, '2026-01-06', '2026-01-06', '2026-01-06', 'RETURNED');
INSERT INTO `borrows` VALUES (30, 4, 11, '2026-01-06', '2026-01-09', '2026-01-06', 'RETURNED');
INSERT INTO `borrows` VALUES (31, 1, NULL, '2026-01-06', '2026-01-10', '2026-01-06', 'RETURNED');
INSERT INTO `borrows` VALUES (32, 2, 11, '2026-01-06', '2026-01-08', NULL, 'REJECTED');
INSERT INTO `borrows` VALUES (33, 5, 11, '2026-01-06', '2026-01-07', '2026-01-06', 'RETURNED');
INSERT INTO `borrows` VALUES (34, 6, 18, '2026-01-06', '2026-01-08', '2026-01-06', 'RETURNED');
INSERT INTO `borrows` VALUES (35, 1, NULL, '2026-01-06', '2026-01-07', '2026-01-06', 'RETURNED');

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备名称',
  `manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '生产厂商（替换原author）',
  `equipment_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备编号（替换原isbn）',
  `quantity` int NULL DEFAULT 1 COMMENT '总数量',
  `available` int NULL DEFAULT 1 COMMENT '可借数量',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '未分类' COMMENT '设备分类',
  `img_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备图片存储路径（本地）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE,
  INDEX `idx_manufacturer`(`manufacturer` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (11, '数字示波器', 'Tektronix', 'TEK-2025001', 5, 1, '2026-01-06 15:47:43', '电子设备', '/static/upload/cb88d6e8-03a6-44a7-a98c-a8748a6cf24a.png');
INSERT INTO `equipment` VALUES (12, '高精度万用表', 'Fluke', 'FLU-2025002', 8, 4, '2026-01-06 15:49:25', '电子设备', '/static/upload/1a7ee929-2594-4d6d-b9e6-0705f235bf54.png');
INSERT INTO `equipment` VALUES (13, '恒温培养箱', '赛默飞世尔', 'THER-2024003', 3, 0, '2026-01-06 15:50:42', '实验仪器', '/static/upload/ce9cac61-6149-4091-b4d8-db087f49eebf.png');
INSERT INTO `equipment` VALUES (14, '电子天平', '梅特勒-托利多', 'MET-2025004', 4, 4, '2026-01-06 15:51:59', '实验仪器', '/static/upload/98013bfb-a4ff-4012-8c88-381adf18c3bd.png');
INSERT INTO `equipment` VALUES (15, '激光测距仪', 'Leica', 'LEI-2024005', 6, 6, '2026-01-06 15:53:02', '电子设备', '/static/upload/ed94ce4f-e4a9-4b30-9ea0-2bbaa1216add.png');
INSERT INTO `equipment` VALUES (16, '烧杯(600ml)', '蜀牛', 'BOR-2025006', 10, 10, '2026-01-06 15:54:42', '玻璃器皿', '/static/upload/a82a9e47-8921-4122-a878-e5256b02f187.png');
INSERT INTO `equipment` VALUES (17, '高锰酸钾', 'ABD', 'GMS-2025007', 3, 3, '2026-01-06 15:58:16', '化学试剂', '/static/upload/849928be-1b8b-4283-a0c8-9566cf71c0b7.png');
INSERT INTO `equipment` VALUES (18, '容量瓶（100ml）', 'AAA', 'RLP-2025008', 7, 7, '2026-01-06 16:00:35', '玻璃器皿', '/static/upload/a67ef4e9-7ba0-49ee-9107-27773b19d21e.png');
INSERT INTO `equipment` VALUES (19, '实验手套', 'DDD', 'ST-2025009', 10, 5, '2026-01-06 16:02:07', '其他', '/static/upload/f8d3bea8-ac8b-4468-aa9f-af545ae7e2b5.png');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名（唯一）',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（建议加密存储）',
  `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'USER' COMMENT '角色：USER-普通用户，ADMIN-管理员',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '25f9e794323b453885f5181f1b624d0b', 'ADMIN', '2025-12-22 11:12:27');
INSERT INTO `users` VALUES (5, 'user123', 'e10adc3949ba59abbe56e057f20f883e', 'USER', '2026-01-06 16:56:08');
INSERT INTO `users` VALUES (7, 'test', 'e10adc3949ba59abbe56e057f20f883e', 'USER', '2026-01-06 17:03:42');

SET FOREIGN_KEY_CHECKS = 1;
