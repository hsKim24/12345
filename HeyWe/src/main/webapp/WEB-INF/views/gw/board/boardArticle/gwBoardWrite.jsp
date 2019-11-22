<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe 글작성페이지</title>
<link rel="stylesheet" type="text/css"
	href= "resources/css/erp/common/main.css"/>
<link rel="stylesheet" type="text/css"
	href= "resources/css/erp/gw/board/gwBoard.css"/>
<link rel="stylesheet" type="text/css"
	href= "resources/css/erp/gw/board/gwWrite.css"/>
<link rel="stylesheet" type="text/css" 
	href="resources/css/common/popup.css" />
<style type="text/css">
.realArea {
	display : none;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/common/popup.js"></script>
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("contents",{
		height : 400,
		resize_enabled : false,
		language : "ko",
		enterMode : "2"
		});
		$("#cancelBtn").on("click",function(){
			if('${param.boardMngtNo}' == 1){
				location.href = "GWDeptBoard"
			} else if ('${param.boardMngtNo}' == 2){
				location.href = "GWComBoard"
			} else if ('${param.boardMngtNo}' == 0) {
				location.href = "GWNotice"
			}
		});
		$("#saveBtn").on("click", function(){
			var uploadForm = $("#uploadForm");
			uploadForm.ajaxForm ({ 
				beforeSubmit : function(){
					
				}, 
				success : function(result) {
					if(result.result == "SUCCESS") {
						var attList = "";
						var fileName = "";
						for(var i = 0 ; i < result.fileName.length ; i ++) {
							attList += "/" + result.fileName[i];
						}
						$("#attList").val(attList.substring(1));
						
						$("#contents").val(CKEDITOR.instances['contents'].getData());
						$("#contents").val($("#contents").val().replace(/<script/gi, "&lt;script"));
						
				         if($.trim($("#title").val()) == "") {
				             alert("제목을 입력하세요.");
				             $("#title").focus();
				          } else if($.trim($("#contents").val()) == "") {
				             alert("내용을 입력하세요.");
				          } else {
									if($("#noticesel").length > 0) {
										if($("#noticesel").val() == 0) {
											$("#title").val("[전사]" + $("#title").val());
										} else {
											$("#title").val("[${sDeptName}]" + $("#title").val());
										}
									}
						var params = $("#formData").serialize();
						
	 					$.ajax({
							type : "post",
							url : "GWBoardWriteAjax",
							data : params,
							datatype : "json",
							success : function(result) {
				       		 makeAlert(1, "확인", "저장되었습니다.", true, function(){
				       			 
								if('${param.boardMngtNo}' == 1){
									location.href = "GWDeptBoard"
								} else if ('${param.boardMngtNo}' == 2){
									location.href = "GWComBoard"
								} else if ('${param.boardMngtNo}' == 0) {
									location.href = "GWNotice"
								}
				       		 });
							}
						});
	 					}
					} else {
						alert("실패");
					 }
					}, 	error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + request.error);
						}
			});
			
			uploadForm.submit();
			
		});
		var arrFile = [0, 0, 0];
		$("#fileBtn").on("click", function() {
			if($.inArray(0, arrFile) != -1){
				$("#attFile" + ($.inArray(0, arrFile)+1)).click();
			} else {
				makeAlert(1, "확인", "첨부파일은 3개까지 가능합니다.", false, null);
			}
		});
		
		$(".realArea").on("change", "input", function() {
			var num = ($(this).attr("id").substring($(this).attr("id").length - 1, $(this).attr("id").length)) * 1 - 1;
			console.log("첨부파일 들어간 번째 수" + num);
			arrFile[num] = 1;
			
			var html="";
			for(var i=0; i<arrFile.length; i++){
				if(arrFile[i] == 1){
					html += "<div name=\"attFile" + (i+1) + "\">";
					html += "<div class=\"fLeft\"><span>" + $("#attFile" + (i+1)).val().substring($("#attFile" + (i+1)).val().lastIndexOf("\\") + 1) + "</span></div>" 
					html += "<div class=\"fRight\"><input type=\"button\" value=\"삭제\" /></div>";
					html += "</div>";
				}
			}
			
			$(".attFileList").html(html);
		});
		
		//첨부파일 리스트에서 삭제
		$(".attFileList").on("click", "input", function() {
			var p = $(this).parents("div").parents("div").attr("name");
			console.log("리스트에서 삭제된 첨부파일 : " + p);
			$("#" + p).val(""); //arrFile이 1인 것만 보내는 걸로?
			$("div[name='" + p + "']").remove();
			var num = p.substring(p.length - 1, p.length) - 1;
			arrFile[num] = 0;
		});		
});

