<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String inputId   = (String) request.getAttribute("inputId");
    String inputName = (String) request.getAttribute("inputName");
    if (inputId   == null) inputId   = "";
    if (inputName == null) inputName = "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 사용자 관리 시스템</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <header class="navbar">
        <a href="<%= request.getContextPath() %>/main" class="nav-brand">
            <span>🛡️ UserSystem</span>
        </a>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/login" class="btn btn-outline">로그인</a>
        </div>
    </header>

    <main class="container container-narrow">
        <div class="card">
            <div style="text-align: center; margin-bottom: 1.5rem;">
                <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">✨</div>
                <h2 class="card-title" style="margin-bottom: 0.25rem;">회원가입</h2>
                <p class="card-desc" style="margin-bottom: 0;">새 계정을 만들어 서비스를 이용하세요.</p>
            </div>

            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="alert alert-danger">
                    ⚠️ <%= errorMessage %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/register" method="post" id="registerForm" novalidate>
                <div class="form-group">
                    <label class="form-label" for="regId">아이디</label>
                    <input type="text" id="regId" name="id" class="form-control"
                           placeholder="4~20자 영문·숫자" value="<%= inputId %>"
                           minlength="4" maxlength="20" required autofocus>
                    <div class="form-helper">4~20자 사이로 입력해주세요.</div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="regName">이름</label>
                    <input type="text" id="regName" name="name" class="form-control"
                           placeholder="실명 또는 닉네임" value="<%= inputName %>"
                           maxlength="50" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="regPw">비밀번호</label>
                    <input type="password" id="regPw" name="password" class="form-control"
                           placeholder="비밀번호를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="regPw2">비밀번호 확인</label>
                    <input type="password" id="regPw2" name="password2" class="form-control"
                           placeholder="비밀번호를 한 번 더 입력하세요" required>
                    <div id="pwMatchMsg" class="form-helper"></div>
                </div>

                <div style="margin-top: 1.75rem; display: flex; flex-direction: column; gap: 0.75rem;">
                    <button type="submit" class="btn btn-primary btn-block" id="submitBtn">가입하기</button>
                    <a href="<%= request.getContextPath() %>/login" class="btn btn-outline btn-block"
                       style="text-align: center;">이미 계정이 있으신가요? 로그인</a>
                </div>
            </form>
        </div>
    </main>

    <script>
        // 비밀번호 실시간 일치 확인
        const pw  = document.getElementById('regPw');
        const pw2 = document.getElementById('regPw2');
        const msg = document.getElementById('pwMatchMsg');

        function checkPw() {
            if (pw2.value === '') {
                msg.textContent = '';
                msg.style.color = '';
                return;
            }
            if (pw.value === pw2.value) {
                msg.textContent = '✅ 비밀번호가 일치합니다.';
                msg.style.color = '#047857';
            } else {
                msg.textContent = '❌ 비밀번호가 일치하지 않습니다.';
                msg.style.color = '#b91c1c';
            }
        }

        pw.addEventListener('input', checkPw);
        pw2.addEventListener('input', checkPw);

        // 제출 전 최종 검증
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            if (pw.value !== pw2.value) {
                e.preventDefault();
                msg.textContent = '❌ 비밀번호가 일치하지 않습니다.';
                msg.style.color = '#b91c1c';
                pw2.focus();
            }
        });
    </script>
</body>
</html>
