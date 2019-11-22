<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 강의 정보 관리</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/as/lecturelist.css" />
<style type="text/css">

.table_area_inpopup{
	margin:10px 0px 10px 0px;
}
#numbercheck, #phonenumbercheck {
	border-radius: 3px;
	width: 70px;
	height: 32px;
	font-size: 5px;
	background-color: #134074;
	color: #FFF;
	font-weight: bold;
	outline: none;
}

#empCheck, #placeCheck, #tchrCheck, #fileBtn1 {
	border-radius: 3px;
	width: 70px;
	height: 32px;
	font-size: 5px;
	background-color: #134074;
	color: #FFF;
	font-weight: bold;
	outline: none;
}

#placename {
	height: 10px;
}

#board2, #tchr_board, #place_board {
	margin-left: 0px;
	width: 250px;
}

/* #listDiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: calc(100% - 15px);
	margin: 0px !important;
	height: 170px !important;
} */

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

var roomnumcheckv=0; //호실번호 중복 판별
var phonenumcheckv=0; //강사휴대전화 중복 판별

	$(document).ready(function() {
		
		
		$("#placetable").on("click","tr",function(){
		
			$("#no").val($(this).attr("name"));
			//alert($("#no").val());
			if(($(this).attr("name"))!="Nseltr")
			{
				placeList(); //플레이스 리스트
			}
			else{console.log($(this).attr("name"));}
		});	
	
		
		$("#tchrtable").on("click","tr",function(){
			
			
			$("#tno").val($(this).attr("name"));
			
			if(($(this).attr("name"))!="Nseltr")
			{
				tchrDtl(); //강사 상세정보
			}
			else{console.log($(this).attr("name"));}
		});	

	
		if($("#page3").val() == ""){
			$("#page3").val("1");
		}
		tchr_reloadList();
		$("#sche_pagingArea").on("click","input", function(){
			$("#page3").val($(this).attr("name"));
			tchr_reloadList();
		});	
		
		
		
		
		
		
		
		if($("#page").val() == ""){
			$("#page").val("1");
		}
		place_reloadList();
		$("#pagingArea").on("click","input", function(){
			$("#page").val($(this).attr("name"));
			place_reloadList();
		});	
		
		
		
		$("#place_regi").on("click",function() {
			var html="";
			html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
			html +=	"<div class=\"login_input_q\">호실 번호</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"호실 번호 입력\" id =\"placeno\" name=\"placeno\" 	length=\"4\" style=\"width:100px\"  />";
			html +=	"<input type=\"button\"  value=\"중복확인\"  id=\"numbercheck\" >";
			html +=	"</div>";
			html +=	"<br/>";
			html +=	"<div class=\"login_input_q\">장소명</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"장소명을 입력하세요\" id =\"placename\" name=\"placename\"  />";
			html +=	"</div>";
			html +=	"<br/>";
			html +=	"<div class=\"login_input_q\">수용인원</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"수용인원을 입력하세요\" id =\"placeppl\" name=\"placeppl\"  maxlength=\"2\" />";
			html +=	"</div>";
			html += "</form>"
			
			
			makePopup(1,"장소등록", html, true , 350, 250, function(){
				
				$("#numbercheck").on("click", function(){
					
					if($.trim($("#placeno").val()) == ""){
						makeAlert(2,"알림","호실 번호를 입력하세요",null, null);
					
						$("#placeno").focus;
					}else{
						roomnumcheck();
					}
				});	

			$("#placeno").bind("keyup", function(event) {
			    var regNumber = /^[0-9]*$/;
			    var temp = $("#placeno").val();
			    if(!regNumber.test(temp))
			    {
			        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
			        $("#placeno").val(temp.replace(/[^0-9]/g,""));
			        $("#placeno").focus();
			    }
			});
			$("#placeppl").bind("keyup", function(event) {
			    var regNumber = /^[0-9]*$/;
			    var temp = $("#placeppl").val();
			    if(!regNumber.test(temp))
			    {
			        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
			        $("#placeppl").val(temp.replace(/[^0-9]/g,""));
			        $("#placeppl").focus();
			    }
			});			
			},
				"장소등록",function(){
				if(roomnumcheckv == 0){
					makeAlert(2,"알림","중복체크 후 진행하세요",null, null);
					$("#placeno").focus;
				}else if($.trim($("#placeno").val()) == ""){
					makeAlert(2,"알림","호실 번호를 입력하세요",null, null);
					$("#placeno").focus;
				}else if($.trim($("#placename").val()) == ""){
					makeAlert(2,"알림","장소명을 입력하세요",null, null);
					$("#placename").focus;
				}else if($.trim($("#placeppl").val()) == ""){
					makeAlert(2,"알림","수용인원을 입력하세요",null, null);
					$("#placeppl").focus;
				}else{
					regiPlace();
					closePopup(1);
				}
		});
});
		$("#tchr_regi").on("click",function() {
			var html="";
			html += "<form action=\"#\" id=\"actionForm2\" method=\"post\">";
			html += "<div style=\"margin-top:10px\">"
			html +=	"<div class=\"login_input_q\">강사 이름</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\"이름을 입력하세요\" id =\"tchrname\" name=\"tchrname\" maxlength=\"10\"  />";
			html +=	"</div>";
			html +=	"</div>";
			html +=	"<div class=\"login_input_q\">연락처</div>";
			html +=	"<div class=\"login_input_txt\">";
			html +=	"<input type=\"text\" placeholder=\" '-'를 제외하고 입력\" id =\"tchrphoneno\" name=\"tchrphoneno\" maxlength=\"11\" style=\"width:150px\"  />";
			html +=	"<input type=\"button\"  value=\"중복확인\"  id=\"phonenumbercheck\" >";
			html +=	"</div>";
			html += "</form>"
			
			
			makePopup(1,"강사등록", html, true , 350, 250, function(){
				
				$("#phonenumbercheck").on("click", function(){
					
			var regNumber =  /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
			var temp = $("#tchrphoneno").val();
				
					if(!regNumber.test(temp)){
					 makeAlert(2,"알림","올바른 값을 입력하세요",null, null);
					 $("#tchrphoneno").val('');
					 $("#tchrphoneno").focus();
					}else{
					//alert("중복확인 클릭");
					tchrnumcheck();
				}
			});


		/*$("#tchrphoneno").bind("keyup", function(event) {
				    var regNumber = /^[0-9]*$/;
				    var temp = $("#tchrphoneno").val();
				    if(!regNumber.test(temp))
				    {
				        makeAlert(2, "", "숫자만 입력하세요", null, null);
				        $("#tchrphoneno").val(temp.replace(/[^0-9]/g,""));
				        $("#tchrphoneno").focus();
				    }
				}); 
					 */
					
					
				},
					"강사등록",function(){
					
					var getName= RegExp(/^[가-힣]+$/);
					var regNumber =  /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
					var temp = $("#tchrphoneno").val();

						 if($.trim($("#tchrname").val()) == ""){
							makeAlert(2,"알림","강사 이름을 입력하세요",null, null);
							$("#tchrname").focus;
					
						}else if (!getName.test($("#tchrname").val())) {
							makeAlert(2,"알림","이름을 올바르게 입력하세요",null, null);
					        $("#tchrname").val("");
					        $("#tchrname").focus();
						}else if($.trim($("#tchrphoneno").val()) == ""){
							makeAlert(2,"알림","휴대전화 번호를 입력하세요",null, null);
							$("#tchrphoneno").focus;
					
						}else  if(!regNumber.test(temp)){
							makeAlert(2,"알림","휴대전화 번호를 확인하세요",null, null);
							 $("#tchrphoneno").val('');
							 $("#tchrphoneno").focus();
						 }else{
							regiTchr();	
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
	function tchr_reloadList() {
		var params = $("#tchr_dataForm").serialize();
		
		$.ajax({
			type : "post",
			url : "tchrListAjax", 
			dataType : "json",
			data : params, 
			success : function(result) {
				tchr_redrawList(result.list3);
				tchr_redrawPaging(result.pb3);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function tchr_redrawList(list) {
		var html = "";
		if(list.length == 0){

		html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		for (var i = 0; i <3; i++) {
			if (color == 0) {
				html += "<tr   name=\"Nseltr\" class=\"#\" >";
				color = 1;
			} else {
				html += "<tr  name=\"Nseltr\" class=\"sec_tr\"  >";
				color = 0;
			}
			html += "<td></td>";
			html += "<td disabled></td>";
			
			html += "</tr>";	
			console.log(color);
		}
			} else {
				var color = 0;
				for (var i = 0; i < list.length; i++) {
					
					if (color == 0) {
						
						html += "<tr name=\"" + list[i].TCHR_NO + "\" >";
						color = 1;
					} else {
						html += "<tr name=\"" + list[i].TCHR_NO + "\" class=\"sec_tr\" >";
						color = 0;
					}
					html += "<td>" + list[i].TCHR_NAME + "</td>";
					html += "<td>" + list[i].MOBILE_NUM + "</td>";
					html += "</tr>";
					
					console.log(color);
				}
			}

			if (list.length == 0) {
			
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
					html += "<td disabled></td>";
					
					html += "</tr>";
					console.log(color);
				}
			}
			$("#sche_board tbody").html(html);

		}
	
	function tchr_redrawPaging(pb) {
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
	function place_reloadList() {
	var params = $("#place_dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "placeListAjax", 
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

	html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		for (var i = 0; i <3; i++) {
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
			html += "</tr>";
			console.log(color);
		}
		} else {
			var color = 0;
			for (var i = 0; i < list.length; i++) {
				
				if (color == 0) {
					
					html += "<tr name=\"" + list[i].PLACE_NO + "\" >";
					color = 1;
				} else {
					html += "<tr name=\"" + list[i].PLACE_NO + "\" class=\"sec_tr\" >";
					color = 0;
				}
				html += "<td>" + list[i].PLACE_NO + "</td>";
				html += "<td>" + list[i].PLACE_NAME + "</td>";
				html += "<td>" + list[i].USE_PPL + "</td>";
				html += "</tr>";
				
				console.log(color);
			}
		}

		if (list.length == 0) {
			
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
				html += "</tr>";
				console.log(color);
			}
		}
		$("#board tbody").html(html);

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
  
  
  /*----------------------------------강의실 번호 중복체크 ---------------------------*/
 
	function roomnumcheck(){
		var params = $("#actionForm").serialize();

		$.ajax({
			type : "post",
			url : "roomnumcheckAjax",
			dataType : "json",
			data : params,
			success : function(data) {
			

				if (data.result == 1) {
					makeAlert(2, "알림", "이미 입력된 강의실 입니다", null, null);
					$("#placeno").val("");
					roomnumcheckv=0;
					
				} else {
					makeAlert(2, "알림", "입력이 가능한 호실 입니다.", null, null);
					roomnumcheckv=1;
				}
			}

		});
	}
	 /*----------------------------------강의실 번호 중복체크 끝---------------------------*/
	 
	 
	/*----------------------------------강사 중복체크 시작---------------------------*/
	
	function tchrnumcheck(){
		var params = $("#actionForm2").serialize();

		$.ajax({
			type : "post",
			url : "tchroverrapcheckAjax",
			dataType : "json",
			data : params,
			success : function(data) {
			

				if (data.result == 1) {
					makeAlert(2, "알림", "이미 등록된 전화번호 입니다", null, null);
					$("#tchrphoneno").val("");
					phonenumcheckv=0;
					
				} else {
					makeAlert(2, "알림", "입력이 가능한 전화번호 입니다.", null, null);
					phonenumcheckv=1;
				}
			}

		});
	}
	 
	 
	function tchrnumcheck2(){
		var params = $("#actionForm2").serialize();

		$.ajax({
			type : "post",
			url : "tchroverrapcheckAjax",
			dataType : "json",
			data : params,
			success : function(data) {
			

				if (data.result == 1) {
					makeAlert(2, "알림", "이미 등록된 전화번호 입니다", null, null);
					$("#tchrphoneno").val("");
					phonenumcheckv=0;
					
				} else {
					phonenumcheckv=1;
				}
			}

		});
	}
	
	

	
	
	 
	/*----------------------------------강사 중복체크 끝---------------------------*/
	/*--------------------------------------강의등록 시작 -------------------------------------- */

	function regiPlace() {
		var params = $("#actionForm").serialize();

		console.log(params);

		$.ajax({
			type : "post",
			url : "regiPlaceAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				makeAlert(2, "알림", result.msg , true, null);
				place_reloadList();
				roomnumcheckv=0;
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function regiTchr() {
		
		tchrnumcheck2();
		
		if(phonenumcheckv==1){
			
			var params = $("#actionForm2").serialize();

			console.log(params);

			$.ajax({
				type : "post",
				url : "regiTchrAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					makeAlert(2, "알림", result.msg , true, null);
					tchr_reloadList();
					phonenumcheckv=0;
					closePopup(1);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}

	}
	
	function placeList() {
		var params = $("#place_dataForm").serialize();
		console.log(params);
		$.ajax({
			type : "post",
			url : "placeDtlAjax",
			dataType : "json",	
			data : params,
			success : function(result) {
				if(result.data != null) {
					placedrawList(result.data);
				}
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function placedrawList(data){
		
		var html = "";
		
		html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
		html +=	"<div class=\"login_input_q\">호실 번호</div>";
		html +=	"<div class=\"login_input_txt\">";
		html +=	"<div class=\"login_input_q\" style=\"text-align:left\">: " + data.PLACE_NO + "</div>";
		html +=	"<input type=\"hidden\" placeholder=\"호실 번호 입력\" id =\"placeno\" name=\"placeno\" maxlength=\"4\" style=\"width:100px\"  readonly=\"readonly\" value=\"" + data.PLACE_NO + "\" />";
		html +=	"</div>";
		html +=	"<br/>";
		html +=	"<div class=\"login_input_q\">장소명</div>";
		html +=	"<div class=\"login_input_txt\">";
		html +=	"<input type=\"text\" placeholder=\"장소명을 입력하세요\" id =\"placename\" name=\"placename\" value=\"" + data.PLACE_NAME + "\" />";
		html +=	"</div>";
		html +=	"<br/>";
		html +=	"<div class=\"login_input_q\">수용인원</div>";
		html +=	"<div class=\"login_input_txt\">";
		html +=	"<div class=\"login_input_q\" style=\"text-align:left\">: " + data.USE_PPL + "</div>";
		html +=	"<input type=\"hidden\" placeholder=\"수용인원을 입력하세요\" id =\"placeppl\" name=\"placeppl\"  maxlength=\"2\" style=\"width:100px\"  value=\"" + data.USE_PPL + "\" />";
		html +=	"</div>";
		html += "</form>"
		
		
		makePopup(1,"장소 상세조회", html ,true ,350 ,250, function(){
			
		},"수정", function(){
			
			//수정부분
			updatePlace();
			
			
			
		});
	}
	
	function tchrDtl() {
		//alert("ajax동작");
		var params = $("#tchr_dataForm").serialize();
		console.log(params);
		$.ajax({
			type : "post",
			url : "tchrDtlAjax",
			dataType : "json",	
			data : params,
			success : function(result) {
				if(result.data2 != null) {
					tchrdrawList2(result.data2,result.list2);
					
				}
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function tchrdrawList2(data,list){
		//alert("ajax동작");
		var html = "";
		
		html += "<form action=\"#\" id=\"tchr_dataForm\" method=\"post\">";
		html +=	"<div class=\"login_input_q\">강사 번호</div>";
		html +=	"<div class=\"login_input_txt\">";
		html +=	"<div class=\"login_input_q\" style=\"text-align:left\">: " + data.TCHR_NO + "</div>";
		html +=	"<input type=\"hidden\" placeholder=\"호실 번호 입력\" id =\"placeno\" name=\"placeno\" maxlength=\"4\" style=\"width:100px\"  readonly=\"readonly\" value=\"" + data.PLACE_NO + "\" />";
		html +=	"</div>";
		html +=	"<br/>";
		html +=	"<div class=\"login_input_q\">강사 이름</div>";
		html +=	"<div class=\"login_input_txt\">";
		html +=	"<div class=\"login_input_q\" style=\"text-align:left\">: " + data.TCHR_NAME + "</div>";
		html +=	"<input type=\"hidden\" placeholder=\"장소명을 입력하세요\" id =\"placename\" name=\"placename\" value=\"" + data.TCHR_NAME + "\" />";
		html +=	"</div>";
		html +=	"<br/>";
		html +=	"<div class=\"login_input_q\" >전화번호</div>";
		html +=	"<div class=\"login_input_txt\">";
		html +=	"<div class=\"login_input_q\" style=\"text-align:left;width:200px\" >: " + data.TCHR_MOBILE_NUM+ "</div>";
		html +=	"<input type=\"hidden\" placeholder=\"수용인원을 입력하세요\" id =\"placeppl\" name=\"placeppl\"  maxlength=\"2\" style=\"width:100px\"  value=\"" + data.TCHR_MOBILE_NUM + "\" />";
		html +=	"</div>";
		html += "<div class=\"\">※강사경력 </div>";
		html += "</form>"
		
		
		html += "<div class=\"table_area_inpopup\">";
		html += "<table >";
		
		html += "<colgroup>";
		html += "<col width=\"120\" />";
		html += "<col width=\"240\" />";
		
		html += "</colgroup>";
		html += "<thead>";
		html += "<tr>";
		html += "<th>강의명</th>";
		html += "<th>기 간</th>";
		
		html += "</tr>";
		html += "</thead>";
		html += "</table>";
		
		html += "<div id=\"listDiv_1\">";
		
		html += "<table id=\"afcboard\">";
		html += "<colgroup>";
		html += "<col width=\"120\" />";
		html += "<col width=\"240\" />";
		html += "</colgroup>";
		html += "<tbody>";
		
		if (list.length == 0){
			html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
		} else {
				
			for (var i = 0; i < list.length; i++) {		
				
				html += "<tr name=\"" + list[i].TCHR_CAREER_NO + "\" class=\"sec_tr\" >";
				html += "<td>" + list[i].LECT_NAME + "</td>";
				html += "<td>" + list[i].LECT_DAY + "</td>";
				html += "</tr>";
			}
			
		}
		html += "</tbody>";
		html += "</table>";
		

		html += "</div>"; 
		html += "</div>"; 
		
			

		makeNoBtnPopup(1,"강사 상세조회", html ,true ,450 ,430, function(){
			
			$("#listDiv_1").slimScroll({
				height: "80px", width:"400px",
				axis: "both"
			});
		}, null);
		

	}	
/*--------------------------------------강의등록 끝 -------------------------------------- */
/*--------------------------------------장소명 수정부분 -------------------------------------- */
	
	
	function updatePlace() {
		var params = $("#actionForm").serialize();

		console.log(params);

		$.ajax({
			type : "post",
			url : "updatePlaceAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				makeAlert(2, "알림", result.msg , true, function(){
					place_reloadList();
					closePopup(1);
					closePopup(2);
				});
		
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	
/*--------------------------------------장소명 수정부분 -------------------------------------- */
</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="39"></c:param>
		<c:param name="leftMenuNo" value="48"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			 <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<!-- 메뉴 네비게이션 -->
		<div class="content_nav">HeyWe &gt; 자산 &gt; 교육관리 &gt; 강의 정보 관리</div>
		<!-- 현재 메뉴 제목 -->
		<div class="content_title">강의 정보 관리</div>
		<!-- 내용 영역 -->
		<div class="top_block">장소 관리</div>
		<form action="#" id="place_dataForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}" /> <input
				type="hidden" name="no" id="no" />
		</form>
		<div class="table_area">
			<table id="board">
				<colgroup>
					<col width="150" />
					<col width="200" />
					<col width="150" />
				</colgroup>
				<thead>
					<tr>
						<th>호실번호</th>
						<th>장소 이름</th>
						<th>수용인원</th>
					</tr>
				</thead>
				<tbody id="placetable">

				</tbody>
			</table>
			<div id="pagingArea" style="width: 500px"></div>
			<div class="button_div" style="width: 500px">
				<input type="button" value="장소 등록" id="place_regi" />
			</div>
			<!-- 컨트롤러+ajax로 테이블 내용 채울 영역 -->


		</div>
		<div class="block_" style="height: 50px"></div>
		<div class="top_block">강사 관리</div>
		<form action="#" id="tchr_dataForm" method="post">
			<input type="hidden" name="page3" id="page3" value="${page3}" /> <input
				type="hidden" name="tno" id="tno" />
		</form>
		<div class="table_area">
			<table id="sche_board">
				<colgroup>
					<col width="200" />
					<col width="300" />
				</colgroup>
				<thead>
					<tr>
						<th>강사명</th>
						<th>휴대전화 번호</th>
					</tr>
				</thead>
				<tbody id="tchrtable">

				</tbody>
			</table>
			<div id="sche_pagingArea" style="width: 500px"></div>
		</div>
		<div class="button_div" style="width: 500px">
			<input type="button" value="강사등록" id="tchr_regi" />
		</div>
	</div>
	<!-- ======================================================= -->
</body>
</html>