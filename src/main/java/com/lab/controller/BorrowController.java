package com.lab.controller;

import com.lab.entity.Borrow;
import com.lab.entity.User;
import com.lab.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    // 借出设备
    @PostMapping("/borrow/add")
    public String borrow(@RequestParam Integer equipmentId,
            @RequestParam String dueDate,
            HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        Borrow borrow = new Borrow();
        borrow.setUserId(user.getId());
        borrow.setEquipmentId(equipmentId);
        // 设置用户选择的归还日期
        borrow.setDueDate(java.sql.Date.valueOf(dueDate));
        boolean result = borrowService.borrowEquipment(borrow);
        return "redirect:/equipment/list";
    }

    // 归还设备
    @GetMapping("/borrow/return")
    public String returnEquipment(@RequestParam Integer borrowId) {
        borrowService.returnEquipment(borrowId);
        return "redirect:/user/borrowHistory";
    }

    // 查询个人借出记录
    @GetMapping("/user/borrowHistory")
    public String borrowHistory(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        List<Borrow> borrowList = borrowService.findByUserId(user.getId());
        model.addAttribute("borrowList", borrowList);
        return "user/borrowHistory";
    }
}