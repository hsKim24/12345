<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서함 - 게시글 상세보기</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/document/documentDetail.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
		$("#writeBtn").on("click", function(){
		$("#dataForm").attr("action", "GWDocWrite");
		$("#dataForm").submit();
	});
	$("#updateBtn").on("click", function(){
		$("#dataForm").attr("action", "GWDocUpdate");
		$("#dataForm").submit();
	});
	
	$("#delBtn").on("click", function(){
		makeConfirm(1, "경고", "삭제하시겠습니까?", true, function(){
			deleteBtn();
		});
		
	});
	$("#backBtn").on("click", function(){
		
		if('${param.sDocType}' == '0'){
			location.href = "GWComnDocBoard"
		} else if ('${param.sDocType}' == '1'){
			location.href = "GWPubDocBoard"
		} else {
			location.href = "GWDeptDocBoard"
		}
		
	});
});

function deleteBtn(){
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "GWDocDelAjax",
		data : params,
		dataType : "json",
		success : function(result) {
			makeAlert(2, "확인", "삭제되었습니다.", true, function() {
			if('${param.sDocType}' == '0'){
				location.href = "GWComnDocBoard"
			} else if ('${param.sDocType}' == '1'){
				location.href = "GWPubDocBoard"
			} else {
				location.href = "GWDeptDocBoard"
			}
			});
	}, error : function(request, status, error) {
		console.log("status : " + request.status);
		console.log("text : " + request.responseText);
		console.log("error : " + error);
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
	$("#ct_attachment").css("display","none");
	$("#dtl_Btn").css("display","none");
    window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
    window.print();
}

</script>
</head>
<body>

<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
	<c:when test="${dtl.DOC_TYPE_NAME eq '공용문서'}">
		<c:set var="leftMenuNo" value="14" />
	</c:when>
	<c:when test="${dtl.DOC_TYPE_NAME eq '공문서'}">
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
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; ${dtl.DOC_TYPE_NAME} 문서함  &gt; 상세보기</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<b>	<c:choose>
		<c:when test="${dtl.DOC_TYPE_NAME eq '공용문서'}"> 공용문서함 </c:when>
		<c:when test="${dtl.DOC_TYPE_NAME eq '공문서'}"> 공문서함 </c:when>
		<c:otherwise> ${sDeptName} 문서함</c:otherwise>
		</c:choose></b>
	</div>
	<form action="#" id="dataForm" method="post">
	<input type="hidden" id="no" name="no" value="${param.no}"/>
	<c:choose>
		<c:when test="${empty param.sDocType}">
			<input type = "hidden" name="deptNo" value="${sDeptNo}"/>
		</c:when>
		<c:otherwise>
			<input type = "hidden" name="sDocType" value="${param.sDocType}"/>
		</c:otherwise>
	</c:choose>
	<input type = "hidden" name="Doc_Type_Name" value="${dtl.DOC_TYPE_NAME}"/>
	<div id="main_area">
			<div id="top_info">
				<div id="category">
					<div>번호</div>
					<div>제목</div>
					<div>글쓴이</div>
					<div>날짜</div>
				</div>
				<div id="ct_contents">
					<div>${dtl.DOC_NO}</div>
					<div>${dtl.TITLE}</div>
					<div>${dtl.NAME}</div>
					<div>${dtl.WRITE_DAY}</div>
				</div>
			</div>
		<div id="ct_main">${dtl.CON}</div>
		<div id="ct_attachment">
			<c:forEach var="att" items="${att_dtl}">
    			<a href="resources/upload/${att.ATT_FILE_NAME}" download>${att.ATT_FILE_NAME}</a><br/>
			</c:forEach>
		</div>
		<div id="dtl_Btn">
				<a href="javascript:history.go(0)" onclick="pageprint()"><input type="button" value="인쇄" id="printBtn"/></a>
				<input type="button" value="글쓰기" id="writeBtn">
				<c:if test = "${sEmpNo eq dtl.EMP_NO || sDeptNo eq 0}">
					<input type="button" value="수정" id="updateBtn">
					<input type="button" value="삭제" id="delBtn">
				</c:if>
				<input type="button" value="목록" id="backBtn">
		</div>
	</div>
	
	</form>
</div>
</body>
</html>