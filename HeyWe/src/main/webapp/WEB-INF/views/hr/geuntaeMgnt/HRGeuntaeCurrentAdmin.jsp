<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 근태현황(관리자)</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/geuntaeMgnt/HRGeuntaeCurrentAdmin.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<!-- calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>


<script type="text/javascript">

 $(document).ready(function() {
	drawSelectBox(); 
	drawDSelectBox();  
	/* 캘린더  */
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'both',
		closeText: '닫기',
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		changeYear: true,
		changeMonth: true,
		dateFormat: 'yy/mm/dd',
		yearRange: '-100y:+0d'
	}); 
	
	$("#date_start").datepicker({
		dateFormat : 'yy-mm-dd',
		maxDate : new Date,
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (endDate > startDate) {
            	alert("조회 기간은 과거로 설정하세요.");
            	//달력에 종료 날짜 넣어주기
        		$("#date_start").val($("#stdt").val());
			} else {
				$("#stdt").val($("#date_start").val());
			}
		}
	});
	
	$("#date_end").datepicker({
		dateFormat : 'yy-mm-dd',
		maxDate : new Date,
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (startDate > endDate) {
            	alert("조회 기간은 과거로 설정하세요.");
            	//달력에 종료 날짜 넣어주기
        		$("#date_end").val($("#eddt").val());
			} else {
				$("#eddt").val($("#date_end").val());
			}
		}
	});
	/* 캘린더  */	
	
	
  if($("#page").val() == "") {

    $("#page").val("1");

 } 

 reloadList();
 /* 사유 팝업 */
 $("tbody").on("click",".title_content",function(){
	 $("#no").val($(this).attr("name"));
	
	 makeAlert(1, "사유", $(this).children(".GeunTaeNote").html(), true, null);
});
 
/* 근태특이사항팝업  */
  $("#GeunTaePlus").on("click", function(){ 
	  	
		makePopup(1, "사원 조회", empPopup() , true, 1400, 500, function(){
			$("#listDiv").slimScroll({
				height: "170px",
				axis: "both"
			});
			drawElist();
			drawSelectBox();
			
			$("#timeTxt").on("keyup", function() {
			    $(this).val($(this).val().replace(/[^0-9]/g,""));
			});
			
			$("#search_btn").on("click", function(){
				drawElist();
			});
			$("#search_txt").keyup(function(event){
				if(event.keyCode == '13'){
				drawElist();
				}
			});
		}, "확인", function(){
			makeConfirm(2, "근태등록", "등록하시겠습니까.", true, function(){
			$("#con").val($("#conTxt").val());
			$("#time").val($("#timeTxt").val());
			closePopup(1);
			GeunTaeApply();
			
			}); 
		
		});
		
 });
 
 
 
 

 $("#searchBtn").on("click", function() {
    $("#page").val("1");
    /* 굳이 안바꿔줘도 되는 구문. */
   /*  $("#GeunTaeNo").val($("#GeunTaeSelectBox").val()); */
    reloadList();

 });

 

 $(".paging_group").on("click", "input", function() {

    $("#page").val($(this).attr("name"));

    reloadList();

   });
 
 });

