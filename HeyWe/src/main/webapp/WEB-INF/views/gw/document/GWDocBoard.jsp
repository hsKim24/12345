<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹웨어 문서함</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/document/documentBoard.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	 	
	if($("#page").val() == "") {
		$("#page").val("1");
	}
		reloadList();
		
	$("#searchBtn").on("click", function(){
			if($("#searchtxt").val() == "") {
				makeAlert(1, "검색 안내", "검색어를 입력해 주세요.", true, function() {
					$("#searchtxt").focus();
				});
			} else{
				$("#page").val("1");
				reloadList();
			}
	});
	
	$("#searchtxt").keydown(function(key){
		if(key.keyCode == 13){
			if($("#searchtxt").val() == "") {
				makeAlert(1, "검색 안내", "검색어를 입력해 주세요.", true, function() {
					$("#searchtxt").focus();
				});
			} else{
				$("#page").val("1");
				reloadList();
			}
		}
	});
	
	$("#pagingArea").on("click", "input", function(){
		$("#page").val($(this).attr("name"));
		reloadList();
	});
	
	$("tbody").on("click", "tr", function(){
		$("#no").val($(this).attr("name"));
		$("#dataForm").attr("action", "GWDocDtl");
		$("#dataForm").submit();
	});
	
	$("#writeBtn").on("click", function(){
		$("#dataForm").attr("action", "GWDocWrite");
		$("#dataForm").submit();
	})
	
	document.addEventListener('keydown', function(event) {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	}, true);
	
});

function reloadList() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "GWDocBoardAjax",
		data : params,
		datatype : "json",
		success : function(result){
			redrawList(result.data);
			redrawPaging(result.pb);
			totalArticle(result.cnt);
			console.log(result);
			console.log(result.data);
			console.log(result.pb);
			}
	});
}

function redrawList(data){
	var html = "";
	if(data.length == 0){
		html += "<th colspan=\"6\">조회결과가 없어요</th>";
	} else {
		for (var i = 0 ; i < data.length ; i++) {
			html += "<tr name=" + data[i].DOC_NO + "\>";
			html += "<td>" + data[i].DOC_NO + "</td>";
			html += "<td id=" + "\"article_title\">" + data[i].TITLE + "</td>";
			html += "<td>" + data[i].NAME + "</td>";
			html += "<td>" + data[i].DOC_HIT + "</td>";
			html += "<td>" + data[i].WRITE_DAY + "</td>";
			html += "</tr>";
			}
		}
	$("tbody").html(html);
}
	
function redrawPaging(pb){
	var html = ""; // 처음 페이지는 무조건 1페이지로.
		html += "<input type=\"button\" value=\"<<\" name=\"1\"/>";
	if($("#page").val() == "1") { // 만약에 1페이지일때 이전페이지를 누르면 1페이지로.
		html += "<input type=\"button\" value=\"<\" name=\"1\"/>";
	} else { // 다른 페이지일 때는 page * 1 - 1로.
		html += "<input type= \"button\" value= \"<\" name=\"" + ($("#page").val() * 1 - 1) + "\"/>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++) {
		if(i == $("#page").val()){
			html += "<input type=\"button\" value=\"" + i + "\" name =\"" + i + "\"id=\"checked\" disabled=\"disabled\"/>";
		} else {
			html += "<input type=\"button\" value=\"" + i + "\" name =\"" + i + "\"/>";
		}
	}
	
	if($("#page").val() == pb.maxPcount) {
		html += "<input type= \"button\" value =\">\" name=\"" + pb.maxPcount + "\"/>";
	} else {
		html += "<input type= \"button\" value=\">\" name=\"" + ($("#page").val() * 1 + 1) + "\"/>";
	}
		html += "<input type=\"button\" value=\">>\" name=\"" + pb.maxPcount + "\"/>";
		
		$("#pagingArea").html(html);
}

function totalArticle(cnt){
	var html = "";
	html += cnt;
	$("#total").html(html);
}

</script>
</head>

<body>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
	<c:when test="${path eq '/GWDeptDocBoard'}">
		<c:set var="leftMenuNo" value="13" />
	</c:when>
	<c:when test="${path eq '/GWComnDocBoard'}">
		<c:set var="leftMenuNo" value="14" />
	</c:when>
	<c:when test="${path eq '/GWPubDocBoard'}">
		<c:set var="leftMenuNo" value="15" />
	</c:when>
</c:choose>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="${leftMenuNo}"></c:param>
</c:import>
<!-- doctype는 Board에서만 사용한다. Board에서 sDocType을 설정해준다. -->
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt;
		<c:choose>
			<c:when test="${doctype eq 0}"> 공용문서함 </c:when>
			<c:when test="${doctype eq 1}">	공문서함 </c:when>
			<c:otherwise> ${sDeptName} 문서함</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 내용 영역 -->
		
	<div class="content_title">
		<b>	<c:choose>
			<c:when test="${doctype eq 0}"> 공용문서함 </c:when>
			<c:when test="${doctype eq 1}">	공문서함 </c:when>
			<c:otherwise>${sDeptName} 문서함	</c:otherwise>	
			
		</c:choose></b>
	</div>
	
	<div class="top_box">
		<div class="total_doc">총 게시물 :&nbsp; &nbsp;<span id="total"></span>   개</div>
	</div>
	
	<div class="container_box">
		<!-- 최신 게시판 글 -->
		<form action="#" id="dataForm" method="post">
		<input type="hidden" id="page" name="page" value="${page}"/>
		<input type="hidden" id="no" name="no"/>
		<c:choose>
			<c:when test="${doctype eq 0}">
				<input type="hidden" id="sDocType" name="sDocType" value="0"/>
			</c:when>
			<c:when test="${doctype eq 1}">
				<input type="hidden" id="sDocType" name="sDocType" value="1"/>
			</c:when>
			<c:otherwise>	
				<input type="hidden" id="deptNo" name="deptNo" value="${sDeptNo}"/>
			</c:otherwise>
		</c:choose>
		
		
		<table>
			<thead>
			<tr class="article_main" >
				<td>글번호 </td>
				<td class="artcle_title">제목 </td>
				<td>작성자 </td>
				<td>조회수 </td>
				<td class="td_date">작성날짜 </td>
			</tr>
			</thead>
			<tbody></tbody>
		</table>
		
        <div id="pagingArea"></div>
        <input type="button" value="작성" id="writeBtn"/>
         		
		<select name="SearchGbn">
				<option value = "0">제목</option>
				<option value = "1">내용</option>
				<option value = "2">제목 + 내용</option>
				<option value = "3">글 작성자</option>
		</select>
		<input type="text" id = "searchtxt" name="searchTxt" />
		<input type="button" value="검색" id="searchBtn"/>
		
		</form>
		
	</div>
</div>
</body>
</html>