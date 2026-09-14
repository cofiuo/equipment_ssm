package com.lab.controller;

import com.lab.entity.User;
import com.lab.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // 跳转到登录页
    @GetMapping("/login")
    public String toLogin() {
        return "login";
    }

    // 登录
    @PostMapping("/login")
    public String login(@RequestParam String username,
            @RequestParam String password,
            Model model,
            HttpSession session) {
        User user = userService.login(username, password);
        if (user != null) {
            // 登录成功，保存用户到session
            session.setAttribute("loginUser", user);
            return "redirect:/index";
        } else {
            model.addAttribute("error", "用户名或密码错误");
            return "login";
        }
    }

    // 跳转到注册页
    @GetMapping("/register")
    public String toRegister() {
        return "register";
    }

    // 注册
    @PostMapping("/register")
    public String register(User user, Model model) {
        boolean result = userService.register(user);
        if (result) {
            return "redirect:/login";
        } else {
            model.addAttribute("error", "用户名已存在");
            return "register";
        }
    }

    // 退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // 个人信息
    @GetMapping("/user/info")
    public String info(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "user/info";
    }

    // 更新个人信息
    @PostMapping("/user/update")
    public String updateUser(User user, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        // 设置用户ID
        user.setId(loginUser.getId());
        user.setRole(loginUser.getRole()); // 保持原有角色

        boolean result = userService.updateUser(user);
        if (result) {
            // 密码修改后需要重新登录
            session.invalidate();
            return "redirect:/login?success=1";
        } else {
            model.addAttribute("error", "用户名已被使用");
            return "redirect:/user/info";
        }
    }
}