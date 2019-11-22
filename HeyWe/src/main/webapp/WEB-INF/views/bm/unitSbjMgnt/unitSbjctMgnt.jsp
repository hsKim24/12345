<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>HeyWe - 계정과목 관리</title>
      <link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
      <link rel="stylesheet" type="text/css" href="resources/css/erp/bm/unitSbjMgnt/unitSbjctMgntStyle.css" />
   
      	<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				
				if($("#page").val() == "") {
					$("#page").val("1");
				}
				
				reloadUnitSbjctMgntList();
				
				$("#searchBtn").on("click", function(){
					$("#page").val("1");
					reloadUnitSbjctMgntList()
				});
				
				// 페이징
				$("#pagingArea").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadUnitSbjctMgntList();
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
					
					$("#unitSbjctMgntTable tbody input[type='checkbox']").each(function() {
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
						makePopup(1, "계정과목 신규등록", unitSbjctNewRegPopup(), true, 350, 150, null , "등록", function(){
							
							if($.trim($("#unitSbjctName").val()) == "") {
								makeAlert(2, "알림", "계정과목명을 입력하세요", true, function(){
								$("#unitSbjctName").focus();
								});
							} else {
								var params = $("#popupDataForm").serialize();
								
								$.ajax({
									type : "post",
									url : "BMUnitSbjctNewRegAjax",
									dataType : "json",
									data : params,
									success : function(result){
										makeAlert(2, "알림",result.msg, true, null);
										reloadUnitSbjctMgntList();
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
						$("#unitSbjctMgntTable tbody input[type='checkbox']:checked").each(function() {
							checkFlag++;
						});
						
						if(checkFlag == 1) {
							// 수정 makePopup
							makePopup(1, "계정과목 수정", unitSbjctUpdatePopup(), true, 350 , 150, function(){
								
								// 체크박스가 선택된 계정과목 정보 가져오기
								$("#sltedUnitSbjctNo").val($("#unitSbjctMgntTable tbody input[type='checkbox']:checked").val());
								
								var params = $("#popupDataForm").serialize();
								
								$.ajax({
									type : "post",
									url : "BMSltedUnitSbjctInfoAjax",
									dataType : "json",
									data : params,
									success : function(result) {
										$("#unitSbjctName").val(result.data.UNIT_SBJ_NAME);
									},
									error : function(request, status, error) {
										console.log("status : ", request.status);
										console.log("text : ", request.responseText);
										console.log("error : ", error);
									}
								});
							} , "수정", function(){
							
								if($.trim($("#unitSbjctName").val()) == "") {
									makeAlert(1, "알림","계정과목명을 입력하세요", true, null);
									$("#unitSbjctName").focus();
								} else {
									var params = $("#popupDataForm").serialize();
									
									$.ajax({
										type : "post",
										url : "BMUnitSbjctUpdateAjax",
										dataType : "json",
										data : params,
										success : function(result){
											makeAlert(2, "알림",result.msg, true, null);
											reloadUnitSbjctMgntList();
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
						$("#unitSbjctMgntTable tbody input[type='checkbox']:checked").each(function() {
							checkFlag++;
						});
						
						if(checkFlag == 1){
							makeConfirm(1,"알림","삭제하시겠습니까?",true, function(){	
								$("#sltedDelUnitSbjctNo").val($("#unitSbjctMgntTable tbody input[type='checkbox']:checked").val());	
											
											var params = $("#delDataForm").serialize();
											
											$.ajax({
												type : "post",
												url : "BMUnitSbjctDelAjax",
												dataType : "json",
												data : params,
												success : function(result){
													if(result.flag == 0){
														makeAlert(2, "오류", "삭제할 수 없는 항목입니다", true, null);
														reloadUnitSbjctMgntList();
													} else {
														//성공
														makeAlert(2, "완료", "삭제 되었습니다", true, null);
														reloadUnitSbjctMgntList();
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
		

		<%-- 계정과목리스트 가져오기 --%>
		function reloadUnitSbjctMgntList() {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post",
				url : "BMUnitSbjctMgntAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					redrawUnitSbjctMgntList(result.list);
					redrawPaging(result.pb);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
		
		function redrawUnitSbjctMgntList(list) {
			var html = "";
			
			if(list.length == 0) {
				html += "<td colspan=\"2\">조회할 수 있는 데이터가 없습니다</td>";
			} else {
				for(var i = 0; i < list.length; i++) {
					if(i%2 == 0) {
						html += "<tr class=\"top_tr\" name=\"" + list[i].UNIT_SBJ_NO + "\">";
						html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
						+ list[i].UNIT_SBJ_NO + "\" /></td>";
						html += "<td>" + list[i].UNIT_SBJ_NAME + "</td>";
						html += "</tr>";
					} else {
						html += "<tr class=\"bottom_tr\" name=\"" + list[i].UNIT_SBJ_NO + "\">";
						html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
						+ list[i].UNIT_SBJ_NO + "\" /></td>"; 
						html += "<td>" + list[i].UNIT_SBJ_NAME + "</td>";
						html += "</tr>";
					}
				}
			}
			
			$("#unitSbjctMgntTable tbody").html(html);
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
		function unitSbjctNewRegPopup() {
			var html = "";
			
			html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
			
			html += "<div class=\"regPage_contents_title\">계정과목명(*)</div>";
			html += "<div class=\"regPage_contents_input\">";
			html += "<input type=\"text\" class=\"txt\" id=\"unitSbjctName\" name=\"unitSbjctName\"/>";
			html += "</div>";
			html += "<br/>";
			html += "</form>";
			return html;
		}
		
		// 수정 팝업 내용
		function unitSbjctUpdatePopup() {
			var html = "";
			
			html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
			html += "<input type=\"hidden\" id=\"sltedUnitSbjctNo\" name=\"sltedUnitSbjctNo\" value=\"\" />";
			html += "<div class=\"regPage_contents_title\">계정과목명(*)</div>";
			html += "<div class=\"regPage_contents_input\">";
			html += "<input type=\"text\" class=\"txt\" id=\"unitSbjctName\" name=\"unitSbjctName\"/>";
			html += "</div>";
			html += "<br/>";
			html += "</form>";
			return html;
		}
			
			
		</script>
   </head>
   
   
   <body>
   
   		<form action="#" method="post" id="delDataForm">
			<input type="hidden" id="sltedDelUnitSbjctNo" name="sltedDelUnitSbjctNo" value="" />
		</form>
		
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>	 
      
      <!-- 내용 영역 -->
      <div class="content_area">
         <!-- 메뉴 네비게이션 -->
         <div class="content_nav">HeyWe &gt; 경영관리 &gt; 계정과목관리</div>
         <!-- 현재 메뉴 제목 -->
         <div class="content_title">계정과목관리</div>
         <br/>

         <!-- 내용 영역 -->
         
         <form action="#" id="actionForm" method="post">
         <div class="data_search_area">
            
            <div class="data_search_menu">계정과목</div>
            <div class="data_search_input">
               <input type="text" class="txt" name="unitSbjct"/>
               <input type="hidden" id="page" name="page" >
            </div>
            <div class="data_search_icon"></div>
            <div class="data_search_btn">
               <input type="button" value="검색" class="searchBtn" id="searchBtn"/>
            </div>
         </div>
         </form>
         
         <br/>
         
         <div class="data_info_area">
            
            <table class="data_info_table" id="unitSbjctMgntTable">
               <colgroup>
                  <col width="50"/>
                  <col width="300"/>
                  <col width="300"/>
               </colgroup>
               <thead>
               <tr class="first_tr">
                  <td><input type="checkbox" id="check_all"/></td>
                  <th>계정과목명</th>
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