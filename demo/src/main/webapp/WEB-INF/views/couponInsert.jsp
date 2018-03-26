<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Form</title>
</head>
<body>
<h2> *이메일을 입력하세요 </h2>
 
<div class="container">
    <form action="/list/post" method="post">
      <div class="form-group">
        <label for="email">쿠폰생성</label>
        <input type="text" class="form-control" id="email" name="emailAddr" placeholder="이메일을 입력하세요.">
      </div>
      <button type="submit" class="btn btn-primary">생성</button>
    </form>
</div>
<%@ include file="bootstrap.jsp" %>
</body>
</html>