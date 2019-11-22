<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재진행문서함 - 수정</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvDocCommon.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvLineSelectPopup.css" />

<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<!-- calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />

<style type="text/css">
.ui-datepicker select.ui-datepicker-year, .ui-datepicker select.ui-datepicker-month {
	width: 50%;
}
</style>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<!-- 팝업js -->
<script src="resources/script/common/popup.js"></script>

<script type="text/javascript" src="resources/script/erp/gw/ea/selectApvLinePopup.js"></script> <!-- 결재라인 지정 팝업 -->
<!-- ckeditor -->
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script><!-- 파일업로드 -->
<script type="text/javascript">
$(document).ready(function(){
	$(".exit_btn").on("click", function() {
		if(!checkEmpty("#titleTxt") || !checkEmpty("#conTxt")){
			makeConfirm(1, "확인", "수정 중인 내용은 저장되지 않습니다.<br/>정말 나가시겠습니까?", true, 
					function() {
						history.back();
					}
				);
		} else {
			history.back();
		}
	});
	
	CKEDITOR.replace("contents", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2",
		height : 500
	});
	
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'both',
		closeText: '닫기',
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd'
	}); 
	
    $("#imp_date").datepicker({
    	dateFormat : 'yy/mm/dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var date = "${data.DRAFT_DATE}";
			var draftDate = parseInt(date.replace("/", '').replace("/", ''));
			var impDate = parseInt(dateText.replace("/", '').replace("/", ''));
			
            if (draftDate > impDate) {
            	alert("날짜를 다시 확인해주세요.");
            	$("#imp_date").val("");
			} 
		}
    });
    
  	//시행일초기화
	$("[alt='reset']").on("click", function() {
		$("#imp_date").val("");
	});

	//첨부파일 업로드
	var arrFile = [0, 0, 0];	//첨부파일 3개의 첨부여부
	if("${fn:length(attFileList)}" != 0){	//기존 첨부파일의 수가 있다면 
		for(var i = 0; i<"${fn:length(attFileList)}"; i++){	//존재한 첨부파일 수만큼 첨부여부 1(있음)로 설정
			arrFile[i] = 1;
		}
	}
	// 파일첨부 버튼
	$("#fileBtn").on("click", function() {	
		if($.inArray(0, arrFile) != -1){						// 첨부여부에 공간이 있다면
			$("#attFile" + ($.inArray(0, arrFile)+1)).click();	// 여유있는 공간을 클릭하는 기능
		} else {
			makeAlert(1, "확인", "첨부파일은 3개까지 가능합니다.", false, null);
		}
	});
	$(".realArea").on("change", "input", function() {
		var num = ($(this).attr("id").substring($(this).attr("id").length - 1, $(this).attr("id").length)) * 1 - 1;
		arrFile[num] = 1;	//실제 선택한 파일의 첨부여부 1(있음)로 설정
		
		var html="";
		for(var i=0; i<$("input[name='existAttFile']").length; i++){
			var exist = $("input[name='existAttFile']").eq(i);
			html += "<div name=\"" + exist.val() + "\">";
			html += 	"<div class=\"fLeft\"><span>" + exist.attr("fileName") + "</span></div>" 
			html += 	"<div class=\"fRight\"><input type=\"button\" value=\"삭제\" /></div>";
			html += "</div>";
		}
		for(var i=$("input[name='existAttFile']").length; i<3; i++){
			if(arrFile[i] == 1){
				html += "<div name=\"attFile" + (i+1) + "\">";
				html += 	"<div class=\"fLeft\"><span>" + $("#attFile" + (i+1)).val().substring($("#attFile" + (i+1)).val().lastIndexOf("\\") + 1) + "</span></div>" 
				html += 	"<div class=\"fRight\"><input type=\"button\" value=\"삭제\" /></div>";
				html += "</div>";
			}
		}
		
		$(".attFileList").html(html);
	});
	
	//첨부파일 리스트에서 삭제
	$(".attFileList").on("click", "input", function() {
		var p = $(this).parents("div").parents("div").attr("name");
		$("div[name='" + p + "']").remove();
		
		var existDel = 0;
		$("input[name='existAttFile']").each(function() {	//기존 첨부되었던 파일의 삭제버튼을 누르면
			console.log($(this).val());
			if($(this).val() == p){	//첨부파일 번호가 같으면 기존 첨부파일에서 삭제
				$(this).remove();
				existDel = 1;
				
				var len = $(".realArea input").length;
				var html="";
				html += "<input type=\"file\" name=\"attFile" + (3-len) + "\" id=\"attFile" + (3-len) + "\">";	
				arrFile[2-len] = 0;		//기존 첨부파일 삭제하면 input[type='file'] 하나씩 추가
				
				$("#uploadForm").prepend(html);
				
				return;
			}
		});
		
		if(existDel == 0){
			$("#" + p).val(""); 
			$("div[name='" + p + "']").remove();
			var num = p.substring(p.length - 1, p.length) - 1;
			arrFile[num] = 0;
		}
	});
	
	//결재라인 선택
	$("#apvLineBtn").on("click", function() {
		console.log("현재 선택된 결재자 수 :" + $("input[name=\"exceptEmpNo\"]").length);
		if($("input[name=\"exceptEmpNo\"]").length != 0){
			makeConfirm(2, "확인", "지정했던 결재라인은 초기화 됩니다.", true, 
				function() {
					$("input[name='exceptEmpNo']").each(function() {
						$(this).remove();
					});
					makeSelectApvLinePopup();
				}
			);
		} else {
			makeSelectApvLinePopup();
		}
	});
	
	//수정 확인 버튼
	$("#updateBtn").on("click", function() {
		if($(".apver").length == 0){
			makeAlert(1, "확인", "결재자가 1명 이상 존재해야 합니다.", true, null)
		} else {
			if(checkEmpty("#titleTxt")){
				makeAlert(1, "확인", "제목을 입력해주세요", false, 
					function() {
						$("#titleTxt").focus();	
					}		
				);
			} else if(checkEmpty("#conTxt")){
				makeAlert(1, "확인", "내용을 입력해주세요", false, 
					function() {
						$("#conTxt").focus();	
					}		
				);
			} else {	//수정 ㄱㄱ
				var uploadForm = $("#uploadForm");
				
				uploadForm.ajaxForm({
					beforeSubmit : function() {
						
					},
					success : function(result) {
						if(result.result == "SUCCESS"){
							var attList = "";
							for(var i = 0; i < result.fileName.length; i++){
								attList += "/" + result.fileName[i];
							}
							$("#attList").val(attList.substring(1));
							
							apvUpdate();
							
						}else {
							makeAlert(1, "확인", "첨부파일 저장 실패", false, null);
						}
					},
					error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
				uploadForm.submit();
			}
		}
	});
});

