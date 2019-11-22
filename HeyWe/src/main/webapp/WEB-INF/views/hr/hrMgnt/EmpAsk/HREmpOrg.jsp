<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - Contents</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/EmpAsk/HREmpOrg.css" />

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
	<c:param name="lMenu" value="gw"></c:param>
</c:import>

<div class="left_area">
	<div class="left_large_menu">인사</div>
	
  <!-- 왼쪽 소메뉴 -->
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
                  <div class="left_sub_detail_sub_menu_txt">조회</div>
                  <div class="left_sub_detail_sub_menu_txt_on">조직도</div>
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
      </div>
   </div>
   
   <!-- 왼쪽 소메뉴 -->
  <div class="left_menu_wrap">
      <div class="left_sub_menu">
         <div class="left_sub_menu_txt">근태관리</div>
         <div class="left_sub_detail_menu_wrap">
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">- 근태 항목</div>
            </div>
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">- 근태 현황</div>
               
            </div>
            <div class="left_sub_detail_menu">
               <div class="left_sub_detail_menu_txt">- 근태 현황(admin)</div>
           
            </div>
            <div class="left_sub_detail_menu_on">
               <div class="left_sub_detail_menu_txt">- 추가근무 등록</div>
            </div>
            
         </div>
      </div>

   <!-- 왼쪽 소메뉴 -->
   <div class="left_menu_wrap">
      <div class="left_sub_menu">
         <div class="left_sub_menu_txt">증명서관리</div>
      </div>
   </div>
	</div>	
</div>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 자산 &gt; 교육관리 &gt; 교육 관리 현황</div>
	<!-- 내용 영역 -->
	 <div class="content_title">
      
      <div class="content_title_text">조직도 </div>
   </div>
   <br/>
   <br/>
<div class = "content">
<div class="a1"><input type="button" class = "button" value="-">
	<input class="office" type="text" value="HeyWe" disabled="disabled"></input></div>
	<div class="a2">
			<input type="button" class = "button" value="+">
			<input class="office" type="text" value="대표이사" disabled="disabled"></input></div>
	<div class="a2">
			<input type="button" class = "button" value="+">
			<input class="office" type="text" value="총괄임원" disabled="disabled"></input></div>
	<div class="a2">
			<input type="button" class = "button" value="-">
			<input class="office" type="text" value="기획부" disabled="disabled"></input></div>

		<div class="a3">
				<input type="button" class = "button" value="*" >
				<input class="office" type="text" value="기획부장:오수현" disabled="disabled"></input></div>
		<div class="a3">
				<input type="button" class = "button" value="-">
				<input class="office" type="text" value="기획팀 A" disabled="disabled"></input></div>
			<div class="a4">
				<input type="button" class = "button" value="*">
				<input class="office" type="text" value="기획팀장:김기연" disabled="disabled"></input></div>
			
			<div class="a4">
				<input type="button" class = "button" value="*">
				<input class="office" type="text" value="사원:김기현" disabled="disabled"></input></div>
			
			<div class="a4">
				<input type="button" class = "button" value="*">
				<input class="office" type="text" value="사원:킹기연" disabled="disabled"></input></div>
		<div class="a3">
				<input type="button" class = "button" value="+">
				<input class="office" type="text" value="기획팀 B" disabled="disabled"></input></div>
	<div class="a2">
			<input type="button" class = "button" value="+">
			<input class="office" type="text" value="인사부" disabled="disabled"></input></div>
			<div class="a2">
			<input type="button" class = "button" value="+">
			<input class="office" type="text" value="경리부" disabled="disabled"></input></div>
			<div class="a2">
			<input type="button" class = "button" value="+">
			<input class="office" type="text" value="경영관리부" disabled="disabled"></input></div>
			<div class="a2">
			<input type="button" class = "button" value="+">
			<input class="office" type="text" value="CRM" disabled="disabled"></input></div>
</div>
</div>
</body>
</html>