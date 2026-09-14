package com.lab.util;

import com.lab.entity.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Web通用工具类
 */
public class WebUtils {

    /**
     * 获取当前登录用户
     */
    public static User getLoginUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return (User) session.getAttribute("loginUser");
    }

    /**
     * 判断当前用户是否为管理员
     */
    public static boolean isAdmin(HttpServletRequest request) {
        User user = getLoginUser(request);
        return user != null && "ADMIN".equals(user.getRole());
    }

    /**
     * 检查用户是否登录，未登录则返回false
     */
    public static boolean checkLogin(HttpServletRequest request) {
        return getLoginUser(request) != null;
    }

    /**
     * 获取项目根路径（用于文件上传）
     */
    public static String getProjectPath(HttpServletRequest request) {
        return request.getServletContext().getRealPath("/");
    }

    /**
     * 获取文件上传的完整路径
     */
    public static String getUploadPath(HttpServletRequest request) {
        return getProjectPath(request) + "static/upload/";
    }
}