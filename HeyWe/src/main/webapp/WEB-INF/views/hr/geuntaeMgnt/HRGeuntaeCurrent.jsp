<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 근태현황</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/geuntaeMgnt/HRGeuntaeCurrent.css" />
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

<style type="text/css">
	.ui-datepicker select.ui-datepicker-year {
	    width: 50%;
	    font-size: 11px;
	}
	.ui-datepicker select.ui-datepicker-month {
	    width: 40%;
	    font-size: 11px;
	}
</style>
<script type="text/javascript">

$(document).ready(function() {
	drawSelectBox();
	
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
		maxDate : new Date,
		dateFormat : 'yy-mm-dd',
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

 
 $("tbody").on("click",".title_content",function(){
	 $("#no").val($(this).attr("name"));
	 /* alert($("#no").val()); */ /*들어오는 #no값 확인 */
	 makeAlert(1, "사유", $(this).children(".GeuntaeNote").html(), true, null);
});
 

 $("#searchBtn").on("click", function() {
    $("#page").val("1");
    $("#GeunTaeNo").val($("#GeunTaeSelctBox").val());
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
	      url : "HRGeunTaeAjax",
	      dataType : "json",
	      success : function(result) {
	         drawGeunTaeSelctBox(result.list);
	         
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }

	   });
}

function drawGeunTaeSelctBox(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ;i++){
		html += "<option value=\""+ list[i].GEUNTAE_NO +"\">"+ list[i].GEUNTAE_NAME +"</option>";
	}
	
	$("#GeunTaeSelctBox").append(html);
}

function reloadList() {

 var params = $("#dataForm").serialize();

 

 $.ajax({

    type : "post",

    url : "HRGeuntaeCurrentAjax",

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
 html +=	"<tr class= \"title\" ><th>성명</th><th>사번</th><th>부서</th><th>날짜</th><th>근태명</th><th>시간</th></tr>"
 if(list.length == 0) {

    html += "<tr class= \"title_content\" ><td colspan=\"7\">조회결과가 없습니다.</td></tr>";

 } else {

    for(var i = 0 ; i < list.length ; i++) {

       html += "<tr class =  \"title_content\" name=\"" + list[i].EMP_NO + "\">";

       html += "<td>" + list[i].NAME + "</td>";

       html += "<td>" + list[i].EMP_NO + "</td>";

       html += "<td>" + list[i].DEPT_NAME + "</td>";

       html += "<td>" + list[i].REC_DATE + "</td>";
       
       html += "<td>" + list[i].GEUNTAE_NAME + "</td>";
       
       html += "<td>" + list[i].ADD_WORK_TIME + "</td>";
       
       html += "<td style=\"display:none;\" class=\"GeuntaeNote\">" + list[i].NOTE + "</td>";
       

       html += "</tr>";

    	}
 	}
	   $("#board tbody").html(html);

	/* $("tbody").on("click",".title_content",function(){
		$("#no").val($(this).attr("name"));
		$("#dataForm").submit();
	}); */
 


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
	<c:param name="leftMenuNo" value="69"></c:param> --%>
	<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
</c:import>


	
<div class="content_area">
<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}" />
		<input type="hidden" name="sEmpNo" value="${sEmpNo}" />
		<input type="hidden" id="GeunTaeNo" name="GeunTaeNo" value="1000">
		
	<div class="content_nav">HeyWe &gt; 인사 &gt; 근태관리 &gt; 근태현황</div>
	<!-- 내용 영역 -->
	 <div class="content_title">
  
      <div class="content_title_text">근태 현황</div>
   </div>
   <br/>
   <br/>
<div class = "content">
   <div class="근태종류">근태종류  :</div>
	<select name="GeunTaeSelctBox" id="GeunTaeSelctBox">
		<option disabled="disabled" value="1000"> 근태명 </option>
		<option value = "1000" selected="selected">전체 </option>
	</select>
	
<div class="근태종류">기록조회  :</div>
	<input class="입사년도" type="text"  id="date_start" name="date_start" placeholder="YYYY-MM-DD" readonly>
	<div class="물결">~</div>
	<input class="입사년도" type="text"  id="date_end" name="date_end" placeholder="YYYY-MM-DD" readonly>
	<img class= "돋보기" alt="" src="resources/images/erp/hr/d.png" id="searchBtn" ></img>
</div>
	<!-- 아래 내용 영역 -->
	<div class="content_down">
			<table id="board" class="table" border="1"  cellspacing ="0">
			
			<tbody>
			</tbody>
		</table>
			
			<div class="paging_group" >
	       
	      </div>
	 </div>
</form>
</div>
</body>
</html>