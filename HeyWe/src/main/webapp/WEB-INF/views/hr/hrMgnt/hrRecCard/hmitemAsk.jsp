<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 인사기록카드 </title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/hrRecCard/hmitemAsk.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#auth").val() != 3){
		$("#reg").css("display", "none");
		$("#update").css("margin-left", "475px");
	}
	
	$("#hmitemBtn").on("click", function(){
		$(".tabbtn_area [type='button']").removeClass("on");
    	$(this).attr("class", "on");
    	reloadHmItem();
		$("#hmitem").css("display","")
		$("#aabty").css("display","none")
		$("#qlfc").css("display","none")
		$("#career").css("display","none")
		$("#family").css("display","none")

	});

	$("#aabtyBtn").on("click", function(){
		$(".tabbtn_area [type='button']").removeClass("on");
    	$(this).attr("class", "on");
    	redrawAAbty();
		$("#hmitem").css("display","none")
		$("#aabty").css("display","")
		$("#qlfc").css("display","none")
		$("#career").css("display","none")
		$("#family").css("display","none")

	});
	
	$("#qlfcBtn").on("click", function(){
		$(".tabbtn_area [type='button']").removeClass("on");
    	$(this).attr("class", "on");
    	redrawQlfc();
		$("#hmitem").css("display","none")
		$("#aabty").css("display","none")
		$("#qlfc").css("display","")
		$("#career").css("display","none")
		$("#family").css("display","none")

	});

	$("#careerBtn").on("click", function(){
		$(".tabbtn_area [type='button']").removeClass("on");
    	$(this).attr("class", "on");
    	redrawCareer();
		$("#hmitem").css("display","none")
		$("#aabty").css("display","none")
		$("#qlfc").css("display","none")
		$("#career").css("display","")
		$("#family").css("display","none")

	});
	
	$("#familyBtn").on("click", function(){
		$(".tabbtn_area [type='button']").removeClass("on");
    	$(this).attr("class", "on");
    	redrawfamilyInfo();
		$("#hmitem").css("display","none")
		$("#aabty").css("display","none")
		$("#qlfc").css("display","none")
		$("#career").css("display","none")
		$("#family").css("display","")

	});
	
	$("#hmitemBtn").click();
	
	$("#reg").on("click",function(){
		location.href = "HRHmitemReg";
	});

	$("#update").on("click", function(){
		//시스템관리자와 인사부서만 모든 사원의 인사기록카드를 수정 할 수 있음.
		if($("#sAuthNo").val() == 0 || $("#sAuthNo").val() == 1 || $("#sAuthNo").val() ==2){
			makePopup(1, "사원조회", empPopup() , true, 700, 386, function(){
				$("#selectEmpFlag").val("0");
				popUpSearch();
				
				$("#listDiv").slimScroll({
					height: "170px",
					axis: "both"
				});
				
				$("#search_btn").on("click", function(){
					popUpSearch();
				});
				
				$("#search_txt").keyup(function(event){
					if(event.keyCode == '13'){
						popUpSearch();
					}
				});
				
				$("#listCon tbody").on("click", "tr", function(){
					$("#listCon tr").css("background-color", "");
					$(this).css("background-color", "#B0DAEC");
					$("#selectEmpNo").val($(this).attr("name"));
					$("#selectEmpFlag").val("1");
				});
				
			}, "선택", function(){ 
				if($("#selectEmpFlag").val() == "1"){
					$("#dataForm").submit();
				}else{
					makeAlert(2, "사원조회", "사원을 선택해주세요.", true, null);
				}
				
				closePopup(1);
			});
		}else{
			$("#selectEmpNo").val($("#empNo").val());
			$("#dataForm").submit();
		}
		
	});
});

