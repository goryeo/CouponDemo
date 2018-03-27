<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CouponList</title>
<link rel="shortcut icon" href="/resources/image/icon/favicon.ico">
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="/resources/bootstrap/css/datepicker.min.css" />
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<script src="//code.jquery.com/jquery.js"></script>
<!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
<script src="/resources/bootstrap/js/respond.js"></script>
<script src="/resources/bootstrap/js/jquery.number.min.js"></script>
<script src="/resources/bootstrap/js/jssor.slider.mini.js"></script>
<script src="/resources/bootstrap/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
</script>
</head>
<title>CouponList</title>
</head>
<body>
    <h3>CouponList</h3>
        <form class="form-inline" id="frmSearch" action="/coupon/list">
            <input type="hidden" id="startPage" name="startPage" value="">
            <input type="hidden" id="visiblePages" name="visiblePages" value="">
        </form>
            <div class="container">
                <table class="table">
                    <tr>
                        <td align="right">
                            <button class="btn btn-primary" style="float:left;" id="create" name="create">Create Coupon</button>
                        </td>
                    </tr>
                </table>
                <table class="table">
                <div class="col-md-12" style="text-align:right">
                    <button class="btn btn-default" id="search">조회</button>
                </div>
			        <tr>
			            <th>ID</th>
			            <th>Email</th>
			            <th>Coupon</th>
			            <th>Datetime</th>
			        </tr>
                    <c:choose>
                        <c:when test="${fn:length(couponList) == 0}">
                            <tr>
                                <td colspan="4" align="center">
                                                            조회결과가 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="row" items="${couponList}" varStatus="status">
						        <tr>
						            <td>${row.couponID}</td>
						            <td>${row.emailAddr}</td>
						            <td>${row.couponNo}</td>
						            <td>${row.regdate}</td>
						        </tr>
                            </c:forEach>
                        </c:otherwise> 
                    </c:choose>
                </table>
                <br>
                <div class="col-md-12" align="center">
                    <ul id="pagination" class="pagination"></ul>
                </div>
            </div>
            <script src="/resources/bootstrap/js/jquery.twbsPagination.js"></script>
            <script type="text/javascript">
            $(document).ready(function() {
                 
                $("#search").click(function(){
                    $("#frmSearch").submit();
                });
                     
                var totalPages = ${totalPage};//전체 페이지
                var visiblePages = 10;//리스트 보여줄 페이지
                var startPage = ${startPage};//현재 페이지
                 
                $("#pagination").twbsPagination({
                    totalPages: totalPages,
                    visiblePages: visiblePages,
                    startPage: startPage,
                    onPageClick: function (event, page) {
                        $('#startPage').val(page);//보고 싶은 페이지
                        $('#visiblePages').val(visiblePages);
                        $("#frmSearch").submit();
                    }
                });
            });
            </script>
    </body>
</html>