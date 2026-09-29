package com.servlet.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.servlet.dao.UserDAO;
import com.servlet.model.User;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("loginUser");

        String name = request.getParameter("name");
        String password = request.getParameter("password");

        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/mypage?msg=empty_name");
            return;
        }

        // 비밀번호가 새로 입력되지 않았으면 기존 비밀번호 유지
        String updatePassword = (password != null && !password.trim().isEmpty()) 
                                ? password.trim() 
                                : sessionUser.getPassword();

        User updatedUser = new User();
        updatedUser.setId(sessionUser.getId());
        updatedUser.setName(name.trim());
        updatedUser.setPassword(updatePassword);
        updatedUser.setRole(sessionUser.getRole());

        boolean isSuccess = userDAO.updateUser(updatedUser);

        if (isSuccess) {
            session.setAttribute("loginUser", updatedUser);
            response.sendRedirect(request.getContextPath() + "/mypage?msg=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/mypage?msg=fail");
        }
    }
}
