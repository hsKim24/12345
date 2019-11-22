<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - Contents</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/EmpAsk/HREmpAsk2.css" />
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
<c:import url="/top"> <%-- top이란 주소를 넣어 보여주는 것. --%>
	<c:param name="lMenu" value="hr"></c:param>
</c:import>

<div class="left_area">
	<div class="left_large_menu">인사</div>
	
	<!-- 왼쪽 소메뉴 -->
	 <div class="left_menu_wrap">
      <div class="left_sub_menu_on">
         <div class="left_sub_menu_txt">인사관리</div>
         <div class="left_sub_detail_menu_wrap">
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">인사기록카드</div>
            </div>
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">인사발령</div>
               <div class="left_sub_detail_sub_menu_wrap">
                  <div class="left_sub_detail_sub_menu_txt_on">기록조회</div>
                  <div class="left_sub_detail_sub_menu_txt">등록 (관리자)</div>
                  <div class="left_sub_detail_sub_menu_txt">결재상태</div>
               </div>
            </div>
            <div class="left_sub_detail_menu_on">
               <div class="left_sub_detail_menu_txt">사원조회</div>
                <div class="left_sub_detail_sub_menu_wrap">
                  <div class="left_sub_detail_sub_menu_txt_on">조회</div>
                  <div class="left_sub_detail_sub_menu_txt">조직도</div>
            </div>
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">휴가관리</div>
            </div>
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">부서관리 (관리자)</div>
            </div>
         </div>
      </div>
   </div>
	</div>
	
	<!-- 왼쪽 소메뉴 -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu">
			<div class="left_sub_menu_txt">급여관리</div>
			<div class="left_sub_detail_menu">
				<div class="left_sub_detail_menu_txt_on">- 교육 관리 현황</div>
				<div class="left_sub_detail_menu_txt">- 종료 교육 관리</div>
			</div>
		</div>
	</div>
	
	<!-- 왼쪽 소메뉴 -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu">
			<div class="left_sub_menu_txt">근태 관리</div>
			<div class="left_sub_detail_menu">
				<div class="left_sub_detail_menu_txt_on">- 교육 관리 현황</div>
				<div class="left_sub_detail_menu_txt">- 종료 교육 관리</div>
			</div>
		</div>
	</div>
	
	<!-- 왼쪽 소메뉴 -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu">
			<div class="left_sub_menu_txt">증명서 관리</div>
			<div class="left_sub_detail_menu">
				<div class="left_sub_detail_menu_txt_on">- 교육 관리 현황</div>
				<div class="left_sub_detail_menu_txt">- 종료 교육 관리</div>
			</div>
		</div>
	</div>	
</div>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 자산 &gt; 교육관리 &gt; 교육 관리 현황</div>
	<!-- 내용 영역 -->
	 <div class="content_title">
  
      <div class="content_title_text">인사 관리</div>
   </div>
   <br/>
   <br/>
<div class = "content">
	<select class= "mr">
		<option disabled="disabled"> 부서명 </option>
		<option selected="selected">기획부</option>
		<option>인사부</option>
		<option>개발부</option>
		<option>경영관리부</option>
		<option>CRM</option>
	</select>
	<select class= "job_name">
		<option selected="selected" disabled="disabled"> 직위명 </option>
		<option>부장</option>
		<option>팀장</option>
		<option>대리</option>
		<option>사원</option>
	</select>
	
	<input class="입사년도" type="text" placeholder="입사 년도"></input>
	<div class="사원명">
		<input class="사원이름" type="text" placeholder="사원 이름"></input>
	</div>
	<img class= "돋보기" alt="" src="resources/images/erp/common/d.png" ></img>
</div>
	<!-- 아래 내용 영역 -->
	<div class="content_down">
			<table class="table" border="1"  cellspacing ="0">
			<colgroup>
				<col style="width: 220px;"/>
				<col style="width: 220px;"/>
				<col style="width: 220px;"/>
				<col style="width: 220px;"/>
				<col style="width: 220px;"/>
			</colgroup>
			<thead></thead>
			<tbody>
			<tr class= "title" >
			<th>부서명</th>
			<th>직위</th>
			<th>입사일</th>
			<th>사원코드</th>
			<th>사원명</th>
			</tr>
			<tr class="title_content">
			<th>기획 부서</th>
			<th>기획부장</th>
			<th>2019.04.02</th>
			<th>19040201</th>
			<th>김기연</th>
			</tr>
			<tr class="title_content_color">
			<th>기획 부서</th>
			<th>팀장</th>
			<th>2019.04.10</th>
			<th>19041011</th>
			<th>김수찬</th>
			</tr>
			<tr class="title_content">
			<th>기획 부서</th>
			<th>팀장</th>
			<th>2019.04.03</th>
			<th>19040311</th>
			<th>강호빈</th>
			</tr>
			<tr class="title_content_color">
			<th>기획 부서</th>
			<th>대리</th>
			<th>2019.04.17</th>
			<th>19041711</th>
			<th>오수현</th>
			</tr>
			<tr class="title_content">
			<th>기획 부서</th>
			<th>대리</th>
			<th>2019.04.09</th>
			<th>19040911</th>
			<th>김수판</th>
			</tr>
			<tr class="title_content_color">
			<th>기획 부서</th>
			<th>대리</th>
			<th>2019.04.11</th>
			<th>19041111</th>
			<th>강리마</th>
			</tr>
			<tr class="title_content">
			<th>기획 부서</th>
			<th>사원</th>
			<th>2019.04.12</th>
			<th>19041211</th>
			<th>박그리</th>
			</tr>
			<tr class="title_content_color">
			<th>기획 부서</th>
			<th>사원</th>
			<th>2019.04.01</th>
			<th>19040111</th>
			<th>장기현</th>
			</tr>
			<tr class="title_content">
			<th>기획 부서</th>
			<th>사원</th>
			<th>2019.04.02</th>
			<th>19040211</th>
			<th>진현익</th>
			</tr>
			<tr class="title_content_color">
			<th>기획 부서</th>
			<th>사원</th>
			<th>2019.04.18</th>
			<th>19041811</th>
			<th>이영호</th>
		</tbody>
		</table>
			<div class="paging_group">
	         <div>&lt;</div>
	         <div class="paging_on">1</div>
	         <div class="paging_off">2</div>
	         <div class="paging_off">3</div>
	         <div class="paging_off">4</div>
	         <div>&gt;</div>
	      </div>
	 </div>
</div>
</body>
</html>