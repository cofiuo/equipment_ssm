# 实验室设备管理系统（SSM）

基于 Spring + Spring MVC + MyBatis 的实验室设备借还管理系统，课程设计项目。

## 演示

![系统演示](docs/demo.gif)

完整演示视频（约 4 分钟，含各角色完整操作流程）：[docs/demo-full.mp4](docs/demo-full.mp4)

## 技术栈

- Spring 5 / Spring MVC（以 Java 配置类为主）
- MyBatis + Druid 连接池
- MySQL 8
- JSP + JSTL 视图层
- Maven 构建，打包为 war

## 主要功能

- 用户注册与登录
- 设备列表浏览、借出申请
- 个人借用记录查询
- 管理员：设备管理、用户管理、借用审批

## 本地运行

1. 创建数据库并导入数据：`mysql -u root -p < equipment_ssm.sql`（库名 `equipment_ssm`）
2. 配置数据库连接：把 `src/main/resources/jdbc.properties.example` 复制为 `jdbc.properties`，填入你自己的账号密码
3. 打包：`mvn clean package`，得到 `target/lab-equipment-system-1.0-SNAPSHOT.war`
4. 部署到 Tomcat 8/9，访问 `http://localhost:8080/lab-equipment-system-1.0-SNAPSHOT/`

测试账号与初始数据见 `equipment_ssm.sql` 中的 `users` 表。

## 说明

`jdbc.properties` 因包含本机数据库密码而未纳入版本管理，请按示例文件自行创建。
