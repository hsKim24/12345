<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재- 문서함 - 글쓰기</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/document/documentWrite.css"/>

<style type="text/css">
.realArea {
	display : none;
}
</style>

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("contents", {
		height : 400,
		resize_enabled : false, // 크기 변경 불가
		language :"ko",
		enterMode :"2"
		});
	console.log("${att_dtl}");
	var checkUnload = true;
    $(window).on("beforeunload", function(){
        if(checkUnload) return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
    });
    
    var arrFile = [0, 0, 0];
	if("${fn:length(att_dtl)}" != 0){
		for(var i = 0; i<"${fn:length(att_dtl)}"; i++){
			arrFile[i] = 1;
		}
	}
	
	$("#fileBtn").on("click", function() {
		if($.inArray(0, arrFile) != -1){
			$("#attFile" + ($.inArray(0, arrFile)+1)).click();
		} else {
			makeAlert(1, "확인", "첨부파일은 3개까지 가능합니다.", false, null);
		}
	});
	$(".realArea").on("change", "input", function() {
		var num = ($(this).attr("id").substring($(this).attr("id").length - 1, $(this).attr("id").length)) * 1 - 1;
		arrFile[num] = 1;
		
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
		$("input[name='existAttFile']").each(function() {	//기존 첨부되었던 파일이 삭제되면
			console.log($(this).val());
			if($(this).val() == p){	//첨부파일 번호가 같으면 기존 첨부파일에서 삭제
				$(this).remove();
				existDel = 1;
				
				console.log(arrFile);
				var len = $(".realArea input").length;
				var html="";
				html += "<input type=\"file\" name=\"attFile" + (3-len) + "\" id=\"attFile" + (3-len) + "\">";
				arrFile[2-len] = 0;
				console.log(arrFile);
				
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
	
$("#updateBtn").on("click", function(){
		checkUnload = false;
		var uploadForm = $("#uploadForm");
		uploadForm.ajaxForm ({
			beforeSubmit : function(){
				
			}, success : function(result) {
					if(result.result == "SUCCESS"){
						var attList = "";
						for(var i = 0; i < result.fileName.length; i++){
							attList += "/" + result.fileName[i];
						}
						$("#attList").val(attList.substring(1));
					
						/* var fileName = "";
						var html = "";
						
						$("#fake_file_area span .fileName").each(function() {
							fileName += "," + $(this).val();
						});
						
						for(var i = 0 ; i < result.fileName.length ; i ++) {
							fileName += "," + result.fileName[i];
						}
						
						fileName = fileName.substring(1);
						
						$("#uploadFileName").val(fileName);
						
						$("#finishAtt").html(html); */
						
					$("#contents").val(CKEDITOR.instances['contents'].getData());
					$("#contents").val($("#contents").val().replace(/<script/gi, "&lt;script"));

					if($.trim($("#title").val()) == "") {
						makeAlert(1, "글쓰기 안내", "제목을 입력해 주세요.", true, function() {
							$("#title").focus();
						});
					} else if ($.trim($("#contents").val()) == "") {
						makeAlert(1, "글쓰기 안내", "내용을 입력해 주세요.", true, function() {
							$("#contents").focus();
						});
					} else {
					var params = $("#dataform").serialize();
					
 					$.ajax({
						type : "post",
						url : "GWDocUpdateAjax",
						data : params,
						datatype : "json",
						success : function(result) {
							  makeAlert(1, "확인", "수정되었습니다.", true, function(){
									if('${param.sDocType}' == '0'){
										location.href = "GWComnDocBoard";
									} else if ('${param.sDocType}' == '1'){
										location.href = "GWPubDocBoard";
									} else {
										location.href = "GWDeptDocBoard";
									}
							  });
						}
						  });
							}
				} else {
					alert("실패");
					}
		},	error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + request.error);
					}
		});
		uploadForm.submit();
			
	});
	
	
	$("#backBtn").on("click", function(){
		checkUnload = false;
		makeConfirm(1, "취소 안내", "수정을 취소 하시겠습니까? <br/> 글 내용은 저장되지 않습니다.", true, function(){
			history.go(-1);
		});
	});
	
	/* 
	$("#fake_file_area").on("click", "input", function(){
		clickFile($(this).attr("id"));
	});
	
	$(".real_file_area").on("change", "input", function(){
		insertFileName($(this).attr("id"));
	});
	
	$("#fake_file_area").on("click", "#filedelete", function() {
		var idx = $(this).parent().attr("name");
		
		$(this).parent().remove();
		
		var html = "";
		
		html += "<input type=\"text\" class=\"fileName\" id=\"fileName" + idx + "\" readonly=\"readonly\"/> ";
		html += "<input type=\"button\" value=\"파일추가\" id=\"fileBtn" + idx + "\"/><br/>";
		
		$("#fake_file_area").append(html);
		
		var fileHtml = "";
		
		fileHtml += "<input type=\"file\" name=\"attFile" + idx + "\" id=\"attFile" + idx + "\"/>";
		
		$("#uploadForm").append(fileHtml);
		
	}); */
	
});
function clickFile(obj){
	var num = obj.substring(obj.length - 1, obj.length);
		
		$("#attFile" + num).click();
}

function insertFileName(obj){

	var num = obj.substring(obj.length - 1, obj.length);
	var fileName = $("#" + obj).val();
	console.log($("#" + obj).val());
	fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
	$("#fileName" + num).val(fileName);
}

</script>	
</head>

<body>


<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
	<c:when test="${param.sDocType eq 0}">
		<c:set var="leftMenuNo" value="14" />
	</c:when>
	<c:when test="${param.sDocType eq 1}">
		<c:set var="leftMenuNo" value="15" />
	</c:when>
	<c:otherwise>
		<c:set var="leftMenuNo" value="13" />
	</c:otherwise>
</c:choose>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="${leftMenuNo}"></c:param>
</c:import>


<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; <c:choose>
			<c:when test="${param.sDocType eq 0}"> 공용문서함 </c:when>
			<c:when test="${param.sDocType eq 1}"> 공문서함 </c:when>
			<c:otherwise> ${sDeptName} 문서함 </c:otherwise></c:choose> &gt; 글수정 </div>
	<!-- 내용 영역 -->
	<form action="#" id="dataform" method="post">
	<!-- 첨부파일 -->
	<input type="hidden" id="attList" name="attList" />	<!-- 첨부파일 -->
	<input type="hidden" id="resetAtt" name="resetAtt" value="0" />	<!-- 첨부파일 초기화 여부 -->
	<c:forEach var="att" items="${att_dtl}" varStatus="status">
		<input type="hidden" id="existAttFile${status.count}" name="existAttFile" value="${att.ATT_FILE_NO}" fileName="${att.ATT_FILE_NAME.substring(20)}">
	</c:forEach>
	
	<c:choose>
		<c:when test="${empty param.sDocType}">
			<input type = "hidden" name="deptNo" value="${sDeptNo}"/>
		</c:when>
		<c:otherwise>
			<input type = "hidden" id="sDocType" name="sDocType" value="${param.sDocType}"/>
		</c:otherwise>
	</c:choose>
	<input type="hidden" id="no" name="no" value="${param.no}"/>
	<input type="hidden" id="uploadFileName" name="uploadFileName"/>
	<div id="Ariticle">
		<div id="SelectF">제목	
			<input type="text" id="title" name="title" value="${data.TITLE}"/>
		</div>
		<div id="SelectG">
			<textarea id="contents" name="contents">${data.CON}</textarea><br/>
		</div>
		
		
		<%-- <div id="fake_file_area">
				<c:forEach items="${att_dtl}" var="att" varStatus="status">
					<span name="${status.count}">
					<input type="text" class="fileName" id="fileName${status.count}" readonly="readonly" value="${att.ATT_FILE_NAME}"/>
					<img src="resources/images/erp/gw/msg/close.png" id="filedelete" width="20" height="20"><br/>
					</span>
				</c:forEach>
				<c:forEach var="idx" begin="${fn:length(att_dtl) + 1}" end="3" step="1">
					<input type="text" class="fileName" id="fileName${idx}" readonly="readonly"/>
					<input type="button" value="파일추가" id="fileBtn${idx}"/><br/>
				</c:forEach>
		</div> --%>
		
		<input type="button" value="파일첨부" id="fileBtn"/>
		<div class="attFileArea"> 
				<div class="fakeArea">
					<div class="attFileList">
						<c:choose>
							<c:when test="${!empty att_dtl}">
								<c:forEach var="att" items="${att_dtl}">
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
		
			<input type ="button" id="updateBtn" value="수정"/>
			<input type ="button" id="backBtn" value="취소"/>
			
	</div>
		
	<!-- 	<div id="finishAtt"></div> -->
		
	</form>
	
	<div class="realArea">
		<form action="fileUploadAjax" method="post" id="uploadForm" enctype="multipart/form-data">
			<c:forEach var="i" begin="${fn:length(att_dtl) + 1}" end="3">
				<input type="file" name="attFile${i}" id="attFile${i}" accept=".xls, .ppt, .doc, .xlsx, .pptx, .docx, .hwp, .csv, .jpg, .jpeg, .png, .gif, .bmp, .tld, .txt, .pdf"/>
			</c:forEach>
		</form>
	</div>
	
	<%-- <div class="real_file_area">
		<form action="fileUploadAjax" method="post" id="uploadForm" enctype="multipart/form-data">
			<c:forEach var="idx" begin="${fn:length(att_dtl) + 1}" end="3" step="1">
				<input type="file" name="attFile${idx}" id="attFile${idx}"/>
			</c:forEach>
		</form>
	</div> --%>
		
		
</div>
</body>
</html>