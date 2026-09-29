-- 1. 데이터베이스 생성 및 선택
CREATE DATABASE IF NOT EXISTS springdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE springdb;

-- 2. users 테이블 생성
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user'
);

-- 3. 초기 테스트 데이터 등록
-- 관리자 계정 (ID: admin, PW: 1234, ROLE: admin)
INSERT INTO users (id, password, name, role) 
VALUES ('admin', '1234', '시스템 관리자', 'admin');

-- 일반 회원 계정 (ID: user1, PW: 1234, ROLE: user)
INSERT INTO users (id, password, name, role) 
VALUES ('user1', '1234', '홍길동', 'user');

-- 일반 회원 계정 2 (ID: user2, PW: 1234, ROLE: user)
INSERT INTO users (id, password, name, role) 
VALUES ('user2', '1234', '이순신', 'user');

-- 데이터 확인
SELECT * FROM users;
