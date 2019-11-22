<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe 게시판</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/board/gwBoard.css"/>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		if ($("#page").val() == "") {
			$("#page").val("1");
		}
		reloadList();
		
		$("#insertBtn").on("click",function(){
			$("#formData").attr("action", "GWBoardWrite");
			$("#formData").submit();
		});
	
 		$("tbody").on("click","tr", function(){
			$("#no").val($(this).attr("name"));
			$("#formData").attr("action", "GWArticleDtl");
			$("#formData").submit();
		});
 		
 		//관리자용 체크박스
/* 		if($(this).children().is("[type='checkbox']")) {
			if($(this).children().is(":checked")) {
				$(this).children().prop("checked", false);
			} else {
				$(this).children().prop("checked", true);
			}
		} else {} */

		
		$("#searchBtn").on("click", function() {
			if($.trim($("#searchTxt").val()) == "") {
	             alert("검색어를 입력하세요.");
	             $("#searchTxt").focus();
			}else{
			$("#page").val("1");
			reloadList();
			}
		});
		
		$("#searchTxt").keydown(function(key){
			if(key.keyCode == 13){
				if($("#searchTxt").val() == "") {
					alert("검색어를 입력하세요.");
					$("#searchTxt").focus();
				} else{
					$("#page").val("1");
					reloadList();
				}
			}
		});
		
		$("#writeBtn").on("click", function(){
			$("#formData").attr("action", "GWBoardWrite");
			$("#formData").submit();
		});
		
		$("#pagingArea").on("click", "input", function() {
			$("#page").val($(this).attr("name"));
			reloadList();
		});
		
		document.addEventListener('keydown', function(event) {
		    if (event.keyCode === 13) {
		        event.preventDefault();
		    }
		}, true);
	
	});
	function reloadList() {
		var params = $("#formData").serialize();
		
		$.ajax({
			type : "post",
			url : "GWArticleListAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawList(result.list);
				redrawPaging(result.pb);
				totalArticle(result.cnt);
				console.log(result.list);
				console.log(result.pb);
				console.log(result.cnt);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function totalArticle(cnt){
		var html = "";
		html += cnt;
		$("#total").html(html);
	}
	
	function redrawList(list) {
		var html = "";
		if (list.length == 0) {
			html += "<th colspan=\"6\">조회결과가 없습니다.</th>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr name=" + list[i].ARTICLE_NO + "\>";
				html += "<td>" + list[i].ARTICLE_NO + "</td>";
				html += "<td id=\"article_title\">" + list[i].TITLE + "</td>";
				html += "<td>" + list[i].NAME + "</td>";
				html += "<td>" + list[i].HIT + "</td>";
				html += "<td>" + list[i].WRITE_DATE + "</td>";
				html += "</tr>";
			}
		}
		$("tbody").html(html);
	}
	
	function redrawPaging(pb) {
		var html = "";
		html += "<input type=\"button\" value=\"<<\" name=\"1\" />";
		if ($("#page").val() == "1") {
			html += "<input type=\"button\" value=\"<\" name=\"1\" />";
		} else {
			html += "<input type=\"button\" value=\"<\" name=\""
			+ ($("#page").val() * 1 - 1) + "\" />";
		}
		for (var i = pb.startPcount; i <= pb.endPcount; i++) {
			if (i == $("#page").val()) {
				html += "<input type=\"button\" value=\"" + i + "\" name =\"" + i + "\"id=\"checked\" disabled=\"disabled\"/>";
			} else {
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" />";
			}
		}
		if ($("#page").val() == pb.maxPcount) {
			html += "<input type=\"button\" value=\">\" name=\"" + pb.maxPcount + "\" />";
		} else {
			html += "<input type=\"button\" value=\">\" name=\""
			+ ($("#page").val() * 1 + 1) + "\" />";
		}
		html += "<input type=\"button\" value=\">>\" name=\"" + pb.maxPcount + "\" />";
		$("#pagingArea").html(html);
	}
	
</script>

</head>
<body>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
	<c:when test="${path eq '/GWNotice'}">
		<c:set var="leftMenuNo" value="8" />
	</c:when>
	<c:when test="${path eq '/GWDeptBoard'}">
		<c:set var="leftMenuNo" value="9" />
	</c:when>
	<c:when test="${path eq '/GWComBoard'}">
		<c:set var="leftMenuNo" value="10" />
	</c:when>
</c:choose>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="${leftMenuNo}"></c:param>
</c:import>
	<div class="content_area">
		<div class="content_nav"> <span>HeyWe</span> &gt; <span>그룹웨어</span> &gt; <span>게시판</span> &gt; <span>
		<c:choose>
		<c:when test="${boardMngtNo eq 2}"> 전사게시판 </c:when>
		<c:when test="${boardMngtNo eq 0}">	공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
		</c:choose></span> </div>
		<div class="content_title">
			<b>	<c:choose>
		<c:when test="${boardMngtNo eq 2}"> 전사게시판 </c:when>
		<c:when test="${boardMngtNo eq 0}">	공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
		</c:choose></b>
		</div>
		<div class="top_box">
			<div class="total_doc">총 게시물 :&nbsp; &nbsp;<span id="total"></span>   개</div>
		</div>
	<c:choose>
		<c:when test="${boardMngtNo eq 2}"> 전사게시판 </c:when>
		<c:when test="${boardMngtNo eq 0}">	공지사항 </c:when>
		<c:otherwise> ${sDeptName} 게시판</c:otherwise>
	</c:choose>
	<form action="#" id="formData" method="post">
	<input type="hidden" name="page" id="page" value="${page}" /> 
	<input type="hidden" id="no" name="no"/>
	<input type="hidden" value="${sEmpNo}" id="empNo" name="empNo" />
	<input type="hidden" value="${boardMngtNo}" id="boardMngtNo" name="boardMngtNo"/>
	<c:if test="${boardMngtNo eq 1}">
		<input type="hidden" value="${sDeptNo}" id="sDeptNo" name="sDeptNo" />
	</c:if>
		<table id="articleDtl">
			<thead>
				<tr class="article_main" >
					<td>글번호 </td>
					<td class="artcle_title">제목 </td>
					<td>작성자 </td>
					<td>조회수 </td>
					<td class="td_date">작성일 </td>
				</tr>
			</thead>
			<tbody></tbody>
			<tfoot>
				<tr>
					<td colspan="6">
						<div class="b_Btn">
							<c:if test="${boardMngtNo eq 0 && (sAuthNo eq 0 || sAuthNo eq 2 || sAuthNo eq 3 || sAuthNo eq 5 || sAuthNo eq 7 || sAuthNo eq 9)}">
								<input type="button" value="글쓰기" id="writeBtn"/>
							</c:if>
							<c:if test="${boardMngtNo ne 0}">
								<input type="button" value="글쓰기" id="writeBtn"/>
							</c:if>
 						<div id="pagingArea"></div>
						<div class="s_Btn">						
						<select name="searchGbn" id="searchGbn">
							<option value="0">제목</option>
							<option value="1">내용</option>
							<option value="2">작성자</option>
							<option value="3">제목 + 내용</option>
						</select> 
							<input type="text" id="searchTxt" name="searchTxt" placeholder="검색어를 입력해 주세요."/>
							<input type="button" value="검색" id="searchBtn"/>
						</div>
						</div>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	</div>
</body>
</html>