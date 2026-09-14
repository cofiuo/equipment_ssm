package com.lab.controller;

import com.lab.entity.Equipment;
import com.lab.entity.User;
import com.lab.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class EquipmentController {

    @Autowired
    private EquipmentService equipmentService;

    // 设备列表（支持搜索和分类筛选）
    @GetMapping("/equipment/list")
    public String list(@RequestParam(required = false) String keyword,
            @RequestParam(required = false) String category,
            Model model,
            HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        List<Equipment> equipmentList = equipmentService.findAll(keyword, category);
        model.addAttribute("equipmentList", equipmentList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        return "equipment/list";
    }
}