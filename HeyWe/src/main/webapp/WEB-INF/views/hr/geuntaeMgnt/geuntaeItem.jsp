<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 근태항목</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/geuntaeMgnt/geuntaeItem.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#tableConDiv").slimScroll({
			width: "400px",
			height: "400px",
			axis: "both"
		}); 
		
		reloadGeuntae();
		
		//근태추가버튼
		$("#geuntae_add_btn").on("click", function(){
			$("#overlap_flag").val("0");
			
			var html = "";
			
			html += "<div class=\"info_top\">";
			html += "<div class=\"box\">";
			html += "<div class=\"table\">";
			html += "<div class=\"box_note\">근태명</div>";
			html += "<input type=\"text\" placeholder=\"입력\" id=\"geuntae_name\" name=\"geuntae_name\">";
			html += "</div>";
			html += "</div>";
			html += "<div class=\"box\">";
			html += "<div class=\"table\">";
			html += "<div class=\"box_note\">급여배율</div>";
			html += "<input type=\"text\" placeholder=\"입력\" id=\"sal_mgfn\" name=\"sal_mgfn\">";
			html += "</div>";
			html += "</div>";
			html += "<input type=\"button\" value=\"중복확인\" id=\"overlap_check_btn\"><br>";
			html += "</div>";
			html += "<div class=\"info_bottom\">";
			html += "<input type=\"button\" value=\"추가\" id=\"add_btn\">";
			html += "</div>";
			
			$(".data_box").html(html);
			
			$(".geuntae_category input[type='button']").removeClass("on");
			$(this).attr("class", "on");
			
			$("#geuntae_click_check").val("0");
			
			//급여배율에 숫자만 입력하도록
			$("#sal_mgfn").on("change", function() {
				if(isNaN($(this).val() * 1)) {
					makeAlert(1, "급여배율", "숫자를 입력하세요.", true, null);
					$(this).val("");
					$(this).focus();
				}
			});
			
			//중복확인버튼
			$("#overlap_check_btn").on("click", function(){
				if($.trim($("#geuntae_name").val()) == ''){
					makeAlert(1, "중복확인", "근태명을 입력해주세요.", true, null);
					
					$("#overlap_flag").val("0");
				}else if($.trim($("#sal_mgfn").val()) == ''){
					makeAlert(1, "중복확인", "급여배율을 입력해주세요.", true, null);
					
					$("#overlap_flag").val("0");
				}else {
					if($("#overlap_flag").val() == "0"){
						$("#formGeuntaeName").val($.trim($("#geuntae_name").val()));
						$("#formSalMgfn").val($.trim($("#sal_mgfn").val()));
						
						var params = $("#actionForm").serialize(); 
						$.ajax({
							type : "post",
							url : "HRGeuntaeOverlapCheckAjax",
							dataType : "json",
							data : params,
							success : function(result){
								if(result.cnt == 0){
									makeAlert(1, "중복확인", "사용가능합니다.", true, null);
									
									$("#overlap_flag").val("1");
								}else {
									makeAlert(1, "중복확인", "동일한 근태명이 존재합니다.", true, null);
									
								}
							},
							error : function(request, status, error){
								console.log("status : " + request.status);
								console.log("text : " + request.responseText);
								console.log("error : " + error);
							}
						});
					}else {
						makeAlert(1, "중복확인", "중복확인 되었습니다.", true, null);
					}
					
				}
			});
			
			//추가버튼
			$("#add_btn").on("click", function(){
				//중복확인체크여부
				if($("#overlap_flag").val() == "1"){
					//중복확인을 한다음에 부서명을 지우고 추가를 클릭했을때
					if($.trim($("#geuntae_name").val()) == ''){
						makeAlert(1, "추가", "근태명을 입력해주세요.", true, null);
						
						$("#overlap_flag").val("0");
					}else if($.trim($("#sal_mgfn").val()) == ''){
						makeAlert(1, "추가", "급여배율을 입력해주세요.", true, null);
						
						$("#overlap_flag").val("0");
					}else {
						makeConfirm(1, "추가", "추가하시겠습니까?", true, function(){
							var params = $("#actionForm").serialize();
							
							$.ajax({
								type : "post",
								url : "HRGeuntaeAddAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.errorCheck == 0){
										location.href = "HRGeuntaeItem";
									}else {
										makeAlert(2, "추가", "근태추가에 실패하였습니다.", true, null);
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
				}else {
					makeAlert(1, "추가", "중복확인을 해주세요.", true, null);
				}
					
				
			});
		});
		
		//근태수정버튼
		$("#geuntae_update_btn").on("click", function(){
			var html = "";
			
			html += "<input type=\"text\" disabled=\"disabled\" value=\"수정할 근태를 선택해주세요\" id=\"deleteTxt\">";
			
			$(".data_box").html(html);
			
			$(".geuntae_category input[type='button']").removeClass("on");
			$(this).attr("class", "on");
			
			$("#geuntae_click_check").val("1");
		});
		
		//근태삭제버튼
		$("#geuntae_delete_btn").on("click", function(){
			var html = "";
			
			html += "<input type=\"text\" disabled=\"disabled\" value=\"삭제할 근태를 선택해주세요\" id=\"deleteTxt\">";
			
			$(".data_box").html(html);
			
			$(".geuntae_category input[type='button']").removeClass("on");
			$(this).attr("class", "on");
			
			$("#geuntae_click_check").val("2");
		});
		
		$("tbody").on("click", "tr", function(){
			$("#formGeuntaeNo").val($(this).attr("name"));
			$("#temp_geuntae_name").val($(this).children(".geuntaeName").html());
			$("#temp_sal_mgfn").val($(this).children(".salMgfn").html());
			$("#geuntae_delete_flag").val("0");
			
			//근태수정
			if($("#geuntae_click_check").val() == "1"){
				var html = "";
				
				html += "<div class=\"info_top\">";
				html += "<div class=\"box\">";
				html += "<div class=\"table\">";
				html += "<div class=\"box_note\">근태명</div>";
				html += "<input type=\"text\" placeholder=\"입력\" id=\"geuntae_name\" name=\"geuntae_name\" value=\""+ $(this).children(".geuntaeName").html() +"\">";
				html += "</div>";
				html += "</div>";
				html += "<div class=\"box\">";
				html += "<div class=\"table\">";
				html += "<div class=\"box_note\">급여배율</div>";
				html += "<input type=\"text\" placeholder=\"입력\" id=\"sal_mgfn\" name=\"sal_mgfn\" value=\""+ $(this).children(".salMgfn").html() +"\">";
				html += "</div>";
				html += "</div>";
				html += "<input type=\"text\" size=\"30\" disabled=\"disabled\" id=\"geuntae_select_txt\" value=\"'"+ $(this).children(".geuntaeName").html() + "' 선택\" ><br>";
				html += "</div>";
				html += "<div class=\"info_bottom\">";
				html += "<input type=\"button\" value=\"수정\" id=\"update_btn\">";
				html += "</div>";
				
				$(".data_box").html(html);
				
				//급여배율에 숫자만 입력하도록
				$("#sal_mgfn").on("change", function() {
					if(isNaN($(this).val() * 1)) {
						makeAlert(1, "급여배율", "숫자를 입력하세요.", true, null);
						$(this).val("");
						$(this).focus();
					}
				});
				
				$("#update_btn").on("click", function(){
					if($.trim($("#geuntae_name").val()) == ''){
						makeAlert(1, "수정", "근태명을 입력해주세요.", true, null);
						
					}else if($.trim($("#sal_mgfn").val()) == ''){
						makeAlert(1, "수정", "급여배율을 입력해주세요.", true, null);
					}else {
						//기존 근태명과 동일한지 비교
						if($("#temp_geuntae_name").val() == $.trim($("#geuntae_name").val()) && $("#temp_sal_mgfn").val() == $.trim($("#sal_mgfn").val())){
							makeAlert(1, "수정", "기존과 동일합니다.", true, null);
						}else {
							makeConfirm(1, "수정", "수정하시겠습니까?", true, function(){
								
								$("#formGeuntaeName").val($.trim($("#geuntae_name").val()));
								$("#formSalMgfn").val($.trim($("#sal_mgfn").val()));
								
								var params = $("#actionForm").serialize();  
								
								$.ajax({
									type : "post",
									url : "HRGeuntaeUpdateAjax",
									dataType : "json",
									data : params,
									success : function(result){
										if(result.cnt == 0){
											if(result.updateResult == 0){
												makeAlert(2, "수정", "근태수정에 실패하였습니다.", true, null);
											} else {
												location.href = "HRGeuntaeItem";
											}
										} else {
											makeAlert(2, "수정", "동일한 근태명이 존재합니다.", true, null);
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
						
						
					}
				});
			}
			//근태삭제
			else if($("#geuntae_click_check").val() == "2"){
				
				var html = "";
				
				html += "<div class=\"info_top\">";
				html += "<input type=\"text\" disabled=\"disabled\" id=\"geuntae_select_txt\" value=\"'"+ $(this).children(".geuntaeName").html() + "' 선택\" ><br>";
				html += "<input type=\"button\" value=\"삭제가능여부\" id=\"delete_check_btn\"><br>";
				html += "</div>";
				html += "<div class=\"info_bottom\">";
				html += "<input type=\"button\" value=\"삭제\" id=\"delete_btn\">";
				html += "</div>";
				
				$(".data_box").html(html);
				
				$("#delete_check_btn").on("click", function(){
					if($("#geuntae_delete_flag").val() == "0"){
						var params = $("#actionForm").serialize();  
						
						$.ajax({
							type : "post",
							url : "HRGeuntaeDeleteCheckAjax",
							dataType : "json",
							data : params,
							success : function(result){
								//삭제가능
								if(result.cnt == 0){
									makeAlert(1, "삭제가능여부", "삭제할 수 있습니다", true, null);
									
									$("#geuntae_delete_flag").val("1");
								}else {
									makeAlert(1, "삭제가능여부", "사용중인 근태입니다.", true, null);
								}
							},
							error : function(request, status, error){
								console.log("status : " + request.status);
								console.log("text : " + request.responseText);
								console.log("error : " + error);
							}
						});
					}else {
						makeAlert(1, "삭제가능여부", "삭제할 수 있습니다.", true, null);
					}
					
				});
				
				$("#delete_btn").on("click", function(){
					if($("#geuntae_delete_flag").val() == "1"){
						makeConfirm(1, "삭제", "삭제하시겠습니까?", true, function(){
							
							var params = $("#actionForm").serialize();  
							
							$.ajax({
								type : "post",
								url : "HRGeuntaeDeleteAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.cnt == 0){
										makeAlert(2, "삭제", "삭제에 실패하였습니다.", true, null);
									}else {
										location.href = "HRGeuntaeItem";
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
						makeAlert(1, "삭제", "삭제가능여부를 확인해주세요.", true, null);
					}
				});
			}
		});
	});
	
	function reloadGeuntae(){
		$.ajax({
			type : "post",
			url : "HRGeuntaeMgntAjax",
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
			html += "<tr><td> - </td><td> - </td></tr>";
		} else {
			for(var i = 0 ; i < list.length ; i++){
				html += "<tr name=\"" + list[i].GEUNTAE_NO + "\">";
				html += "<td class=\"geuntaeName\">"+ list[i].GEUNTAE_NAME + "</td>";
				html += "<td class=\"salMgfn\">"+ list[i].SAL_MGFN + "</td>";
				html += "</tr>";
			}
		}
		
		$(".search_box #tableConDiv #tableCon tbody").html(html);
	}
</script>
</head>
<body>

<!-- 중복확인 -->
<input type="hidden" id="overlap_flag" value="0">
<!-- 삭제여부확인 -->
<input type="hidden" id="geuntae_delete_flag" value="0">
<input type="hidden" id="geuntae_click_check">
<input type="hidden" id="temp_geuntae_name">
<input type="hidden" id="temp_sal_mgfn">

<form action="#" id="actionForm" method="post">
	<input type="hidden" id="formGeuntaeName" name="formGeuntaeName">
	<input type="hidden" id="formSalMgfn" name="formSalMgfn">
	<input type="hidden" id="formGeuntaeNo" name="formGeuntaeNo">
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="68"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 근태관리 &gt; 근태항목</div>
	<!-- 내용 영역 -->
	<div class="content_title">
     	<div class="content_title_text">근태항목</div>
	</div>
	<div class="content_box">
		<div class="geuntae_category">
			<input type="button" value="근태추가" id="geuntae_add_btn">
			<input type="button" value="근태수정" id="geuntae_update_btn">
			<input type="button" value="근태삭제" id="geuntae_delete_btn">
		</div>
		<div class="search_box">
			<input type="text" value="조회" disabled="disabled">
			<table id="tableTop">
				<colgroup>
					<col width="150">
					<col width="150">
				</colgroup>
				<thead>
					<tr>
						<td>근태명</td>
						<td>급여배율</td>
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
		<div class="data_box">

		</div>
	</div>
</div>
</body>
</html>
