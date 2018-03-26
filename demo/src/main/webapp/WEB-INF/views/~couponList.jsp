<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List</title>
</head>
<title>쿠폰 목록</title>
</head>
<body>
    <h3>쿠폰 목록</h3>
    <button class="btn btn-primary" style="float : left;" onclick="location.href='/list/post'">쿠폰생성</button>
    <br>
    <br>
    <table class="table">
        <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Coupon</th>
            <th>Datetime</th>
        </tr>
        <c:forEach var="l" items="${list}">
        <tr>
            <td>${l.CouponID}</td>
            <td>${l.EmailAddr}</td>
            <td>${l.CouponNo}</td>
            <td>${l.regdate}</td>
        </tr>
        </c:forEach>
    </table> 
<%@ include file="bootstrap.jsp" %>
</body>
</html>