function drawEmpSearchList(list){
	var html = "";
	
	if(list.length == 0){
		html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
		html += "<tr class=\"even_row\"><td colspan=\"2\"></td></tr>";
		html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
		html += "<tr class=\"even_row\"><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
		html += "<tr class=\"even_row\"><td colspan=\"2\"></td></tr>";
		html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
	}else {
		for(var i = 0 ; i < list.length ; i++){
			if(i % 2 == 0){
				html += "<tr class=\"odd_row\" name=\""+ list[i].EMP_NO + "\">";
			}else {
				html += "<tr class=\"even_row\" name=\""+ list[i].EMP_NO + "\">";
			}
			html += "<td>" + list[i].DEPT_NAME + "</td>";
			html += "<td>" + list[i].NAME + "</td>";
			html += "</tr>";
		}
	}
	
	$("#listCon tbody").html(html);
}

function empPopup(){
	var html="";
	
	html += "<div id=\"empSearch\">";
	html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_txt\">";
	html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
	html += "</div>";
	html += "<div id=\"list\">";
	html += "<table id=\"listTop\">";
	html += "<colgroup>";
	html += "<col width=\"330px\">";
	html += "<col width=\"300px\">";
	html += "</colgroup>";
	html += "<tr>";
	html += "<th>부서명</th>";
	html += "<th>이름</th>";
	html += "</tr>";
	html += "</table>";
	html += "<div id=\"listDiv\">";
	html += "<table id=\"listCon\">";
	html += "<colgroup>";
	html += "<col width=\"330px\">";
	html += "<col width=\"300px\">";
	html += "</colgroup>";
	html += "<tbody>";
	html += "</tbody>";
	html += "</table>";
	html += "</div>";
	html += "</div>";
	
	return html;
}