function drawSelectBox(){
	$.ajax({

		
	      type : "post",
	      url : "HRGeunTaeAdminAjax",
	      dataType : "json",
	      success : function(result) {
	         drawGeunTaeSelectBox(result.list);
	         
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}

function drawGeunTaeSelectBox(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ;i++){
		html += "<option value=\""+ list[i].GEUNTAE_NO +"\">"+ list[i].GEUNTAE_NAME +"</option>";
	}
	
	$("#GeunTaeSelectBox").append(html);
	$("#GeunTaeSelectBox").on("change", function(){
	$("#GeunTae_no").val($(this).val());
	});
}

function drawDSelectBox(){
	$.ajax({

		
	      type : "post",
	      url : "HRDeptAdminAjax",
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
	
	$("#DeptSelectBox").append(html);
}



function reloadList() {

 var params = $("#dataForm").serialize();

 

 $.ajax({

    type : "post",

    url : "HRGeuntaeCurrentAdminAjax",

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
 html +=	"<tr class= \"title\" ><th>성명</th><th>사번</th><th>부서</th><th>날짜</th><th>특이사항</th><th>시간</th></tr>"
 if(list.length == 0) {

    html += "<tr class = \"title_content\"><td colspan=\"7\">조회결과가 없습니다.</td></tr>";

 } else {

    for(var i = 0 ; i < list.length ; i++) {

       html += "<tr class =  \"title_content\" name=\"" + list[i].EMP_NO + "\">";

       html += "<td>" + list[i].NAME + "</td>";

       html += "<td>" + list[i].EMP_NO + "</td>";

       html += "<td>" + list[i].DEPT_NAME + "</td>";

       html += "<td>" + list[i].REC_DATE + "</td>";
       
       html += "<td>" + list[i].GEUNTAE_NAME + "</td>";
       
       html += "<td>" + list[i].TIME + "</td>";
       
       html += "<td style=\"display:none;\" class=\"GeunTaeNote\">" + list[i].NOTE + "</td>";
       

       html += "</tr>";

    	}
 	}
	   $("#board tbody").html(html);

	
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
 
 function empPopup(){
		var html="";
		
		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_txt\" name=\"search_txt\">";
		html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
		html += "</div>";
		html += "<div id=\"list\">";
		html += "<form id=\"gtForm\" action=\"#\" method=\"post\">"
		html += "<table id=\"listTop\"  border=\"1\">";
		html += "<colgroup>";
		html += "<col width=\"530px\">";
		html += "<col width=\"500px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>부서명</th>";
		html += "<th>이름</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"530px\">";
		html += "<col width=\"500px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";
		html += "<hr>";
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\"  border=\"1\">";
		html += "<tr>";
		html += "<th>특이사항</th>";
		html += "<th>시간</th>";
		html += "<th>사유</th>";
		html += "<colgroup>";
		html += "<col width=\"430px\">";
		html += "<col width=\"300px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "</tr>";
		html += "<tr>";
		html += "<td>";
		html += "<select name=\"GeunTaeSelectBox\" id=\"GeunTaeSelectBox\" class=\"GeunTaePopCss\">";
		html +=	"<option disabled=\"disabled\" value=\"1000\"> 근태명 </option>";
		html +=	"<option value = \"1000\" selected=\"selected\">전체 </option>";
		html += "</select>";
		html += "</td>";
		html += "<td>";
		html += "<input type=\"text\" placeholder=\"시간(숫자만)\" name=\"timeTxt\" id=\"timeTxt\" class=\"PopCon\" numberOnly >";
		html += "</td>";
		html += "<td>";
		html += "<input type=\"text\" placeholder=\"사유\" name=\"conTxt\" id=\"conTxt\" class=\"PopCon\" >";
		html += "</td>";
		html += "</tr>";
		html += "</table>";
		html += "</div>";
		
		return html;
	}
 function drawElist(){
		$("#empsearchtxt").val($.trim($("#search_txt").val()));
		var params = $("#dataForm").serialize(); 
		$.ajax({
			type : "post",
			url : "HRempSearchAjax",
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
 function drawEmpSearchList(list){
		var html = "";
		
		if(list.length == 0){
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		}else {
			for(var i = 0 ; i < list.length ; i++){
				html += "<tr name=\""+ list[i].EMP_NO + "\">";
				html += "<td>" + list[i].DEPT_NAME + "</td>"
				html += "<td>" + list[i].NAME + "</td>"
				html += "</tr>"
			}
		}
		
		$("#listCon tbody").html(html);
		
		$("#listCon").on("click", "tr" , function(){
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#emp_no").val($(this).attr("name"));
		});
	}
 
 function GeunTaeApply() {
	 
	 	$("#time").val($("#timeTxt").val());
		$("#con").val($("#conTxt").val());
		var params = $("#dataForm").serialize();
		/* alert($("#Time").val()); 
		alert($("#Con").val());  */
		
		console.log(params);
		
		


		출처: https://hihoyeho.tistory.com/entry/텍스트박스input-text에-숫자만-입력-가능하도록-설정 [하이호예호]
		
		$.ajax({ 
			type : "post",  		//데이터 전송방식
			url : "HRGeunTaeApplyAjax",		//주소
			dataType : "json",		//데이터 전송 규격
			data : params,
			// json양식 -> {키:값,키:값,...}
			success : function(result) {  //성공했을 때 넘어오는 값을 result변수로 받겠다.
				
				if(result.msg=="" || result.msg== null){
					console.log(result.msg);
					location.reload();
				}else{
					makeAlert(2, "근태등록", "등록에 실패하였습니다.", true, null);
				}
			},
			
			error : function(request, status, error) {
				console.log("status :" + request.status);
				console.log("text :" + request.responseText);
				console.log("error :" + error);
				 
				
			}
		});
	};
</script>

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
	<c:param name="leftMenuNo" value="70"></c:param> --%>
	<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>


<div class="content_area">
<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}" />
		<!-- <input type="hidden" id="deptNo" name="deptNo" value="1000"> -->
		<input type="hidden" id="GeunTaeNo" name="GeunTaeNo" value="1000">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 근태관리 &gt; 근태현황(관리자)</div>
	<!-- 내용 영역 -->
	 <div class="content_title">
  
      <div class="content_title_text">근태 현황(관리자)</div>
   </div>
   <br/>
 <div>
	<input type ="button" class="등록" id="GeunTaePlus" value="근태 특이사항 등록" />
	</div> 
<div class = "content">
   <div class="근태종류">근태종류  :</div>
	<select name="GeunTaeSelectBox" id="GeunTaeSelectBox">
		<option disabled="disabled" value="1000"> 근태명 </option>
		<option value = "1000" selected="selected">전체 </option>
	</select>
	
	<div class="근태종류">부서  :</div>
	<select name="DeptSelectBox" id="DeptSelectBox">
		<option disabled="disabled" value="1000"> 부서명 </option>
		<option value = "1000" selected="selected">전체 </option>
	</select>
	
<div class="근태종류">기록조회  :</div>
	<input class="입사년도" type="text"  id="date_start" name="date_start" placeholder="YYYY-MM-DD" readonly>
	<div class="물결">~</div>
	<input class="입사년도" type="text"  id="date_end" name="date_end" placeholder="YYYY-MM-DD" readonly>
	<div class="근태종류">성명  :</div>
		<input class="사원이름" type="text" placeholder="사원 이름" name="searchTxt" id="searchTxt" >
	<img class= "돋보기" alt="" src="resources/images/erp/hr/d.png" id="searchBtn" ></img>
</div>
	
	<!-- 아래 내용 영역 -->
	
	<div class="content_down">
			<table  id="board" class="table" border="1"  cellspacing ="0">
			<tbody>
			</tbody>
			</table>
		
			<div class="paging_group">
	         <div>&lt;</div>
	         <div class="paging_on">1</div>
	         <div class="paging_off">2</div>
	         <div class="paging_off">3</div>
	         <div class="paging_off">4</div>
	         <div>&gt;</div>
	      </div>
	 </div>
	 <input type="hidden" name="empsearchtxt" id="empsearchtxt"/>
				<input type="hidden" name="emp_no" id="emp_no"/>
				<input type="hidden" name="GeunTae_no" id="GeunTae_no"/>
				<input type="hidden" name="con" id="con" />
				<input type="hidden" name="time" id="time" />
</form>
</div>
</body>
</html>