function clickFile(obj){
	var num = obj.substring(obj.length - 1, obj.length);
		
		$("#attFile" + num).click();
}

function insertFileName(obj){

	var num = obj.substring(obj.length - 1, obj.length);
	var fileName = $("#" + obj).val();
	fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
	$("#fileName" + num).val(fileName);
}

</script>
</head>
<body>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
	<c:when test="${param.boardMngtNo eq 2}">
		<c:set var="leftMenuNo" value="10" />
	</c:when>
	<c:when test="${param.boardMngtNo eq 0}">
		<c:set var="leftMenuNo" value="8" />
	</c:when>
	<c:otherwise>
		<c:set var="leftMenuNo" value="9" />
	</c:otherwise>
</c:choose>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="${leftMenuNo}"></c:param>
</c:import>
	<div class="content_area">
		<div class="content_nav"><span>HeyWe</span> &gt; <span>그룹웨어</span> &gt; <span>게시판</span> &gt;
		<span><c:choose>
		<c:when test="${param.boardMngtNo eq 2}"> 전사게시판 </c:when>
		<c:when test="${param.boardMngtNo eq 0}"> 공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
		</c:choose></span> &gt; <span>글쓰기</span></div>
		<div class="content_title">
		
		<b><c:choose>
		<c:when test="${param.boardMngtNo eq 2}"> 전사게시판 </c:when>
		<c:when test="${param.boardMngtNo eq 0}"> 공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
		</c:choose></b>
		</div>
		

 
	<form action="#" id="formData" method="post">
	
	<input type="hidden" value="${sEmpNo}" id="empNo" name="empNo" />
	<input type="hidden" value="${param.boardMngtNo}" id="boardMngtNo" name="boardMngtNo" />
	<input type = "hidden" id="attList" name="attList" />
	<div id="Article">
		<div id="Atitle">제	목
			<c:if test="${param.boardMngtNo eq 0}"> 
				<select name="noticesel" id="noticesel">
					<option value="0">전사</option>
					<option value="1">부서</option>
				</select>
			</c:if> 

			<input type="text" id="title" name="title" />
		</div>
		<div id="Acontents"> 
			<textarea rows="10" cols="20" id="contents"name="contents"></textarea>
		</div>		

		<div class="attFileArea"> 
			<div class="fakeArea">
				<div class="attFileList">
					<span style="font-style: italic; color: #8B8786;">첨부파일은 3개까지 가능합니다.</span>
				</div>
			</div>
		</div>
			<div class="att2_Btn">
				<input type="button" id="fileBtn"   value="첨부"/>
				<input type="button" id="saveBtn" value="저장" /> 
				<input type="button" id="cancelBtn" value="취소" /> 
			</div>
		</div>
	</form>
	<div class="realArea">
		<form action="fileUploadAjax" method="post" id="uploadForm" enctype="multipart/form-data">
			<input type="file" name="attFile1" id="attFile1" accept=".xls, .ppt, .doc, .xlsx, .pptx, .docx, .hwp, .csv, .jpg, .jpeg, .png, .gif, .bmp, .tld, .txt, .pdf"/><br/>
			<input type="file" name="attFile2" id="attFile2" accept=".xls, .ppt, .doc, .xlsx, .pptx, .docx, .hwp, .csv, .jpg, .jpeg, .png, .gif, .bmp, .tld, .txt, .pdf"/><br/>
			<input type="file" name="attFile3" id="attFile3" accept=".xls, .ppt, .doc, .xlsx, .pptx, .docx, .hwp, .csv, .jpg, .jpeg, .png, .gif, .bmp, .tld, .txt, .pdf"/><br/>
		</form>
	</div>
	</div>
</body>
</html>