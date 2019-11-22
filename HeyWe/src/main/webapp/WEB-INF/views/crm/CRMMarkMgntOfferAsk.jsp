<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업제안 상세</title>
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/sa_chance_r.css" />
<link rel="stylesheet" type="text/css" href="resources/css/calendar/fullcalendar/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="resources/css/calendar/fullcalendar/fullcalendar.min.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/calendar/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="resources/script/calendar/fullcalendar/lang-all.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	reloadAtt();
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();
	$(".tdleftOffer").css("background-color", "#76bbd9");
	$(".content_area input[type='checkbox']").checkboxradio();
	$(".content_area input[type='button']").button();
	if (dd < 10) {
		dd = '0' + dd
	}
	if (mm < 10) {
		mm = '0' + mm
	}
	today = yyyy + '-' + mm + '-' + dd;
	if($("#page").val()==""){
		$("#page").val("1");
	}
	$(".mokT2_2").text(today);
	$("#selectDate").val(today);
	calAjax();
	reloadCalList();
	reloadOpinion();
	$(".chanceDiv").css("display", "none")
	$("#backImg").on("click", function(){
			$("#dataForm").attr("action", "CRMMarkMgntOfferList");
			$("#dataForm").submit();
	});
	$("#oppage").on("click", "input", function(){
		$("#page").val($(this).attr("name"));
		reloadOpinion();
	});
	$("#writeBtn").on("click", function(){
			$("#dataForm").attr("action", "CRMMarkMgntOfferUpdate");
			$("#dataForm").submit();
	});
	$("#opwriteBtn").on("click", function(){
		if($.trim($("#txtWrite").val()) == ""){
			makeAlert(1, "", "내용을 입력하세요.", true, null);
		}
		else{
			makeConfirm(1, "의견 작성", "작성하시겠습니까?", true, function(){
				insertOpinion();
				$("#txtWrite").val("");
			});
		}
	});
	$("#drawop").on("click", "#trashBtn" , function(){
		$("#delOp").val($(this).attr("name"));
		makeConfirm(1, "의견 삭제", "삭제하시겠습니까?", true, function(){
			deleteOpinion();
		});
	});
	
	$("#checkChance").on("change", function(){
		if ($("input:checkbox[id='checkChance']").is(":checked") == true){
			$(".chanceDiv").css("display", "");
			$(".tdleftChance").css("background-color", "#c2e4f3");
			}
		else{
			$(".chanceDiv").css("display", "none");
			}
		});
	
	$("#checkOffer").on("change", function(){
		if ($("input:checkbox[id='checkOffer']").is(":checked") == true){
			$(".offerDiv").css("display", "");
			}
		else{
			$(".offerDiv").css("display", "none");
			}
		});
	
	$("#nextBtn").on("click", function(){
		$("#dataForm").attr("action", "CRMMarkMgntNegoWrite");
		$("#dataForm").submit();
	});
	$("#nextBtn2").on("click", function(){
		makePopup(1, "진행상태 변경", psePopup() , true, 250, 180, function() {
			$("#pseSel").val("${dtl.PROGRESS_STATE_NO}");
			$("#pseNo").val("${dtl.PROGRESS_STATE_NO}");
			$("#pseSel").on("change", function(){
				$("#pseNo").val($(this).val());
			});
			}, "확인", function(){ 
			closePopup(1);
			updatePse();
		});
	});
	$("#histBtn").on("click", function(){
		makeNoBtnPopup(1, "영업히스토리" , Histpopup() , true, 650, 300, function(){
			$("#HlistDiv").slimScroll({
				height: "150",
				axis: "both"
			});
			reloadHist();
		} , null);
	});
});

