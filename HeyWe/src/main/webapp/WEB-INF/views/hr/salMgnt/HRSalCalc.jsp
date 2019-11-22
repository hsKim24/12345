<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 연봉관리  </title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/salMgnt/HRSalCalc.css" />
<style type="text/css">
</style>

<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#page").val()==""){
		$("#page").val("1");
	}
	reloadList();
	
	$(".paging_group").on("click","div" ,function(){
		$("#page").val($(this).attr("name"));
		reloadList();
	});

	$("#searchBtn").on("click",function(){
		reloadList();
	});
	
	$("#searchTxt").on("keypress",function(event) {
		if(event.keyCode == 13) {
			$("#searchBtn").click();
			return false;
		}
	});
});

function reloadList(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRSalCalcListAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			redrawList(result.list);
			//redrawPaging(result.pb);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function salCalcApv(){
	
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRsalCalcApvAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			makeAlert(2,"성공","정상적으로 결재가 신청되었습니다.","false",function(){
				reloadList();
			});
		},
		error : function(request, status, error){
			makeAlert(2,"실패","결재 신청에 실패하였습니다.","false",null);
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

function redrawList(list){
	var html="";
	if(list.length == 0){
		html += "<tr><td colspan=\"9\">조회결과가 없습니다</td><tr>";
	} else {
		for(var i = 0; i < list.length; i++){
			if(i%2==0){
				html +=	"<tr height= \"20\" name=\"" + list[i].EMP_SAL_NO + "\" class=\"A\">";
			}else{
				html +=	"<tr height= \"20\" name=\"" + list[i].EMP_SAL_NO + "\" class=\"B\">";
			}
			html +=	"	<td >"+list[i].RNUM+"</td>";
			html +=	"	<td>"+list[i].EMP_NO+"</td>";
			html +=	"	<td>"+list[i].NAME+"</td>";
			html +=	"	<td>"+list[i].DEPT_NAME+"</td>";
			html +=	"	<td>"+list[i].POSI_NAME+"</td>";
			html +=	"	<td>"+list[i].AUTH_NAME+"</td>";
			if(list[i].SAL == '0'){
				html +=	"	<td><input type=\"number\" style=\"width:100%;\"/></td>";
				html +=	"	<td>"+list[i].STD_YEAR+"</td>";
				html +=	"	<td><input type=\"button\" class = \"oneSaveBtn\" value=\"저장\" style=\"width:70%;\"/></td>";
			}else{
				html +=	"	<td>"+list[i].SAL+"</td>";
				html +=	"	<td>"+list[i].STD_YEAR+"</td>";
				html +=	"	<td><input type=\"button\" class = \"oneUpdateBtn\" value=\"수정\" style=\"background-color:yellow;color:black;width:70%;\"/>";
				html += "<input type=\"button\" class = \"oneUpdateBtn2\" value=\"저장\" style=\"width:70%; display : none;\"/></td>";
			}
			html +=	"</tr>";
		}
	}
	$("#salCalcArea2").html(html);
	$(".oneSaveBtn").click(function(){
		$("#oneEmpNo").val($(this).parent().parent().children().eq(1).html());
		$("#oneStdYear").val($(this).parent().parent().children().eq(7).html()+"-01-01");
		$("#oneEmpSal").val($(this).parent().parent().children().eq(6).children().val());
		console.log($("#oneEmpNo").val());
		console.log($("#oneEmpSal").val());
		console.log($("#oneStdYear").val());
		oneSaveBtnAjax();
	});
	$(".oneUpdateBtn").click(function(){
		var sal = "";
		sal = $(this).parent().parent().children().eq(6).html();
		console.log(sal);
		var text = "";
		text += "<input type=\"number\" style=\"width:100%;\" value = \""+sal+"\"/>";
		console.log(text);
		$(this).parent().parent().children().eq(6).html(text);
		$(this).css("display","none");
		$(this).parent().children().eq(1).css("display","");
		 /* $(this).attr("class","oneUpdateBtn2");  */
	});
	
	$(".oneUpdateBtn2").click(function(){
		$("#oneEmpSalNo").val($(this).parent().parent().attr("name"));
		console.log($("#oneEmpSalNo").val());
		$("#oneEmpSal").val($(this).parent().parent().children().eq(6).children().val());
		console.log($("#oneEmpSal").val());
		oneUpdateBtnAjax(); 
	});
}

function oneUpdateBtnAjax(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRoneUpdateBtnAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.res!=0){
				makeAlert(2,"성공","저장 되었습니다.","false",function(){
					reloadList();
				});
			}else{
				makeAlert(2,"실패","저장에 실패하였습니다.","false",null);
			}
		},
		error : function(request, status, error){
			makeAlert(2,"실패","저장에 실패하였습니다.","false",null);
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

function oneSaveBtnAjax(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HROneSaveBtnAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.res!=0){
				makeAlert(2,"성공","저장 되었습니다.","false",function(){
					reloadList();
				});
			}else{
				makeAlert(2,"실패","저장에 실패하였습니다.","false",null);
			}
		},
		error : function(request, status, error){
			makeAlert(2,"실패","저장에 실패하였습니다.","false",null);
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

/* 
function apvSalCalc(Con){
	var expCon="";
	expCon += Con;
	expCon += "   </tbody>";
	expCon += "</table>";
	return expCon;
}
 */
</script>
</head>
<body>

<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
   <%-- <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param> --%>
    <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>



<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 연봉관리 </div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">연봉관리 </div>
	</div>
	<div class="content_area_table_area">
<!-- 	<div id = "info">
		<div id="prev" >prev</div>
		<div id="month" >19년 4월</div>
		<div id="next" >next</div>
	</div> -->
	
	<div id = "searchDiv">
		<div class = "content_area_input_area_sub">
			<form action="#" id="dataForm" method="post">
				<%-- <input type="hidden" name="page" id="page" value="${page}"/> --%>
<!-- 				<input type="hidden" id="title" name="title" value="급여결재" />
				<input type="hidden" id="apvDocTypeNo" name="apvDocTypeNo"  value=""/>
				<input type="hidden" id="con" name="con" value="급여결재" />
				<input type="hidden" id="impDate" name="impDate" value=""  /> start date 박자
				<input type="hidden" id="expCon" name="expCon"/> 
				<input type="hidden" id="outApvTypeNo" name="outApvTypeNo"  value="2"/> 급여결재는 2
				<input type="hidden" id="connectNo" name="connectNo" value="0"/>
				<input type="hidden" id="apverNos" name="apverNos" />
				<input type="hidden" id="allApvWhether" name="allApvWhether" value="1" />전결가능여부
				<input type="hidden" id="salCalcList" name="salCalcList" /> -->
				<input type="hidden" id="oneEmpNo" name="oneEmpNo" /> 
				<input type="hidden" id="oneEmpSal" name="oneEmpSal" /> 
				<input type="hidden" id="oneStdYear" name="oneStdYear" /> 
				<input type="hidden" id="oneEmpSalNo" name="oneEmpSalNo" /> 
				
			
					<!-- 부서이름 뽑아오기 -->
				<select id = "deptGbn" name="deptGbn">
						<option value="900">전체</option>
					<c:forEach var="data"  items="${deptList}">
						<option value="${data.DEPT_NO}">${data.DEPT_NAME}</option>
					</c:forEach>
				</select> 
					<!-- 부서이름 뽑아오기 -->
				<select id = "stdYear" name="stdYear">
					<c:forEach var="data"  items="${stdList}">
						<option value="${data.STD_YEAR}">${data.STD_YEAR}</option>
					</c:forEach>
				</select> 
				
				<div style="display : inline-block; font-size: 16px; ">사원명</div>
				<input type="text" name="searchTxt" id="searchTxt" value=""/>
				
			<input type="button" id="searchBtn" value = "검색"/>
		</form>
		</div>
		<!-- <input type="button"  id = "signupBtn" value = "전체 저장"/> -->
	</div>
		
			<table id = "table_va" border = "1" cellspacing="0">
				<colgroup>
					<col width="20"/>
					<col width="60"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
				</colgroup>
				<thead></thead>
					<tbody id = "salCalcArea">
						<tr height= "20" id = "table_color">          
							<!-- <th><input type="checkbox" id="cAll"/></th>   --> 
							<th></th>         <!-- RNUM -->                               
							<th>사원코드</th>   <!-- EMP_NO -->                                   
							<th>이름</th>      <!-- NAME -->                    
							<th>부서</th>      <!-- DEPT_NAME -->                                
							<th>직급</th>      <!-- POSI_NAME -->                               
							<th>직책</th>      <!-- AUTH_NAME -->                               
							<th>연봉</th>      <!-- SAL -->                               
							<th>기준년도</th>    <!-- STD_YEAR -->                                 
							<th></th>                                   
						</tr> 											
					</tbody>
			</table>
				<div  style="overflow-y:auto; overflow-x:hidden; width:100%; height:500px;">
					<table id = "table_va2" border = "1" cellspacing="0">
						<colgroup>
							<col width="20"/>
							<col width="60"/>
							<col width="80"/>
							<col width="80"/>
							<col width="80"/>
							<col width="80"/>
							<col width="80"/>
							<col width="80"/>
							<col width="80"/>
						</colgroup>
						<thead></thead>
						<tbody id = "salCalcArea2">
						
						</tbody>
					</table>
				</div>
		
		<!-- <div class="paging_group">
		
		</div> -->
	</div>
	
	
</div>

</body>
</html>