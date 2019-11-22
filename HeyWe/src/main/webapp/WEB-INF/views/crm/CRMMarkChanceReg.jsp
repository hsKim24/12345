<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업기회작성</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_chance_c.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
</head>
<body>
	<c:import url="/top">
		<c:param name="lMenu" value="crm">
		</c:param>
	</c:import>
	<c:import url="/left">
		<c:param name="subMenu" value="sa">
			<%-- 1뎁스 (1.sa 2.cu 3.st) --%>
		</c:param>
		<c:param name="subDetail" value="chance">
		</c:param>
		<c:param name="subDetail2" value="nego">
		</c:param>
	</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업기회 &gt; 영업기회 작성</div>
		<!-- 내용 영역 -->
		<div class="content_title">영업기회 글쓰기</div>
		<div>
			<img src="resources/images/erp/crm/write.png" id="writeImg" style="cursor:pointer"/> <img
				src="resources/images/erp/crm/back.png" id="backImg" style="cursor:pointer"/>
		</div>
		<div class="crmInfo">
			<table border="1" cellspacing="0">
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
				<tbody>
					<tr>
						<td id="tdleft">영업기회명</td>
						<td id="tdright"><input type="text" width="500px"
							id="fulltext" /></td>

					</tr>
					<tr>
						<td id="tdleft">고객사</td>
						<td id="tdright"><input type="text" width="500px"
							id="middletext" />&nbsp<input type="button" id="btn" value="검색" /></td>
					</tr>
					<tr>
						<td id="tdleft">담당자(고객)</td>
						<td id="tdright"><input type="text" width="500px"
							id="middletext" />&nbsp<input type="button" id="btn" value="검색" /></td>
					</tr>
					<tr>
						<td id="tdleft">진행상태</td>
						<td id="tdright"><select id="select"><option>선택하세요</option>
								<option>진행중</option>
								<option>종료(성공)</option>
								<option>종료(실패)</option></select></td>
					</tr>
					<tr>
						<td id="tdleft">예상매출</td>
						<td id="tdright"><input type="text" width="500px"
							id="fulltext" /></td>
					</tr>
					<tr>
						<td id="tdleft">사업유형</td>
						<td id="tdright"><select id="select">
								<option>선택하세요</option>
								<option>민수사업</option>
								<option>관공사업</option>
						</select></td>
					</tr>
					<tr>
						<td id="tdleft">매출구분</td>
						<td id="tdright"><select id="select">
								<option>선택하세요</option>
								<option>SI파견</option>
								<option>솔루션 판매</option>
						</select></td>
					</tr>
					<tr>
						<td id="tdleft">매출구분상세</td>
						<td id="tdright"><select id="select">
								<option>선택하세요</option>
								<option>쳇봇 솔루션 판매</option>
								<option>클라우드 솔루션 판매</option>
						</select></td>
					</tr>
					<tr>
						<td id="tdleft">진행단계</td>
						<td id="tdright"><select id="select" disabled="disabled"><option>인지</option>
								<option>고객</option></select></td>
					</tr>
					<tr>
						<td id="tdleft">인지경로</td>
						<td id="tdright"><select id="select"><option>인터넷검색</option>
								<option>지인</option></select></td>
					</tr>
					<tr>
						<td id="tdleft">영업시작일</td>
						<td id="tdright"><input type="text" id="fulltext" /></td>
					</tr>
					<tr>
						<td id="tdleft">담당자(자사)</td>
						<td id="tdright"><input type="text" width="500px"
							id="middletext" />&nbsp<input type="button" id="btn" value="검색" /></td>
					</tr>
					<tr>
						<td id="tdleft">비고</td>
						<td id="tdright"><input type="text" width="500px"
							id="fulltext" /></td>
					</tr>
				</tbody>
			</table>
			<div id="upName">
				연관고객<img src="resources/images/erp/crm/plus.png" width="30px"
					height="30px" id="plusImg">
			</div>
			<div class="pluscustom">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="400">
						<col width="400">
						<col width="70">
					</colgroup>
					<tbody>
						<tr id="pluscrmTop">
							<td>고객사</td>
							<td>고객</td>
							<td>삭제</td>
						</tr>
						<tr id="pluscrmMiddle">
							<td>구디아카데미</td>
							<td>이영호</td>
							<td><input type="button" value="삭제"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>


</body>
</html>