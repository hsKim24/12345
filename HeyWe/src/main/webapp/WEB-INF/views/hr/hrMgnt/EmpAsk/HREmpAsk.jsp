<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 사원조회</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	drawSelectBox();
	drawPSelectBox();
	$("#searchTxt").on("keypress",function(event){
		if(event.keyCode==13){
			$("#searchBtn").click();
			return false;
		}
	});
	
   if($("#page").val() == "") {

      $("#page").val("1");

   }

   

   reloadList();

   $("tbody").on("click",".title_content",function(){
		 $("#no").val($(this).attr("name"));
		 /* alert($("#no").val()); */ /*들어오는 #no값 확인 */
	 	dataList();
	});

   $("#searchBtn").on("click", function() {
      $("#page").val("1");
      /* alert($("#deptSelectBox").val());
      alert($("#posiSelectBox").val()); */
      $("#deptNo").val($("#deptSelectBox").val());
      $("#posiNo").val($("#posiSelectBox").val());
      reloadList();

   });

   

   $("#pagingArea").on("click", "input", function() {

      $("#page").val($(this).attr("name"));

      reloadList();

   });
   
});

 
function drawSelectBox(){
	$.ajax({

	      type : "post",
	      url : "HRDeptAjax",
	      dataType : "json",
	      success : function(result) {
	         drawDeptSelectBox(result.list);
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }

	   });
}

function drawDeptSelectBox(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ;i++){
		html += "<option value=\""+ list[i].DEPT_NO +"\">"+ list[i].DEPT_NAME +"</option>";
		
	}
	
	
	$("#deptSelectBox").append(html);
}

function drawPSelectBox(){
	$.ajax({

	      type : "post",
	      url : "HRPosiAjax",
	      dataType : "json",
	      success : function(result) {
	         drawPosiSelectBox(result.list);
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }

	   });
} 

function drawPosiSelectBox(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ;i++){
		html += "<option value=\""+ list[i].POSI_NO +"\">"+ list[i].POSI_NAME +"</option>";
	}
	
	$("#posiSelectBox").append(html);
}

function reloadList() {

   var params = $("#dataForm").serialize();

   

   $.ajax({

      type : "post",

      url : "HREmpAskAjax",

      dataType : "json",

      data : params,

      success : function(result) {

         redrawList(result.list);

          redrawPaging(result.pb); 

      },

      error : function(request, status, error) {

         console.log("status : " + request.status);

         console.log("text : " + request.responseText);

         console.log("error : " + error);

      }

   });

}

 

function redrawList(list) {
	console.log(list);

   var html = "";
   html +=	"<tr class= \"title\" ><th>부서명</th><th>직위</th><th>입사일</th><th>사원코드</th><th>사원명</th></tr>"
   if(list.length == 0) {

      html += "<tr class= \"title_content\"><td colspan=\"5\">조회결과가 없습니다.</td></tr>";

   } else {

      for(var i = 0 ; i < list.length ; i++) {

         html += "<tr class =  \"title_content\" name=\"" + list[i].EMP_NO + "\">";

         html += "<td>" + list[i].DEPT_NAME + "</td>";

         html += "<td>" + list[i].POSI_NAME + "</td>";

         html += "<td>" + list[i].APNT_DATE + "</td>";

         html += "<td>" + list[i].EMP_NO + "</td>";
         
         html += "<td>" + list[i].NAME + "</td>";
         

         html += "</tr>";

      }

   }
	   $("#board tbody").html(html);
}

