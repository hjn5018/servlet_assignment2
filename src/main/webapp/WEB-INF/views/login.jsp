<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String inputUserId = (String) request.getAttribute("inputUserId");
    if (inputUserId == null) inputUserId = "";
    String loginMsg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 사용자 관리 시스템</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <header class="navbar">
        <a href="<%= request.getContextPath() %>/main" class="nav-brand">
            <span>🛡️ UserSystem</span>
        </a>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/main" class="btn btn-outline">홈으로</a>
        </div>
    </header>

    <main class="container container-narrow">
        <div class="card">
            <h2 class="card-title" style="text-align: center; margin-bottom: 0.25rem;">로그인</h2>
            <p class="card-desc" style="text-align: center;">계정 아이디와 비밀번호를 입력해주세요.</p>

            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="alert alert-danger">
                    ⚠️ <%= errorMessage %>
                </div>
            <% } else if ("deleted".equals(loginMsg)) { %>
                <div class="alert alert-success">
                    ✅ 회원 탈퇴가 성공적으로 처리되었습니다. 이용해 주셔서 감사합니다.
                </div>
            <% } else if ("registered".equals(loginMsg)) { %>
                <div class="alert alert-success">
                    ✅ 회원가입이 완료되었습니다! 로그인해주세요.
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/login" method="post">
                <div class="form-group">
                    <label class="form-label" for="userId">아이디</label>
                    <input type="text" id="userId" name="id" class="form-control" 
                           placeholder="아이디를 입력하세요" value="<%= inputUserId %>" required autofocus>
                </div>

                <div class="form-group">
                    <label class="form-label" for="userPw">비밀번호</label>
                    <input type="password" id="userPw" name="password" class="form-control" 
                           placeholder="비밀번호를 입력하세요" required>
                </div>

                <div style="margin-top: 1.5rem;">
                    <button type="submit" class="btn btn-primary btn-block">로그인</button>
                </div>
            </form>

            <div style="margin-top: 1.5rem; padding-top: 1rem; border-top: 1px solid var(--border-color); font-size: 0.85rem; color: var(--text-secondary);">
                <strong>💡 테스트 계정 안내</strong><br>
                - 일반 사용자: ID <code>user1</code> / PW <code>1234</code><br>
                - 관리자 계정: ID <code>admin</code> / PW <code>1234</code>
            </div>

            <div style="margin-top: 1rem; text-align: center;">
                <a href="<%= request.getContextPath() %>/register"
                   style="font-size: 0.88rem; color: var(--primary); text-decoration: none; font-weight: 600;">
                    처음 이용하세요? 회원가입 &rarr;
                </a>
            </div>
        </div>
    </main>
</body>
</html>
