<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 강의 목록</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/as/lecturelist.css" />
<style type="text/css">
.modi_btnzone {
	text-align: right;
}

.modi_btnzone>button {
	padding: 10px;
}

.input_area {
	height: 380px;
}

#tchrnoti {
	font-size: 10pt;
	margin-left: 23px;
	color: red;
}

#mngrname, #placename, #tchrname {
	border: 1px solid;
	border-radius: 5px;
	background-color: #FFFFFF;
	color: #134074;
	outline: 0px;
}

.checkPop_1  select {
	
}

#empCheck, #placeCheck, #tchrCheck, #fileBtn1, #regicancel_btn {
	border-radius: 3px;
	width: 70px;
	height: 32px;
	font-size: 5px;
	background-color: #134074;
	color: #FFF;
	font-weight: bold;
	outline: none;
}

#board2, #tchr_board, #place_board {
	margin-left: 0px;
	width: 250px;
}

#listDiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: calc(100% - 15px);
	margin: 0px !important;
	height: 170px !important;
}

#listDiv_1 {
	display: inline-block;
	height: 80px;
}

#hrlistDiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: calc(100% - 15px);
	margin: 0px !important;
	height: 170px !important;
	width: 250px !important;
}

.slimScrollDiv {
	
}

.checkPop {
	text-align: center;
	font-size : 11pt;
}

div.checkPop_2 {
	text-align: center;
	margin-left: 70px;
}

#emphead {
	margin-left: 0px;
	width: 250px;
}

