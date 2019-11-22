<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 종료 강의 목록</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/as/lecturelist.css" />
<style type="text/css">

/*----------------- 검색창-------------------------------- */

.modi_btnzone{
	text-align: right;
}
.modi_btnzone > button{
	padding : 10px;
}

#regicareer_btn{
	border-radius: 3px;
    width: 70px;
    height: 32px;
	font-size : 5px;
    background-color: #134074;
    color: #FFF;
    font-weight: bold;
    outline: none;

}

.s_btn {
    border-radius: 3px;
    width: 75px;
    height: 35px;
    
   /*  padding: 5px; */
    background-color: #134074;
    color: #FFF;
    font-weight: bold;
    outline: none;
} 

#makePopup1btn{
margin-left:0px;
}

.data_search_area{
	
	width: 880px;
	height: 50px;
	background-color:#8da9c4;
	border-top-left-radius:3px;
	border-top-right-radius:3px;
	border-bottom-right-radius:3px;
	border-bottom-left-radius:3px;
	margin:20px 40px;
	border: 1px solid #ccc;
	text-indent: 0px;
}

.search_line{
	width :850px;
	margin: 0 auto;
}

.search_l{
	float: left;
	margin-top:5px;
}

.searchGbn{
	margin-top: 5px;
	height : 30px;
}

.date_ser{
	display:inline-block;
	margin-top:10px;
	margin-left:100px;
	font-size:15px;
	
}
#searchBtn{
	color: #fff;
    background-color: #134074;
    border-radius: 5px;
    width: 100px;
    height: 30px;
    font-size: 11pt;
    font-weight: bolder;
    border: 0px;
    cursor: pointer;
   
}

.button_h{
	width:100px;
	height:50px;
	margin-left:10px;
	margin-top:9px;
	float:right;
}

#endday{
	height : 26px;
}

#startday{
	height : 26px;
}

#searchTxt{
	margin-top:10px;
	height : 24px;
	
}

/*----------------- 검색창끝-------------------------------- */
/* #listDiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: calc(100% - 15px);
	margin: 0px !important;
	height: 170px !important;
} */
.slimScrollDiv{

}

.checkPop{
	text-align: center;
}

div.checkPop_2{
	text-align: center;

}

