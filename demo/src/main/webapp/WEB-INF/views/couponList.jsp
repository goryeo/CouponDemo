<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CouponList</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<script src="//code.jquery.com/jquery.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/bootstrap/js/respond.js"></script>
<script src="/resources/bootstrap/js/jquery.number.min.js"></script>
<script src="/resources/bootstrap/js/jquery.twbsPagination.js"></script>
<script type="text/javascript">
$(document).ready(function() {

    $("#create").click(function(){
                 
        //유효성 검사
        if($("#email").val().trim() == ""){
            alert("이메일을 해주세요.");
            $("#email").focus();
            return false;
        }

        var objParams = {
            email : $("#email").val(),
        };
         
        //쿠폰 생성
        $.ajax({
            url         : "/coupon/create",
            dataType    : "json",
            contentType : "application/x-www-form-urlencoded; charset=UTF-8",
            type        : "post",
            data        : objParams,
            success     : function(retVal){
                if(retVal.code == "OK") {
                    alert(retVal.message);
                    location.href = "/coupon/list";  
                } else {
                    alert(retVal.message);
                }
            },
            error : function(request, status, error){
                console.log("AJAX_ERROR");
            }
        });
    });
});
</script>
</head>
<body>
<div class="container">
<h3>CouponList</h3>
<div class="panel panel-default">
    <form class="form-inline" id="frmSearch" action="/coupon/list">
        <input type="hidden" id="pageNo" name="pageNo" value="">
        <input type="hidden" id="pageSize" name="pageSize" value="">
    </form>
</div>
<div class="row">
    <div class="col-md-12" style="text-align:left">
        * 이메일을 입력해주세요.
    </div>
    <br>
    <div class="col-md-12" style="text-align:left">
        <input type="text" id="email" name="email" style="width:300px;" placeholder="example@domain.com" value=""/>
    </div>
    <br>
    <div class="col-md-12" style="text-align:left">
        <button class="btn btn-primary" id="create" name="create">Create Coupon</button>
    </div>
</div>
<br>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <!-- Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover specialCollapse">
                    <thead>
                        <tr>
                            <th class="text-center">ID</th>
                            <th class="text-center">Email</th>
                            <th class="text-center">Coupon</th>
                            <th class="text-center">Datetime</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${fn:length(couponList) == 0}">
                            <tr>
                                <td colspan="4" align="center">조회결과가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="row" items="${couponList}" varStatus="status">
                                <tr>
                                    <td align="center">${row.couponid}</td>
                                    <td align="center">${row.emailaddr}</td>
                                    <td align="center">${row.couponno}</td>
                                    <td align="center"><fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="col-md-12" align="center">
                <ul id="pagination" class="pagination"></ul>
            </div>
        </div>
    </div>
</div>
</div>
<script src="/resources/bootstrap/js/jquery.twbsPagination.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    
    var firstPageClick = true;
    var totalPages     = ${totalPage};    //전체 페이지
    var pageSize       = 10;              //리스트 개수
    var pageNo         = ${pageNo};    //현재 페이지
     
    $("#pagination").twbsPagination({
        totalPages  : totalPages,
        visiblePages: pageSize,
        startPage   : pageNo,
        onPageClick: function (event, pageNo) {
            if(firstPageClick) {
                   firstPageClick = false;
                   return;
            }
            $('#pageNo').val(pageNo);
            $('#pageSize').val(pageSize);
            $("#frmSearch").submit();
        }
    });
});
</script>
</body>
</html>