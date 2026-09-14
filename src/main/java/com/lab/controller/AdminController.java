package com.lab.controller;

import com.lab.entity.Borrow;
import com.lab.entity.Equipment;
import com.lab.entity.User;
import com.lab.service.BorrowService;
import com.lab.service.EquipmentService;
import com.lab.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private BorrowService borrowService;
    @Autowired
    private UserService userService;

    // 权限拦截（所有管理员接口前置检查）
    @ModelAttribute
    public void checkAdmin(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            throw new RuntimeException("无管理员权限");
        }
    }

    // 设备管理页面
    @GetMapping("/equipment/manage")
    public String equipmentManage(Model model) {
        List<Equipment> equipmentList = equipmentService.findAll(null, null);
        model.addAttribute("equipmentList", equipmentList);
        return "admin/equipmentManage";
    }

    // 添加设备（含图片上传）
    @PostMapping("/equipment/add")
    public String addEquipment(Equipment equipment,
            @RequestParam("file") MultipartFile file,
            HttpSession session) throws IOException {
        // 图片上传逻辑
        if (!file.isEmpty()) {
            // 1. 获取上传路径
            // String uploadDir = "src/main/webapp/static/upload/";
            String uploadDir = "D:\\big_three\\javaee\\equipment_ssm\\src\\main\\webapp\\static\\upload";
            File uploadFile = new File(uploadDir);
            if (!uploadFile.exists()) {
                uploadFile.mkdirs(); // 创建目录
            }
            // 2. 生成唯一文件名
            String originalFilename = file.getOriginalFilename();
            String newFileName = UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
            String fullSavePath = uploadDir + File.separator + newFileName;//

            file.transferTo(new File(fullSavePath));

            // 4. 保存图片路径
            equipment.setImgPath("/static/upload/" + newFileName);

        }
        equipmentService.add(equipment);
        return "redirect:/admin/equipment/manage";
    }

    // 修改设备
    @PostMapping("/equipment/update")
    public String updateEquipment(Equipment equipment,
            @RequestParam(value = "file", required = false) MultipartFile file,
            HttpSession session) throws IOException {
        // 图片上传逻辑
        if (file != null && !file.isEmpty()) {
            // 1. 获取上传路径
            String uploadDir = "D:\\big_three\\javaee\\equipment_ssm\\src\\main\\webapp\\static\\upload";
            File uploadFile = new File(uploadDir);
            if (!uploadFile.exists()) {
                uploadFile.mkdirs();
            }
            // 2. 生成唯一文件名
            String originalFilename = file.getOriginalFilename();
            String newFileName = UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
            // 3. 上传文件
            String fullSavePath = uploadDir + File.separator + newFileName;//
            file.transferTo(new File(fullSavePath));
            // 4. 保存图片路径
            equipment.setImgPath("/static/upload/" + newFileName);
        }
        equipmentService.update(equipment);
        return "redirect:/admin/equipment/manage";
    }

    // 删除设备
    @GetMapping("/equipment/delete")
    public String deleteEquipment(@RequestParam Integer id, Model model) {
        try {
            equipmentService.delete(id);
            return "redirect:/admin/equipment/manage";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            List<Equipment> equipmentList = equipmentService.findAll("", "");
            model.addAttribute("equipmentList", equipmentList);
            return "admin/equipmentManage";
        }
    }

    // 查看所有借出记录
    @GetMapping("/borrow/list")
    public String borrowList(Model model) {
        List<Borrow> borrowList = borrowService.findAll();
        model.addAttribute("borrowList", borrowList);
        return "admin/borrowList";
    }

    // 审核借用请求
    @GetMapping("/borrow/approve")
    public String approveBorrow(@RequestParam Integer borrowId) {
        borrowService.approveBorrow(borrowId);
        return "redirect:/admin/borrow/list";
    }

    // 拒绝借用请求
    @GetMapping("/borrow/reject")
    public String rejectBorrow(@RequestParam Integer borrowId) {
        borrowService.rejectBorrow(borrowId);
        return "redirect:/admin/borrow/list";
    }

    // 用户管理页面
    @GetMapping("/user/manage")
    public String userManage(Model model) {
        List<User> userList = userService.findAll();
        model.addAttribute("userList", userList);
        return "admin/userManage";
    }

    // 添加用户
    @PostMapping("/user/add")
    public String addUser(User user) {
        userService.register(user);
        return "redirect:/admin/user/manage";
    }

    // 修改用户
    @PostMapping("/user/update")
    public String updateUser(User user) {
        userService.updateUser(user);
        return "redirect:/admin/user/manage";
    }

    // 删除用户
    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam Integer id, Model model) {
        try {
            userService.deleteUser(id);
            return "redirect:/admin/user/manage";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            List<User> userList = userService.findAll();
            model.addAttribute("userList", userList);
            return "admin/userManage";
        }
    }

    // 查看特定用户借用记录
    @GetMapping("/user/borrowHistory")
    public String userBorrowHistory(@RequestParam Integer id, Model model) {
        List<Borrow> borrowList = borrowService.findByUserId(id);
        model.addAttribute("borrowList", borrowList);
        return "user/borrowHistory";
    }
}