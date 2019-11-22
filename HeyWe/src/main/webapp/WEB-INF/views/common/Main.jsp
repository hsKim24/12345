<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<!-- 팝업 -->
<script src="resources/script/common/popup.js"></script>

<!-- full calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/fullcalendar/fullcalendar.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/calendar/fullcalendar/fullcalendar.css" />

<!-- full calendar js -->
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/calendar/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript" src="resources/script/calendar/fullcalendar/lang-all.js"></script>

<!-- datePicker css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<style type="text/css">
.MainDiv{
	font-size: 13pt;
	color: black;
	text-align: center;
	margin-top: 60px;
}

#noticeBoard{
	display: inline-block;
}

#MainCalendar{
   width: 800px;
   font-size: 11pt;
   display : inline-block;
   vertical-align: top;
}
.fc-sat {
	color:blue;
} 
.fc-sun {
	color:red;
} 

#notice {
	text-align: left;
	font-size: 19pt;
	margin-left: 35px;
}

.notice_table {
    margin-left: 40px;
    border-collapse: collapse;
    text-align: center;
    margin-top: 9px;
    display: inline-block;
 }
 
.notice_table thead{
    background-color: #134074;
    color: white;
 }
 
.notice_table tr td{
   height: 37px;
   min-width : 70px;
}

.notice_tr {
   font-weight: bold;
}

.notice_tabel tbody tr {
   font-size : 13pt;
}

.notice_table tbody tr:nth-child(2n) {
   font-size: 13pt;
    color: black;
   background-color: #dee6ef;
}

.notice_table tbody tr:hover {
   background-color: #b0daec;
   color: #134074;
   cursor: pointer;
}

.article_title{
    text-align: left;
    min-width: 580px;
}

#calender{
	width: 800px;
}
#con{
	width: 400px;
	height: 100px;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'button',
		closeText: '닫기',
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd'    
	}); 
	
	AjaxDrawArticle();
	AjaxMainSchList();
	//$('table.calendar > tbody > tr > td:nth-child(-n+2)').addClass('fc-weekend');

	$(".notice_table tbody").on("click", "tr", function(){
      $("#no").val($(this).attr("name"));
      $("#dataForm").attr("action", "GWArticleDtl");      
      $("#dataForm").submit();
   });

	

	$("#deleteBtn").on("click",function(){
		if($("#schNo").val() == "NoData"){
			makeAlert(3,"실패","삭제할 일정을 선택하여주세요.",false,null);
		}else{
			AjaxDeleteSchMain();
			AjaxMainSchList();
		}
		
	})
});

function AjaxDrawArticle(){
    $.ajax({
       type : "post",
       url : "MainNoticeAjax",
       dataType : "json",
       success : function(result){
          console.log(result);
          var articleCnt = 2;
          var html ="";
          for(i = 0; i < result.list.length; i++){
             html += "<tr class=\"article" + articleCnt + "\"name=\"" + result.list[i].ARTICLE_NO + "\">";
             html += "<td>" + result.list[i].ARTICLE_NO + "</td>";
             html += "<td class=\"article_title\">" + result.list[i].TITLE + "</td>";
             html += "<td>" + result.list[i].NAME + "</td>";
             html += "<td>" + result.list[i].HIT + "</td>";
             html += "<td class=\"td_date\">" + result.list[i].WRITE_DATE + "</td>";
             html += "</tr>";
             if(articleCnt == 2){
                articleCnt--;
             }else{
                articleCnt++;
             }
          }
       $(".notice_table tbody").html(html);
       },
       error : function(request, status, error){
          console.log("실패");
          console.log("status : " + request.status);
          console.log("text : " + request.responseText);
          console.log("error : " + error);
       }
    });
 }

