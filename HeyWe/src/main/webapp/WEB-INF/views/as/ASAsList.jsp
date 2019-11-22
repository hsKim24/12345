<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 자산 목록</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/as/As_main.css" />
<style type="text/css">
.popup1 {
	width: 100%;
	height: 100%;
	font-size: 11pt;
	text-align: left;
}
#div1{
	width: 25%;
	height: 30px;
	display: inline-block;
	vertical-align: top;
	text-align: right;
}
#div2{
	width: 70%;
	height: 30px;
	display: inline-block;
	margin-left: 6px;
}
#checkRe, #empCheck, #searchEmpBtn{
	width: 80px;
	height: 30px;
	font-size: 10pt;
	padding: 0px;
	background-color: #134074;
	color:white;
	border-radius: 3px;
}
#textItemNm, #textEmpNm, #textDepNm, #textPurPri, #textPurDate, #textCsNum, #textItemNo, #textDeptNm, #searchEmpTxt{
	width: 150px;
	height: 24px;
	font-size: 12pt;
}
#barcordImg{
	width: 150px;
	height: 150px;
}
#pagingArea {
	margin: 10px 0px;
	width : 880px;
	height: 40px;
	margin-left :40px;
	text-align: center;
}

#pagingArea > [type="button"] {
   display: inline-block;
   width: 30px;
   height: 30px;
   border: 1px solid #134074;
   border-radius:2px;
   font-size: 14pt;
   font-weight: bold;
   background-color: #FFFFFF;
   margin-left: 10px;
   color: #134074;
}

#pagingArea > [type="button"]:hover {
   cursor: pointer;
   background-color: #134074;
    color: #FFFFFF;
} 

#pagingArea  .paging_on {
   background-color: #134074;
   color: #FFFFFF;
}

#pagingArea  .paging_off {
   background-color: #FFFFFF;	
   color: #134074;
}
#searchGbn, #searchGbnD{	
	width: 90px;
	height: 35px;
	padding: 0px;
	font-size: 11pt;	
	border-radius: 3px;
}
#searchGbn1{	
	width: 90px;
	height: 30px;
	padding: 0px;
	font-size: 11pt;	
	border-radius: 3px;
}

.checkPop {
	width: 100%;
	height: 100%;
}
.checkPop_1{
	width: 100%;
	height: 40%;
	text-align: center;
}
.checkPop_2{
	width: 282px;
	height: 250px;
	text-align: center;
	margin: 0 auto;
} 

.checkPop_2 tbody tr.on {
	background-color: #DEE6EF;
}
#listdiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: calc(100% - 15px);
	margin: 0px !important;
	height: 160px !important;
}
</style> 
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
//중복체크에 쓰일거 선언
var itemNoCheck = 0;

$(document).ready(function () {
	
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	reloadList();
	
	if("${sAuthNo}" != 7){
		$("#newRegi").css("display", "none");
	}
	
//-------------------엔터 쳤을때 검색 작동되게하는것
	$(".midB").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			$("#searchBtn").click();
			return false;
		}
	});

	$("#pagingArea").on("click", "input", function() {
		$("#page").val($(this).attr("name"));
		reloadList();
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		reloadList();
	});
