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

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
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

        // 비밀번호 재확인 (본인 인증)
        String confirmPassword = request.getParameter("confirmPassword");

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/mypage?msg=delete_empty_pw");
            return;
        }

        // 비밀번호 일치 여부 확인
        if (!confirmPassword.trim().equals(sessionUser.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/mypage?msg=delete_wrong_pw");
            return;
        }

        // 관리자 계정은 탈퇴 불가
        if (sessionUser.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/mypage?msg=delete_admin_forbidden");
            return;
        }

        boolean isDeleted = userDAO.deleteUser(sessionUser.getId());

        if (isDeleted) {
            // 세션 무효화 후 로그인 페이지로 이동
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login?msg=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/mypage?msg=delete_fail");
        }
    }
}
