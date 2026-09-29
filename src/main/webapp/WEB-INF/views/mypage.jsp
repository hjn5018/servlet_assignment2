<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.servlet.model.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) request.getAttribute("user");

    @SuppressWarnings("unchecked")
    List<User> userList = (List<User>) request.getAttribute("userList");

    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - 사용자 관리 시스템</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <!-- 상단 네비게이션 -->
    <header class="navbar">
        <a href="<%= request.getContextPath() %>/main" class="nav-brand">
            <span>🛡️ UserSystem</span>
        </a>
        <div class="nav-links">
            <div class="nav-user-info">
                <strong><%= user.getName() %></strong>님
                <span class="badge <%= user.isAdmin() ? "badge-admin" : "badge-user" %>">
                    <%= user.getRole() %>
                </span>
            </div>
            <a href="<%= request.getContextPath() %>/main" class="btn btn-outline">홈으로</a>
            <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">로그아웃</a>
        </div>
    </header>

    <main class="container">
        <!-- 알림 메시지 영역 -->
        <% if ("success".equals(msg)) { %>
            <div class="alert alert-success">
                ✅ 회원 정보가 성공적으로 수정되었습니다!
            </div>
        <% } else if ("fail".equals(msg)) { %>
            <div class="alert alert-danger">
                ❌ 회원 정보 수정 중 오류가 발생했습니다. 다시 시도해주세요.
            </div>
        <% } else if ("empty_name".equals(msg)) { %>
            <div class="alert alert-danger">
                ⚠️ 이름을 비워둘 수 없습니다. 이름을 입력해주세요.
            </div>
        <% } %>

        <!-- 회원 정보 및 수정 카드 -->
        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                <div>
                    <h2 class="card-title">내 정보 관리</h2>
                    <p class="card-desc" style="margin-bottom: 0;">현재 계정 정보를 확인하고 수정할 수 있습니다.</p>
                </div>
                <div>
                    <span class="badge <%= user.isAdmin() ? "badge-admin" : "badge-user" %>" style="font-size: 0.85rem; padding: 0.35rem 0.8rem;">
                        <%= user.isAdmin() ? "👑 관리자 계정" : "👤 일반 사용자" %>
                    </span>
                </div>
            </div>

            <form action="<%= request.getContextPath() %>/updateUser" method="post">
                <div class="form-group">
                    <label class="form-label" for="userId">아이디 (ID)</label>
                    <input type="text" id="userId" class="form-control" value="<%= user.getId() %>" readonly>
                    <div class="form-helper">아이디는 변경할 수 없습니다.</div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="userRole">권한 (Role)</label>
                    <input type="text" id="userRole" class="form-control" value="<%= user.getRole() %>" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label" for="userName">이름 (Name)</label>
                    <input type="text" id="userName" name="name" class="form-control" 
                           value="<%= user.getName() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="userPassword">새 비밀번호 (Password)</label>
                    <input type="password" id="userPassword" name="password" class="form-control" 
                           placeholder="변경할 비밀번호 입력 (미입력 시 기존 비밀번호 유지)">
                    <div class="form-helper">비밀번호를 변경하지 않으려면 빈칸으로 두세요.</div>
                </div>

                <div style="margin-top: 1.75rem; display: flex; gap: 0.75rem;">
                    <button type="submit" class="btn btn-primary">정보 수정 저장</button>
                    <a href="<%= request.getContextPath() %>/main" class="btn btn-outline">취소</a>
                </div>
            </form>
        </div>

        <!-- 관리자 전용: 회원 목록 조회 섹션 -->
        <% if (user.isAdmin()) { %>
            <div class="card" id="admin-section" style="border-top: 4px solid var(--danger);">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.75rem;">
                    <div>
                        <h2 class="card-title" style="color: #991b1b;">👑 관리자 전용: 전체 회원 목록</h2>
                        <p class="card-desc">등록된 모든 회원의 정보를 조회합니다. (총 <%= (userList != null ? userList.size() : 0) %>명)</p>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 80px;">No.</th>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>비밀번호 (암호화 전/마스킹)</th>
                                <th>권한(Role)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (userList != null && !userList.isEmpty()) {
                                    int count = 1;
                                    for (User u : userList) {
                            %>
                                <tr>
                                    <td><%= count++ %></td>
                                    <td><strong><%= u.getId() %></strong></td>
                                    <td><%= u.getName() %></td>
                                    <td><code><%= u.getPassword().length() > 2 ? u.getPassword().substring(0, 2) + "****" : "****" %></code></td>
                                    <td>
                                        <span class="badge <%= u.isAdmin() ? "badge-admin" : "badge-user" %>">
                                            <%= u.getRole() %>
                                        </span>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="5" style="text-align: center; color: var(--text-secondary); padding: 2rem;">
                                        등록된 회원이 없습니다.
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        <% } %>
    </main>
</body>
</html>
