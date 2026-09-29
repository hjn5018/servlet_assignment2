package com.servlet.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.servlet.dao.UserDAO;
import com.servlet.model.User;

@WebServlet("/mypage")
public class MyPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("loginUser");

        // 최신 회원 정보 재조회
        User currentUser = userDAO.getUserById(sessionUser.getId());
        if (currentUser == null) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // 세션 정보도 최신으로 동기화
        session.setAttribute("loginUser", currentUser);
        request.setAttribute("user", currentUser);

        // 관리자인 경우 전체 회원 목록 조회
        if (currentUser.isAdmin()) {
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
        }

        request.getRequestDispatcher("/WEB-INF/views/mypage.jsp").forward(request, response);
    }
}