#emphead{
margin-left:0px;
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
var careercheckv = 0;
	$(document).ready(function() {
	
		$("#searchBtn").on("click", function(){ 
	
			var startDate = $("#startday").val();
		    var endDate = $("#endday").val();
		
		    var startArray = startDate.split('-');
		    var endArray = endDate.split('-');
		    
		    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
		    var end_date = new Date(endArray[0], endArray[1], endArray[2]);
		       

		    
		    if(start_date.getTime() > end_date.getTime()) {
	        	makeAlert(2, "알림", "종료일자가 시작일보다 빠릅니다.", null, null);
	        }else{
	        	$("#page").val("1");
				reloadList();
	        }
			
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
		
		
		$("body").on("click","#regibtn",function() {
			
			$("#actionForm").attr("action","ASLecList")
			regiLect();
			$(".popup").remove();
			$(".bg").remove();
		}); 
		

		if($("#page").val() == ""){
			$("#page").val("1");
		}
		
		reloadList();
		
		$("#pagingArea").on("click","input", function(){
			$("#page").val($(this).attr("name"));
			reloadList();
		});	
		
		$("body").on("click",".close",function() {
			//alert("팝업닫힘");
			$(".popup").remove();
			$(".bg").remove();
		});
			
		$("body").on("click",".bg",function() {
			//alert("팝업닫힘");
			$(".popup").remove();
			$(".bg").remove();
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
	

	/* 제이쿼리 존 */
	function reloadList() {
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",
		url : "lectendListAjax", 
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

	html += "<tr name=\"Nseltr\"><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
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
			html += "<tr name=\"Nseltr\><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
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
		$.ajax({
			type : "post",
			url : "lectDtlAjax",
			dataType : "json",
			data : params,
			success : function(result) {

				redrawList2(result.data2,result.list2);
		

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
		//비동기(ajax로 데이터를 받았을 때 )
		if (data == null) { // 받은 데이터가 null 일 때
			location.href = "ASLectList"; // 리스트로 이동
		} else {// null 이 아닐 떄(정상 값이 들어온 경우) 정상적으로 작업을 수행
			var html = "";

			
					
			html += "<div class=\"input_area\" style=\"height:410px\">";
			html += html += "<div class=\"input_inform_area\">";
			html += "<div class=\"login_input_area\">";
			html += "<div class=\"login_input_q\">강의명:</div>";
			html += "<div class=\"login_input_a\">" + data.LECT_NAME + "</div>";
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
			html += "<div class=\"login_input_a\">" + data.PLACE_NAME
					+ "</div>";
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
			html += "<div class=\"\">※수료인원 :"+ list.length +" </div>";
			html += "</div>";
			html += "<div class=\"table_area_inpopup\">";
			html += "<form action=\"#\" id=\"dataForm\" method=\"post\">";
			html += "</form>";
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
			
			html += "<div id=\"listDiv\">";
		
			html += "<table id=\"afcboard\">";
			html += "<colgroup>";
			html += "<col width=\"120\" />";
			html += "<col width=\"120\" />";
			html += "<col width=\"120\" />";
			html += "</colgroup>";
			html += "<tbody>";
			html += "</tbody>";
			
			if (list.length == 0) {
				html += "<tr><td colspan=\"4\">조회결과가 없습니다.</td></tr>";
			} else {
				for (var i = 0; i < list.length; i++) {
					html += "<tr name=\"" + list[i].AFC_NO + "\" class=\"sec_tr\" >";
					html += "<td>" + list[i].NAME + "</td>";
					html += "<td>" + list[i].EMP_NO + "</td>";
					html += "<td>" + list[i].POSI_NAME + "</td>";
					html += "</tr>";
				}
			}
			html += "</table>";
			html += "</div>";
			html += "</div>";
			html += "</div>";
			html += "<div class=\"input_inform_area_2\">";
			html += "<div class=\"info_img\">";
			
			if(data.LECT_PIC == null || data.LECT_PIC == "") {
			      html += "<img alt=\"사진없음\" src=\"resources/upload/nopic.jpg\"/>";
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
			
			if("${sAuthNo}"==7 && data.TCHR_NAME != null){
				html += "<div class=\"modi_btnzone\">";
				html += "<input type=\"button\" value=\"경력 등록\" id=\"regicareer_btn\" style=\"margin-right:10px\" />";
			//	html += "<input type=\"button\" value=\"수  정\" id=\"modify_btn\" />";
				html += "</div>";
			}
			
			makeNoBtnPopup(1,"종료 강의 상세정보", html, true , 750, 580, function(){
				
				$("#listDiv").slimScroll({
					height: "80px",
					axis: "both"
					});
				
				
				//경력 등록 부분
					$("#regicareer_btn").on("click", function(){
						
						

						var html="";
						
						html +=	"<form action=\"#\" id=\"careerDataForm\" method=\"post\">";
						html += "<div class=\"checkPop\">";
						
						html += "강사명:" +data.TCHR_NAME+"";
						html += "<input type=\"hidden\" name=\"c_tchr_no\" id=\"c_tchr_no\" value=\"" +data.TCHR_NO+"\">";
						html += "<br/>";
						
						html += "강의명:" +data.LECT_NAME+"";
						html += "<input type=\"hidden\" name=\"c_lect_name\" id=\"c_lect_name\" value=\"" +data.LECT_NAME+"\">";
						html += "<br/>";
						html += "기간:" +data.LECT_DAY+"";
						html += "<input type=\"hidden\" name=\"c_lectsday\" id=\"c_lectsday\" value=\"" +data.LECT_START_DAY+"\">";
						html += "<input type=\"hidden\" name=\"c_lecteday\" id=\"c_lecteday\" value=\"" +data.LECT_FNSH_DAY+"\">";
						html += "<br/>";
					
						html += "<br/>";
						html += "경력에 등록하시겠습니까?";
						html += "</div>";
						html += "</form>";
						
					
						makePopup(2, "경력 등록", html, true, 300, 200, null, "등록", function(){
							regicareer();	
					
											
						});					
			
					});
				
			},null,null);

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

	function regiLect() {
		
		
		var params = $("#actionForm").serialize();

		console.log(params);

		$.ajax({
			type : "post",
			url : "regiLectlAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				alert("등록에 성공했습니다.");
				reloadList();
				
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	//강사경력 중복여부 체크
	function careerCheck(){
			
			var params = $("#careerDataForm").serialize();
			
			$.ajax({
				type : "post",
				url : "careerCheckAjax",
				dataType : "json",
				data : params,
				success : function(data) {
				
	
					if (data.result == 1) {
						makeAlert(3, "알림", "이미 등록된 경력입니다.", true, function(){
							
							closePopup(3);
							closePopup(2);
							careercheckv=0;
						});
					
						
					} else {
						careercheckv=1;
					}
				}
	
			});
	
			
		}
	

	//강사경력등록
	function regicareer() {
		
		careerCheck();
		
		if(careercheckv == 1){

		
		var params = $("#careerDataForm").serialize();

		console.log(params);
		
			$.ajax({
				type : "post",
				url : "regiCareerAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					makeAlert(3, "알림", result.msg , null, function(){
						closePopup(1);	
						closePopup(2);
						careercheckv=0;
					});
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
	}
	
	
	
	

</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="39"></c:param>
		<c:param name="leftMenuNo" value="47"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			 <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<!-- 메뉴 네비게이션 -->
		<div class="content_nav">HeyWe &gt; 자산 &gt; 교육관리 &gt; 종료 교육 현황</div>
		<!-- 현재 메뉴 제목 -->
		<div class="content_title">종료 교육 현황</div>
		<!-- 내용 영역 -->
		<form action="#" id="dataForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}" /> <input
				type="hidden" name="no" id="no" />
			<div class="data_search_area">
				<div class="search_line">

					<div class="search_l">
						<select class="searchGbn"  name="searchGbn">
							<option value="0" selected="selected">프로그램명</option>
							<option value="1">교육담당</option>
							<option value="2">형식</option>
						</select>
					</div>
					<input id="searchTxt" type="text" name="searchTxt" width="10px">
					<div class="date_ser">
						기간검색 <input type="date" id="startday" name="startday"> - <input type="date" id="endday" name="endday">
					</div>
					<div class="button_h">
						<input id="searchBtn" type="button" value="조   회">
					</div>
				</div>
			</div>
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
		</div>

	<!-- ============================= -->

</body>
</html>