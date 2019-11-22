<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 전자결재 - 메인</title>

<!-- 얘내는 달력을 위한 -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/zabuto_calendar.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">

<!-- 데이터 피커 css 파일 -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<!-- 메인을 위한 -->
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/main/gw_main.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/main/table.css"/>


<style type="text/css">
/* 
   DarkBlue : rgb(19, 64, 116), #134074
   DeepLightBlue : rgb(141, 169, 196), #8DA9C4
   LightBlue : rgb(222,230,239), #DEE6EF
   White : rgb(255,255,255), #FFFFFF
 */
*, *:before, *:after {
	webkit-box-sizing: unset!important;
	-moz-box-sizing: unset!important;
	box-sizing: unset!important;
}

tbody .article_title {
	text-align: left;
}

img {
	vertical-align: baseline!important;
}

.popup_bot input {
	box-sizing : border-box!important;
}

/* 달력용 스타일*/
#calendar{
	width: 591px;
	height: 500px;
}
#calendar th{
	height: 50px;
}
#calendar .table {
	height: 500px!important ;
}

#calendar td, #calendar th {
	vertical-align: middle;s
}
.calendar-month-header{
	font-size: 14pt;
}
#calendar2{
	width: 700px;
	height: 600px;
}
#calendar2 th{
	height: 50px;
}
#calendar2 .table{
	height: 570px!important;
}
#calendar2 td, #calendar2 th {
	vertical-align: middle;
}

/* 날씨 탭뷰 css*/
/* 텝뷰용*/
ul.weatherTabs {
    margin: 0;
    padding: 0;
    float: left;
    list-style: none;
    height: 32px;
    border-bottom: 1px solid #eee;
    border-left: 1px solid #eee;
    width: 100%;
    font-family:"dotum";
    font-size:12px;
}
ul.weatherTabs li {
    float: left;
    text-align:center;
    cursor: pointer;
    width:82px;
    height: 31px;
    line-height: 31px;
    border: 1px solid #eee;
    border-left: none;
    font-weight: bold;
    background: #fafafa;
    overflow: hidden;
    position: relative;
}
ul.weatherTabs li.active {
    background: #FFFFFF;
    border-bottom: 1px solid #FFFFFF;
}
.weatherTab_container {
    border: 1px solid #eee;
    border-top: none;
    clear: both;
    float: left;
    width: 414px;
    background: #FFFFFF;
}
.weatherTab_content {
    padding: 5px;
    font-size: 12px;
    display: none;
}
.weatherTab_container .weatherTab_content ul {
    width:100%;
    margin:0px;
    padding:0px;
}
.weatherTab_container .weatherTab_content ul li {
    padding:5px;
    list-style:none
}
;
#weatherContainer {
    width: 249px;
    margin: 0 auto;
}

.grade-1 {
    background-color: blue;
}

.grade-2 {
    background-color: red;
}

.grade-3 {
    background-color: green;
}

.grade-4 {
    background-color: fuchsia;
}

.purple {
    background-color: purple;
}
/* 데이트 피커*/
/* .ui-datepicker-div{
	font-size: 10pt;
}
.ui-datepicker-calendar{
	font-size: 10pt;
} */
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>
<script src="resources/script/calendar/zabuto_calendar.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<script src="resources/script/common/popup.js"></script>

<!-- 캘린더 펑션 -->
<script type="text/javascript">
var fullDate = new Date();
var Month = fullDate.getMonth() + 1;
var day = fullDate.getDate();
var xcnt = 0;
var arr = new Array();