function popUpSearch(){
	$("#empSearchTxt").val($.trim($("#search_txt").val()));
	
	var params = $("#dataForm").serialize(); 
	
	$.ajax({
		type : "post",
		url : "HREmpSearchAjax",
		dataType : "json",
		data : params,
		success : function(result){
			drawEmpSearchList(result.list);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadHmItem(){    // 인적사항 
	var params = $("#dataForm").serialize();
	   
	   $.ajax({
	      type : "post",
	      url : "HRHmitemAskAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  redrawHmItem(result.data, result.data2);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}



function redrawAAbtyCon(){   //학력  
	var params = $("#dataForm").serialize();
	   
	   $.ajax({
	      type : "post",
	      url : "HRAAbtyAskAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  redrawAAbtyConInsert(result.list3);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}


function redrawQlfcCon(){ // 자격증 
	var params = $("#dataForm").serialize();
	   
	   $.ajax({
	      type : "post",
	      url : "HRQlfcAskAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) { 
	    	  redrawQlfcConInsert(result.list);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}


function redrawCareerCon(){ //경력   
	var params = $("#dataForm").serialize();
	   
	   $.ajax({
	      type : "post",
	      url : "HRCareerAskAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  redrawCareerConInsert(result.list2);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}


function redrawfamilyCon(){ //가족정보   
	var params = $("#dataForm").serialize();
	   
	   $.ajax({
	      type : "post",
	      url : "HRFamilyInfoAskAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  redrawfamilyConInsert(result.list4);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}



function redrawHmItem(data,data2) {
	var html ="";
		
		html += "<div class=\"hmitem\">";
		
			html += "<div class=\"tab_txt\">사원정보</div>"
			html += "<div class=\"tabcnt_area\">";
			html += "<div class=\"tabcnt_img\">";
			if(data.PIC != null){
				html += "<img alt=\" \" src=\"resources/upload/" + data.PIC + "\" />";
			}else{
				html += "<img alt=\" \" src=\"resources/images/erp/common/nopic.jpg\" />";
			}
			html += "</div>";
			html += "</div>";
			
			html +="<table class=\"tab_table_a\">";
			html +="<clogroup>"
			html +="<col width=\"40px\" />";
			html +="<col width=\"70px\" />";
			html +="<col width=\"40px\" />";
			html +="<col width=\"50px\" />";
			html +="</colgrouop>";
			
			html +="<tbody>";
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">성명</td>";
			html +="<td class=\"tab_a\">" + data.NAME + "</td>";
			html +="<td class=\"tab_cntt\">주민등록번호</td>";
			html +="<td class=\"tab_a\">" + data.RRNUM1 + "-" + data.RRNUM2 + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">입사일</td>";
			html +="<td class=\"tab_a\">" + data2.APNT_DATE + "</td>"; 
			html +="<td class=\"tab_cntt\">E-mail</td>";
			html +="<td class=\"tab_a\">" + data.EMAIL + "</td>"
			html +="</tr>"
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">직위</td>";
			html +="<td class=\"tab_a\">" + data.POSI_NAME + "</td>"; 
			html +="<td class=\"tab_cntt\">휴대폰</td>";
			html +="<td class=\"tab_a\">" + data.MOBILE_NO + "</td>";
			html +="</tr>";
			
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">부서명</td>";
			html +="<td class=\"tab_a\">" + data.DEPT_NAME + "</td>"; 
			html +="<td class=\"tab_cntt\">내선번호</td>"
			html +="<td class=\"tab_a\">" + data.EXTE + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">우편번호</td>";
			html +="<td class=\"tab_a\">" + data.POST_NO + "</td>"; 
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\" rowspan=\"2\">주소</td>";
			html +="<td class=\"tab_a\" colspan=\"3\">" + data.ADDR + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_a\" colspan=\"3\">" + data.DTL_ADDR + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">권한</td>";
			html +="<td class=\"tab_a\" colspan=\"3\">" + data.AUTH_NAME + "</td>";
			html +="</tr>";
			
			html +="</tbody>";
			html +="</table>";
			
			html +="<div class=\"tab_txt\">인적사항</div>";
			
			html +="<table class=\"tab_tables\">";
			html +="<tboby>";
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">결혼여부</td>";
			html +="<td class=\"tab_a\">" + data.CD_MARRY + "</td>";
			html +="<td class=\"tab_cntt\">병역구분</td>";
			html +="<td class=\"tab_a\">" + data.CD_MILSERV + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">장애여부</td>";
			html +="<td class=\"tab_a\">" + data.CD_DISA + "</td>";
			html +="<td class=\"tab_cntt\">계급</td>";
			html +="<td class=\"tab_a\">" + data.MILRNK + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"tab_cnt\">";
			html +="<td class=\"tab_cntt\">장애구분</td>";
			html +="<td class=\"tab_a\" colspan=\"3\">" + data.DISA_CON + "</td>";
			html +="</tr>";
			
			html +="</tbody>";
			html +="</table>";
		html +="</div>"
		
		$("#hmitem").html(html);
}	


function redrawQlfc(){  // 테이블 그림
	var html="";  
	
	html +="<div class=\"qlfc\">";
		html +="<div class=\"tab_txt_area\">";
		html +="<div class=\"tab_txt_area_head\">자격면허</div>";
		html +="</div>"
		
		html +="<table class=\"tab_table\" border=\"1px\" cellspacing=\"0\">"; 
		html +="<colgroup>";
		html +="<col width=\"20px\" />";
		html +="<col width=\"100px\" />";
		html +="<col width=\"90px\" />";
		html +="<col width=\"80px\" />";
		html +="<col width=\"40px\" />";
		html +="</colgroup>";
		
		
		html +="<thead>";
		html +="<tr class=\"tabtitle\">";
		html +="<th>No</th>";
		html +="<th>자격증명</th>";
		html +="<th>취득일</th>";
		html +="<th>취득처</th>";
		html +="<th>자격번호</th>";
		html +="</tr>";
		html +="</thead>";
		
		html +="<tbody>";
		
		html +="</tbody>";
		
		html +="</table>";
	html +="</div>";
		
		$("#qlfc").html(html);

	redrawQlfcCon();
}

function redrawAAbty(){
	var html="";  
	
	html +="<div class=\"aAbty\">";
		html +="<div class=\"tab_txt_area\">";
		html +="<div class=\"tab_txt_area_head\">학력</div>";
		html +="</div>"
		
		html +="<table class=\"tab_table\" border=\"1px\" cellspacing=\"0\">"; 
		html +="<colgroup>";
		html +="<col width=\"40px\" />";
		html +="<col width=\"70px\" />";
		html +="<col width=\"30px\" />";
		html +="<col width=\"50px\" />";
		html +="<col width=\"40px\" />";
		html +="</colgroup>";
		
		
		html +="<thead>";
		html +="<tr class=\"tabtitle\">";
		html +="<th>학교구분</th>";
		html +="<th>학교명</th>";
		html +="<th>졸업구분</th>";
		html +="<th>졸업년도</th>";
		html +="<th>전공</th>";
		html +="</tr>";
		html +="</thead>";
		
		html +="<tbody>";
		
		html +="</tbody>";
		
		html +="</table>";
	html +="</div>";
	
		$("#aabty").html(html);
		
		redrawAAbtyCon();
	}
	
	
function redrawCareer(){  // 테이블 그림
	var html="";  
	
	html +="<div class=\"career\">";
		html +="<div class=\"tab_txt_area\">";
		html +="<div class=\"tab_txt_area_head\">경력</div>";
		html +="</div>"
		
		html +="<table class=\"tab_table\" border=\"1px\" cellspacing=\"0\">"; 
		html +="<colgroup>";
		html +="<col width=\"10px\" />";
		html +="<col width=\"100px\" />";
		html +="<col width=\"10px\" />";
		html +="<col width=\"100px\" />";
		html +="<col width=\"40px\" />";
		html +="</colgroup>";
		
		
		html +="<thead>";
		html +="<tr class=\"tabtitle\">";
		html +="<th>No</th>";
		html +="<th>직장명</th>";
		html +="<th>직위</th>";
		html +="<th>근무기간</th>";
		html +="<th>담당업무</th>";
		html +="</tr>";
		html +="</thead>";
		
		html +="<tbody>";
		
		html +="</tbody>";
		
		html +="</table>";
	html +="</div>";

	$("#career").html(html);
	
	redrawCareerCon();
}


function redrawfamilyInfo(){  
	var html="";  
	
	html +="<div class=\"family\">"
		html +="<div class=\"tab_txt_area\">";
		html +="<div class=\"tab_txt_area_head\">가족정보</div>";
		html +="</div>"
		
		
		html +="<table class=\"tab_table\" border=\"1px\" cellspacing=\"0\">"; 
		html +="<colgroup>";
		html +="<col width=\"10\" />";
		html +="<col width=\"100\" />";
		html +="<col width=\"100\" />";
		html +="<col width=\"100\" />";
		html +="</colgroup>";
		
		html +="<thead>";
		html +="<tr class=\"tabtitle\">";
		html +="<th>No</th>";
		html +="<th>이름</th>";
		html +="<th>생년월일</th>";
		html +="<th>가족구분</th>";
		html +="</tr>";
		html +="</thead>";
		
		html +="<tbody>";
		
		html +="</tbody>";
		
		html +="</table>";
		
	html +="</div>";
	
	$("#family").html(html);
	
	redrawfamilyCon();
}
		
		
		
		
		
		
		
		
function redrawAAbtyConInsert(list){   //학력
	var html = "";
	
	if(list.length == 0){
		html += "<tr class=\"not\" height=\"50\"><td colspan=\"5\">조회결과가없습니다</td></tr>";
	}else{
		for(var k = 0 ; k < list.length; k++){
			html +="<tr class=\"tab_cnt_a\">";
			html +="<td>"+list[k].SC_DIV +"</td>";
			html +="<td>" + list[k].SC_NAME + "</td>";
			html +="<td>" + list[k].DEGREE + "</td>";
			html +="<td>" + list[k].GRD_DAY + "</td>";
			html +="<td>" + list[k].MAJOR + "</td>";
			html +="</tr>";
		}
	}
	
	$(".tab_table tbody").html(html); 
}


function redrawQlfcConInsert(list){  //자격증
	var html = "";

	if(list.length == 0){
		html += "<tr class=\"not\" height=\"50\"><td colspan=\"5\">조회결과가없습니다</td></tr>";
	}else{
		for(var i = 0 ; i < list.length; i++){
			html +="<tr class=\"tab_cnt_a\">";
			html +="<td>"+list[i].NO +"</td>";
			html +="<td>" + list[i].PROOF_NAME + "</td>";
			html +="<td>" + list[i].GET_DAY + "</td>";
			html +="<td>" + list[i].GET_PUBC + "</td>";
			html +="<td>" + list[i].QLFC_NO + "</td>";
			html +="</tr>";
		}
	}
	
	$(".tab_table tbody").html(html); // tobody에 추가
}




function redrawCareerConInsert(list){  //경력
	var html = "";

	if(list.length == 0){
		html += "<tr class=\"not\" height=\"50\"><td colspan=\"5\">조회결과가없습니다</td></tr>";
	}else{
		for(var j = 0 ; j < list.length; j++){
			html +="<tr class=\"tab_cnt_a\">";
			html +="<td>"+list[j].NO +"</td>";
			html +="<td>" + list[j].WPLACE_NAME + "</td>";
			html +="<td>" + list[j].POSI_NAME + "</td>";
			html +="<td>" + list[j].WORK_START + " ~ " + list[j].WORK_FNSH + "</td>";
			html +="<td>" + list[j].TASK + "</td>";
			html +="</tr>";
		}
	}
	
	$(".tab_table tbody").html(html); 
}


function redrawfamilyConInsert(list){  //가족정보
	var html = "";

	if(list.length == 0){
		html += "<tr class=\"not\" height=\"50\"><td colspan=\"5\" >조회결과가없습니다</td></tr>";
	}else{
		for(var j = 0 ; j < list.length; j++){
			html +="<tr class=\"tab_cnt_a\">";
			html +="<td>"+list[j].NO +"</td>";
			html +="<td>" + list[j].NAME + "</td>";
			html +="<td>" + list[j].BIRTH + "</td>";
			html +="<td>" + list[j].FAM + "</td>";
			html +="</tr>";
		}
	}
	
	$(".tab_table tbody").html(html); 
}





</script>

</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="51"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
<div class="content_area">
<form action="HRHmitemUpdate" id="dataForm" method="post">
	<input type="hidden" id="empNo" name="empNo" value="${sEmpNo}" />
	<input type="hidden" id="selectEmpNo" name="selectEmpNo">
	<input type="hidden" id="sAuthNo" value="${sAuthNo}" >
	<input type="hidden" id="empSearchTxt"name="empSearchTxt" />
</form>
<input type="hidden" id="selectEmpFlag" >
<input type="hidden" id="auth" value="${auth}">

	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 인사기록카드</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">
        <div class="content_title_text">인사기록카드 조회</div>
   </div>
	<!-- 내용 영역 -->

<!--  인적사항 -->
 
<div class="tabbtn_area">
    <input  type="button" value="인적사항" id="hmitemBtn">
    <input  type="button" value="학력" id="aabtyBtn">
	<input  type="button" value="자격먼허" id="qlfcBtn">
	<input  type="button" value="경력" id="careerBtn">
	<input  type="button" value="가족정보" id="familyBtn">
	<input  type="button" value="수정" id="update">
	<input  type="button" value="등록" id="reg">
</div>
<!-- <div class="tabbtn_area_save">
 	<input class="tabbtn_save" type="button" value="저장">
</div> -->


<div class="bg" id="hmitem">
</div>
<div class="bg" id="aabty">
</div>
<div class="bg" id="qlfc">
</div>
<div class="bg" id="career">
</div>
<div class="bg" id="family">
</div>
 


</div> <!--내용  -->

	
</body>
</html>
   			