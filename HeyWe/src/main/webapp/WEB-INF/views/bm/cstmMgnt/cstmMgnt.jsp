<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>HeyWe - 거래처관리</title>
      <link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
      <link rel="stylesheet" type="text/css" href="resources/css/erp/bm/cstmMgnt/cstmMgntStyle.css" />
   
      	<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				
				if($("#page").val() == "") {
					$("#page").val("1");
				}
				
				reloadCstmMgntList();
				
				$("#searchBtn").on("click", function(){
					$("#page").val("1");
					reloadCstmMgntList()
				});
				
				// 페이징
				$("#pagingArea").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadCstmMgntList();
				});

				// 체크박스 작업
				
				$("tbody").on("click", "tr", function() {
					if($(this).children().eq(0).children().is(":checked")) {
						$(this).children().eq(0).children().prop("checked", false);
					} else {
						$(this).children().eq(0).children().prop("checked", true);
					}
					// 모든 tr의 checkbox가 체크되면
					// th의 checkbox도 체크
					var checkFlag = 0;
					
					$("#cstmMgntTable tbody input[type='checkbox']").each(function() {
						if(!$(this).is(":checked")) {
							checkFlag++;
						}
					});
					console.log(checkFlag);
					if(checkFlag == 0) {
						$("#check_all").prop("checked", true);
					} else {
						$("#check_all").prop("checked", false);
					}
				});
				
				$("tbody").on("click", "[type='checkbox']", function() {
					if($(this).is(":checked")) {
						$(this).prop("checked", false);
					} else {
						$(this).prop("checked", true);
					}

					if($("#check_all").is(":checked")) {
						$("#check_all").prop("checked", false);
					}
				});

					$("#check_all").on("click",function(){
					if($(this).is(":checked")){
						$("tbody input").prop("checked",true);
					} else{
						$("tbody input").prop("checked",false);
					}
					
				});
					
					// 신규등록 팝업
					$("#btn_newReg").on("click", function()	{
						makePopup(1, "거래처 신규등록", cstmNewRegPopup(), true, 350, 200, function(){
							// 사업자번호에 숫자만 입력하도록
							$("#bsnsNo").on("keyup", function(){
								var data = $(this).val();
									
								if(isNaN(data * 1)) {
									makeAlert(2	, "알림", "숫자만 입력해주세요", false, function() {
										$("#bsnsNo").val("");
										$("#bsnsNo").focus();
									});
								}
							});
						} , "등록", function(){
							
							if($.trim($("#cstmName").val()) == "") {
								makeAlert(2, "알림", "거래처명을 입력하세요", true, function(){
								$("#cstmName").focus();
								});
							} else if($.trim($("#bsnsNo").val()) == ""){
								makeAlert(2, "알림", "사업자번호를 입력하세요", true, function(){
									$("#bsnsNo").focus();
								});
							} else if($("#bsnsNo").val().length != 10){
								makeAlert(2, "알림", "사업자번호 10자리를 입력하세요", true, function(){
									$("#bsnsNo").focus();
								});
							} else {
								var params = $("#popupDataForm").serialize();
								
								$.ajax({
									type : "post",
									url : "BMCstmNewRegAjax",
									dataType : "json",
									data : params,
									success : function(result){
										makeAlert(2, "알림",result.msg, true, null);
										reloadCstmMgntList();
										closePopup(1);
									},
									error : function(request, status, error){
										console.log("status : " + request.status);
										console.log("text : " + request.responseText);
										console.log("error : " + error);
									}
								});	
							}
						});					
					});
					
					
					// 수정 버튼 클릭				
					$("#updateBtn").on("click", function()	{
						var checkFlag = 0;
						$("#cstmMgntTable tbody input[type='checkbox']:checked").each(function() {
							checkFlag++;
						});
						
						if(checkFlag == 1) {
							// 수정 makePopup
							makePopup(1, "거래처 수정", cstmUpdatePopup(), true, 350 , 200, function(){
								
								// 사업자번호에 숫자만 입력하도록
								$("#bsnsNo").on("keyup", function(){
									var data = $(this).val();
										
									if(isNaN(data * 1)) {
										makeAlert(2	, "알림", "숫자만 입력해주세요", false, function() {
											$("#bsnsNo").val("");
											$("#bsnsNo").focus();
										});
									}
								});
								
								// 체크박스가 선택된 거래처 정보 가져오기
								$("#sltedCstmNo").val($("#cstmMgntTable tbody input[type='checkbox']:checked").val());
								
								var params = $("#popupDataForm").serialize();
								
								$.ajax({
									type : "post",
									url : "BMSltedCstmInfoAjax",
									dataType : "json",
									data : params,
									success : function(result) {
										$("#cstmName").val(result.data.CSTM_NAME);
										$("#bsnsNo").val(result.data.BSNS_NO)
									},
									error : function(request, status, error) {
										console.log("status : ", request.status);
										console.log("text : ", request.responseText);
										console.log("error : ", error);
									}
								});
							} , "수정", function(){
							
								if($.trim($("#cstmName").val()) == "") {
									makeAlert(2, "알림","거래처명을 입력하세요", true, function(){
										$("#cstmName").focus();
									});
								} else if($.trim($("#bsnsNo").val()) == ""){
									makeAlert(2, "알림","사업자번호를 입력하세요", true, function(){
										$("#bsnsNo").focus();
									});
								} else if($("#bsnsNo").val().length != 10){
									makeAlert(2, "알림", "사업자번호 10자리를 입력하세요", true, function(){
										$("#bsnsNo").focus();
									});
								} else {
									var params = $("#popupDataForm").serialize();
									
									$.ajax({
										type : "post",
										url : "BMCstmUpdateAjax",
										dataType : "json",
										data : params,
										success : function(result){
											makeAlert(2, "알림",result.msg, true, null);
											reloadCstmMgntList();
											closePopup(1);
										},
										error : function(request, status, error){
											console.log("status : " + request.status);
											console.log("text : " + request.responseText);
											console.log("error : " + error);
										}
									});	
								}
							});	
						} else if(checkFlag == 0) {
							makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
						} else {
							makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
						}
					});	// 수정 버튼 클릭 (끝)
					
					
					
					// 삭제 버튼 클릭
					$("#delBtn").on("click", function() {
						var checkFlag = 0;
						$("#cstmMgntTable tbody input[type='checkbox']:checked").each(function() {
							checkFlag++;
						});
						
						if(checkFlag == 1){
							makeConfirm(1,"알림","삭제하시겠습니까?",true, function(){	
								$("#sltedDelCstmNo").val($("#cstmMgntTable tbody input[type='checkbox']:checked").val());	
											
											var params = $("#delDataForm").serialize();
											
											$.ajax({
												type : "post",
												url : "BMCstmDelAjax",
												dataType : "json",
												data : params,
												success : function(result){
													if(result.flag == 0){
														makeAlert(2, "오류", "삭제할 수 없는 항목입니다", true, null);
														reloadCstmMgntList();
													} else {
														//성공
														makeAlert(2, "완료", "삭제 되었습니다", true, null);
														reloadCstmMgntList();
													}
												},
												error : function(request, status, error){
													console.log("status : " + request.status);
													console.log("text : " + request.responseText);
													console.log("error : " + error);
												}
											});
										});
									} else if(checkFlag == 0) {
										makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
									} else {
										makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
									}
							});
			});
		
			
			/* 조회 작업 */
		

		<%-- 거래처리스트 가져오기 --%>
		function reloadCstmMgntList() {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post",
				url : "BMCstmMgntAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					redrawCstmMgntList(result.list);
					redrawPaging(result.pb);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
		
		function redrawCstmMgntList(list) {
			var html = "";
			
			if(list.length == 0) {
				html += "<td colspan=\"4\">조회할 수 있는 데이터가 없습니다</td>";
			} else {
				for(var i = 0; i < list.length; i++) {
					if(i%2 == 0) {
						html += "<tr class=\"top_tr\" name=\"" + list[i].CSTM_NO + "\">";
						html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
						+ list[i].CSTM_NO + "\" /></td>";
						html += "<td>" + list[i].CSTM_NAME + "</td>";
						html += "<td>" + list[i].BSNS_NO + "</td>";
						html += "</tr>";
					} else {
						html += "<tr class=\"bottom_tr\" name=\"" + list[i].CSTM_NO + "\">";
						html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
						+ list[i].CSTM_NO + "\" /></td>"; 
						html += "<td>" + list[i].CSTM_NAME + "</td>";
						html += "<td>" + list[i].BSNS_NO + "</td>";
						html += "</tr>";
					}
				}
			}
			
			$("#cstmMgntTable tbody").html(html);
		}
		
		<%-- 페이징 --%>
		function redrawPaging(pb) {
		      var html = "";
		      html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";
		      
		      if($("#page").val() == "1"){
		         html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
		      } else {
		         html += "<input type=\"button\" value=\"&lt\" name=\""
		         		 + ($("#page").val() * 1 - 1) + "\">";
		      }
		      
		      for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
		         if(i == $("#page").val()){
		            html += "<input type=\"button\" value=\"" + i + "\" name=\"" 
		            		+ i + "\" disabled=\"disabled\" class=\"paging_on\">";
		         } else {
		            html += "<input type=\"button\" value=\"" + i + "\" name=\""
		            		+ i +  "\" class=\"paging_off\">";
		         }
		      }
		      
		      if($("#page").val() == pb.maxPcount) {
		         html += "<input type=\"button\" value=\"&gt\" name=\"" 
		         		 + pb.maxPcount +  "\">"; 
		      }else {
		         html += "<input type=\"button\" value=\"&gt\" name=\""
		         		 + ($("#page").val() * 1 + 1) +   "\">";
		      }
		      
		      html += "<input type=\"button\" value=\"&gt&gt\" name=\""
		      		  + pb.maxPcount +  "\">";
		      
		      $("#pagingArea").html(html);
		   }
		
		// 신규등록 팝업 내용
		function cstmNewRegPopup() {
			var html = "";
			
			html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
			
			html += "<div class=\"regPage_contents_title\">거래처명(*)</div>";
			html += "<div class=\"regPage_contents_input\">";
			html += "<input type=\"text\" class=\"txt\" id=\"cstmName\" name=\"cstmName\"/>";
			html += "</div>";
			html += "<br/>";
			html += "<div class=\"regPage_contents_title\">사업자번호(*)</div>";
			html += "<div class=\"regPage_contents_input\">";
			html += "<input type=\"text\" maxlength=\"10\" placeholder=\"\' - \'없이 입력하시오.\" class=\"txt\" id=\"bsnsNo\" name=\"bsnsNo\"/>";
			html += "</div>";
			html += "</form>";
			return html;
		}
		
		// 수정 팝업 내용
		function cstmUpdatePopup() {
			var html = "";
			
			html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
			html += "<input type=\"hidden\" id=\"sltedCstmNo\" name=\"sltedCstmNo\" value=\"\" />";
			html += "<div class=\"regPage_contents_title\">거래처명(*)</div>";
			html += "<div class=\"regPage_contents_input\">";
			html += "<input type=\"text\" class=\"txt\" id=\"cstmName\" name=\"cstmName\"/>";
			html += "</div>";
			html += "<div class=\"regPage_contents_title\">사업자번호(*)</div>";
			html += "<div class=\"regPage_contents_input\">";
			html += "<input type=\"text\" maxlength=\"10\" placeholder=\"\' - \'없이 입력하시오.\" class=\"txt\" id=\"bsnsNo\" name=\"bsnsNo\"/>";
			html += "<br/>";
			html += "</form>";
			return html;
		}
			
			
		</script>
   </head>
   
   
   <body>
   
   		<form action="#" method="post" id="delDataForm">
			<input type="hidden" id="sltedDelCstmNo" name="sltedDelCstmNo" value="" />
		</form>
		
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>
      
      <!-- 내용 영역 -->
      <div class="content_area">
         <!-- 메뉴 네비게이션 -->
         <div class="content_nav">HeyWe &gt; 경영관리 &gt; 거래처관리</div>
         <!-- 현재 메뉴 제목 -->
         <div class="content_title">거래처관리</div>
         <br/>

         <!-- 내용 영역 -->
         
         <form action="#" id="actionForm" method="post">
         <div class="data_search_area">
            
            <div class="data_search_menu">거래처</div>
            <div class="data_search_input">
               <input type="text" class="txt" name="cstm"/>
               <input type="hidden" id="page" name="page" >
            </div>
            <div class="data_search_icon"></div>
            
            <div class="data_search_menu">사업자번호</div>
            <div class="data_search_icon"></div>
            <div class="data_search_input">
               <input type="text" class="txt" name="bsnsNo"/>
            </div>
            <div class="data_search_icon"></div>
            
            <div class="data_search_btn">
               <input type="button" value="검색" class="searchBtn" id="searchBtn"/>
            </div>
            
            
            
         </div>
         </form>
         
         <br/>
         
         <div class="data_info_area">
            
            <table class="data_info_table" id="cstmMgntTable">
               <colgroup>
                  <col width="50"/>
                  <col width="300"/>
                  <col width="300"/>
               </colgroup>
               <thead>
               <tr class="first_tr">
                  <td><input type="checkbox" id="check_all"/></td>
                  <th>거래처명</th>
                  <th>사업자번호</th>
               </tr>
               </thead>
               
               <tbody>
               
               
               </tbody>
            
            </table>
            
            <div class="pagingArea" id="pagingArea"></div>
            
         </div>
         <br/>
         <div class="data_btn_area">
            <div class="left_btn_area">
               <div class="btn_area"><input type="button" value="삭제" class="btn" id="delBtn"/></div>
               <div class="btn_area"><input type="button" value="수정" class="btn" id="updateBtn"/></div>
            </div>
            <div class="right_btn_area">
               <div class="btn_area"><input type="button" value="신규등록" class="btn" id="btn_newReg"/></div>
            </div>
         </div>
      </div>
   </body>
</html>