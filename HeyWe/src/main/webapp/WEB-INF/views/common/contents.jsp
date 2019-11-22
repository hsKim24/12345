<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - Contents</title>
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	SteelBlue : rgb(70, 130, 180), #4682b4
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	LightSkyBlue : rgb(176,218,236), #B0DAEC
	White : rgb(255,255,255), #FFFFFF
 */
.search_bar {
	display: inline-block;
	width: 800px;
	height: 120px;
	margin-left: 40px;
	margin-top: 20px;
	margin-bottom: 20px;
	background-color: #8DA9C4;
	color: #000000;
    background-color: #DEE6EF;
    color: #134074;
	border: 1px solid #CCCCCC;
	border-radius: 3px;
}

.search_wrap {
	display: inline-block;
	vertical-align: top;
	width: 50%;
	height: 40px;
	font-size: 11pt;
}

.search_gbn {
	height: 24px;
    width: 50px;
    margin: 8px 10px;
    padding: 0px 10px;
    display: inline-block;
    vertical-align: top;
    font-weight: bold;
}
.search_txt {
	height: 20px;
    width: 200px;
    margin: 8px 10px;
    padding: 0px;
    display: inline-block;
    vertical-align: top;
}

.search_btn {
	height: 24px;
    width: 60px;
    margin: 8px 0px 8px 250px;
    padding: 0px 5px;
    display: inline-block;
    vertical-align: top;
}

.default_table {
	border-collapse: collapse;
	font-size: 11pt;
	margin-top: 20px;
	margin-left: 40px;
	margin-bottom: 20px; 
}

.default_table tr {
	height: 35px;
}

.default_table th {
	background-color: #134074;
	color: #FFFFFF;
}

.default_table td {
	text-align: center;
}

.default_table tbody {
	cursor: pointer;
}

.default_table .single_row {
	background-color: #FFFFFF;
	color: #000000;
}

.default_table .double_row {
	background-color: #DEE6EF;
	color: #000000;
}

.default_table tbody tr:hover {
	background-color: #B0DAEC;
	color: #134074;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	/* makePopup(1, "test", "test", true, 600, 200,
			function() {
		// 컨텐츠 이벤트
	}, "테스트", function(){
		alert("aa");
		closePopup(1);
	}); */

	makeThreeBtnPopup(1, "test", "test", true, 600, 200,
			function() {
		// 컨텐츠 이벤트
	}, "테스트1", function(){
		alert("aa1");
		closePopup(1);
	}, "테스트2", function(){
		alert("aa2");
		closePopup(1);
	}, "테스트3", function(){
		alert("aa3");
		closePopup(1);
	});
	
	/* makeAlert(1, "test", "test중입니다.", true, null); */
	
	/* makeConfirm(1, "test", "test중입니다.", true, function(){
		alert("aa");
	}); */
	//공통코드 취득 Sample
	$.ajax({
		type : "post",
		url : "getCmnCdAjax",
		dataType : "json",
		data : "cdL=1",
		success : function(result) {
			console.log(result.cdList);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
});
</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="53"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
<div class="content_area">
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 자산 &gt; 교육관리 &gt; 교육 관리 현황</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">가나다라마바사</div>
	<!-- 내용 영역 -->
	<div class="search_bar">
		<div class="search_wrap">
			<span class="search_gbn">구분</span>
			<input type="text" class="search_txt" placeholder="검색어" />
		</div>
		<div class="search_wrap">
			<span class="search_gbn">구분</span>
			<input type="text" class="search_txt" placeholder="검색어" />
		</div>
		<div class="search_wrap">
			<span class="search_gbn">구분</span>
			<input type="text" class="search_txt" placeholder="검색어" />
		</div>
		<div class="search_wrap">
			<span class="search_gbn">구분</span>
			<input type="text" class="search_txt" placeholder="검색어" />
		</div>
		<div class="search_wrap">
		</div>
		<div class="search_wrap">
			<input type="button" class="search_btn" value="검색" />
		</div>
		
	</div>
	<table class="default_table">
		<colgroup>
			<col width="100" />
			<col width="500" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody>
			<tr class="single_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="double_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="single_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="double_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="single_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="double_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="single_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="double_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="single_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
			<tr class="double_row">
				<td>1</td>
				<td>테스트중</td>
				<td>테스터</td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>