//--------------------------------------------신규등록
	$("#newRegi").on("click", function () {
		
		var html="";
			html +=	"<form action=\"#\" id=\"writeDataForm\" method=\"post\">";
			html += "<input type=\"hidden\" id=\"textEmpNo\" name=\"textEmpNo\">";
			
			html += "<div class=\"popup1\">";
			html +=	"<div><div id=\"div1\">제품 코드</div>"
									+"<div id=\"div2\"><input type=\"text\" id=\"textItemNo\" name=\"textItemNo\" placeholder=\"\" maxlength=\"15\">"
									+"</div></div><br>";
			html +=	"<div><div id=\"div1\">품 명</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textItemNm\" name=\"textItemNm\" placeholder=\"\"></div></div><br>";
			html +=	"<div><div id=\"div1\">사 용 자</div>"                                  
						+"<div id=\"div2\"><input type=\"text\" id=\"textEmpNm\" name=\"textEmpNm\" readonly=\"readonly\" >"
						+"<input type=\"hidden\" id=\"textEmpNo\" name=\"textEmpNo\" >"
						+"<input type=\"button\" value=\"검색\" id=\"empCheck\" name=\"empCheck\"></div></div><br>";
			html +=	"<div><div id=\"div1\">담당 부서</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textDeptNm\" name=\"textDeptNm\"  readonly=\"readonly\">"
						+"<input type=\"hidden\" id=\"textDeptNo\" name=\"textDeptNo\"></div></div><br>";
			html +=	"<div><div id=\"div1\">구입 가격</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textPurPri\" name=\"textPurPri\" placeholder=\"\" maxlength=\"11\"></div></div><br>";
			html +=	"<div><div id=\"div1\">구입 일자</div>"
						+"<div id=\"div2\"><input type=\"date\" id=\"textPurDate\" name=\"textPurDate\" placeholder=\"\"></div></div><br>";
			html +=	"<div><div id=\"div1\">CS. Num</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textCsNum\" name=\"textCsNum\" placeholder=\"\" maxlength=\"12\"></div></div>";
			html += "</div>"
			html +=	"</form>";	
			
		makePopup(1, "신규등록", html, true, 450, 450,
				function() {
			
//-------------------숫자만 입력하세요 
			$("#textPurPri").bind("keyup", function(event) {
			    var regNumber = /^[0-9]*$/;
			    var temp = $("#textPurPri").val();
			    if(!regNumber.test(temp))
			    {
			        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
			        $("#textPurPri").val(temp.replace(/[^0-9]/g,""));
			        $("#textPurPri").focus();
			    }
			});
			
			$("#textCsNum").bind("keyup", function(event) {
			    var regNumber = /^[0-9]*$/;
			    var temp = $("#textCsNum").val();
			    if(!regNumber.test(temp))
			    {
			       makeAlert(2, "알림", "숫자만 입력하세요", null, null);
			        $("#textCsNum").val(temp.replace(/[^0-9]/g,""));
			        $("#textCsNum").focus();
			    }
			});
					
			// 컨텐츠 이벤트(위에 html 내용 이후에 이벤트관련해서 여기서 사용)
			$("#empCheck").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"searchEmpDataForm\" method=\"post\">";
				html += "<div class=\"checkPop\">";
				html += "<div class=\"checkPop_1\">";
				html += "<select name=\"searchGbn1\" id=\"searchGbn1\">";
				html += "<option value=\"0\">성명</option>";
				html += "<option value=\"1\">부서</option>";
				html += "</select>";
				html += "<input type=\"text\" id=\"searchEmpTxt\" name=\"searchEmpTxt\">";
				html += "<input type=\"button\" id=\"searchEmpBtn\" name=\"searchEmpBtn\" value=\"검색\">";
				html += "</div><br>";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<input type=\"hidden\" name=\"deptno\" id=\"deptno\">";
				html += "<input type=\"hidden\" name=\"deptnm\" id=\"deptnm\">";
				html += "<table>";
				html +=	"<colgroup>";	
				html +=	"<col width=\"140\">";
				html +=	"<col width=\"140\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>성명</th>";
				html += "<th>부서</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board2\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"140\">";
				html +=	"<col width=\"140\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "사용자 & 부서 검색", html, true, 400, 400,
					function() {
					// 컨텐츠 이벤트
//--------------------------------스크롤
					$("#listdiv").slimScroll({
						height: "170px",
						axis: "both"
					});
//-----------------------엔터가능
					$(".checkPop").on("keypress", "input", function(event) {
						if(event.keyCode == 13) {
							$("#searchEmpBtn").click();
							return false;
						}
					});
//------------------------사용자부서에서 검색버튼
					$("#searchEmpBtn").on("click", function () {
						searchEmpForm();
					});
				
					$("#searchEmpDataForm").attr("action","ASAsList")
					searchEmpForm();
			
					$(".checkPop_2 tbody").on("click","tr", function () {
						$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
						$(".checkPop_2 #no").val($(this).children().eq(0).attr("name"));// name 가져와서 .ch~no에 데이터 담기
						$(".checkPop_2 #nm").val($(this).children().eq(0).html());// html에 자식값을 nm에 전달
						$(".checkPop_2 #deptno").val($(this).children().eq(1).attr("name"));// name 가져와서 .ch~no에 데이터 담기
						$(".checkPop_2 #deptnm").val($(this).children().eq(1).html());// html에 자식값을 nm에 전달
						$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
						//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
					});
				
			}, "확인", function(){
				$("#writeDataForm #textEmpNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
				$("#writeDataForm #textEmpNm").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
				$("#writeDataForm #textDeptNo").val($(".checkPop_2 #deptno").val());// no값을 textempno에 담기
				$("#writeDataForm #textDeptNm").val($(".checkPop_2 #deptnm").val());// nm값을 textempnm에 담기
				closePopup(2);
			});
		});
			
		}, "등록", function(){
//------------------------------공백일때 알람					
			if($.trim($("#textItemNo").val()) == ""){
				 makeAlert(2, "알림", "제품코드를 입력하세요", null, null);
				$("#textItemNo").focus();
			}else if($.trim($("#textItemNm").val())==""){
				makeAlert(2, "알림", "품명을 입력하세요", null, null);
				$("#textItemNm").focus();
			}else if($.trim($("#textPurPri").val())==""){
				makeAlert(2, "알림", "구입가격을 입력하세요", null, null);
				$("#textPurPri").focus();
			}else if($.trim($("#textPurDate").val())==""){
				makeAlert(2, "알림", "구입날짜를 선택하세요", null, null);
				$("#textPurDate").focus();
			}else if($.trim($("#textEmpNm").val())==""){
				makeAlert(2, "알림", "사용자를 선택하세요", null, null);
				$("#textEmpNm").focus();
			}else if($.trim($("#textCsNum").val())==""){
				makeAlert(2, "알림", "고객센터번호를 입력하세요", null, null);
				$("#textCsNum").focus();
			}else{	
				$("#writeDataForm").attr("action","ASAsList")
				
//-------중복체크폼 호출				
				itemNoCheckForm();
				closePopup(1);
			}
		});
		
	});