//호출호출
function AjaxMainSchList(){
	  
	$.ajax({
	   type : "post",
	   url : "AjaxMainSchList",
	   dataType : "json",
	   success : function(result) {
		   
			var h;
			var j;

			if("${sDeptNo}" == "2") {
				h = {
						left: 'myCustomButton',
						center: 'title'
					};
				j = ( function(event, element) {
					$("#schNo").val(event.schno);
					makePopup(3, "삭제", "해당 일정을 삭제하시겠습니까??", true, 300, 200,
							   null, "삭제", function(){
							AjaxDeleteSchMain();
						  	closePopup(3);
							});
					//$(this).css("background-color","yellow");
				})
				
			} else {
				h = {};
				j = {};
			}
		   
		   //캘린더 호출
		   $("#calender").fullCalendar({
			// 커스텀 버튼
				   customButtons: {
				   myCustomButton: {
				       text: '일정등록',
				       click: function() {
				    	   var html= "";
							html += "<form action=\"#\" id=\"insertForm\" method=\"post\">";
							html += "<input type=\"hidden\" id=\"stdt\" name=\"stdt\"/>";
							html += "<input type=\"hidden\" id=\"eddt\" name=\"eddt\"/>";
							html += "<input type=\"text\" title=\"시작기간선택\" id=\"date_start\"";
							html += "name=\"startDay\" value=\"\" readonly=\"readonly\"/>";
							html += "~";
							html += "<input type=\"text\" title=\"종료기간선택\" id=\"date_end\"";
							html +=	"name=\"endDay\" value=\"\" readonly=\"readonly\"/>";
							html += "<input type=\"text\" id=\"con\"name=\"con\" placeholder=\"내용을 입력해주세요\"/>";
							html += "</form>";
							
							makePopup(3, "등록", "일정등록 <br/>" + html, true, 500, 350, function(){
								$("#date_start").datepicker({
									dateFormat : 'yy-mm-dd',
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
								}); // #date_start datepicker end
								
								$("#date_end").datepicker({
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
								}); // #date_end datepicker end
							}, "등록", function(){
									AjaxInsertSchMain();
								  	
							}); // makePopup end
						}
				     }
				   },
					lang : "ko",
					height : 460,
					displayEventTime: false,
					header: h,
					events : result.list,
					//Event Click
					eventClick : j
				});	
				// 왼쪽 버튼을 클릭하였을 경우 (월을 강제로 일정등록으로 바꿈)
		 },
	   error : function(result) {
	      alert(result.errorMessage);
	   }
	});
}

function AjaxMainReloadSchList(){
	$.ajax({
	   type : "post",
	   url : "AjaxMainSchList",
	   dataType : "json",
	   success : function(result) {
			var oldEvents = $("#calender").fullCalendar("getEventSources");
			$("#calender").fullCalendar("removeEventSources", oldEvents);
			$("#calender").fullCalendar("refetchEvents");
			$("#calender").fullCalendar("addEventSource", result.list);
			$("#calender").fullCalendar("refetchEvents");
	   },
	   error : function(result) {
	      alert(result.errorMessage);
	   }
	});
}

function AjaxDeleteSchMain(){
	var params = $("#schForm").serialize();
		
	$.ajax({
	   type : "post",
	   url : "AjaxDeleteSchMain",
	   data : params,
	   dataType : "json",
	   success : function(result) {
		   AjaxMainReloadSchList();
	   },
	   error : function(result) {
	      alert(result.errorMessage);
	   }
	});
}

function AjaxInsertSchMain(){
	var params = $("#insertForm").serialize();
	
	$.ajax({
	   type : "post",
	   url : "AjaxInsertSchMain",
	   data : params,
	   dataType : "json",
	   success : function(result) {
		   AjaxMainReloadSchList();
		   
		   closePopup(3);
	   },
	   error : function(result) {
	      alert(result.errorMessage);
	   }
	}); 
}


</script>
</head>
<!--  -->
<body>
<c:import url="/topLeft">
</c:import>

	<form action="#" id="dataForm" method="post">
	   <input type="hidden" name="no" id="no"/>
	   <input type="hidden" value="0" id="boardMngtNo" name="boardMngtNo" />
	</form>
	
<div class="content_area">
	<div class="MainDiv"> 
      <div id="MainCalendar">
         <div id="calender"></div>
      </div>
      	<div id="noticeBoard">
     	 <div id="notice">공지사항</div>
         <table class="notice_table">
            <thead>
            <tr class="notice_tr">
               <td>글번호 </td>
               <td class="artcle_title">제목 </td>
               <td>작성자 </td>
               <td>조회수 </td>
               <td class="td_date">작성날짜 </td>
            </tr>
            </thead>
            <tbody></tbody>
         </table>
         </div>
   </div>

	<form action="#" id="schForm" method="post">
		<input type="hidden" id="schNo" name="schNo" value="NoData"/>
	</form>
</div>
</body>
</html>