/* 사원조회 사원클릭시 데이터값 불러올 Ajax처리문 */
function dataList() {

	   var params = $("#dataForm").serialize();

	   $.ajax({
	      type : "post",
	      url : "HREmpAskDtlAjax",
	      dataType : "json",
	      data : params,
	      success : function(mapper) {
	    	  
	    	  makeNoBtnPopup(1, "사원정보",empDtlPopup(mapper.data), true, 1300, 554,
	  				function() {
	  			// 컨텐츠 이벤트
	  		}, null);
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
	}

function empDtlPopup(data) {

	var html = "";
	
	    
		html+="<div class=\"s_info1\">"
		if(data.PIC != null){
		html+="<img alt=\"알림\" class=\"picture\" src=\"resources/upload/"+data.PIC+"\" />";
		}else{
		html+="<class=\picture\" src=\"resources/images/common/nopic.png\">";
		}
		html+="</div>"
		html+="<div class=\"s_info2\">"
		html+="<div class=\"main_name\">사원정보</div>";
	    html+="<table class=\"tb_a\" border=\"1\" cellspacing=\"0\">";
		html+="<thead></thead>";
		html+="<tbody class = \"tby\">";
		html+="<tr>";
		html+="<th class=\"gray_content\">※사원번호</th>";
		html+="<th class=\"white_content\">"+ data.EMP_NO + "</th>";
		html+="<th class=\"gray_content\">※주민등록번호</th>";
		html+="<th class=\"white_content\">"+ data.RRNUM1 + - + data.RRNUM2 + "</th>";
		html+="</tr>";
		html+="<tr>";
		html+="<th class=\"gray_content\">※성명</th>";
		html+="<th class=\"white_content\">"+ data.NAME+"</th>";
		html+="<th class=\"gray_content\">※휴대폰</th>";
		html+="<th class=\"white_content\">"+data.MOBILE_NO+"</th>";
		html+="</tr>";
		html+="<tr>";
		html+="<th class=\"gray_content\">※입사일</th>";
		html+="<th class=\"white_content\">"+data.APNT_DATE+"</th>";
		html+="<th class=\"gray_content\">※E-mail</th>";
		html+="<th class=\"white_content\">"+data.EMAIL+"</th>";
		html+="</tr>";
		html+="<tr>";
		html+="<th class=\"gray_content\">※주소</th>";
		html+="<th class=\"white_content\" colspan=\"3\">"+data.ADDR+"</th>";
		html+="</tr>";
		html+="</tbody>";
		html+="</table>";
		
		html+="<div class=\"main_name\">인적사항";
		html+="</div>";
		html+="<table class=\"tb_a\" border=\"1\" cellspacing=\"0\">";
		html+="<thead></thead>";
		html+="<tbody>";
		html+="<tr>";
		html+="<th class=\"gray_content\">결혼여부</th>";
		html+="<th  class=\"white_content\">"+data.CD_MARRY+"";
		html+="</th>";
		html+="<th class=\"gray_content\">※병역";
		html+="</th>"
		html+="<th class=\"white_content\">"+data.CD_MILSERV+"";
		
		
		html+="</th>";
		html+="</tr>";
		html+="<tr>";
		html+="<th class=\"gray_content\">장애구분</th>";
		html+="<th class=\"white_content\">"+data.CD_DISA+"</th>";
		html+="<th class=\"gray_content\">장애내용</th>";
		html+="<th class=\"white_content\">"+data.DISA_CON+"</th>";
		html+="</tr>";
		      
		html+="</tbody>";
		html+="</table>";
		html+="</div>"
		
		
			return html;
	
}


function redrawPaging(pb){
      var html = "";
      html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";
      
      if($("#page").val() == "1"){
         html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
      } else {
         html += "<input type=\"button\" value=\"&lt\" name=\"" + ($("#page").val() * 1 - 1) + "\">";
      }
      
      for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
         if(i == $("#page").val()){
            html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" disabled=\"disabled\" class=\"paging_on\">";
         } else {
            html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i +  "\" class=\"paging_off\">";
         }
      }
      
      if($("#page").val() == pb.maxPcount) {
         html += "<input type=\"button\" value=\"&gt\" name=\"" + pb.maxPcount +  "\">"; 
      }else {
         html += "<input type=\"button\" value=\"&gt\" name=\"" + ($("#page").val() * 1 + 1) +   "\">";
      }
      
      html += "<input type=\"button\" value=\"&gt&gt\" name=\"" + pb.maxPcount +  "\">";
      
      $(".paging_group").html(html);
   }
 


</script>

<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/EmpAsk/HREmpAsk2.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />

<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
</head>
<body>
<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
	<%-- <c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="55"></c:param> --%>
	 <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>
<div class="content_area">
<form action="#" id="dataForm" method="post">
		<input type="hidden" id="deptNo" name="deptNo" value="1000">
		<input type="hidden" id="posiNo" name="posiNo" value="1000">
		<input type="hidden" name="page" id="page" value="${page}" />
		<input type="hidden" name="no" id="no" />
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 사원조회</div>
	<!-- 내용 영역 -->
	 <div class="content_title">
      
      <div class="content_title_text">사원조회</div>
   </div>
   <br/>
   <br/>
<div class = "content">
	<div class="부서명">부서명 :</div>
	<select id="deptSelectBox">
		<option disabled="disabled"  value="1000">부서명</option>
		<option value="1000" selected="selected">전체</option>
	</select>
	
	<div class="직위명">직위명 :</div>
	<select id="posiSelectBox">
		<option disabled="disabled"  value="1000">직위명</option>
		<option value="1000" selected="selected">전체</option>
	</select>



	<div class="사원명">
		<input class="사원이름" type="text" placeholder="사원 이름" name="searchTxt" id="searchTxt" ></input>

	</div>
	<img class= "돋보기" alt="" src="resources/images/erp/hr/d.png" id="searchBtn"
			
			 ></img>
</div>
	<div class="content_down"> 
	<table id="board" class="table" border='1' cellspacing='0'>
		<tbody></tbody>
	</table>
	
	<div id="pagingArea" class="paging_group"></div>
	
	</div>
</form>
</div>
</body>
</html>