$(document).ready(function () {
	allSchList();
	getApvDoc();
	AjaxDrawArticle();
	
	//최신 게시물 이동
	$(".article_table tbody").on("click", "tr", function(){
	      $("#no").val($(this).attr("name"));
	      $("#dataForm").attr("action", "GWArticleDtl");      
	      $("#dataForm").submit();
	   });
	
	$(".confirmation_table").slimScroll({
		width : "680",
		height : "600"
		
		});	
	
	//grade-1 개인(blue) grade-2 부서(red) grade-3 회사(green) grade-4 프로젝트(fuchsia)
	var eventData = [
		{ date :"2019-06-22", badge : true, title:"속초 파견", classname: "grade-1"},
		{ date :"2019-06-04", badge : false, "title":"회사 보안점검", classname:"grade-3"},
		{ date :"2019-06-05", classname:"grade-3"},
		{ date :"2019-06-06", classname:"grade-3"},
		{ date :"2019-06-06", classname:"grade-2", title:"나나"},
		{ date :"2019-06-10", badge : false,"title":"부서 내 긴급점검", classname:"grade-4"},
		{ date :"2019-06-11", classname:"grade-4"},
		{ date :"2019-06-12", classname:"grade-4"},
		{ date :"2019-06-13", classname:"grade-4"},
		{ date :"2019-06-14", classname:"grade-4"}
	];
//var list = [{"grade-1":"green","grade-2":"blue","grade-3":"black","grade-4":"orange"}];
  
	
    // sysdate 가져오기

	for(var i = 1; i < 6; i++){
	    if((Month == 4 || Month == 6 || Month == 9 || Month == 11)
	    		&& day+xcnt > 30){
    		var MonthAndDay = (Month+1) +"월 " + (day + xcnt - 30) +"일";
	    }else if(Month == 2 && day+xcnt > 28){
    		var MonthAndDay = (Month+1) +"월 " + (day + xcnt - 28) +"일";
	    }else{
	    	if(day + xcnt > 31){
				var MonthAndDay =(Month+1) +"월 " + (day + xcnt - 31) +"일";
	    	}else{
				var MonthAndDay = Month +"월 " + (day + xcnt) +"일";
	    	}
	    }
	    $("#tabTh" + i).html(MonthAndDay);
		xcnt++;
	}
	
	//월별 일정 리스트 출력
    //없애버리면 되지 ㅡㅡ
	
	//페이지네이션
    $("#layer2").hide();

    $("div.tabs_img li").click(function () {
        $(".tab_contents").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
    weather();
    
	
    //달력팝업작업 start
    $(".bg").on("click",function(){
    	$(".bg").css("display","none");
    	$(".popup").css("display","none");
    });
    $("#popupex").on("click",function(){
    	$(".bg").css("display","none");
    	$(".popup").css("display","none");
    })
    //일정등록버튼
    $("#insertSchOpenBtn").on("click",function(){
    	$(".popupcal2").css("display","none");
    	$(".popupcal2Sch").css("display","inline-block");
    });
	//일정등록 > 취소버튼
    $("#backSchBtn").on("click",function(){
    	$(".popupcal2").css("display","inline-block");
    	$(".popupcal2Sch").css("display","none");
    });
    
    //일정 삽입 버튼
    $("#insertSchBtn").on("click",function(){
    	$("#gwSchTypeNo").val($("input[name=\"일정\"]:checked").val());
		/* console.log($("#gwSchTypeNo").val());
		console.log($("#empNoSch").val());
		console.log($("#date_start").val());
		console.log($("#date_end").val());
		console.log($("#con").val()); */
		if($("#date_start").val() == null || $("#date_start").val() == ""){
			makeAlert(9,"실패","시작날짜를 입력해주세요.",false,null);
		}else if($("#date_end").val() == null || $("#date_end").val() == ""){
			makeAlert(9,"실패","마지막날짜를 입력해주세요.",false,null);
    	}else if($("#con").val() == null || $("#con").val() == ""){
			makeAlert(9,"실패","내용을 입력해주세요.",false,null);
		}else{
			AjaxInsertSch();
		}
		
    });
    
  //일정 삭제 버튼
    $("#deleteSchBtn").on("click", function(){
    	if($("#gwSchNo").val() == "NoData"){
    		makeAlert(9,"실패","삭제할 일정을 선택해 주세요.",false,null);
    	}else{
	    	AjaxDeleteSch();
	    	$("#gwSchNo").val("NoData");
    	}
    });
    
    //삭제할 일정을 선택하여 gwSchTypeNo2의 데이터를 바꿔주는 부분
    var background_color ="";
    $(".calListArea2").on("click", "div", function(){
   		if($("#gwSchNo").val() == $(this).attr("name")){
	    	$(this).css("background-color","white");
	    	$("#gwSchNo").val("NoData");
   		}else{
	    	$("#gwSchNo").val($(this).attr("name"));
	    	$("#"+background_color).css("background-color","white");
	    	$(this).css("background-color","yellow");
	    	background_color = $(this).attr("id");
   		}
    	
    }) 

    //일정 바꾸기(전체,개인,부서,회사,프로젝트)
    $("#Allcheck").change(function(){
    	 if($("#Allcheck").is(":checked")){
    		 $(".calListArea2 .cal1").css("display","block");
    		 $(".calListArea2 .cal2").css("display","block");
    		 $(".calListArea2 .cal3").css("display","block");
    		 $(".calListArea2 .cal4").css("display","block");
    	 }else{
    		 $(".calListArea2 .cal1").css("display","none");
    		 $(".calListArea2 .cal2").css("display","none");
    		 $(".calListArea2 .cal3").css("display","none");
    		 $(".calListArea2 .cal4").css("display","none");
    		 
    		 if($("#personCheck").is(":checked")){
        		 $(".calListArea2 .cal1").css("display","block");
        	 }else{
        		 $(".calListArea2 .cal1").css("display","none");
        	 } 
    		 if($("#departmentCheck").is(":checked")){
        		 $(".calListArea2 .cal2").css("display","block");
        	 }else{
        		 $(".calListArea2 .cal2").css("display","none");
        	 }
    		 if($("#companyCheck").is(":checked")){
        		 $(".calListArea2 .cal3").css("display","block");
        	 }else{
        		 $(".calListArea2 .cal3").css("display","none");
        	 }
    		 if($("#projectCheck").is(":checked")){
        		 $(".calListArea2 .cal4").css("display","block");
        	 }else{
        		 $(".calListArea2 .cal4").css("display","none");
        	 }
    	 }
    });
    $("#personCheck").change(function(){
    	 if($("#personCheck").is(":checked")){
    		 $(".calListArea2 .cal1").css("display","block");
    	 }else{
    		 $(".calListArea2 .cal1").css("display","none");
    	 }
    });
    $("#departmentCheck").change(function(){
    	 if($("#departmentCheck").is(":checked")){
    		 $(".calListArea2 .cal2").css("display","block");
    	 }else{
    		 $(".calListArea2 .cal2").css("display","none");
    	 }
    });
    $("#companyCheck").change(function(){
    	 if($("#companyCheck").is(":checked")){
    		 $(".calListArea2 .cal3").css("display","block");
    	 }else{
    		 $(".calListArea2 .cal3").css("display","none");
    	 }
    });
    $("#projectCheck").change(function(){
    	 if($("#projectCheck").is(":checked")){
    		 $(".calListArea2 .cal4").css("display","block");
    	 }else{
    		 $(".calListArea2 .cal4").css("display","none");
    	 }
    });
    
    
    //결재문서 상세보기페이지 이동
    $("body").on("click",".confirm",function(){
    	$("#apvNo").val($(this).attr("name"));
    	$("#confirmForm").attr("action","GWApvProgress");
    	$("#confirmForm").submit();
    	
    });
    
//게시글 상세보기페이지로 이등
//$()`~~{
//attr("action","GWArticleDtl");
//가야할 데이터는
// sEmpNo => empNo,  
//<input type="hidden" id="no" name="no"/>
//<input type="hidden" value="${sEmpNo}" id="empNo" name="empNo" />
//<input type="hidden" value="${boardMngtNo}" id="boardMngtNo" name="boardMngtNo"/>
//}
    
    
    
});
//팝업 draw
function drawPopup(){
	var popup ="";
}

// 날씨파싱
function weather(){
	var html= "";
	var year = "";
	var month = "";
	var weatherDay = "";
	var time = "";
	
	$.ajax({
		type : "get",
		url : "https://api.openweathermap.org/data/2.5/forecast?q=Seoul,kr&appid=f7ebbe1f10b47dcbadfd27d7d30f29ce",
		dataType : "json",
		success : function(result){
			console.log(result);
		var cnt = 0;
		var iplus = 0;
		for(var j=1; j<6; j++){
			
			for(var i = iplus; i < iplus+8; i+=2){
				year = result.list[i].dt_txt.substring(0,4);
				month = result.list[i].dt_txt.substring(5,7);
				weatherDay = result.list[i].dt_txt.substring(8,10);
				time = result.list[i].dt_txt.substring(11,13);
				
				if(time >=12){
					time = "PM " + ((time*1) -12);
				}else{
					time = "AM " + time;
				}
				day = day*1;
				if(day < 10){
					weatherDay = result.list[i].dt_txt.substring(9,10);
					if(day != weatherDay){
						html += "0" + weatherDay + "일 " + time + "시 날씨 : " + result.list[i].weather[0].main
						html += "<img src=\"http://openweathermap.org/img/w/" + result.list[i].weather[0].icon + ".png\"/>";
						html += "<br/>";
						cnt = cnt+2;
					}else{
						html += time + "시 날씨 : "+result.list[i].weather[0].main
						html += "<img src=\"http://openweathermap.org/img/w/" + result.list[i].weather[0].icon + ".png\"/>";
						html += "<br/>";
						cnt = cnt+2;
					}
				}else{
					if(day != weatherDay){
						html += weatherDay + "일 " + time + "시 날씨 : " + result.list[i].weather[0].main
						html += "<img src=\"http://openweathermap.org/img/w/" + result.list[i].weather[0].icon + ".png\"/>";
						html += "<br/>";
						cnt = cnt+2;
					}else{
						html += time + "시 날씨 : "+result.list[i].weather[0].main
						html += "<img src=\"http://openweathermap.org/img/w/" + result.list[i].weather[0].icon + ".png\"/>";
						html += "<br/>";
						cnt = cnt+2;
					}
				}
			}
			if((Month == 4 || Month == 6 || Month == 9 || Month == 11) && day >= 30){
				day = day - 30;
			}else if(Month == 2 && day >= 28){
				day = day - 28;
			}else{
				if(day>=31){
					day = day - 31;
				}
			}
			day = day + 1 ;
			
			iplus += cnt;
			cnt = 0;
			$("#weatherTab" +j).html(html);
			html ="";
		}
		
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

$(function () {
	// 날씨 텝뷰
    $(".weatherTab_content").hide();
    $(".weatherTab_content:first").show();
	
    $("ul.weatherTabs li").click(function () {
        $("ul.weatherTabs li").removeClass("active").css("color", "#333");
        $(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "darkred");
        $(".weatherTab_content").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).show();
    });
});

// 월별 일정리스트
function AjaxSelectSchList(){
	var params = $("#selectSchListForm").serialize();
	// params += $("#sEmpNo").val();
	
	$.ajax({
		type : "post",
		url : "AjaxSelectSchList",
		dataType : "json",
		data : params,
		success : function(result){
			console.log(result);
			 var html = "";
			for(var i = 0; i < result.list.length; i++){
				if(result.list[i].GW_SCH_TYPE_NO == 1){
					html += "<div class=\"cal1\" name=\"sch_"+ result.list[i].GW_SCH_NO +"\">";
				}else if(result.list[i].GW_SCH_TYPE_NO == 2){
					html += "<div class=\"cal2\" name=\"sch_"+result.list[i].GW_SCH_NO +"\">";
				}else if(result.list[i].GW_SCH_TYPE_NO == 3){
					html += "<div class=\"cal3\" name=\"sch_"+result.list[i].GW_SCH_NO +"\">";
				}else{
					html += "<div class=\"cal4\" name=\"sch_"+result.list[i].GW_SCH_NO +"\">";
				}
				html += result.list[i].START_DAY.substring(5,10);
				html += " ~ " + result.list[i].END_DAY.substring(5,10) + " " + result.list[i].CON;
				html += "</div>";
			}
			$(".calListArea").html(html); 
			
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	})
}

// 일정등록
function AjaxInsertSch(){
	var params = $("#insertSchForm").serialize();
	$.ajax({
		type : "post",
		url : "AjaxGWInsertSch",
		dataType : "json",
		data: params,
		success : function(result){
			if(result.msg == "실패"){
				makeAlert(9,"실패","등록에 실패하였습니다.",false,null);
			}else{
				makeAlert(9,"등록","등록되었습니다.",false,
						function(){
							$("#gwSchTypeNo").val("");
							$("#date_start").val("");
							$("#date_end").val("");
							$("#con").val("");
							$("input:radio[name=\"일정\"]").prop("checked",false);
					    	$(".popupcal2").css("display","inline-block");
					    	$(".popupcal2Sch").css("display","none");			
							allSchList();
						}  
				);
			}
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}



// 게시글 그려주는 펑션
function AjaxDrawArticle(){
	$.ajax({
		type : "post",
		url : "AjaxGWMainArticle",
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
		$(".article_table tbody").html(html);
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

// 결재문서 가져오는 펑션
function getApvDoc(){
	$.ajax({
		type : "post",
		url : "AjaxGWMainApvProgressDoc",
		dataType : "json",
		success : function(result){
			console.log(result);
			var html = "";
			if(result.list.length == 0){
				html += "<div> 결재할 문서가 없습니다</div>";
			}else{
				for(i = 0; i < result.list.length; i++){
					
					html += "<div class=\"confirmation_list\">";
					html += "<img class=\"exmark\" src=\"resources/images/erp/gw/main/confirmation_exmark.png\">";
					html += "<div class=\"confirmation_state\">";
					if(result.list[i].DOC_STATE == 0){
						html += "상신";	
					}else{
						html += "진행중";
					}
					html +=	"</div>";
					html += "<div class=\"confirmation_value\">" + result.list[i].TITLE + "</div><hr>";
					html += "<div class=\"banban\">";
					html += "<div class=\"confirmation_writer\">기안자</div>";
					html += "<div class=\"confirmation_writer_data\">" + result.list[i].NAME + "</div>";
					html += "</div>";
					html += "<div class=\"banban\">";
					html += "<div class=\"confirmation_writer\">결재양식</div>";
					html += "<div class=\"confirmation_writer_data\">" + result.list[i].APV_DOC_TYPE_NAME +"</div>";
					html += "</div>";
					html += "<input type=\"button\" class=\"confirm\" name=\"" +result.list[i].APV_NO + "\" value=\"결재하기\"/>";
					html += "</div>";
				}
			}

			$(".confirmation_table").html(html);
			
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}


//일정 삭제
function AjaxDeleteSch(){
	var params = $("#delectSchForm").serialize();
	
	$.ajax({
		type : "post",
		url : "AjaxGWDeleteSch",
		dataType : "json",
		data: params,
		success : function(result){
			if(result.msg == "실패"){
				makeAlert(9,"실패","삭제할 일정을 선택하여주세요.",false,null);
			}else{
				//makePopup(2,"삭제","삭제되었습니다.",false,120,70,null,"확인",null);
				makeAlert(9,"삭제","삭제되었습니다.",false,function(){
					allSchList();
					console.log("다시그려져라 얍!");
				});
			}
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function allSchList(){
	var params = $("#allSchListForm").serialize();
	
	$.ajax({
		type : "post",
		url : "AjaxGWAllSchList",
		dataType : "json",
		//data : "${sEmpNo}",
		data : params,
		success : function(result){
			arr = new Array();
 			for(var i = 0; i < result.list.length; i++){
				var x = result.list[i].END_DAY.substring(8,10) * 1;
				var y = result.list[i].START_DAY.substring(8,10) * 1;
					if(x == y){
						arr.push({
							date : result.list[i].START_DAY,
							title: result.list[i].CON,
							classname: "grade-" + result.list[i].GW_SCH_TYPE_NO
						});
					}else{
						for(var j=0; j <= x-y; j++){
							arr.push({
								date: result.list[i].START_DAY.split('-')[0] + "-" + result.list[i].START_DAY.split('-')[1] + "-" + lpad((result.list[i].START_DAY.split('-')[2] * 1 + j), 2, '0'),
								title: result.list[i].CON,
								classname: "grade-" + result.list[i].GW_SCH_TYPE_NO
							});
						}
					}
			}
 			console.log(arr);
 			var calendarHtml = "<div id=\"my-calendar\"></div>";
 			$("#calendar").html(calendarHtml);
 			
 			$("#my-calendar").zabuto_calendar({
 				language: "kr",
 				today: true,
 				show_days: true,
 				weekstartson: 0,
 				data: arr,
 				legend: [
 		           {type: "text", label: "중복 일정 표시", badge: "00"},
 		           {type: "spacer"},
 		           {type: "list", list: ["grade-1"]},
 		           {type: "text", label: "개인일정"},
 		           {type: "list", list: ["grade-2"]},
 		           {type: "text", label: "부서일정"},
 		           {type: "list", list: ["grade-3"]},
 		           {type: "text", label: "회사일정"},
 		           {type: "list", list: ["grade-4"]},
 		           {type: "text", label: "프로젝트일정"}
 		        ],
 		       	action: function() {
	 		       	$(".bg").css("display","block");
	 		    	$(".popup").css("display","block");
 		       	},
 		       	action_nav: function() { 
 		       		var monthAndDay = $("#selectSchList").val().split("-");
 		       		if($(this).attr("id").lastIndexOf('next') >= 1){
	 		       		monthAndDay[1] = (monthAndDay[1] * 1) + 1 		       			
 		       		}else{
	 		       		monthAndDay[1] = (monthAndDay[1] * 1) - 1 		       			
 		       		}
 		       		monthAndDay[1] = lpad(monthAndDay[1], 2, '0');
 		       		$("#selectSchList").val(monthAndDay[0] + "-" + monthAndDay[1]);
 		 			AjaxSelectSchList();
 		       	}
 		       	
 		   	});
 			
 			var lpadMonth = $(".calendar-month-header td[colspan='5'] span").html();
 			lpadMonth = lpadMonth.split("월 ",2);
 		    if(lpadMonth[0] < 10){
 		    	lpadMonth = lpadMonth[1] + "-" + "0" + lpadMonth[0]
 		    }else{
 			    lpadMonth = lpadMonth[1] + "-" + lpadMonth[0];
 		    }
 			
 			$("#selectSchList").val(lpadMonth);
 			AjaxSelectSchList();
 			
 			//$("#my-calendar2").remove(); 얘도 안먹음 ㅡㅡ
 			var calendar2Html = "<div id=\"my-calendar2\"></div>";
 			$("#calendar2").html(calendar2Html);
 			$("#my-calendar2").zabuto_calendar({
 			   	language: "kr",
 			   	today: true,
 			   	show_days: true,
 			   	weekstartson: 0,
 			   	data: arr,
 			   	legend: [
 		           {type: "text", label: "중복 일정 표시", badge: "00"},
 		           {type: "spacer"},
 		           {type: "list", list: ["grade-1"]},
 		           {type: "text", label: "개인일정"},
 		           {type: "list", list: ["grade-2"]},
 		           {type: "text", label: "부서일정"},
 		           {type: "list", list: ["grade-3"]},
 		           {type: "text", label: "회사일정"},
 		           {type: "list", list: ["grade-4"]},
 		           {type: "text", label: "프로젝트일정"}
 		         ],
 		   	});
 			// 바까야댐 이걸
	 	var html = "";
		for(var i = 0; i < result.list.length; i++){
			if(result.list[i].GW_SCH_TYPE_NO == 1){
				html += "<div class=\"cal1\" id=\""+result.list[i].GW_SCH_NO +"\" name=\""+result.list[i].GW_SCH_NO +"\">";
			}else if(result.list[i].GW_SCH_TYPE_NO == 2){
				html += "<div class=\"cal2\" id=\""+result.list[i].GW_SCH_NO +"\" name=\""+result.list[i].GW_SCH_NO +"\">";
			}else if(result.list[i].GW_SCH_TYPE_NO == 3){
				html += "<div class=\"cal3\" id=\""+result.list[i].GW_SCH_NO +"\" name=\""+result.list[i].GW_SCH_NO +"\">";
			}else{
				html += "<div class=\"cal4\" id=\""+result.list[i].GW_SCH_NO +"\" name=\""+result.list[i].GW_SCH_NO +"\">";
			}
			html += result.list[i].START_DAY.substring(5,10);
			html += " ~ " + result.list[i].END_DAY.substring(5,10) + " " + result.list[i].CON;
			html += "</div>";
		}
		$(".calListArea2").html(html); 
 		console.log(html);	
		},
		
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
		
	})
}

</script>
<!-- 데이터 피커 -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
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
	});
	
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
	});
});
</script>

</head>
<body>
<c:import url="/topLeft">
	<c:param name="lMenu" value="2"></c:param>
   <c:param name="lfMenu" value=""></c:param>
</c:import>


<div class="content_area">
	<form action="#" id="dataForm" method="post">
		<input type ="hidden" id="no" name="no"/>
	</form>
	<div class="content_nav">HeyWe &gt; 그룹웨어 </div>
	<!-- 내용 영역 -->
	<div class="tab_box">
	<div class="container-box"><!-- 결재문서 & 달력 -->
		<!-- 결재문서 -->
			<form action="#" id="allSchListForm" method="post" >
			<input type="hidden" id="empNo3" name="empNo3" value="${sEmpNo}"/>
			</form>
		<div id="layer1" class="tab_contents">
		<form action="#" id="confirmForm" method="post">
			<input type="hidden" id="apvNo" name="apvNo"/>		
		</form>
			<div class="scrollDiv">
			<div class="confirmation_table">
			<div class="confirmation_list">
				<img class="exmark"src="resources/images/erp/gw/main/confirmation_exmark.png"><div class="confirmation_state">진행중</div>
				<div class="confirmation_value"></div><hr/>
					
			</div>
			</div>
		</div>
		</div>	
	    
		<!-- <img class="change"src="resources/images/erp/common/icon2.png" style="width: 20px; height: 20px">
		<img class="change"src="resources/images/erp/common/icon1.png" style="width: 21px; height: 21px">
		 -->
	<!-- 여기서 레이어 2로 바꿔줘서달력 호출하게할꺼임 하..............................ㄴㅇ라ㅣㅓㅜㅎ ㅓㄻㄴ우ㅏㅣㅎㄴㅇㄹ ㅜ허;ㅣ안ㄹ허;ㅇ리ㅏㅠㅜ피처ㅏㅠㅜ  -->
		<div id="layer2" class="tab_contents" style="background-color: white;">
			<div id="calendar">
			<div id="my-calendar">
			</div>
			</div><br/><br/>
			<div class="calListArea">
				<div class="cal1"></div>
				<div class="cal2"></div>
				<div class="cal3"></div>
			</div>
		</div>
	
	</div>
		<div class="tabs_img">
		     <li class="active" rel="layer1">
		     	<img class="change"src="resources/images/erp/gw/main/icon2.png" style="width: 20px; height: 20px">
		     </li>
		     <li rel="layer2">
		     	<img class="change"src="resources/images/erp/gw/main/icon1.png" style="width: 21px; height: 21px">
		     </li>
		</div>
	</div>
	<div class="board">
		<div class="article_board">
		 날씨
		
	<div id="weatherContainer">
	   <ul class="weatherTabs">
	       <li id="tabTh1"class="active" rel="weatherTab1">오늘 날씨</li>
	       <li id="tabTh2" rel="weatherTab2">1일 후 날씨</li>
	       <li id="tabTh3" rel="weatherTab3">2일 후 날씨</li>
	       <li id="tabTh4" rel="weatherTab4">3일 후 날씨</li>
	       <li id="tabTh5" rel="weatherTab5">4일 후 날씨</li>
	   </ul>
	   <div class="weatherTab_container">
	       <div id="weatherTab1" class="weatherTab_content">
	           <ul>
	               <li><a href="#">탭1번째</a>
	               </li>
	           </ul>
	       </div>
	       <!-- #tab1 -->
	       <div id="weatherTab2" class="weatherTab_content">
	      	 	탭2번째
	       </div>
	       <!-- #tab2 -->
	       <div id="weatherTab3" class="weatherTab_content">
	       		탭3번째
	       </div>
	       <!-- #tab3 -->
	       <div id="weatherTab4" class="weatherTab_content">
	       		탭4번째
	       </div>
	       <!-- #tab4 -->
	       <div id="weatherTab5" class="weatherTab_content">
	       		탭5번째
	       </div>
	       <!-- #tab5 -->
	   </div>
	   <!-- .tab_container -->
	</div>
	<!-- #container -->
</div>
		<!-- 최신 문서함 글  이거 게시판 글로 바꿀꺼임-->
		<div class="document_board">최신 게시판 글	
		<table class="article_table">
		<thead>
			<tr class="article_main">
				<td>글번호 </td>
				<td class="article_title">제목 </td>
				<td>작성자 </td>
				<td>조회수 </td>
				<td class="td_date">작성날짜 </td>
			</tr>
		</thead>
			<tbody>
			</tbody>
		</table>
		</div>
	</div>
</div>

<div class="bg" style="display: none;"></div>
<div class="popup" style="display: none;">
	<!-- 달력 -->
	<!-- 일정등록은 달력에서 날짜 클릭 시 등록할 수 있게 해놓을 것이기에 아직 만들지 않았음 -->
	<div class="popupcal1">
		<div id="calendar2">
		<div id="my-calendar2">
		</div>
		</div>
	</div>
	<div class="popupcal2">
		<div class="popupicon">
			<div class="All"><input type="checkbox" id="Allcheck" value="전체일정" checked="checked"/>전체일정</div>
			<div class="person"><input type="checkbox" id="personCheck" value="개인일정"/>개인일정</div>
			<div class="department"><input type="checkbox" id="departmentCheck" value="부서일정"/>부서일정</div>
			<div class="company"><input type="checkbox" id="companyCheck" value="회사일정"/>회사일정</div>
			<div class="project"><input type="checkbox" id="projectCheck" value="프로젝트일정"/>프로젝트일정</div>
			<div id="xe"><img src="resources/images/erp/gw/main/exicon.png" id="popupex"/></div>
		</div>
		<!-- 월별 일정 출력하기 위한 데이터 -->
		<form action="#" id="selectSchListForm" method="post">
			<input type="hidden" id="empNo2" name="empNo2" value="${sEmpNo}"/>
			<input type="hidden" id="selectSchList" name="month"/>
		</form>
		<form action="#" id="delectSchForm" method="post">
			<input type="hidden" id="gwSchNo" name="gwSchNo" value="NoData"/>
		</form>
		<div class="calListArea2">
			<div class="personTxt">
			</div>
			<div class="departmentTxt">
			</div>
			<div class="companyTxt">
			</div>
			<div class="projectTxt">
			</div>
		</div>
		<input class="calBtn" type="button" value="일정등록" id="insertSchOpenBtn"/>
		<input class="calBtn" type="button" value="일정삭제" id="deleteSchBtn"/>
	</div>
	<div class="popupcal2Sch" style="display: none;">
		<div class="popupicon">
			<div class="All"><input type="checkbox" value="전체일정" disabled="disabled" />전체일정</div>
			<div class="person"><input type="checkbox" value="개인일정" disabled="disabled"/>개인일정</div>
			<div class="department"><input type="checkbox" value="부서일정" disabled="disabled"/>부서일정</div>
			<div class="company"><input type="checkbox" value="회사일정" disabled="disabled"/>회사일정</div>
			<div class="project"><input type="checkbox" value="프로젝트일정" disabled="disabled"/>프로젝트일정</div>
			<div class="xe"><img src="resources/images/erp/gw/main/exicon.png" id="popupex"/></div>
		</div>
		<div class="insertTxt">
		 <form action="#" method="post" id="insertSchForm">
			<input type="hidden" id="empNoSch" name="empNo" value="${sEmpNo}"/>
			<input type="hidden" id="gwSchTypeNo" name="gwSchTypeNo" value=""/>
			<input type="hidden" id="startDay"  value="${stdt}" />
			<input type="hidden" id="endDay" value="${eddt}" />
		<div>
			<input type="text" width="80px" title="시작기간선택" id="date_start" name="startDay" value="" readonly="readonly" />
			~
			<input type="text" title="종료기간선택" id="date_end" name="endDay" value="" readonly="readonly" />
		</div><hr>
			내용 <input type="text" placeholder="내용을 입력하세요" class="cal_contents" id="con" name="con"/><br><br><br>
			등록될 일정의 분류를 선택해주세요<br><br>
			<div class="person" id="person"><input type="radio" name="일정" value="1"/>개인일정</div><br>
			<div class="department" id="department"><input type="radio" name="일정" value="2"/>부서일정</div><br>
			<div class="company" id="company"><input type="radio" name="일정" value="3"/>회사일정</div><br>
			<div class="project" id="project"><input type="radio" name="일정" value="4"/>프로젝트일정</div><br>
			
			<br><br><br><br><br><br><br>
				<input type="button" class="calBtn" id="insertSchBtn" value="등록"/>
		 </form> 
				<input type="button" class="calBtn" id="backSchBtn" value="취소"/>
		</div>	
	</div>
</div>


</body>
</html>