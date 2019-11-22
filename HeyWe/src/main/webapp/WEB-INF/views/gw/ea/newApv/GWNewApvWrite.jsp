<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재문서 작성페이지</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvDocCommon.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvLineSelectPopup.css" />

<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<!-- calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />

<style type="text/css">
#cke_1_bottom {
	display: none;
}
.ui-datepicker select.ui-datepicker-year, .ui-datepicker select.ui-datepicker-month {
	width: 50%;
	vertical-align: middle;
}
</style>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script><!-- 파일업로드 -->

<script type="text/javascript" src="resources/script/erp/gw/ea/selectApvLinePopup.js"></script> <!-- 결재라인 지정 팝업 -->

<script type="text/javascript">
$(document).ready(function() {
	$(".exit_btn").on("click", function() {
		if(!checkEmpty("#titleTxt") || !checkEmpty("#conTxt")){
			makeConfirm(1, "확인", "작성 중인 내용이 사라집니다.<br/>정말 나가시겠습니까?", true, 
					function() {
						location.href="GWApvProgressDoc";
					}
				);
		} else {
			location.href="GWApvProgressDoc";
		}
	});
	
	var st_date = new Date().toISOString().substr(0, 10).replace('-', '/').replace('-', '/');

	$("#draftDate").text(st_date);
	
	$.datepicker.setDefaults({
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'both',
		closeText: '닫기',
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd',
		changeYear: true, //콤보박스에서 년 선택 가능
        changeMonth: true,//콤보박스에서 월 선택 가능
        minDate: "-10Y"
	}); 
	
    $("#imp_date").datepicker({
    	dateFormat : 'yy/mm/dd',
		duration: 200,
		minDate: new Date,
		onSelect:function(dateText, inst){
			var draftDate = parseInt($("#draftDate").text().replace("/", '').replace("/", ''));
			var impDate = parseInt(dateText.replace("/", '').replace("/", ''));
			
            if (draftDate > impDate) {
            	alert("날짜를 다시 확인해주세요.");
            	$("#imp_date").val("");
			} 
		}
    });
    
	CKEDITOR.replace("contents", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2",
		height : 500
	});
    
	//시행일초기화
	$("[alt='reset']").on("click", function() {
		$("#imp_date").val("");
	});
	
	//첨부파일 업로드
	var arrFile = [0, 0, 0];	//첨부파일 3개 첨부여부 (0:비어있음, 1:첨부됨)
	$("#fileBtn").on("click", function() {
		if($.inArray(0, arrFile) != -1){	//첨부여부 배열에 비어있는 자리가 있다면
			$("#attFile" + ($.inArray(0, arrFile)+1)).click();	//비어있는 위치의 file type 파일첨부 버튼을 클릭
		} else {
			makeAlert(1, "확인", "첨부파일은 3개까지 가능합니다.", false, null);
		}
	});
	
	$(".realArea").on("change", "input", function() {
		var num = ($(this).attr("id").substring($(this).attr("id").length - 1, $(this).attr("id").length)) * 1 - 1;
		console.log("첨부파일 들어간 번째 수" + num);
		arrFile[num] = 1;	//파일첨부한 경우 해당 첨부여부 배열의 값을 1로 변경
		
		var html="";
		for(var i=0; i<arrFile.length; i++){
			if(arrFile[i] == 1){	//파일이 첨부됐을 경우 목록을 최신화
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
		console.log("리스트에서 삭제된 첨부파일 : " + p);
		$("#" + p).val("");
		$("div[name='" + p + "']").remove();
		var num = p.substring(p.length - 1, p.length) - 1;
		arrFile[num] = 0;
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
	
	//상신하기 버튼
	$("#reportBtn").on("click", function() {
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
			} else {	//상신 ㄱㄱ
				var uploadForm = $("#uploadForm"); //Form정보를 가져온다
				
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
							
							reportApv();
							
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

//문서 상신
function reportApv() {
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
		url: "GWReportAjax",
		dataType: "json",
		data: params,
		success: function(result) {
			makeAlert(1, "확인", "상신 되었습니다.", true, function() {
				location.href ="GWApvProgressDoc";
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
	</div>
	<input type="hidden" id="apverNos" name="apverNos" /> <!-- 실제 결재 올릴 결재자들 사원번호 (ex "20190002,20190003")-->
	
	<!-- 결재 문서 관련 -->
	<input type="hidden" id="apvDocTypeNo" name="apvDocTypeNo" value='${apvDocType.APV_DOC_TYPE_NO}'/>
	<input type="hidden" id="impDate" name="impDate" />	<!-- #imp_date 넣을 것 -->
	<input type="hidden" id="title" name="title" />		<!-- #titleTxt -->
	<input type="hidden" id="con" name="con" />			<!-- #conTxt -->
	<input type="hidden" id="expCon" name="expCon" />	<!-- #contents -->
	<input type="hidden" id="allApvWhether" name="allApvWhether" value="1"/>	<!-- #checkAllApv -->

	<input type="hidden" id="attList" name="attList" />	<!-- 첨부파일 -->
	
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="4"></c:param>
</c:import>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 전자결재 &gt; 새 결재 진행</div>
	<div class="content_title">
		결재문서 작성 페이지
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
				<input type="checkbox" id="checkAllApv" checked="checked"><label for="checkAllApv">전결가능</label>
			</div>
			<div class="bg1_right">
				<input type="button" id="reportBtn" value="상신" />
			</div>
		</div>
		<div class="bg2">
			<div class="apvTypeName">${apvDocType.APV_DOC_TYPE_NAME}</div>
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
								<td>${sName}</td>
							</tr>
							<tr>
								<th>소속</th>
								<td>${sDeptName}</td>
							</tr>
							<tr>
								<th>기안일</th>
								<td id="draftDate"></td>
							</tr>
							<tr>
								<th>시행일</th>
								<td><input type="text" placeholder="YYYY/MM/DD" id="imp_date" readonly="readonly" />
									<img alt="reset" src="resources/images/erp/gw/ea/reset.png" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="apverArea">
 					<div style="font-style: italic; color: #8B8786;">결재자가 최소 1명이상 지정되어야 합니다.</div> 
				</div>
			</div>
			<div class="docSimpleInfoArea"> 
				<div>
				<table class="docNameAndCon">
					<tbody>
						<tr>
							<th>제목</th>
							<td><input type="text" id="titleTxt" placeholder="제목을 입력해주세요." /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><input type="text" id="conTxt" placeholder="내용을 입력해주세요." /></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="docUnCommonArea">
				<div class="expCon" name='${apvDocType.APV_DOC_TYPE_NO}'>
					<textarea rows="10" cols="20"id="contents" name="contents">
						${apvDocType.EXP_TYPE_CON}
					</textarea>	
				</div>
			</div>
			<div class="attFileArea"> 
				<div class="fakeArea">
					<input type="button" value="파일첨부" id="fileBtn"/>
					<div class="attFileList">
						<span style="color: #8B8786; font-size:12pt"><i>첨부파일은 3개까지 첨부 가능합니다.</i></span>
					</div>
				</div>
			</div>
			<div class="realArea">
				<form action="fileUploadAjax" method="post" id="uploadForm" enctype="multipart/form-data">
					<input type="file" name="attFile1" id="attFile1">
					<input type="file" name="attFile2" id="attFile2">
					<input type="file" name="attFile3" id="attFile3">
				</form>
			</div>
		</div>
	</div>	
</div>

</body>
</html>