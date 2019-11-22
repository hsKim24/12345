<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	console.log("${param}");
	
	var checkUnload = true;
    $(window).on("beforeunload", function(){
        if(checkUnload) return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
    });

	$("#insertBtn").on("click", function(){
		checkUnload = false;
		var uploadForm = $("#uploadForm");
		uploadForm.ajaxForm ({ 
			beforeSubmit : function(){
				
			}, success : function(result) {
				if(result.result == "SUCCESS") {
					var attList = "";
					var fileName = "";
					for(var i = 0 ; i < result.fileName.length ; i ++) {
						attList += "/" + result.fileName[i];
						console.log(result.data);
					}
					
					$("#attList").val(attList.substring(1));
					
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
						url : "GWDocWriteAjax",
						data : params,
						datatype : "json",
						success : function(result) {
							makeAlert(1, "확인", "저장되었습니다.", true, function(){
							
							if('${param.sDocType}' == '0'){
								location.href = "GWComnDocBoard"
							} else if ('${param.sDocType}' == '1'){
								location.href = "GWPubDocBoard"
							} else {
								location.href = "GWDeptDocBoard"
							}
							});
						}
					});
					}
				} else {
					makeAlert(1, "경고", "허용되지 않는 확장자입니다.", true, function() {
						$("#contents").focus();
					});					
				 }
				}, 	error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + request.error);
					}
		});
		uploadForm.submit();
		
		
	});
	
	$("#backBtn").on("click", function(){
		checkUnload = false;
		makeConfirm(1, "취소 안내", "글쓰기를 취소 하시겠습니까? <br/> 글 내용은 저장되지 않습니다.", true, function(){
			history.back();
		});
	});
/* 	
	$("#fake_file_area").on("click", "input", function(){
		clickFile($(this).attr("id"));
	});
	
	$(".real_file_area").on("change", "input", function(){
		insertFileName($(this).attr("id"));
	});
	
	$("#filedelete1").on("click", function(){
		$("#attFile1").val("");
		$("#fileName1").val("");
	});
	$("#filedelete2").on("click", function(){
		$("#attFile2").val("");
		$("#fileName2").val("");
	});
	$("#filedelete3").on("click", function(){
		$("#attFile3").val("");
		$("#fileName3").val("");
	});
	 */
	 
	//첨부파일 업로드
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
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 문서함 &gt; <c:choose>
			<c:when test="${param.sDocType eq 0}"> 공용문서함 </c:when>
			<c:when test="${param.sDocType eq 1}"> 공문서함 </c:when>
			<c:otherwise> ${sDeptName} 문서함 </c:otherwise>
	</c:choose> 글쓰기</div>
	<!-- 내용 영역 -->
	<form action="#" id="dataform" method="post">
	<c:choose>
		<c:when test="${empty param.sDocType}">
			<input type = "hidden" name="deptNo" value="${param.deptNo}"/>
		</c:when>
		<c:otherwise>
			<input type = "hidden" name="sDocType" value="${param.sDocType}"/>
		</c:otherwise>
	</c:choose>
	<input type = "hidden" name="sName" value="${sName}"/>
	<input type = "hidden" name="sEmpNo" value="${sEmpNo}"/>
	<input type = "hidden" name="Doc" value="${param.Doc_Type_Name}"/>
	<input type = "hidden" id="attList" name="attList" />	<!-- 첨부파일 -->
	
	<div id="Ariticle">
		<div id="SelectF">제목	
			<input type="text" id="title" name="title"/>
		</div>
		<div id="SelectG">
			<textarea id="contents" name="contents"></textarea><br/>
		</div>
<!-- 		<div id="fake_file_area">
			<input type="text" id="fileName1" readonly="readonly"/>
			<input type="button" value="파일추가" id="fileBtn1"/>
			<img src="resources/images/erp/gw/msg/close.png" id="filedelete1" width="20" height="20"><br/>
			<input type="text" id="fileName2" readonly="readonly"/>
			<input type="button" value="파일추가" id="fileBtn2"/>
			<img src="resources/images/erp/gw/msg/close.png" id="filedelete2" width="20" height="20"><br/>
			<input type="text" id="fileName3" readonly="readonly"/>
			<input type="button" value="파일추가" id="fileBtn3"/>
			<img src="resources/images/erp/gw/msg/close.png" id="filedelete3" width="20" height="20">
			
		</div>
		
		<div id="finishAtt"></div> -->
		<div class="attFileArea"> 
				<div class="fakeArea">
					<div class="attFileList">
						<span style="font-style: italic; color: #8B8786;">첨부파일은 3개까지 첨부 가능합니다.</span>
					</div>
				</div>
			</div>
			<input type="button" value="파일첨부" id="fileBtn"/>
			<input type ="button" id="insertBtn" value="등록"/>
			<input type ="button" id="backBtn" value="취소"/>
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