<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.servlet.model.User" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지 - 사용자 관리 시스템</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <!-- 상단 네비게이션 -->
    <header class="navbar">
        <a href="<%= request.getContextPath() %>/main" class="nav-brand">
            <span>🛡️ UserSystem</span>
        </a>
        <div class="nav-links">
            <% if (loginUser != null) { %>
                <div class="nav-user-info">
                    <strong><%= loginUser.getName() %></strong>님
                    <span class="badge <%= loginUser.isAdmin() ? "badge-admin" : "badge-user" %>">
                        <%= loginUser.getRole() %>
                    </span>
                </div>
                <a href="<%= request.getContextPath() %>/mypage" class="btn btn-outline">마이페이지</a>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">로그아웃</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/register" class="btn btn-outline">회원가입</a>
                <a href="<%= request.getContextPath() %>/login" class="btn btn-primary">로그인</a>
            <% } %>
        </div>
    </header>

    <!-- 메인 본문 영역 (비움) -->
</body>
</html>
