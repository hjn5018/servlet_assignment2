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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 이미 로그인 중이면 메인으로
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loginUser") != null) {
            response.sendRedirect(request.getContextPath() + "/main");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id       = request.getParameter("id");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
        String name     = request.getParameter("name");

        // 필수값 검증
        if (id == null || id.trim().isEmpty()) {
            request.setAttribute("errorMessage", "아이디를 입력해주세요.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "이름을 입력해주세요.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "비밀번호를 입력해주세요.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(password2)) {
            request.setAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // 아이디 길이 제한
        if (id.trim().length() < 4 || id.trim().length() > 20) {
            request.setAttribute("errorMessage", "아이디는 4~20자 사이여야 합니다.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // 아이디 중복 확인
        if (userDAO.isIdExist(id.trim())) {
            request.setAttribute("errorMessage", "이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // 신규 회원 등록
        User newUser = new User();
        newUser.setId(id.trim());
        newUser.setPassword(password.trim());
        newUser.setName(name.trim());
        newUser.setRole("user");

        boolean isSuccess = userDAO.insertUser(newUser);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/login?msg=registered");
        } else {
            request.setAttribute("errorMessage", "회원가입 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
            request.setAttribute("inputId", id);
            request.setAttribute("inputName", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}
