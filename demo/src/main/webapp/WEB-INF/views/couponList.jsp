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
            success     : function(retVal){
                if(retVal.code == 0) {
                    alert(retVal.message);
                    location.href = "/coupon/list";  
                } else {
                    alert(retVal.message);
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
<div class="panel panel-default">
    <!--<form class="form-inline" id="frmSearch" action="/coupon/list">
        	<input type="hidden" id="pageNo" name="pageNo" value="">
        	<input type="hidden" id="pageSize" name="pageSize" value="">
    	</form>-->
</div>
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
<script type="text/javascript">
$(document).ready(function() {
	
	var firstPageClick = true;
    var totalPages     = ${totalPage};    //전체 페이지
    var pageSize       = ${pageSize};     //리스트 개수
    var pageNo         = ${pageNo};       //현재 페이지
    
    var url;
    var objListParams  = new Object();
    
	listCall(1);//페이지에 들어오자마자 실행
	
	function listCall(page){
		url="/coupon/list"
    	objListParams.pageNo   = pageNo;
    	objListParams.pageSize = pageSize;
        ajaxCall(url,objListParams);
	}
	
        function ajaxCall(reqUrl, reqData){
            console.log(reqUrl, reqData);
            $.ajax({
                url:reqUrl,
                type:"post",
                data:reqData,
                dataType:"json",
                success:function(d){                
                    if(retVal.code == 0){
                        showPage = d.pageNo; 
                        listPrint(d.couponList);
                        $('#pagination').twbsPagination({
                            startPage: d.pageNo,    //시작 페이지
                            totalPages: d.totalPage,    //총 페이지 갯수
                            visiblePages: d.pageSize,    //페이징 처리되어 보여줄 페이지 12345 밑에 그거임
                            onPageClick: function (event, page) {
                                console.log(event);
                                console.log(page);
                                listCall(page);
                            }
                        });
                    } else {
                        alert(retVal.message);
                    }
                },
                error : function(request, status, error){
                	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }
        
        //리스트 그리기
        //listCall이 성공하면 가져온 페이지를 보여준다.
        //로그인에 성공하여 리스트 페이지에 오면 페이징 처리되어 있지만 1페이지만을 가져온다.
        
        function listPrint(list){            
            var content="";                    
            for(var i=0; i<list.length; i++){
                content+="<tr>";
                content+="<td>"+list[i].bbsno+"</td>";
                content+="<td>"+list[i].user_id+"</td>";
                content+="<td>"+list[i].reg_date+"</td>";
                content+="<td>"+list[i].bHit+"</td>";    
                content+="</tr>";
            }                        
            $("#list").empty();
            $("#list").append(content);            
        }
});
</script>
</body>
</html>