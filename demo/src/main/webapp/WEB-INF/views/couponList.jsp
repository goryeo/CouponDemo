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

	var firstPageClick = true;
    var objListParams  = new Object();
    var jsonListData   = null;
	
    //리스트 첫 페이지 최초 호출
    listCall(1, 10);
    
	function listCall(page, pageSize){
    	objListParams.pageNo   = page;
    	objListParams.pageSize = pageSize;
    	jsonListData = JSON.stringify(objListParams);
        ajaxCall(jsonListData);
	}
	
	function ajaxCall(objJsonParams){
	    $.ajax({
	        url 	    : "/coupon/list",
	        type        : "post",
	        contentType : "application/json",
	        data        : objJsonParams,
	        dataType    : "json",
	        success:function(data){                
	            if(data.code == 0){
	            	
	                listPrint(data.couponList);
	                
	                $('#pagination').twbsPagination({
	                    startPage: data.pageNo,    //시작 페이지
	                    totalPages: data.totalPage,    //총 페이지 갯수
	                    visiblePages: data.pageSize,    //페이징 처리되어 보여줄 페이지 12345 밑에 그거임
	                    onPageClick: function (event, page) {
	                    	if(firstPageClick) {
	                            firstPageClick = false;
	                            return;
	                     	}
	                    	else{
	                    		listCall(page, data.pageSize);	
	                    	}
	                    }
	                });
	            } else {
	                alert(data.message);
	            }
	        },
	        error : function(request, status, error){
	        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
	    });
	}
    
    //리스트 그리기
    function listPrint(list){            
        var content="";                    
        for(var i=0; i<list.length; i++){
            content += "<tr class=text-center>";
            content += "<td>" + list[i].intCouponID  + "</td>";
            content += "<td>" + list[i].strEmailAddr + "</td>";
            content += "<td>" + list[i].strCouponNo  + "</td>";
            content += "<td>" + list[i].strRegDate   + "</td>";    
            content += "</tr>";
        }                        
        $("#list").empty();
        $("#list").append(content);            
    }
    
    $("#create").click(function(){
        
    	var strEmailAddr = $("#email").val();
    	var strRegExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    	
        //유효성 검사
        if(strEmailAddr.trim() == ""){
            alert("이메일을 입력해주세요.");
            $("#email").focus();
            return false;
        }
        
        if (!strRegExp.test(strEmailAddr)) {
            alert("이메일 주소가 유효하지 않습니다.");
            $("#email").focus();
            return false;
        }
        
        var objParams = new Object();
            objParams.strEmailAddr = strEmailAddr;
            
        var jsonData = JSON.stringify(objParams);
        
        //쿠폰 생성
        $.ajax({
            url         : "/coupon/create",
            type        : "post",
            contentType : "application/json",
            dataType    : "json",
            data        : jsonData,
            success     : function(data){
                if(data.code == 0) {
                    alert(data.message);
                    listCall(1, 10);
                    $("#email").val("");
                    $("#email").focus();
                } else {
                    alert(data.message);
                }
            },
            error : function(request, status, error){
            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    });
});
</script>
</head>
<body>
<div class="container">
<h3>CouponList</h3>
<div class="row">
    <div class="col-md-12" style="text-align:left">
        * 이메일을 입력해주세요.
    </div>
    <br>
    <div class="col-md-12" style="text-align:left">
        <input type="text" id="email" name="email" style="width:300px;" placeholder="example@domain.com" maxlength="200" value=""/>
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
            <!-- Default panel contents -->
                <div class="panel-heading"><span class="glyphicon glyphicon-list"></span> 
                Results
                </div>
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
				<tbody id="list">
		            <!-- 리스트가 출력될 영역 -->
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
</body>
</html>