//아작스
function reloadOpinion(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "MCCOpinionAjax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawOpinion(result.opinion);
			redrawOpinionpb(result.pb);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function insertOpinion(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "MCCinsertOpinionAjax",
		dataType : "json",
		data : params,
		success : function(result){	
			reloadOpinion();
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function deleteOpinion(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "MCCdeleteOpinionAjax",
		dataType : "json",
		data : params,
		success : function(result){
			reloadOpinion();
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}
function calAjax() {
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "calAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			calendarEvent(result.cal);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadCalList() {
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "reloadCalListAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			CalList(result.callist);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function updatePse(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "CRMupdatePseAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			$("#dataForm").attr("action", "CRMMarkMgntOfferAsk");
			$("#dataForm").submit();
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadHist(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "CRMreloadHistAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			redrawHist(result.histList);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

//함수
function redrawOpinion(opinion){
	var html="";
	if(opinion.length!=0){
	for(var i = 0 ; i<opinion.length; i++){
		html += "<div class=\"contentList\"><div id=\"contentTop\"><div id=\"contentname\">"+ opinion[i].EMP_NAME +"</div>";
		html += "<div id=\"contentday\">"+ opinion[i].REG_DATE;
		if('${sEmpNo}' == opinion[i].EMP_NO){
			html += "<img src=\"resources/images/erp/crm/trash.png\" width=\"15px\" height=\"15px\" style=\"cursor:pointer\" id=\"trashBtn\" name ="+ opinion[i].MARK_OPINION_NO +" />";
		}
		
		html += "</div></div><div id=\"contentBottom\">"+ opinion[i].CON +"</div></div><hr />";
	}
	}
	else{
		html += "<div id=\"div1\">의견이 없습니다.</div>"
	}
	$("#drawop").html(html);
} 

function redrawOpinionpb(pb){
	 var html = "";
		
		if($("#page").val() == "1"){
			html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"1\"/>";		
		}
		else{
			html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"" + ($("#page").val()*1-1)+"\" />";
		}	
		
		
		for(var i = pb.startPcount ; i<= pb.endPcount ; i++){
			if(i == $("#page").val()){
				html += "<input type=\"button\" class =\"numberBtn\" value=\""+ i + "\" disabled=\"disabled\" />";
			}
			else{
				html += "<input type=\"button\" class =\"numberBtn\" value=\"" + i + "\"name=\"" + i + "\" />";
			}
		}
		
		
		if($("#page").val() == pb.maxPcount){
			html += "<input type=\"button\" class =\"nextBtn\"value=\"▶\" name=\"" + pb.maxPcount + "\" />";
		}
		else{
			html += "<input type=\"button\" class =\"nextBtn\" value=\"▶\"name=\"" + ($("#page").val()*1+1)+"\" />";
		}
		
		$("#oppage").html(html);
		$(".oppage input[type='button']").button();

}
function calendarEvent(cal) {
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	var i = 0;
	if (m < 10) {
		m = "0" + m;
	}
	if (d < 10) {
		d = "0" + d;
	}
	$("#calender").fullCalendar(
			{
				lang : "ko",
				height : 460,
				events : cal,
				eventClick : function(event, element) {
					makeNoBtnPopup(1, "일정보기", event.title + "-"
							+ event.ename + "<br/>" + event.activity_con,
							true, 500, 500, null, null);
				},
				dayClick : function(date) {
					$(".mokT2_2").text(date.format());
					$("#selectDate").val(date.format());
					reloadCalList();
				}
			});
}

function CalList(callist) {
	var html = ""
	for (var i = 0; i < callist.length; i++) {
		html += "<tr> <td class=\"mokT_1\">"
		if (callist[i].COLOR == '#4499bd') {
			html += "<img alt=\"red2\" src=\"resources/images/erp/crm/red2.png\" id=\"red2\"></td>"
		}
		else if(callist[i].COLOR=='skyblue') {
			html += "<img alt=\"blue2\" src=\"resources/images/erp/crm/blue2.png\" id=\"blue2\">"
		}
		else if(callist[i].COLOR=='green') {
			html += "<img alt=\"green2\" src=\"resources/images/erp/crm/green2.png\" id=\"green2\">"
		}
		else if(callist[i].COLOR=='yellow') {
			html += "<img alt=\"yellow2\" src=\"resources/images/erp/crm/yellow2.png\" id=\"yellow2\">"
		}
		html += "<td class=\"mokT_2\">" + callist[i].START + " ~ "
				+ callist[i].END + " </td>"
		html += "<td class=\"mokT_3\">" + callist[i].TITLE + "</br>"
				+ callist[i].ENAME + "</td></tr>"
	} 
	$(".mokT").html(html);
}

function psePopup(){
var html="";
	html += "<div class=\"psepopup\">";
	html +=	"<select id=\"pseSel\">";
	html +=	"<option value=\"0\">진행중</option>";
	html +=	"<option value=\"1\">종료(성공)</option>";
	html += "<option value=\"2\">종료(실패)</option>";
	html +=	"<option value=\"3\">보류(연기)</option></select>";
	html += "</div>";
	return html;
}

function Histpopup(){
	var html="";
		html+="<div class=\"histListdiv\">";
		html+="<table class=\"histListTop\">";
		html+="<colgroup>";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="</colgroup>";
		html+="<tr>";
		html+="<th>날짜</th>";
		html+="<th>이력</th>";
		html+="<th>진행단계</th>";
		html+="<th>진행상태</th>";
		html+="<th>작성자</th>";
		html+="</tr>";
		html+="</table>";
		html+="<div id=\"HlistDiv\">"
		html+="<table id=\"drawList\">";
		html+="<colgroup>";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="</colgroup>";
		html+="<tbody>";
		html+="</tbody>";
		html+="</table>";
		html+="</div>";
		html+="</div>";
		return html;
}
function redrawHist(histList){
	var html = "";
	for(var i=0; i<histList.length; i++){
		html+="<tr>";
		html+="<th>"+ histList[i].UPDATE_DATE +"</th>";
		html+="<th>"+ histList[i].CON +"</th>";
		html+="<th>"+ histList[i].PSP_NAME +"</th>";
		html+="<th>"+ histList[i].PSE_NAME +"</th>";
		html+="<th>"+ histList[i].EMP_NAME +"</th>";
		html+="</tr>";
		}
	$("#drawList tbody").html(html);
}
function reloadAtt() {
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "MarkAttAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			
			redrawAtt(result.markAtt);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function redrawAtt(markAtt) {
	var html = "";
	html += "<colgroup><col width=\"870px\"></colgroup><tr id=\"tbtop\"><td id=\"tdfile\">파일명</td></tr>";
	if (markAtt.length != 0) {
		for (var i = 0; i < markAtt.length; i++) {
			html += "<tr><td id =\"tbMiddle\" name=\""+markAtt[i].MARK_ATT_FILE_NO+"\">";
			html += "<a href=\"resources/upload/" +markAtt[i].FILE_NAME + "\" download>"
					+ markAtt[i].FILE_NAME.substring(20) + "</a>";
			html += "&nbsp&nbsp<input type=\"button\" id=\"attdelete\" value=\"삭제\"/>";
			html += "</td></tr>";
		}
	} else {
		html += "<tr><td id =\"tbMiddle\">첨부자료가 없습니다.</td></tr>";
	}
	$("#att").html(html);
	$("#attdelete").on("click", function() {
		$("#attdeleteNo").val($(this).parent().attr("name"));	
	
		makeConfirm(1, "첨부파일 삭제", "해당 첨부파일을 삭제하시겠습니까?", true, function() {
			deleteAttFile();
		});
	});
}
function deleteAttFile() {
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "deleteaMarkAttFileAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			reloadAtt();
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}


</script>
</head>
<body>
<c:import url="/topLeft"> 
	<c:param name="topMenuNo" value="17"></c:param>
	<c:param name="leftMenuNo" value="22"></c:param>
</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업현황 &gt; 제안</div>
		<!-- 내용 영역 -->
		<div class="content_title">제안 상세</div> 
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeBtn" style="cursor:pointer"/>
			<img src="resources/images/erp/crm/back.png" id="backImg" style="cursor:pointer"/>
		</div>
		<div class="checkbox">
			<input type="checkbox" value="기회" id="checkChance"/><label for="checkChance">기회</label>
			<input type="checkbox" value="제안" id="checkOffer" checked="checked"/><label for="checkOffer">제안</label>
		</div>
		<div class="crmInfo">
			<div class="commonDiv">
			<table border="1" cellspacing="0">
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
				<tbody>
					<tr>
						<td id="tdleft">영업명</td>
						<td id="tdright">${dtl.MARK_NAME}
						<input type="button" value="영업히스토리" id="histBtn"/>
						</td>
					</tr>
					<tr>
						<td id="tdleft">고객사</td>
						<td id="tdright">${dtl.CSTM_NAME}</td>
					</tr>
					<tr>
						<td id="tdleft">고객</td>
						<td id="tdright">${dtl.MNGR_NAME}</td>
					</tr>
					<tr>
						<td id="tdleft">진행단계</td>
						<td id="tdright">${dtl.PROGRESS_STEP_NAME}
						<input type="button" value="다음 단계로" id="nextBtn"/>
						</td>
					</tr>
					<tr>
						<td id="tdleft">진행상태</td>
						<td id="tdright">${dtl.PROGRESS_STATE_NAME}
						<input type="button" value="변경" id="nextBtn2"/>						
						</td>
					</tr>
					<tr>
						<td id="tdleft">사업유형</td>
						<td id="tdright">${dtl.BSNS_NAME}</td>
					</tr>
					<tr>
						<td id="tdleft">매출구분</td>
						<td id="tdright">${dtl.SALES_DIV_NAME}</td>
					</tr>
					<tr>
						<td id="tdleft">매출구분상세</td>
						<td id="tdright">${dtl.SALES_DIV_DTL}</td>
					</tr>
					<tr>
						<td id="tdleft">담당자(자사)</td>
						<td id="tdright">${dtl.EMP_NAME}</td>
					</tr>
					<tr>
						<td id="tdleft">비고</td>
						<td id="tdright">${dtl.NOTE}</td>
					</tr>
				</tbody>
			</table>
			</div>
			<div class="chanceDiv">
				<table border="1" cellspacing="0"> 
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
					<tbody>
						<tr>
							<td id="tdleft" class="tdleftChance">영업시작일</td>
							<td id="tdright">${dtl.START_DATE}</td>
						</tr>
						<tr>
							<td id="tdleft" class="tdleftChance">인지경로</td>
							<td id="tdright">${dtl.RECOG_NAME}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="offerDiv">
				<table border="1" cellspacing="0"> 
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
					<tbody>
						<tr>
						<td id="tdleft" class="tdleftOffer">제안내용</td>
						<td id="tdright">${dtl.OFFER_CON}</td>
					</tr>
					<tr>
						<td id="tdleft" class="tdleftOffer">제안날짜</td>
						<td id="tdright">${dtl.OFF_OFFER_DATE}</td>
					</tr>
					<tr>
						<td id="tdleft" class="tdleftOffer">제안마감날짜</td>
						<td id="tdright">${dtl.OFF_FINISH_DATE}</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div id="hr_2">
				<hr />
			</div>
			<div class="calmok2">
					<div class="cal">
						<div class="rcal" id="calender"></div>
						<div class="bumju">
							<div class="bumju1">
								<div class="bumju1_1">
									<img alt="red" id="redBtn"
										src="resources/images/erp/crm/red.png">
								</div>
								<div class="bumju1_2">기회</div>
							</div>
							<div class="bumju2">
								<div class="bumju2_1">
									<img alt="blue" id="blueBtn"
										src="resources/images/erp/crm/blue.png">
								</div>
								<div class="bumju2_2">제안</div>
							</div>
							<div class="bumju3">
								<div class="bumju3_1">
									<img alt="green" id="greenBtn"
										src="resources/images/erp/crm/green.png">
								</div>
								<div class="bumju3_2">협상</div>
							</div>
							<div class="bumju4">
								<div class="bumju4_1">
									<img alt="yellow" id="yellowBtn"
										src="resources/images/erp/crm/yellow.png">
								</div>
								<div class="bumju4_2">계약</div>
							</div>
						</div>
					</div>
					<div class="mok">
						<div class="mok2">
							<div class="mok2_1">
								<table class="mokT2">
									<tr>
										<td class="mokT2_1"><img alt="cal"
											src="resources/images/erp/crm/cal.png" width="35px"
											height="35px" id="cal"></td>
										<td class="mokT2_2"></td>
										<td class="mokT2_3"><div class="wripopup">
											</div></td>
									</tr>
								</table>
							</div>
							<div class="mok2_2">
								<table class="mokT">
								</table>
							</div>
						</div>
					</div>
				</div>
			<div id="hr_2">
				<hr />
			</div>
			<div id="hr_2"></div>
				<div id="upName">첨부자료</div>
				<div id="uploadFile">
					<table border=1 cellspacing="0" width="870px">
						<tbody id="att" >
						
						</tbody>
					</table>
				</div>
			<div id="upName">의견</div>
			<form action="#" id="dataForm" method="post">
			<input type="hidden" id="attdeleteNo" name="attdeleteNo" />
			<input type="hidden" name="markNo" id="markNo" value="${param.markNo}"/>
			<input type="hidden" name="sEmpNo" id="sEmpNo" value="${sEmpNo}"/>
			<input type="hidden" name="page" id="page" value="${page}">
			<input type="hidden" id="selectDate" name="selectDate" />		
			<input type="hidden" name="delOp" id="delOp">
			<input type="hidden" name="pseNo" id="pseNo"/>
			<input type="hidden" id="pspCheck" name="pspCheck" value="1">
			<input type="hidden" name="flag" id="flag" value="1"/>
			<div id="content">
				<div id="contentInput">
					<input type="text" id="txtWrite" name="txtWrite">
				</div>
				<div id="contentBtn">
					<input type="button" value="입력" id="opwriteBtn">
				</div>
			</div>
			<div id="drawop" class="drawop"></div>
			<div class ="oppage" id="oppage"></div>
			</form>
		</div>
	</div>
</body>
</html>