/* 사원목록 선택시 색 변경 */
.checkPop_2 tbody tr.on {
	background-color: #DEE6EF;
}
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
	
		//강의 정보 관리로 이동
		$("#mngrlect").on("click",function() {
			location.href="ASLecInfomgnt";		
		});
		

		//강의상세정보
		$("tbody").on("click","tr",function(){
			$("#no").val($(this).attr("name"));
			$("#dataForm").attr("action","ASLecList");  
			if(($(this).attr("name"))!="Nseltr")
			{
				reloadList2();
			}
			else{console.log($(this).attr("name"));}	
		});	
		
		if($("#page3").val() == ""){
			$("#page3").val("1");
		}
		sche_reloadList();
		$("#sche_pagingArea").on("click","input", function(){
			$("#page3").val($(this).attr("name"));
			sche_reloadList();
		});	
		
			
		if($("#page").val() == ""){
			$("#page").val("1");
		}
		reloadList();
		$("#pagingArea").on("click","input", function(){
			$("#page").val($(this).attr("name"));
			reloadList();
		});	
		
		$("#makePopup").on("click",function() {
		
			var html = "";
			

			html += "<div class=\"input_area\"style=\"height:410px\">";
			html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
			html +=	"<div class=\"input_inform_area\">";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">강의명</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"강의명을 입력하세요\" id =\"lectname\" name=\"lectname\"  />";
			html +=	"</div>";	
			html +=	"</div>";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">시작일</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input class=\"d_input\" type=\"date\" id=\"lectsday\" id =\"lectsday\" name=\"lectsday\">";
			html +=	"</div>";
			html +=	"</div>";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">종료일</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input class=\"d_input\" type=\"date\" id=\"lecteday\" id =\"lecteday\" name=\"lecteday\">";
			html +=	"</div>";
			html +=	"</div>";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">담당자</div>";
			html +=	"<div class=\"login_input_txt_insertbtn\">";
			html +=	"<input type=\"text\" placeholder=\"담당자를 선택하세요\" id =\"mngrname\" name=\"mngrname\"disabled />";
			/*-------------------------담당자검색 ----------------*/
			html +=	"<input type=\"hidden\" id=\"mngrno\" name=\"mngrno\">";
			html += "<input type=\"button\" value=\"사용자검색\" id=\"empCheck\" name=\"empCheck\">";
		
			html +=	"</div>";
			html +=	"</div>";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">장소</div>";
			html +=	"<div class=\"login_input_txt_insertbtn\">";
			html +=	"<input type=\"text\" placeholder=\"강의실을 선택하세요\" id =\"placename\" name=\"placename\" disabled />";
			html +=	"<input type=\"hidden\" id=\"placeno\" name=\"placeno\">";
			/*-------------------------강의실검색 ----------------*/
			html += "<input type=\"button\" value=\"강의실검색\" id=\"placeCheck\" name=\"placeCheck\">";
			html +=	"</div>";
			html +=	"</div>";
			html +=	"<div class=\"login_input_area\" style=\"height:30px\">";
			html +=	"<div class=\"login_input_q\">형식</div>";
			html +=	"<div class=\"chebox_input\">";
			html +=	"<input type=\"radio\" name=\"lectype\" value=\"1\" />강사초빙 ";
			html +=	"<input type=\"radio\" name=\"lectype\" value=\"0\" />스터디</div>";
			html +=	"</div>";
			html += "<div id=\"tchrnoti\">강사초빙 선택시 강사를 선택해야 합니다.</div>";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">강사명</div>";
			html +=	"<div class=\"login_input_txt_insertbtn\">";
			html +=	"<input type=\"text\" placeholder=\"강사를 선택하세요\" id =\"tchrname\" name=\"tchrname\" style=\"height:26px\" disabled />";
			html +=	"<input type=\"hidden\" id=\"tchrno\" name=\"tchrno\">";
			/*-------------------------강사검색 -----------------*/
			html += "<input type=\"button\" value=\"강사검색\" id=\"tchrCheck\" name=\"tchrCheck\">";  
			html +=	"</div>";
			html +=	"</div>";
			
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">수강인원</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"수강인원을 입력하세요\" id=\"atnd\" style=\"width:150px\" name=\"atnd\" /> 명";
			html +=	"</div>";
			html +=	"</div>";
			html +=	"<div class=\"login_input_area\">";
			html +=	"<div class=\"login_input_q\">비용</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"만원(￦)단위 입력\" id=\"cost\" style=\"width:150px\" name=\"cost\" /> 만원";
			html +=	"</div>";
			html +=	"</div>";
			
			html +=	"</div>";
			html +=	"<div class=\"input_inform_area_2\">";
			html +=	"<div class=\"info_img\">";
			html +=	"<div id=\"finish\"></div>";
			html +="</div>";
			html +=	"<div class=\"img_add_div\" >";
		
			html += "<input type=\"hidden\" id=\"fileName1\" readonly=\"readonly\" />";
			html +=	"<input type=\"button\" value=\"사진등록\" id=\"fileBtn1\">";
			html +=	"</div>";
			html +=	"<div class=\"text_input\">";
			html +=	"<textarea placeholder=\"강의과목에 대한 정보 입력\" rows=\"11\" cols=\"40\" id =\"lectinfo\" name=\"lectinfo\" ></textarea>";
			html += "<input type=\"hidden\" id =\"imgname\" name=\"imgname\" >";
			html += "</form>";  
			html += "<div class=\"real_file_area\">";
			html += "<form action = \"fileUploadAjax\" method=\"post\"  id=\"uploadForm\" enctype=\"multipart/form-data\"  >";
			html += "<input type=\"file\" name=\"attFile1\" id=\"attFile1\"><br />";
			html += "</form>";
			html += "<input type=\"button\" value=\"업로드\" id=\"uploadBtn\" />";
			html +=	"<div id=\"finish\"></div>";
			html +=	"</div>";
			html +=	"</div>";
			//html +=	"<input type=\"button\" value=\"강의등록\" id=\"regibtn\">";
			html +=	"</div>";
			
			
			makePopup(1,"강의 등록", html, true , 720, 540,
					function(){
				
				
				//숫자 입력 부분 
				
			
				
			
				$("#cost").bind("keyup", function(event) {
				    var regNumber = /^[0-9]*$/;
				    var temp = $("#cost").val();
				    if(!regNumber.test(temp))
				    {
				        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
				        $("#cost").val(temp.replace(/[^0-9]/g,""));
				        $("#cost").focus();
				    }
				});
				
				
				
				$("#atnd").bind("keyup", function(event) {
				    var regNumber = /^[0-9]*$/;
				    var temp = $("#atnd").val();
				    if(!regNumber.test(temp))
				    {
				       
				        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
				        $("#atnd").val(temp.replace(/[^0-9]/g,""));
				        $("#atnd").focus();
				    }
				});
				
				
				
				
				//강의형식 radio, 강사 입력 부분
				$(".chebox_input").on("click", "input", function() {
					console.log($(this).val());
					if($(this).val() == "0") {
						$("#tchrCheck").prop("disabled", true);
						$("#tchrname").val("");
						$("#tchrno").val("");
					} else {
						$("#tchrCheck").prop("disabled", false);
					}
				});
				
				
				/*------------------------------사용자 검색부분 ----------------------------------*/
				$("#empCheck").on("click", function () {
					
					var html="";
					
					html +=	"<form action=\"#\" id=\"searchEmpDataForm\" method=\"post\">";
					html += "<div class=\"checkPop\">";
					
					html += "<div class=\"checkPop_1\">";
					
					//html += "<input type=\"hidden\" name=\"no\" id=\"no\"/>";
					html += "<select name=\"searchGbn\">";
					html += "<option value=\"0\">성명</option>";
					html += "<option value=\"1\">부서</option>";
					html += "</select>";
					
					html +="<input type=\"text\" id=\"searchEmpTxt\" name=\"searchEmpTxt\">";
					html += "<input type=\"button\" id=\"searchEmpBtn\" name=\"searchEmpBtn\" value=\"검색\">";
					html += "</div><br>";
					html += "<div class=\"checkPop_2\">";
					html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
					html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
					html += "<input type=\"hidden\" name=\"deptno\" id=\"deptno\">";
					html += "<input type=\"hidden\" name=\"deptnm\" id=\"deptnm\">";
					
					html += "<table id=\"emphead\">";
					html += "<colgroup>";
					html += "<col width=\"120\" />";
					html += "<col width=\"120\" />";
					html += "</colgroup>";
					html += "<thead>";
					html += "<tr>";
					html += "<th>성명</th>";
					html += "<th>부서</th>";
					html += "</tr>";
					html += "</thead>";
					html += "</table>";
					html += "<div id=\"listDiv\">";
					html += "<table id=\"board2\">";
					html += "<colgroup>";
					html += "<col width=\"120\" />";
					html += "<col width=\"120\" />";
					html += "</colgroup>";
					html += "<tbody>";
					html += "</tbody>";
					html += "</table>";
					html += "</div>";
					html += "</div>";
					
					html += "</form>";
					

					makePopup(2, "사용자검색", html, true, 400, 400,
					function() {
					$("#searchEmpBtn").on("click", function () {
						searchEmpForm();
								
							});
					//컨텐츠이벤트
					$("#listDiv").slimScroll({
					width: "250px",
					height: "170px",
					axis: "both"
					});
					
					$(".checkPop").on("keypress", "input", function(event) {
						if(event.keyCode == 13) {
							$("#searchEmpBtn").click();
							return false;
						}
					});
					
					
					$("#searchEmpDataForm").attr("action","ASLecList")
					searchEmpForm();
			
					 $(".checkPop_2 tbody").on("click","tr", function () {
						$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
						$(".checkPop_2 #no").val($(this).children().eq(0).attr("name"));// name 가져와서 .ch~no에 데이터 담기
						$(".checkPop_2 #nm").val($(this).children().eq(0).html());// html에 자식값을 nm에 전달
						//$(".checkPop_2 #deptno").val($(this).children().eq(1).attr("name"));// name 가져와서 .ch~no에 데이터 담기
						//$(".checkPop_2 #deptnm").val($(this).children().eq(1).html());// html에 자식값을 nm에 전달
						$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
						//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
					}); 
					
				
					}, "확인", function(){
				 		$("#actionForm #mngrno").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#actionForm #mngrname").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						//$("#writeDataForm #textDeptNo").val($(".checkPop_2 #deptno").val());// no값을 textempno에 담기
						//$("#writeDataForm #textDeptNm").val($(".checkPop_2 #deptnm").val());// nm값을 textempnm에 담기 
						closePopup(2);
					});
				});
/*----------------------------------사용자 검색부분 ----------------------------------*/
/*---------------------------------- 강의실검색     ----------------------------------*/					
					

					
					$("#placeCheck").on("click", function () {
						
						var html="";
						
						html +=	"<form action=\"#\" id=\"searchPlaceDataForm\" method=\"post\">";
						html += "<div class=\"checkPop\">";
					// 	html += "<div class=\"checkPop_1\"><input type=\"text\" id=\"searchPlaceTxt\" name=\"searchPlaceTxt\">";
					//	html += "<input type=\"button\" id=\"searchPlaceBtn\" name=\"searchPlaceBtn\" value=\"검색\">"; 
						html += "</div><br>";
						html += "<div class=\"checkPop_2\">";
						html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
						html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
						html += "<input type=\"hidden\" name=\"deptno\" id=\"deptno\">";
						html += "<input type=\"hidden\" name=\"deptnm\" id=\"deptnm\">";
						
						html += "<table id=\"emphead\">";
						html += "<colgroup>";
						html += "<col width=\"120\" />";
						html += "<col width=\"120\" />";
						html += "</colgroup>";
						html += "<thead>";
						html += "<tr>";
						html += "<th>강의실명</th>";
						html += "<th>수용인원</th>";
						html += "</tr>";
						html += "</thead>";
						html += "</table>";
						html += "<div id=\"listDiv\">";
						html += "<table id=\"place_board\">";
						html += "<colgroup>";
						html += "<col width=\"120\" />";
						html += "<col width=\"120\" />";
						html += "</colgroup>";
						html += "<tbody>";
						html += "</tbody>";
						html += "</table>";
						html += "</div>";
						html += "</div>";
						
						html += "</form>";
						

						makePopup(2, "강의실검색", html, true, 400, 400,
						function() {
						$("#searchPlaceBtn").on("click", function () {
									
									
								});
						//컨텐츠이벤트
						$("#listDiv").slimScroll({
						width: "250px",
						height: "170px",
						axis: "both"
						});
						
						$("#searchPlaceDataForm").attr("action","ASLecList")
						searchPlaceForm();
				
						 $(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().eq(0).attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().eq(0).html());// html에 자식값을 nm에 전달
							//$(".checkPop_2 #deptno").val($(this).children().eq(1).attr("name"));// name 가져와서 .ch~no에 데이터 담기
							//$(".checkPop_2 #deptnm").val($(this).children().eq(1).html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						}); 
						
					
						}, "확인", function(){
					 		$("#actionForm #placeno").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
							$("#actionForm #placename").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
							//$("#writeDataForm #textDeptNo").val($(".checkPop_2 #deptno").val());// no값을 textempno에 담기
							//$("#writeDataForm #textDeptNm").val($(".checkPop_2 #deptnm").val());// nm값을 textempnm에 담기 
							closePopup(2);
						});
					});
	/*---------------------------------- 강의실검색  끝   ----------------------------------*/	
	
	/*---------------------------------- 강사검색     ----------------------------------*/	
	$("#tchrCheck").on("click", function () {
						
						var html="";
						
						html +=	"<form action=\"#\" id=\"searchTchrDataForm\" method=\"post\">";
						html += "<div class=\"checkPop\">";
						html += "<div class=\"checkPop_1\"><input type=\"text\" id=\"searchTchrTxt\" name=\"searchTchrTxt\">";
						html += "<input type=\"button\" id=\"searchTchrBtn\" name=\"searchTchrBtn\" value=\"검색\">";
						html += "</div><br>";
						html += "<div class=\"checkPop_2\">";
						html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
						html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
						html += "<input type=\"hidden\" name=\"deptno\" id=\"deptno\">";
						html += "<input type=\"hidden\" name=\"deptnm\" id=\"deptnm\">";
						
						html += "<table id=\"emphead\">";
						html += "<colgroup>";
						html += "<col width=\"120\" />";
						html += "<col width=\"120\" />";
						html += "</colgroup>";
						html += "<thead>";
						html += "<tr>";
						html += "<th>성명</th>";
						html += "<th>연락처</th>";
						html += "</tr>";
						html += "</thead>";
						html += "</table>";
						html += "<div id=\"listDiv\">";
						html += "<table id=\"tchr_board\">";
						html += "<colgroup>";
						html += "<col width=\"120\" />";
						html += "<col width=\"120\" />";
						html += "</colgroup>";
						html += "<tbody>";
						html += "</tbody>";
						html += "</table>";
						html += "</div>";
						html += "</div>";
						
						html += "</form>";
						

						makePopup(2, "강사검색", html, true, 400, 400,
						function() {
						$("#searchTchrBtn").on("click", function () {
							searchTchrForm();
									
								});
						//컨텐츠이벤트
						$("#listDiv").slimScroll({
						height: "170px",
						width: "250px",
						axis: "both"
						});
						
						$("#searchTchrDataForm").attr("action","ASLecList")
						searchTchrForm();
				
						 $(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().eq(0).attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().eq(0).html());// html에 자식값을 nm에 전달
							//$(".checkPop_2 #deptno").val($(this).children().eq(1).attr("name"));// name 가져와서 .ch~no에 데이터 담기
							//$(".checkPop_2 #deptnm").val($(this).children().eq(1).html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						}); 
						
					
						}, "확인", function(){
					 		$("#actionForm #tchrno").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
							$("#actionForm #tchrname").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
							//$("#writeDataForm #textDeptNo").val($(".checkPop_2 #deptno").val());// no값을 textempno에 담기
							//$("#writeDataForm #textDeptNm").val($(".checkPop_2 #deptnm").val());// nm값을 textempnm에 담기 
							closePopup(2);
						});
					});
	
	/*---------------------------------- 강사검색  끝   ----------------------------------*/	
	
			
	
				///컨텐츠이벤트			
				$(".img_add_div").on("click","input", function() {
					
					clickFile($(this).attr("id"));
				});	
	
				
				$(".real_file_area").on("change","input", function() {
					insertFileName($(this).attr("id"));
					
				var uploadForm = $("#uploadForm");
					//alert("업로드 수행");
					uploadForm.ajaxForm({//폼을 실행 할 때는 ajax형태로 동작 하겠다. (form안에 있는 형태로 , submit을 해야 ajax가 동작한다.)
						beforeSubmit: function() {//Form 실행 전 실행될 내용
							
						},
						success : function(result) {
						if(result.result == "SUCCESS"){
							var html = "";
								
								for(var i = 0; i <result.fileName.length ; i++){
									html += result.fileName[i];
								}
							
							
							//var imgname =html;
							
							$("#imgname").val(html);
							
							html= "<img src=\"resources/upload/" + html+  "\" />";
							//alert(imgname);
							
							
								$("#img_div").html(html);
								$("#finish").html(html);
							}else {
								alert("저장 실패");
							}	
						}, error : function(request, status, error){
							console.log("status : " + request.status);
							console.log("text : " + request.responseText);
							console.log("error : " + error);
						}
					}); // ajaxForm end 
					
					uploadForm.submit();
				});
				
				
				$("#uploadBtn").on("click",function(){	
				
				});

				//컨텐츠 이벤트
			},"강의등록", function(){
				
				
				var type = $('input[name="lectype"]:checked').val();
			
				
				
				//날짜부분
				
				
				var now = new Date();
		   		var year= now.getFullYear();
		   		var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		    	var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		    	var nowDate = year + '-' + mon + '-' + day;
		    
		    
				var startDate = $('#lectsday').val();
			    var endDate = $('#lecteday').val();
			    var nowArray = nowDate.split('-');
			    var startArray = startDate.split('-');
			    var endArray = endDate.split('-');   
			    var now_date = new Date(nowArray[0],nowArray[1],nowArray[2]);
			    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
			    var end_date = new Date(endArray[0], endArray[1], endArray[2]);

			
				
				if($.trim($("#lectname").val()) == ""){
					 makeAlert(2, "알림", "강의명을 입력하세요", null, null);
					$("#lectname").focus();
				}else if($.trim($("#lectsday").val())==""){
					makeAlert(2, "알림", "시작일을 선택하세요", null, null);
					$("#lectsday").focus();
				}else if($.trim($("#lecteday").val())==""){
					makeAlert(2, "알림", "종료일을 선택하세요", null, null);
					$("#lecteday").focus();
				}else if(start_date.getTime() > end_date.getTime()) {
		        	makeAlert(2, "알림", "종료일자가 시작일보다 빠릅니다.", null, null);
		        }else if($.trim($("#placename").val())==""){
					makeAlert(2, "알림", "장소를 선택하세요", null, null);
					$("#placename").focus();
				}else if($.trim($("#mngrname").val())==""){
					makeAlert(2, "알림", "담당자를 선택하세요", null, null);
					$("#mngrname").focus();
				}else if($("input:radio[name='lectype']").is(":checked")==false){
					makeAlert(2, "알림", "형식을 선택하세요", null, null);
					$("#lectype").focus();
				}else if(($.trim($("#tchrname").val())=="")&&(type==1)){
					makeAlert(2, "알림", "강사를 선택하세요", null, null);
					$("#tchrname").focus();
				}else if($.trim($("#atnd").val())==""){
					makeAlert(2, "알림", "수강인원을 입력하세요", null, null);
					$("#atnd").focus();
				}else if($.trim($("#atnd").val())==""){
					makeAlert(2, "알림", "수강인원을 입력하세요", null, null);
					$("#atnd").focus();
				}else if($.trim($("#cost").val())==""){
					makeAlert(2, "알림", "비용을 입력하세요", null, null);
					$("#cost").focus();
				}else if($.trim($("#lectinfo").val())==""){
					makeAlert(2, "알림", "강의 설명을 입력하세요", null, null);
					$("#lectinfo").focus();
				}else{
					
					if(now_date.getTime() > end_date.getTime()){
						makeAlert(2, "알림", "해당 강의는 종료 강의로 입력됩니다.", null, function(){
							closePopup(1);
							
						});
										
					}else if(now_date.getTime() < end_date.getTime()&&now_date.getTime() > start_date.getTime()){
						makeAlert(2, "알림", "본 강의는 진행중 강의로 입력됩니다.", true, function(){
							closePopup(1);
							
						});
						
					}
					
					regiLect();		
				}
			});

		});

	
});
	
	function clickFile(obj){
		var num = obj.substring(obj.length - 1, obj.length);
		console.log(num);
		$("#attFile"+num).click();
			
	}
	
	function insertFileName(obj){
		var num = obj.substring(obj.length - 1, obj.length);
		
		var fileName = $("#" + obj).val();
		fileName =  fileName.substring(fileName.lastIndexOf("\\")+1);
		
		
		$("#fileName" + num).val(fileName);
	}
	
	/*--------------------------------------개설예정 강의 목록 -------------------------------------- */		
	function sche_reloadList() {
		var params = $("#sche_dataForm").serialize();
		
		$.ajax({
			type : "post",
			url : "lectscheListAjax", 
			dataType : "json",
			data : params, 
			success : function(result) {
				sche_redrawList(result.list3);
				sche_redrawPaging(result.pb3);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function sche_redrawList(list) {
		var html = "";
		if(list.length == 0){

		html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		for (var i = 0; i < 3 ; i++) {//
			if (color == 0) {
				html += "<tr   name=\"Nseltr\" class=\"#\" >";
				color = 1;
			} else {
				html += "<tr  name=\"Nseltr\" class=\"sec_tr\"  >";
				color = 0;
			}	
			html += "<td></td>";
			html += "<td></td>";
			html += "<td disabled></td>";
			html += "<td></td>";
			html += "</tr>";
			console.log(color);
		}
		list.length=4;
			} else {
				var color = 0;
				for (var i = 0; i < list.length; i++) {
					
					if (color == 0) {
						
						html += "<tr name=\"" + list[i].LECT_NO + "\" >";
						color = 1;
					} else {
						html += "<tr name=\"" + list[i].LECT_NO + "\" class=\"sec_tr\" >";
						color = 0;
					}
					html += "<td>" + list[i].LECT_NAME + "</td>";
					html += "<td>" + list[i].LECT_DAY + "</td>";
					html += "<td>" + list[i].NAME + "</td>";
					html += "<td>" + list[i].LECT_TYPE + "</td>";
					html += "</tr>";
					
					console.log(color);
				}
			}

			if (list.length == 0) {
				//html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
			} else {
				for (var i = 0; i < 4 - list.length; i++) {
					if (color == 0) {
						html += "<tr   name=\"Nseltr\" class=\"#\" >";
						color = 1;
					} else {
						html += "<tr  name=\"Nseltr\" class=\"sec_tr\"  >";
						color = 0;
					}	
					html += "<td></td>";
					html += "<td></td>";
					html += "<td disabled></td>";
					html += "<td></td>";
					html += "</tr>";
					console.log(color);
				}
			}
			$("#sche_board tbody").html(html);

		}
	
	function sche_redrawPaging(pb) {
		var html = "";
		html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";

		if ($("#page3").val() == "1") {
			html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
		} else {
			html += "<input type=\"button\" value=\"&lt\" name=\""
					+ ($("#page3").val() * 1 - 1) + "\">";
		}

		for (var i = pb.startPcount; i <= pb.endPcount; i++) {
			if (i == $("#page3").val()) {
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" 
						+ i + "\" disabled=\"disabled\" class=\"paging_on\">";
			} else {
				html += "<input type=\"button\" value=\"" + i + "\" name=\""
						+ i +  "\" class=\"paging_off\">";
			}
		}

		if ($("#page3").val() == pb.maxPcount) {
			html += "<input type=\"button\" value=\"&gt\" name=\"" 
					+ pb.maxPcount +  "\">";
		} else {
			html += "<input type=\"button\" value=\"&gt\" name=\""
					+ ($("#page3").val() * 1 + 1) + "\">";
		}
		html += "<input type=\"button\" value=\"&gt&gt\" name=\""
  			+ pb.maxPcount +  "\">";

		$("#sche_pagingArea").html(html);
	}
	
	
	/*--------------------------------------진행중인 강의 목록 -------------------------------------- */	
	
	/* 제이쿼리 존 */
	function reloadList() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "lectListAjax", 
		dataType : "json",
		data : params, 
		success : function(result) {
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}
	

function redrawList(list) {
	var html = "";
	if(list.length == 0){

	//html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		} else {
			var color = 0;
			for (var i = 0; i < list.length; i++) {
				
				if (color == 0) {
					
					html += "<tr name=\"" + list[i].LECT_NO + "\" >";
					color = 1;
				} else {
					html += "<tr name=\"" + list[i].LECT_NO + "\" class=\"sec_tr\" >";
					color = 0;
				}
				html += "<td>" + list[i].LECT_NAME + "</td>";
				html += "<td>" + list[i].LECT_DAY + "</td>";
				html += "<td>" + list[i].NAME + "</td>";
				html += "<td>" + list[i].LECT_TYPE + "</td>";
				html += "</tr>";
				
				console.log(color);
			}
		}

		if (list.length == 0) {
			html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
			for (var i = 0; i < 3; i++) {
				if (color == 0) {
					html += "<tr   name=\"Nseltr\" class=\"#\" >";
					color = 1;
				} else {
					html += "<tr  name=\"Nseltr\" class=\"sec_tr\"  >";
					color = 0;
				}
				html += "<td></td>";
				html += "<td></td>";
				html += "<td disabled></td>";
				html += "<td></td>";
				html += "</tr>";
				console.log(color);
			}
		} else {
			for (var i = 0; i < 4 - list.length; i++) {
				if (color == 0) {
					html += "<tr   name=\"Nseltr\" class=\"#\" >";
					color = 1;
				} else {
					html += "<tr  name=\"Nseltr\" class=\"sec_tr\"  >";
					color = 0;
				}
				html += "<td></td>";
				html += "<td></td>";
				html += "<td disabled></td>";
				html += "<td></td>";
				html += "</tr>";
				console.log(color);
			}
		}
		$("#board tbody").html(html);

	}

	function reloadList2() {
		var params = $("#dataForm").serialize();
		console.log(params);
		$.ajax({
			type : "post",
			url : "lectDtlAjax",
			dataType : "json",	
			data : params,
			success : function(result) {
				if(result.data2 != null) {
					redrawList2(result.data2,result.list2);
				}
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}


	function redrawList2(data,list) {
		var html = "";
		var condition="신 청";

		html += "<div class=\"input_area\">";
		html += html += "<div class=\"input_inform_area\">";
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"login_input_q\">강의명:</div>";
		html += "<div class=\"login_input_a\">" + data.LECT_NAME
				+ "</div>";
		html += "</div>";
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"login_input_q\">시작일:</div>";
		html += "<div class=\"login_input_a\">" + data.LECT_DAY + "</div>";
		html += "</div>";
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"login_input_q\">담당자:</div>";
		html += "<div class=\"login_input_a\">" + data.NAME + "</div>";
		html += "</div>";
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"login_input_q\">장소:</div>";
		html += "<div class=\"login_input_a\">" + data.PLACE_NAME + "</div>";
		html += "</div>";
		
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"login_input_q\">형식:</div>";
		html += "<div class=\"login_input_a\">" + data.LECT_TYPE + "</div>";
		html += "</div>";
		
		if(data.TCHR_NAME != null){	
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"login_input_q\">강사명:</div>";
		html += "<div class=\"login_input_a\">" + data.TCHR_NAME + "</div>";
		html += "</div>";
		}
		
		html += "<div class=\"login_input_area\">";
		html += "<div class=\"\">※수강인원 현황 ("+ list.length +"/"+ data.LECT_ATND +")</div>";
		html += "</div>";
		html += "<div class=\"table_area_inpopup\">";
		html += "<table >";
		
		html += "<colgroup>";
		html += "<col width=\"120\" />";
		html += "<col width=\"120\" />";
		html += "<col width=\"120\" />";
		html += "</colgroup>";
		html += "<thead>";
		html += "<tr>";
		html += "<th>성명</th>";
		html += "<th>사번</th>";
		html += "<th>직급</th>";
		html += "</tr>";
		html += "</thead>";
		html += "</table>";
		
		html += "<div id=\"listDiv_1\">";
	
		html += "<table id=\"afcboard\">";
		html += "<colgroup>";
		html += "<col width=\"120\" />";
		html += "<col width=\"120\" />";
		html += "<col width=\"120\" />";
		html += "</colgroup>";
		html += "<tbody>";
		
		if (list.length == 0){
			html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {		
				if("${sEmpNo}"==list[i].EMP_NO){
					condition="수강취소";
				}
				html += "<tr name=\"" + list[i].AFC_NO + "\" class=\"sec_tr\" >";
				html += "<td>" + list[i].NAME + "</td>";
				html += "<td>" + list[i].EMP_NO + "</td>";
				html += "<td>" + list[i].POSI_NAME + "</td>";
				html += "</tr>";
			}

	}
	
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";
		html += "</div>";  
		
		
		html += "<div class=\"input_inform_area_2\">";
		html += "<div class=\"info_img\">";
		
		if(data.LECT_PIC == null || data.LECT_PIC == "") {
		      html += "<img alt=\"사진없음\" src=\"resources/images/erp/as/sh/lect_nopic.jpg\"/>";
		   } else {
			  html += "<img  src=\"resources/upload/" + data.LECT_PIC+  "\" />";
		   }
		
		
		html += "</div>";
		html += "<div class=\"img_add_div\"></div>"; 
		html += "<div class=\"text_input\">" + data.LECT_CON + "</div>";
		html += "</div>";
		
		//html += "<input type=\"button\" value=\"수   정\">";
		
		html += "</div>";	
		html += "</div>";
		
		
		
		if("${sAuthNo}"==7){
			html += "<div class=\"modi_btnzone\">";
			html += "<input type=\"button\" value=\"등록 취소\" id=\"regicancel_btn\" style=\"margin-right:10px\" />";
		//	html += "<input type=\"button\" value=\"수  정\" id=\"modify_btn\" />";
			html += "</div>";
		}
			
			if(popupCheck(1)) {

			popupContentsChange(1, html, function() {
				$("#listDiv_1").slimScroll({
					height: "80px",
					axis: "both"
				});
			});
		
			popupBtnChange(1,1,condition,function(){
				
				if(condition=="수강취소")
				{

					var html="";
					
					html +=	"<form action=\"#\" id=\"dropLectForm\" method=\"post\">";
					html += "<div class=\"checkPop\">";
					html += "취소신청자 : ${sName}<br/>";
					html += "<input type=\"hidden\" name=\"appemp\" id=\"appemp\" value=\"${sEmpNo}\">";
					html += "취소할 과목 :" +data.LECT_NAME+"";
					html += "<input type=\"hidden\" name=\"applect_no\" id=\"applect_no\" value=\"" +data.LECT_NO+"\">";
					html += "<br/>";
					html += "<br/>";
					html += "취소하시겠습니까?";
					html += "</div>";
					html += "</form>";
					
		
					
					makePopup(2, "수강취소", html, true, 300, 200, null, "수강취소", function(){
						//alert($("#applect_no").val());
						//alert($("#appemp").val());
						dropapply();
						
						closePopup(2);
					});
					
					
					condition="신 청";
					
				}else{
						
	
						var html="";
						
						html +=	"<form action=\"#\" id=\"applyDataForm\" method=\"post\">";
						html += "<div class=\"checkPop\" style=\"font-size:11pt\" >";
						html += "신청자 : ${sName}<br/>";
						html += "<input type=\"hidden\" name=\"appemp\" id=\"appemp\" value=\"${sEmpNo}\">";
						html += "신청과목 :" +data.LECT_NAME+"";
						html += "<input type=\"hidden\" name=\"applect_no\" id=\"applect_no\" value=\"" +data.LECT_NO+"\">";
						html += "<br/>";
						html += "<br/>";
						html += "신청하시겠습니까?";
						html += "</div>";
						html += "</form>";
						
						
						makePopup(2, "신청정보", html, true, 300, 200, null, "신 청", function(){
							//alert($("#applect_no").val());
							regiapply();
							
							closePopup(2);
							
							condition="수강취소";
						});				
				}
			
			});
	
			} else {
						
				
				makePopup(1,"강의 상세정보", html, true , 750, 580, function(){

				$("#regicancel_btn").on("click",function() {
					
					var html="";
					
						html +=	"<form action=\"#\" id=\"delDataForm\" method=\"post\">";
						html += "<div class=\"checkPop\">";
						html += "취소할 강의 :" +data.LECT_NAME+"";
						html += "<input type=\"hidden\" name=\"applect_no\" id=\"applect_no\" value=\"" +data.LECT_NO+"\">";
						html += "<br/>";
						html += "<br/>";
						html += "취소하시겠습니까?";
						html += "</div>";
						html += "</form>";
						
					
						makePopup(2, "등록취소", html, true, 300, 200, null, "등록취소", function(){
						//alert($("#applect_no").val());
						//regiapply();
						delLectForm();
						
						
					});
						
				});
				
				/* --------------수정 시작-------------------------- */
				
				$("#modify_btn").on("click",function() {
										
					var html = "";
					

					html += "<div class=\"input_area\"style=\"height:410px\">";
					html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
					html +=	"<div class=\"input_inform_area\">";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">강의명(*)</div>";
					html +=	"<div class=\"login_input_txt\">";
					html +=	"<input type=\"text\" placeholder=\"강의명을 입력하세요\" id =\"lectname\" name=\"lectname\"  />";
					html +=	"</div>";
					html +=	"</div>";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">시작일</div>";
					html +=	"<div class=\"login_input_txt\">";
					html +=	"<input class=\"d_input\" type=\"date\" id=\"lec	tsday\" id =\"lectsday\" name=\"lectsday\">";
					html +=	"</div>";
					html +=	"</div>";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">종료일</div>";
					html +=	"<div class=\"login_input_txt\">";
					html +=	"<input class=\"d_input\" type=\"date\" id=\"lecteday\" id =\"lecteday\" name=\"lecteday\">";
					html +=	"</div>";
					html +=	"</div>";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">담당자</div>";
					html +=	"<div class=\"login_input_txt_insertbtn\">";
					html +=	"<input type=\"text\" placeholder=\"담당자를 선택하세요\" id =\"mngrname\" name=\"mngrname\"disabled />";
					/*-------------------------담당자검색 ----------------*/
					html +=	"<input type=\"hidden\" id=\"mngrno\" name=\"mngrno\">";
					html += "<input type=\"button\" value=\"사용자검색\" id=\"empCheck\" name=\"empCheck\">";
				
					html +=	"</div>";
					html +=	"</div>";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">장소</div>";
					html +=	"<div class=\"login_input_txt_insertbtn\">";
					html +=	"<input type=\"text\" placeholder=\"강의실을 선택하세요\" id =\"placename\" name=\"placename\" disabled />";
					html +=	"<input type=\"hidden\" id=\"placeno\" name=\"placeno\">";
					/*-------------------------강의실검색 ----------------*/
					html += "<input type=\"button\" value=\"강의실검색\" id=\"placeCheck\" name=\"placeCheck\">";
					html +=	"</div>";
					html +=	"</div>";
					html +=	"<div class=\"login_input_area\" style=\"height:30px\">";
					html +=	"<div class=\"login_input_q\">형식</div>";
					html +=	"<div class=\"chebox_input\">";
					html +=	"<input type=\"radio\" name=\"lectype\" value=\"1\" />강사초빙 ";
					html +=	"<input type=\"radio\" name=\"lectype\" value=\"0\" />스터디</div>";
					html +=	"</div>";
					html += "<div id=\"tchrnoti\">강사초빙 선택시 강사를 선택해야 합니다.</div>";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">강사명</div>";
					html +=	"<div class=\"login_input_txt_insertbtn\">";
					html +=	"<input type=\"text\" placeholder=\"강사를 선택하세요\" id =\"tchrname\" name=\"tchrname\" style=\"height:26px\" disabled />";
					html +=	"<input type=\"hidden\" id=\"tchrno\" name=\"tchrno\">";
					/*-------------------------강사검색 -----------------*/
					html += "<input type=\"button\" value=\"강사검색\" id=\"tchrCheck\" name=\"tchrCheck\">";  
					html +=	"</div>";
					html +=	"</div>";
					
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">수강인원</div>";
					html +=	"<div class=\"login_input_txt\">";
					html +=	"<input type=\"text\" placeholder=\"수강인원을 입력하세요\" id=\"atnd\" style=\"width:150px\" name=\"atnd\" /> 명";
					html +=	"</div>";
					html +=	"</div>";
					html +=	"<div class=\"login_input_area\">";
					html +=	"<div class=\"login_input_q\">비용</div>";
					html +=	"<div class=\"login_input_txt\">";
					html +=	"<input type=\"text\" placeholder=\"만원(￦)단위 입력\" id=\"cost\" style=\"width:150px\" name=\"cost\" /> 만원";
					html +=	"</div>";
					html +=	"</div>";
					
					html +=	"</div>";
					html +=	"<div class=\"input_inform_area_2\">";
					html +=	"<div class=\"info_img\">";
					html +=	"<div id=\"finish\"></div>";
					html +="</div>";
					html +=	"<div class=\"img_add_div\" >";
				
					html += "<input type=\"hidden\" id=\"fileName1\" readonly=\"readonly\" />";
					html +=	"<input type=\"button\" value=\"사진등록\" id=\"fileBtn1\">";
					html +=	"</div>";
					html +=	"<div class=\"text_input\">";
					html +=	"<textarea placeholder=\"강의과목에 대한 정보 입력\" rows=\"11\" cols=\"40\" id =\"lectinfo\" name=\"lectinfo\" ></textarea>";
					html += "<input type=\"hidden\" id =\"imgname\" name=\"imgname\" >";
					html += "</form>";  
					html += "<div class=\"real_file_area\">";
					html += "<form action = \"fileUploadAjax\" method=\"post\"  id=\"uploadForm\" enctype=\"multipart/form-data\"  >";
					html += "<input type=\"file\" name=\"attFile1\" id=\"attFile1\"><br />";
					html += "</form>";
					html += "<input type=\"button\" value=\"업로드\" id=\"uploadBtn\" />";
					html +=	"<div id=\"finish\"></div>";
					html +=	"</div>";
					html +=	"</div>";
					//html +=	"<input type=\"button\" value=\"강의등록\" id=\"regibtn\">";
					html +=	"</div>";
					
					
					makePopup(2,"강의 수정", html, true , 720, 540,
							null,"수정",null);
					

				});

				
				
			/* 	-----------------------------수정 끝---------------------- */
								
				$("#listDiv_1").slimScroll({
					height: "80px",
					axis: "both"
				}); 
				
			}, condition, function(){
				
				if(condition=="수강취소")
				{

					var html="";
					
					html +=	"<form action=\"#\" id=\"dropLectForm\" method=\"post\">";
					html += "<div class=\"checkPop\">";
					html += "취소신청자 : ${sName}<br/>";
					html += "<input type=\"hidden\" name=\"appemp\" id=\"appemp\" value=\"${sEmpNo}\">";
					html += "취소할 과목 :" +data.LECT_NAME+"";
					html += "<input type=\"hidden\" name=\"applect_no\" id=\"applect_no\" value=\"" +data.LECT_NO+"\">";
					html += "<br/>";
					html += "<br/>";
					html += "취소하시겠습니까?";
					html += "</div>";
					html += "</form>";
					
		
					
					makePopup(2, "수강취소", html, true, 300, 200, null, "수강취소", function(){
						//alert($("#applect_no").val());
						//alert($("#appemp").val());
						dropapply();
						
						closePopup(2);
					});
					
					
					condition="신 청";
					
				}else{
						
						
							
						
						var html="";
						
						html +=	"<form action=\"#\" id=\"applyDataForm\" method=\"post\">";
						html += "<div class=\"checkPop\">";
						html += "신청자 : ${sName}<br/>";
						html += "<input type=\"hidden\" name=\"appemp\" id=\"appemp\" value=\"${sEmpNo}\">";
						html += "신청과목 :" +data.LECT_NAME+"";
						html += "<input type=\"hidden\" name=\"applect_no\" id=\"applect_no\" value=\"" +data.LECT_NO+"\">";
						html += "<br/>";
						html += "<br/>";
						html += "신청하시겠습니까?";
						html += "</div>";
						html += "</form>";
						
						
						
						
						makePopup(2, "신청정보", html, true, 300, 200, null, "신 청", function(){
							//alert($("#applect_no").val());
							regiapply();
							
							closePopup(2);
							
							condition="수강취소";
						});
						
				}
			
			}/* , "등록취소",function(){
				alert("등록취소")
			
		
		
			},"수정",function(){
				
				
			} */);
		}
	}

	function redrawPaging(pb) {
		var html = "";
		html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";

		if ($("#page").val() == "1") {
			html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
		} else {
			html += "<input type=\"button\" value=\"&lt\" name=\""
					+ ($("#page").val() * 1 - 1) + "\">";
		}

		for (var i = pb.startPcount; i <= pb.endPcount; i++) {
			if (i == $("#page").val()) {
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" 
						+ i + "\" disabled=\"disabled\" class=\"paging_on\">";
			} else {
				html += "<input type=\"button\" value=\"" + i + "\" name=\""
						+ i +  "\" class=\"paging_off\">";
			}
		}

		if ($("#page").val() == pb.maxPcount) {
			html += "<input type=\"button\" value=\"&gt\" name=\"" 
					+ pb.maxPcount +  "\">";
		} else {
			html += "<input type=\"button\" value=\"&gt\" name=\""
					+ ($("#page").val() * 1 + 1) + "\">";
		}
		html += "<input type=\"button\" value=\"&gt&gt\" name=\""
  			+ pb.maxPcount +  "\">";

		$("#pagingArea").html(html);
	}
/*--------------------------------------진행중인 강의 목록 끝 -------------------------------------- */
  
 /*--------------------------------------강의등록 시작 -------------------------------------- */

	function regiLect() {
		var params = $("#actionForm").serialize();

		console.log(params);

		$.ajax({
			type : "post",
			url : "regiLectlAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				makeAlert(2, "", "등록에 성공했습니다.", null, function(){
					
					closePopup(1);
				});	
				
				reloadList();
				sche_reloadList();
		
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	/*--------------------------------------강의등록 끝 -------------------------------------- */
	
	/*--------------------------------------신청정보 시작 -------------------------------------- */
	
	function regiapply() {
		var params = $("#applyDataForm").serialize();

		$.ajax({
			type : "post",
			url : "regiApplyAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				makeAlert(3, "알림", "등록에 성공했습니다.", false, function() {
					
					
					closePopup(3);
					reloadList2();
				
					
				});
				
				
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
/*--------------------------------------신청정보 끝 -------------------------------------- */	
	
	
/*-----------------------------팝업직원검색 --------------*/
	function searchEmpForm(){
		var params = $("#searchEmpDataForm").serialize();
		

		$.ajax({
			type : "post",	
			url : "emppopupListAjax",	
			dataType : "json",	
			data : params,
			success : function (result) {
				empdraw(result.list);
				
			},
			error : function (request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("erro : " + error);
			}
		});
	}
	//사용자검색 
	function empdraw(list) {
		var html = "";
		if (list.length == 0) {
			html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {

				/* html += "<tr class=\"table_con\">"; */
				html += "<tr >";
				html += "<td name=\"" + list[i].EMP_NO + "\">" + list[i].NAME + "</td>";
				html += "<td name=\"" + list[i].DEPT_NO + "\">" + list[i].DEPT_NAME + "</td>";
				html += "</tr >";
			}
		}
		$("#board2 tbody").html(html);
	}
	/*-----------------------------팝업직원검색 --------------*/
	/*-----------------------------팝업강의실검색 --------------*/
	function searchPlaceForm(){
		var params = $("#searchPlaceDataForm").serialize();
		

		$.ajax({
			type : "post",	
			url : "placepopupListAjax",	
			dataType : "json",	
			data : params,
			success : function (result) {
				placedraw(result.list);
				
			},
			error : function (request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("erro : " + error);
			}
		});
	}
	//사용자검색 
	function placedraw(list) {
		var html = "";
		if (list.length == 0) {
			html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {

				/* html += "<tr class=\"table_con\">"; */
				html += "<tr >";
				html += "<td name=\"" + list[i].PLACE_NO + "\">" + list[i].PLACE_NAME + "</td>";
				html += "<td name=\"" + list[i].PLACE_NO + "\">" + list[i].USE_PPL + "</td>";
				html += "</tr >";
			}
		}
		$("#place_board tbody").html(html);
	}
	/*-----------------------------팝업강의실검색 --------------*/
	/*-----------------------------팝업강사검색 --------------*/
	function searchTchrForm(){
		var params = $("#searchTchrDataForm").serialize();
		

		$.ajax({
			type : "post",	
			url : "tchrpopupListAjax",	
			dataType : "json",	
			data : params,
			success : function (result) {
				tchrdraw(result.list);
				
			},
			error : function (request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("erro : " + error);
			}
		});
	}
	//사용자검색 
	function tchrdraw(list) {
		var html = "";
		if (list.length == 0) {
			html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {

				/* html += "<tr class=\"table_con\">"; */
				html += "<tr >";
				html += "<td name=\"" + list[i].TCHR_NO + "\">" + list[i].TCHR_NAME + "</td>";
				html += "<td name=\"" + list[i].TCHR_NO + "\">" + list[i].MOBILE_NUM + "</td>";
				html += "</tr >";
			}
		}
		$("#tchr_board tbody").html(html);
	}
	/*-----------------------------팝업강사검색 --------------*/
	
	
	
	
	/*----------------삭제 -------------------*/
	
	function delLectForm(){
	var params = $("#delDataForm").serialize();
	

	$.ajax({
		type : "post",	
		url : "AsLecttDeleteAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			
			makeAlert(3, "알림", "취소에 성공했습니다.", false, function() {
				
				closePopup(1);
				closePopup(2);
				closePopup(3);
			});
			
			
			reloadList();
			sche_reloadList();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
} 
	

	/*----------------삭제 -------------------*/
	/*----------------수강철회 -------------------*/

	function dropapply(){
		var params = $("#dropLectForm").serialize();
		

		$.ajax({
			type : "post",	
			url : "AsDroplectAjax",	
			dataType : "json",	
			data : params,
			success : function (result) {
				
				makeAlert(3, "알림", "수강을 취소했습니다..", false, function() {
					
					closePopup(3);
					reloadList2();
				});
				
				reloadList();
				sche_reloadList();
			},
			error : function (request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("erro : " + error);
			}
		});
	} 
	
	
</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="39"></c:param>
		<c:param name="leftMenuNo" value="46"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			 <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<!-- 메뉴 네비게이션 -->
		<div class="content_nav">HeyWe &gt; 자산 &gt; 교육관리 &gt; 교육 관리 현황</div>
		<!-- 현재 메뉴 제목 -->
		<div class="content_title">교육 현황</div>
		<!-- 내용 영역 -->
		<div class="top_block">강의중인 프로그램</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}" /> <input
				type="hidden" name="no" id="no" />
		</form>
		<div class="table_area">
			<table id="board">
				<colgroup>
					<col width="220" />
					<col width="300" />
					<col width="180" />
					<col width="180" />
				</colgroup>
				<thead>
					<tr>
						<th>프로그램</th>
						<th>기간</th>
						<th>교육담당</th>
						<th>형식</th>
					</tr>
				</thead>
				<tbody>


				</tbody>
			</table>
			<div id="pagingArea"></div>
			<!-- 컨트롤러+ajax로 테이블 내용 채울 영역 -->


		</div>
		<div class="block_"></div>
		<div class="top_block">개설예정 프로그램</div>
		<form action="#" id="sche_dataForm" method="post">
			<input type="hidden" name="page3" id="page3" value="${page3}" /> <input
				type="hidden" name="no" id="no" />
		</form>
		<div class="table_area">
			<table id="sche_board">
				<colgroup>
					<col width="220" />
					<col width="300" />
					<col width="180" />
					<col width="180" />
				</colgroup>
				<thead>
					<tr>
						<th>프로그램</th>
						<th>기간</th>
						<th>교육담당</th>
						<th>형식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="no"></td>
						<td></td>
						<td class="writer"></td>
						<td class="writer"></td>
					</tr>
				</tbody>
			</table>
			<div id="sche_pagingArea"></div>
		</div>


		<c:choose>
			<c:when test="${sAuthNo eq '7'}">
				<div class="button_div">
					<input type="button" value="정보관리" id="mngrlect"
						style="margin-right: 10px" /> <input type="button" value="강의등록"
						id="makePopup" />
				</div>
			</c:when>

			<c:otherwise>
			</c:otherwise>
		</c:choose>

	</div>

	<!-- ============================= -->


</body>
</html>