//수정 확인
function apvUpdate() {
	$("#impDate").val($("#imp_date").val());
	$("#title").val($("#titleTxt").val());
	$("#con").val($("#conTxt").val());
	$("#expCon").val(CKEDITOR.instances['contents'].getData());
	$("#expCon").val($("#expCon").val().replace(/<script/gi, "&lt;script"));
	
	if($("#checkAllApv").prop("checked") == true){
		$("#allApvWhether").val("0");
	} else {
		$("#allApvWhether").val("1");
	}
	
	$(".apver").each(function() {
		$("#apverNos").val($("#apverNos").val() + "," + $(this).attr("name"));
	});
	$("#apverNos").val($("#apverNos").val().substring(1));
	
	var params = $("#dataForm").serialize();
	$.ajax({
		type: "post",
		url: "GWApvUpdateAjax",
		dataType: "json",
		data: params,
		success: function(result) {
			makeAlert(1, "확인", "수정 되었습니다.", true, function() {
				$("#dataForm").attr("action", "GWApvProgress");
				$("#dataForm").submit();
			});
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
}
</script>
</head>
<body>

<!-- dataForm 영역 -->
<form action="#" id="dataForm" method="post">
	<input type="hidden" id="deptNo" name="deptNo" />
	<input type="hidden" id="empName" name="empName" />
	<div id="except">
		<c:forEach var="apver" items="${list}">
			<input type="hidden" name="exceptEmpNo" value="${apver.EMP_NO}">
		</c:forEach>
	</div>
	<input type="hidden" id="apverNos" name="apverNos" /> <!-- 실제 결재 올릴 결재자들 사원번호 (ex "20190002,20190003")-->
	
	<!-- 결재 문서 관련 -->
	<input type="hidden" id="apvNo" name="apvNo" value="${data.APV_NO}" />	<!-- #imp_date 넣을 것 -->
	
	<input type="hidden" id="impDate" name="impDate" />	<!-- #imp_date 넣을 것 -->
	<input type="hidden" id="title" name="title" />		<!-- #titleTxt -->
	<input type="hidden" id="con" name="con" />			<!-- #conTxt -->
	<input type="hidden" id="expCon" name="expCon" />	<!-- #contents -->
	<input type="hidden" id="allApvWhether" name="allApvWhether" value="${data.ALLAPV_WHETHER}"/>	<!-- #checkAllApv -->
	
	<!-- 첨부파일 -->
	<input type="hidden" id="attList" name="attList" />	<!-- 첨부파일 -->
	<c:forEach var="att" items="${attFileList}" varStatus="status">
		<input type="hidden" id="existAttFile${status.count}" name="existAttFile" value="${att.ATT_FILE_NO}" fileName="${att.ATT_FILE_NAME.substring(20)}">
	</c:forEach>
	
	<!-- 메뉴 -->
	<input type="hidden" name="topMenuNo" value="${param.topMenuNo}"/>
	<input type="hidden" name="leftMenuNo" value="${param.leftMenuNo}"/>
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
</c:import>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 전자결재 &gt; 결재진행 문서함</div>
	<div class="content_title">
		결재문서 수정 페이지
	</div>
	<div class="apvDocType">
		<div class="bg0">
			<div class="exit_btn">
				<img alt="exit" src="resources/images/erp/gw/ea/exit.png">
			</div>
		</div>
		<div class="bg1">
			<div class="bg1_left">
				<input type="button" id="apvLineBtn" value="결재라인" />
				<input type="checkbox" id="checkAllApv" <c:if test="${data.ALLAPV_WHETHER eq 0}">checked="checked"</c:if> />
				<label for="checkAllApv">전결가능</label>
			</div>
			<div class="bg1_right">
				<input type="button" id="updateBtn" value="확인" />
			</div>
		</div>
		<div class="bg2">
			<div class="apvTypeName">
				업무기안
			</div>
			<div class="docCommonArea">
				<div class="doc_info">
					<table class="doc_info_table">
						<colgroup>
							<col width="100" />
							<col width="200" />
						</colgroup>
						<tbody>
							<tr>
								<th>기안자</th>
								<td>${data.NAME}</td>
							</tr>
							<tr>
								<th>소속</th>
								<td>${data.DEPT_NAME}</td>
							</tr>
							<tr>
								<th>기안일</th>
								<td>${data.DRAFT_DATE}</td>
							</tr>
							<tr>
								<th>시행일</th>
								<td><input type="text" placeholder="YYYY/MM/DD" id="imp_date" value="${data.IMP_DATE}" readonly="readonly" />
									<img alt="reset" src="resources/images/erp/gw/ea/reset.png" /></td>
							</tr>
							<tr>
								<th>품의번호</th>
								<td>${data.CONSULT_NO}</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="apverArea">
					<span><br/><br/>결재</span>
					<c:forEach var="apver" items="${list}">
						<div class="apver" name="${apver.EMP_NO}" >
							<div class="posi" name="${apver.POSI_NO}">${apver.POSI_NAME}</div>
							<div class="empName" >
								<div name="${apver.DEPT_NAME}">${apver.NAME}</div>
							</div>
							<div class="apvDate"><span style="color: #8B8786;"><i>결재일</i></span></div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="docSimpleInfoArea"> 
				<div>
				<table class="docNameAndCon">
					<tbody>
						<tr>
							<th>제목</th>
							<td><input type="text" id="titleTxt" value="${data.TITLE}"/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><input type="text" id="conTxt" value="${data.CON}"/></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="docUnCommonArea">
				<div class="expCon" name='${data.APV_DOC_TYPE_NO}'> 
					<textarea rows="10" cols="20"id="contents" name="contents">
						${data.EXP_CON}
					</textarea>	
				</div>
			</div>
			<div class="attFileArea"> 
				<div class="fakeArea">
					<input type="button" value="파일첨부" id="fileBtn"/>
					<div class="attFileList">
						<c:choose>
							<c:when test="${!empty attFileList}">
								<c:forEach var="att" items="${attFileList}">
									<div name="${att.ATT_FILE_NO}">
										<div class="fLeft"><span>${att.ATT_FILE_NAME.substring(20)}</span></div>
										<div class="fRight"><input type="button" value="삭제" /></div>
									</div>
	         					</c:forEach>
							</c:when>
							<c:otherwise>
								<span style="color: #8B8786;"><i>첨부파일은 3개까지 첨부 가능합니다.</i></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="realArea">
				<form action="fileUploadAjax" method="post" id="uploadForm" enctype="multipart/form-data">
					<c:forEach var="i" begin="${fn:length(attFileList) + 1}" end="3">
						<input type="file" name="attFile${i}" id="attFile${i}">
					</c:forEach>
				</form>
			</div>
		</div>
	</div>
</div>	
</body>
</html>