<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 부서관리</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/deptMgnt/deptMgnt.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#tableConDiv").slimScroll({
			width: "330px",
			height: "400px",
			axis: "both"
		}); 
		
		reloadDept();
		
		//부서추가버튼
		$("#depart_add_btn").on("click", function(){
			$("#flag").val("0");
			
			var html = "";
			
			html += "<div class=\"depart_info_top\">";
			html += "<div class=\"emp_box\">";
			html += "<div class=\"table\">";
			html += "<div class=\"emp_box_note\">부서명</div>";
			html += "<input type=\"text\" placeholder=\"입력\" id=\"deptName\" name=\"deptName\">";
			html += "</div>";
			html += "</div>";
			html += "<input type=\"button\" value=\"중복확인\" id=\"overlap_check_btn\"><br>";
			html += "</div>";
			html += "<div class=\"depart_info_bottom\">";
			html += "<input type=\"button\" value=\"추가\" id=\"add_btn\">";
			html += "</div>";
			
			$(".depart_info").html(html);
			
			$(".depart_category input[type='button']").removeClass("on");
			$(this).attr("class", "on");
			
			$("#dept_click_check").val("0");
			
			$("#deptName").on("change", function(){
				if($("#temp_dept_name").val() != $.trim($("#deptName").val())){
					$("#flag").val("0");
				}
			});
			
			//중복확인버튼
			$("#overlap_check_btn").on("click", function(){
				if($.trim($("#deptName").val()) == ''){
					makeAlert(1, "중복확인", "부서명을 입력해주세요.", true, null);
					
					$("#flag").val("0");
				}else {
					if($("#flag").val() == "0"){
						$("#temp_dept_name").val($.trim($("#deptName").val()));
						$("#formDeptName").val($.trim($("#deptName").val()));

						
						var params = $("#actionForm").serialize(); 
						$.ajax({
							type : "post",
							url : "HRDeptOverlapCheckAjax",
							dataType : "json",
							data : params,
							success : function(result){
								if(result.cnt == 0){
									makeAlert(1, "중복확인", "사용가능합니다.", true, null);
									
									$("#flag").val("1");
								}else {
									makeAlert(1, "중복확인", "동일한 부서명이 존재합니다.", true, null);
								}
							},
							error : function(request, status, error){
								console.log("status : " + request.status);
								console.log("text : " + request.responseText);
								console.log("error : " + error);
							}
						});
					}else {
						makeAlert(1, "중복확인", "중복확인이 되었습니다.", true, null);
					}
					
				}
			});
			
			$("#add_btn").on("click", function(){
				//중복확인체크여부
				if($("#flag").val() == "1"){
					//중복확인을 한다음에 부서명을 지우고 추가를 클릭했을때
					if($.trim($("#deptName").val()) == ''){
						makeAlert(1, "추가", "부서명을 입력해주세요.", true, null);
						
						$("#flag").val("0");
					}else {
						makeConfirm(1, "추가", "추가하시겠습니까?", true, function(){
							
							var params = $("#actionForm").serialize();
							
							$.ajax({
								type : "post",
								url : "HRDeptAddAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.errorCheck == 0){
										location.href = "HRDeptMgnt";
									} else {
										makeAlert(2, "추가", "부서추가에 실패하였습니다.", true, null);
									}
								},
								error : function(request, status, error){
									console.log("status : " + request.status);
									console.log("text : " + request.responseText);
									console.log("error : " + error);
								}
							});
							
						});
					}
				}else {
					makeAlert(1, "추가", "중복확인을 해주세요.", true, null);
				}
			});
		});
		
		//부서수정버튼
		$("#depart_update_btn").on("click", function(){
			$("#flag").val("0");
			
			var html = "";
			
			html += "<input type=\"text\" disabled=\"disabled\" value=\"수정할 부서를 선택해주세요\" id=\"deleteTxt\">";
			
			$(".depart_info").html(html);
			
			$(".depart_category input[type='button']").removeClass("on");
			$(this).attr("class", "on");
			
			$("#dept_click_check").val("1");
		});
		
		//부서삭제버튼
		$("#depart_delete_btn").on("click",function(){
			$("#flag").val("0");
			
			var html = "";
			
			html += "<input type=\"text\" disabled=\"disabled\" value=\"삭제할 부서를 선택해주세요\" id=\"deleteTxt\">";
			
			$(".depart_info").html(html);
			
			$(".depart_category input[type='button']").removeClass("on");
			$(this).attr("class", "on");
			
			$("#dept_click_check").val("2");
		});
		
		//부서선택
		$("tbody").on("click", "tr", function(){
			$("#formDeptNo").val($(this).attr("name"));
			$("#flag").val("0");
			
			//부서수정
			if($("#dept_click_check").val() == "1"){
				var html = "";
				
				html += "<div class=\"depart_info_top\">";
				html += "<div class=\"emp_box\">";
				html += "<div class=\"table\">";
				html += "<div class=\"emp_box_note\">부서명</div>";
				html += "<input type=\"text\" placeholder=\"입력\" id=\"deptName\" name=\"deptName\" value=\""+ $(this).children(".deptName").html() +"\" >";
				html += "</div>";
				html += "</div>";
				html += "<input type=\"text\" size=\"30\" disabled=\"disabled\" id=\"dept_select_txt\" value=\"'"+ $(this).children(".deptName").html() + "' 선택\" ><br>";
				html += "</div>";
				html += "<div class=\"depart_info_bottom\">";
				html += "<input type=\"button\" value=\"수정\" id=\"update_btn\">";
				html += "</div>";
				html += "</div>";
				
				$(".depart_info").html(html);
				
				$("#update_btn").on("click",function(){
					if($.trim($("#deptName").val()) == ''){
						makeAlert(1, "수정", "부서명을 입력해주세요.", true, null);
					}else{
						makeConfirm(1, "수정", "수정하시겠습니까?", true, function(){
							
							$("#formDeptName").val($.trim($("#deptName").val()));
							
							var params = $("#actionForm").serialize(); 
							$.ajax({
								type : "post",
								url : "HRDeptNameUpdateAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.cnt == 0){
										if(result.updateResult == 0){
											makeAlert(2, "수정", "부서수정에 실패하였습니다.", true, null);
										} else {
											location.href = "HRDeptMgnt";
										}
									} else {
										makeAlert(2, "수정", "동일한 부서명이 존재합니다.", true, null);
									}
								},
								error : function(request, status, error){
									console.log("status : " + request.status);
									console.log("text : " + request.responseText);
									console.log("error : " + error);
								}
							});
							
						})
						
					}
						
				});
				
			//부서 삭제
			}else if ($("#dept_click_check").val() == "2"){
				var html = "";
				
				html += "<div class=\"depart_info_top\">";
				html += "<input type=\"text\" disabled=\"disabled\" id=\"dept_select_txt\" value=\"'"+ $(this).children(".deptName").html() + "' 선택\" ><br>";
				html += "<input type=\"button\" value=\"삭제가능여부\" id=\"delete_check_btn\"><br>";
				html += "</div>";
				html += "<div class=\"depart_info_bottom\">";
				html += "<input type=\"button\" value=\"삭제\" id=\"delete_btn\">";
				html += "</div>";
				
				$(".depart_info").html(html);
				
				//삭제가능여부버튼
				$("#delete_check_btn").on("click", function(){
					var params = $("#actionForm").serialize();
					
					$.ajax({
						type : "post",
						url : "HRDeptDeleteCheckAjax",
						dataType : "json",
						data : params,
						success : function(result){
							if(result.cnt == 0){
								$("#flag").val("1");
								makeAlert(1, "삭제가능여부", "삭제할 수 있습니다.", true, null);
							}else{
								makeAlert(1, "삭제가능여부", "삭제할 수 없습니다.", true, null);
							}
						},
						error : function(request, status, error){
							console.log("status : " + request.status);
							console.log("text : " + request.responseText);
							console.log("error : " + error);
						}
					});
				});
				
				$("#delete_btn").on("click", function(){
					if($("#flag").val() == "1"){
						makeConfirm(1, "삭제", "삭제하시겠습니까?", true, function(){
							
							var params = $("#actionForm").serialize();
							
							$.ajax({
								type : "post",
								url : "HRDeptDeleteAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.deleteCnt == 0){
										makeAlert(2, "삭제", "부서삭제에 실패하였습니다.", true, null);
									}else{
										location.href = "HRDeptMgnt";
									}
								},
								error : function(request, status, error){
									console.log("status : " + request.status);
									console.log("text : " + request.responseText);
									console.log("error : " + error);
								}
							});
							
						})
						
					}else {
						makeAlert(1, "삭제", "삭제가능여부를 확인 해주세요.", true, null);
					}
				});
			}
		});
		
	});
	
	function reloadDept(){
		$.ajax({
			type : "post",
			url : "HRDeptMgntAjax",
			dataType : "json",
			success : function(result){
				redrawDept(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function redrawDept(list){
		var html = "";
		if(list.length == 0){
			html += "<tr><td> - </td></tr>";
		} else {
			for(var i = 0 ; i < list.length ; i++){
				html += "<tr name=\"" + list[i].DEPT_NO + "\">";
				html += "<td class=\"deptName\">"+ list[i].DEPT_NAME + "</td>";
				html += "</tr>";
			}
		}
		
		$(".depart_box #tableConDiv #tableCon tbody").html(html);
	}
</script>
</head>
<body>

<input type="hidden" id="temp_dept_name">
<input type="hidden" id="dept_click_check">
<!-- 중복확인, 삭제여부확인 여부 -->
<input type="hidden" id="flag" value="0">
<form action="#" id="actionForm" method="post">
	<input type="hidden" id="formDeptName" name="formDeptName">
	<input type="hidden" id="formDeptNo" name="formDeptNo">
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="63"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 부서관리</div>
	<div class="content_title">
     	<div class="content_title_text">부서관리</div>
	</div>
	<!-- 내용 영역 -->
	<div class="content_box">
		<div class="depart_category">
			<input type="button" value="부서추가" id="depart_add_btn">
			<input type="button" value="부서수정" id="depart_update_btn">
			<input type="button" value="부서삭제" id="depart_delete_btn">
		</div>
		<div class="depart_box">
			<input type="text" value="조회" disabled="disabled">
			<table id="tableTop">
				<colgroup>
					<col width="150">
				</colgroup>
				<thead>
					<tr>
						<td>부서명</td>
					</tr>
				</thead>
			</table>
			<div id="tableConDiv">
				<table id="tableCon">
					<colgroup>
						<col width="150">
						<col width="150">
					</colgroup>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="depart_info">
			
		</div>
	</div>
</div>
</body>
</html>