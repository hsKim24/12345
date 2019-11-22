<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>매출월간보고/연간보고</title>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css"/>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/stc/stcStyle.css"/>
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
	</head>
	<body>
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="78"></c:param>
			<c:param name="leftMenuNo" value="88"></c:param>
			<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
		</c:import>	
		<div class="content_area">
			 <!-- 메뉴 네비게이션 -->
	        <div class="content_nav">HeyWe &gt; 경영관리 &gt; 통계 &gt; 매출월간보고/연간보고</div>
	         <!-- 현재 메뉴 제목 -->
	        <div class="content_title">매출월간보고/연간보고</div>	
			<!-- 내용 영역 -->
			<br />
			<div class="statistic_top_area">
				<input type="button" class="top_btn1"value="월간보고">
				<input type="button" class="top_btn"value="연간보고">
			</div>
			<br/>
			<div class="data_search_area">
				<div class="data_search_menu">날짜(*)</div>
				<div class="data_search_input">
					<select class="slt">
					<option>2019</option>
					<option>2018</option>
					<option>2017</option>
					<option>2016</option>
					<option>2015</option>
					<option>2014</option>
					<option>2013</option>
					<option>2012</option>
					<option>2011</option>
					<option>2010</option>
					<option>2009</option>
				</select>
				</div>
				<div class="data_search_icon">년도</div>
				<div class="data_search_icon"></div>
				<div class="data_search_input">
					<select class="slt">
					<option>2019</option>
					<option>2018</option>
					<option>2017</option>
					<option>2016</option>
					<option>2015</option>
					<option>2014</option>
					<option>2013</option>
					<option>2012</option>
					<option>2011</option>
					<option>2010</option>
					<option>2009</option>
				</select>
				</div>
				<div class="data_search_icon">년도</div>
				<div class="data_search_icon"></div>
				<div class="data_search_btn">
					<input type="button" value="검색" class="btn" />
				</div>				
			</div>
			<br />
			<div class="data_info_area">
				<table class="data_info_table">
					<colgroup>
						<col width="160" />
						<col width="160" />
						<col width="160" />
						<col width="160" />
						<col width="160" />
					</colgroup>
					<tbody>
						<tr class="first_tr">
							<th class="graph"></th>
							<th class="graph"></th>
							<th class="graph"></th>
							<th class="graph"></th>
							<th></th>
						</tr>
						<tr class="top_tr">
							<td class="graph"></td>
							<td class="graph"></td>
							<td class="graph"></td>
							<td class="graph"></td>
							<td></td>
						</tr>
						<tr class="bottom_tr">
							<td class="graph"></td>
							<td class="graph"></td>
							<td class="graph"></td>
							<td class="graph"></td>
							<td></td>
						</tr>
						<tr class="top_tr">
							<td class="graph"></td>
							<td class="graph"></td>
							<td class="graph"></td>
							<td class="graph"></td>
							<td></td>
						</tr>
				</tbody>
			</table>
   			</div>
   			<br/>
   			<div class="data_info_area"></div>
		</div>
</body>
</html>