/*	 makeAlert(1, "test", "test중입니다.", true, null);  [알람 팝업 popup.js참조]
		
	  makeConfirm(1, "test", "test중입니다.", true, function(){
			alert("aa");
		}); 
		
		makePopup(1, "test", "test", true, 600, 200,    [팝업창 버튼]
				function() {
			// 컨텐츠 이벤트
		}, "버튼", function(){
			alert("aa");
			closePopup(1);
		}); 
	*/
	
//--------------상세보기수정 
	 $("#mainBoard tbody").on("click", "tr", function () {
		$("#textItemNo").val($(this).attr("name"));
		$("#dataForm").attr("action","ASAsList");
	 	dtlForm();
	}); 
});	

//-----리로드 리스트
function reloadList(){
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASAsListAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//--------테이블 리스트 그리기
function redrawList(list) {
	console.log(list);
	var html = "";
	if(list.length == 0){
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	}else {
		for(var i = 0; i < list.length; i++){
			
			html +=		"<tr class=\"table_con\" name=\"" + list[i].ASNO+ "\">";
			html +=		"<td>" + list[i].ASNO + "</td>";
			html +=		"<td id=\"itemName\">" + list[i].ASNM + "</td>";
			html +=		"<td id=\"name\">" + list[i].ENAME + "</td>";
			html +=		"<td id=\"dept\">" + list[i].DNAME + "</td>";
			html +=		"<td id=\"purcDate\">" + list[i].PDATE + "</td>";
			html +=		"<td id=\"purcPrice\">" + list[i].PPRI + "</td>";
			html +=		"</tr >";
		}
			
	}
	
	$("#mainBoard tbody").html(html);
}
//------------테이블 페이징
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
//------------------등록 ajax
function writeForm(){
	//alert("itemNoCheck:"+itemNoCheck)
	if(itemNoCheck == 1){

	var params = $("#writeDataForm").serialize();
	//console.log(params);

	$.ajax({
		type : "post",	
		url : "ASAsListWriteAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			makeAlert(2, "알림", "등록성공", null, null);
			itemNoCheck=0;
			reloadList();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
	}
	
}
//--------------제품코드 중복체크 ajax
function itemNoCheckForm(){
	
	var params = $("#writeDataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASAsListItemNoCheckAjax",	
		dataType : "json",	
		data : params,
		success : function (data) {
			if (data.result == 1) {
				makeAlert(2, "알림", "중복된 제품코드 입니다.", null, null);
				$("#textItemNo").val("");
				itemNoCheck=0;
			} else {
				itemNoCheck=1;
			}
//------등록폼 호출 위치를 잘 생각해보기
			writeForm();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}  
//-------사용자 & 부서검색 버튼 ajax 
function searchEmpForm(){
	
	var params = $("#searchEmpDataForm").serialize();

	$.ajax({
		type : "post",	
		url : "AsListSearchEmpAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList1(result.list2);
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------사용자 & 부서검색 리스트 그리기
function redrawList1(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].EMP_NO + "\">" + list[i].NAME + "</td>";
			html += "<td name=\"" + list[i].DEPT_NO + "\">" + list[i].DEPT_NAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board2 tbody").html(html);
}
//-------수정 ajax
function updateForm(){
	var params = $("#updateDataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "AsListUpdateAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			makeAlert(2, "알림", "수정성공", null, null);
			reloadList();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------상세보기 관련 ajax
function dtlForm(){
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "AsListDtlAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList2(result.data);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------상세보기 리스트 그리기 & 수정가능
function redrawList2(data){
	
   var html = "";
   	html +=	"<form action=\"#\" id=\"updateDataForm\" method=\"post\">";  
	html += "<div class=\"popup1\">";
	html +=	"<div><div id=\"div1\">제품 코드</div>"
							+"<div id=\"div2\"><input type=\"text\" id=\"textItemNo\" name=\"textItemNo\" maxlength=\"15\" readonly=\"readonly\"  value=\""+data.ASNO +"\"  >"
							+"</div></div><br>";
	html +=	"<div><div id=\"div1\">품 명</div>"
				+"<div id=\"div2\"><input type=\"text\" id=\"textItemNm\" name=\"textItemNm\" value=\""+data.ASNM +"\"  ></div></div><br>";
	html +=	"<div><div id=\"div1\">사 용 자</div>"
				+"<div id=\"div2\"><input type=\"text\" id=\"textEmpNm\" name=\"textEmpNm\" value=\""+data.ENAME +"\" readonly=\"readonly\"  >"
				+"<input type=\"hidden\" name=\"textEmpNo\" id=\"textEmpNo\" value=\""+data.EMP_NO +"\" >"
				+"<input type=\"button\" value=\"검색\" id=\"empCheck\" name=\"empCheck\"></div></div><br>";
	html +=	"<div><div id=\"div1\">담당 부서</div>"
 				+"<div id=\"div2\"><input type=\"text\" id=\"textDeptNm\" name=\"textDeptNm\" value=\""+data.DNAME +"\" readonly=\"readonly\"  >"
 				+"<input type=\"hidden\" name=\"textDeptNo\" id=\"textDeptNo\" value=\""+data.DEPT_NO +"\" ></div></div><br>";
	html +=	"<div><div id=\"div1\">구입 가격</div>"
				+"<div id=\"div2\"><input type=\"text\" id=\"textPurPri\" name=\"textPurPri\" maxlength=\"11\" value=\""+data.PPRI +"\"  ></div></div><br>";
	html +=	"<div><div id=\"div1\">구입 일자</div>"
				+"<div id=\"div2\"><input type=\"date\" id=\"textPurDate\" name=\"textPurDate\" value=\""+data.PDATE +"\" ></div></div><br>";
	html +=	"<div><div id=\"div1\">CS. Num</div>"
				+"<div id=\"div2\"><input type=\"text\" id=\"textCsNum\" name=\"textCsNum\" maxlength=\"12\" value=\""+data.CSPN +"\" ></div></div>";
	html += "</div>"
	html +=	"</form>"; 
	
	makeTwoBtnPopup(1, "상세보기", html, true, 440, 450,
			function() {
		
//-------숫자만 입력하세요 
		$("#textPurPri").bind("keyup", function(event) {
		    var regNumber = /^[0-9]*$/;
		    var temp = $("#textPurPri").val();
		    if(!regNumber.test(temp))
		    {
		        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
		        $("#textPurPri").val(temp.replace(/[^0-9]/g,""));
		        $("#textPurPri").focus();
		    }
		});
		
		$("#textCsNum").bind("keyup", function(event) {
		    var regNumber = /^[0-9]*$/;
		    var temp = $("#textCsNum").val();
		    if(!regNumber.test(temp))
		    {
		        makeAlert(2, "알림", "숫자만 입력하세요", null, null);
		        $("#textCsNum").val(temp.replace(/[^0-9]/g,""));
		        $("#textCsNum").focus();
		    }
		});
		
				// 컨텐츠 이벤트
//-------사용자 & 부서 검색 버튼
				$("#empCheck").on("click", function () {
					
					var html="";
					
					html +=	"<form action=\"#\" id=\"searchEmpDataForm\" method=\"post\">";
					html += "<div class=\"checkPop\">";
					html += "<div class=\"checkPop_1\">";
					html += "<select name=\"searchGbn1\" id=\"searchGbn1\">";
					html += "<option value=\"0\">성명</option>";
					html += "<option value=\"1\">부서</option>";
					html += "</select>";
					html += "<input type=\"text\" id=\"searchEmpTxt\" name=\"searchEmpTxt\">";
					html += "<input type=\"button\" id=\"searchEmpBtn\" name=\"searchEmpBtn\" value=\"검색\">";
					html += "</div><br>";
					html += "<div class=\"checkPop_2\">";
					html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
					html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
					html += "<input type=\"hidden\" name=\"deptno\" id=\"deptno\">";
					html += "<input type=\"hidden\" name=\"deptnm\" id=\"deptnm\">";
					html += "<table>";
					html +=	"<colgroup>";	
					html +=	"<col width=\"140\">";
					html +=	"<col width=\"140\">";
					html += "</colgroup>";
					html += "<thead>";
					html += "<tr>";
					html += "<th>성명</th>";
					html += "<th>부서</th>";
					html += "</tr>";
					html += "</thead>";
					html += "</table>";
					html += "<div id=\"listdiv\">";
					html += "<table id=\"board2\">";
					html +=	"<colgroup>";	
					html +=	"<col width=\"140\">";
					html +=	"<col width=\"140\">";
					html += "</colgroup>";
					html += "<tbody>";
					html += "</tbody>";
					html += "</table>";
					html += "</div>";
					html += "</div>";
					html += "</form>";
					
					makePopup(2, "사용자 & 부서 검색", html, true, 400, 400,
						function() {
						// 컨텐츠 이벤트
						$("#listdiv").slimScroll({
							height: "170px",
							axis: "both"
						});
						
						
						$(".checkPop").on("keypress", "input", function(event) {
							if(event.keyCode == 13) {
								$("#searchEmpBtn").click();
								return false;
							}
						});
						
						
						$("#searchEmpBtn").on("click", function () {
							searchEmpForm();
						});
					
						$("#searchEmpDataForm").attr("action","ASAsList")
						searchEmpForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().eq(0).attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().eq(0).html());// html에 자식값을 nm에 전달
							$(".checkPop_2 #deptno").val($(this).children().eq(1).attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #deptnm").val($(this).children().eq(1).html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
					
				}, "확인", function(){
					$("#updateDataForm #textEmpNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
					$("#updateDataForm #textEmpNm").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
					$("#updateDataForm #textDeptNo").val($(".checkPop_2 #deptno").val());// no값을 textempno에 담기
					$("#updateDataForm #textDeptNm").val($(".checkPop_2 #deptnm").val());// nm값을 textempnm에 담기
					closePopup(2);
				});
			});

				
	}, "수정", function(){

//-------공백 체크		
		if($.trim($("#textItemNo").val()) == ""){
			 makeAlert(2, "알림", "제품코드를 입력하세요", null, null);
			$("#textItemNo").focus();
		}else if($.trim($("#textItemNm").val())==""){
			makeAlert(2, "알림", "품명을 입력하세요", null, null);
			$("#textItemNm").focus();
		}else if($.trim($("#textPurPri").val())==""){
			makeAlert(2, "알림", "구입가격을 입력하세요", null, null);
			$("#textPurPri").focus();
		}else if($.trim($("#textPurDate").val())==""){
			makeAlert(2, "알림", "구입날짜를 선택하세요", null, null);
			$("#textPurDate").focus();
		}else if($.trim($("#textEmpNm").val())==""){
			makeAlert(2, "알림", "사용자를 선택하세요", null, null);
			$("#textEmpNm").focus();
		}else if($.trim($("#textCsNum").val())==""){
			makeAlert(2, "알림", "고객센터번호를 입력하세요", null, null);
			$("#textCsNum").focus();
		}else{	
			if("${sAuthNo}" == 7){
				updateForm();
				closePopup(1);
			}else{
				makeAlert(2, "알림", "권한이 없습니다.", null, null);
			}
		}
	}, "폐기", function(){
		if("${sAuthNo}" == 7){
			updateDeleteForm();
			closePopup(1);	
		}else{
			makeAlert(2, "알림", "권한이 없습니다.", null, null);
		}
	}); 
}
// 삭제 파기목록으로 폐기 ajax
function updateDeleteForm(){
	var params = $("#dataForm").serialize();
	

	$.ajax({
		type : "post",	
		url : "AsListUpdateDelAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			makeAlert(2, "알림", "폐기성공", null, null);
			reloadList();
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
	<c:param name="leftMenuNo" value="40"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param> 
		<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
	--%>
</c:import>
<div class="content_area">
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 자산 &gt; 자산 목록</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">목록</div>
	<!-- 내용 영역 -->
						<!--메인리스트 데이터폼  -->	
	<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}">
		<input type="hidden" name="textItemNo" id="textItemNo" >
		<div class="midB">
			<select id="searchGbn" name="searchGbn">
				<option value="0">제품코드</option>
				<option value="1">품명</option>
				<option value="2">담당부서</option>
			</select>
			<input type="text" id="txt" name="txt" >
			<input type="button" value="검색" id="searchBtn">		
		</div>
	</form>	
		<div class="secB">
			<div class="secB1">
				<table id="mainBoard">
					<colgroup>
						<col width="169"> 
						<col width="169"> 
						<col width="169">
						<col width="169">
						<col width="169">
						<col width="169">
					</colgroup>
					<thead>
						<tr>
							<th>제품코드</th>
							<th>품명</th>
							<th>사용자</th>
							<th>담당부서</th>
							<th>구입일자</th>
							<th>구입가격</th>			
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div id="pagingArea">
				</div>
			</div>
			<div class="secB2">
				<input type="button" value="신규등록" class="bottomBtn" id="newRegi" >
			</div>	
			<div class="secB3">
			</div>						
		</div>
</div>
</body>
</html>