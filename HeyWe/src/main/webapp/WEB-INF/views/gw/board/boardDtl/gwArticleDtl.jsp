<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe 상세페이지</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" 
	href="resources/css/erp/gw/board/gwBoard.css"/>
<link rel="stylesheet" type="text/css" 
	href="resources/css/common/popup.css" />
	
<script type="text/javascript" 
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
	src="resources/script/common/popup.js"></script>
<style type="text/css">
@media print {
	html, body {
	width: 210mm;
	height: 297mm;
			   }
			 }
@page { 
	size:A4;
	margin: 50px;
 	  } 
h1, h2, h3, h4, h5, dl, dt, dd, ul, li, ol, th, td, p, blockquote, form, fieldset, legend, div,body { -webkit-print-color-adjust:exact; }
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#writeBtn").on("click", function(){
		$("#formData").attr("action", "GWBoardWrite");
		$("#formData").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#formData").attr("action", "GWArticleUpdate");
		$("#formData").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		makeConfirm(1, "경고", "삭제하시겠습니까?", true, function(){	
			deleteBtn();
		});
	});
	
	$("#listBtn").on("click", function(){
		if('${dtl.BOARD_MNGT_NO}' == 1){
			location.href = "GWDeptBoard"
		} else if ('${dtl.BOARD_MNGT_NO}' == 2){
			location.href = "GWComBoard"
		} else if ('${dtl.BOARD_MNGT_NO}' == 0) {
			location.href = "GWNotice"
		} else{
			location.href = "Main"
		}
	});
		
});

function deleteBtn(){
	var params = $("#formData").serialize();
		$.ajax({
			type : "post",
			url : "GWArticleDelAjax",
			data : params,
			dataType : "json",
			success : function(result) {
				makeAlert(2, "확인", "삭제되었습니다.", true, function() {
					if('${dtl.BOARD_MNGT_NO}' == 1){
						location.href = "GWDeptBoard"
					} else if ('${dtl.BOARD_MNGT_NO}' == 2){
						location.href = "GWComBoard"
					} else if ('${dtl.BOARD_MNGT_NO}' == 0) {
						location.href = "GWNotice"
					}
				});
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + request.error);
			}
		});
}
var initBody;

function beforePrint()
{
    initBody = document.body.innerHTML;
    document.body.innerHTML = main_area.innerHTML;
}

function afterPrint()
{
    document.body.innerHTML = initBody;
}

function pageprint()
{
	$(".ct_attachment").css("display","none");
	$(".b_Btn").css("display","none");
    window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
    window.print();
}


</script>
</head>
<body>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
	<c:when test="${dtl.BOARD_MNGT_NO eq 2}">
		<c:set var="leftMenuNo" value="10" />
	</c:when>
	<c:when test="${dtl.BOARD_MNGT_NO eq 0}">
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
		<div class="content_nav"><span>HeyWe</span> &gt; <span>그룹웨어</span> &gt; <span>게시판</span> &gt; <span><c:choose>
		<c:when test="${dtl.BOARD_MNGT_NO eq 2}"> 전사게시판 </c:when>
		<c:when test="${dtl.BOARD_MNGT_NO eq 0}"> 공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
		</c:choose></span> &gt; <span>상세페이지</span></div>
		<!-- 내용 영역 -->
		<div class="content_title">
			<strong><c:choose>
		<c:when test="${dtl.BOARD_MNGT_NO eq 2}"> 전사게시판 </c:when>
		<c:when test="${dtl.BOARD_MNGT_NO eq 0}">공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
		</c:choose></strong>
		</div>
		<form action="#" id="formData" method="post">
		<input type="hidden" value="${sEmpNo}" id="empNo" name="empNo" />
		<input type="hidden" value="${sDeptNo}" id="sDeptNo" name="sDeptNo" />
		<input type="hidden" value="${dtl.BOARD_MNGT_NO}" id="boardMngtNo" name="boardMngtNo" />
		<input type = "hidden" id="attList" name="attList" />
		<input type="hidden" id="no" name="no" value="${param.no}"/>
		<div id="main_area">
			<div class="top_info">
				<div class="category">
					<div>번호</div>
					<div>제목</div>
					<div>작성자</div>
					<div>작성일</div>
				</div>
				<div class="ct_contents">
					<div>${dtl.ARTICLE_NO}</div>
					<div>${dtl.TITLE}</div>
					<div>${dtl.NAME}</div>
					<div>${dtl.WRITE_DATE}</div>
				</div>
			</div>
			<div class="ct_main" style="font-size:12pt;">${dtl.CON}</div>

			<div class="ct_attachment">
				<c:forEach var="att" items="${att_dtl}">
					<a href="resources/upload/${att.ATT_FILE_NAME}" download="${att.ATT_FILE_NAME.substring(20)}">${att.ATT_FILE_NAME.substring(20)}</a><br/>
				</c:forEach>
			</div>
			<div class="b_Btn">
				<a href="javascript:history.go(0)" onclick="pageprint()"><input type="button" value="인쇄" id="printBtn"/></a>
				<c:choose>
					<c:when test="${sEmpNo eq dtl.EMP_NO || sAuthNo eq 0}">
						<input type="button" value="수정" id="updateBtn"/>
						<input type="button" value="삭제" id="deleteBtn"/>
					</c:when>
				</c:choose>
				<input type="button" value="글쓰기" id="writeBtn"/>
				<input type="button" value="목록" id="listBtn" />
			</div>
		</div>
		</form>
	</div>
</body>
</html>