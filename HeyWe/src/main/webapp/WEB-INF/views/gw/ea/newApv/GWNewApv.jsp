<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재문서 양식선택</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvDocTypeSelectPopup.css" />

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script> <!-- 메뉴에 필요함 -->
<script type="text/javascript">
$(document).ready(function() {
	var html = "";
	html += "<div class=\"select_cdType_searchOutput\">"
    html += 	"<div class=\"select_cdType_searchBar\">"
    html +=			"<div class=\"searching\">"
    html += 			"<img alt=\"search\" src=\"resources/images/erp/gw/ea/search.png\" />"
    html +=			"</div>"
    html += 		"<input type=\"text\" placeholder=\"양식명\" id=\"txt\" name=\"txt\" />"
    html +=			"<input type=\"button\" value=\"검색\" id=\"searchBtn\" />"	
    html += 		"<img alt=\"reset\" src=\"resources/images/erp/gw/ea/reset.png\" />"
    html +=		"</div>"
    html +=		"<div class=\"select_cdType_searchList\" id=\"apvTypeListArea\" >"
    html +=	 	"</div>"
    html +=	"</div>";
	
	makePopup(1, "결재 양식 선택", html, true, 300, 460,
				function() {
					$(document).on("click","#popup1Bg, img[alt='exit'], #popup1BtnLeft", function() {
						location.href = "GWApvProgressDoc";
					});
		
					reloadApvTypeList();
					
					$(document).on("click", ".apvTypeDiv", function() {
						var b;
						var sr;
						if($(this).closest("div").find("div").attr("hidden") == "hidden"){
							b = false;
							sr = "resources/images/erp/gw/ea/folder.png"
						} else {
							b = true;
							sr = "resources/images/erp/gw/ea/folderOff.png"
						}
						
						$(this).find("img").attr("src", sr); 
						$(this).closest("div").find("div").attr("hidden", b); 
																					//this는 span이고 div가 감싸고 있음
					});																//closest : 가장 가까운 상위 요소
																					//find : 모든 하위요소
					//검색 버튼
					$(document).on("click", "#searchBtn", function() {
						$("#searchTxt").val($("#txt").val());
						$("#selectedDocType").val("");
						reloadApvTypeList();
					});
					$("#txt").on("keypress", function() {
						if(event.which == "13"){
							$("#searchBtn").click();
						}
					});
					
					//초기화
					$("[alt='reset']").on("click", function() {
						$("#selectedDocType").val("");
						$("#txt").val("");
						$("#searchBtn").click();
					});
					
					//양식 선택
					$(document).on("click", ".apvDocType", function() {
						$("#selectedDocType").val($(this).attr("name"));
						$(".apvDocType").each(function() {
							if($(this).attr("name") == $("#selectedDocType").val()){
								$(this).css("background-color","#8DA9C4");
								$(this).css("color","white");
								$(this).attr("check", "yes");
							} else {
								$(this).css("background-color","");	
								$(this).css("color","#134074");
								$(this).attr("check", "no");
							}
						});
					});
				}
			   , "확인", 
				function() {
					if($.trim($("#selectedDocType").val()) == ""){
						makeAlert(2, "확인", "선택된 양식이 없습니다.", false, null)
					} else {
						$("#actionForm").submit();
					}				   
				}
			);
});

function reloadApvTypeList() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type: "post",
		url: "GWapvTypeListAjax",
		dataType: "json",
		data: params,
		success: function(result) {
			redrawApvTypeList(result.apvTypeDivList, result.apvDocTypeList);
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
}

function redrawApvTypeList(apvTypeDivList, apvDocTypeList) {
	var html = "";
	var cnt = 0;
	
	for(var i = 0; i < apvTypeDivList.length; i++){
		html += "<div><span class=\"apvTypeDiv\" name=\"" + apvTypeDivList[i].APV_TYPE_DIV_NO + "\">"
				+ "<img alt=\"folder\" src=\"resources/images/erp/gw/ea/folder.png\">"
			    + apvTypeDivList[i].APV_TYPE_DIV_NAME + "</span>"; 
		
		for(var j = cnt; j < apvDocTypeList.length; j++){
			if(apvTypeDivList[i].APV_TYPE_DIV_NO == apvDocTypeList[j].APV_TYPE_DIV_NO){
				html += "<div>&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "<span class=\"apvDocType\" name=\"" + apvDocTypeList[j].APV_DOC_TYPE_NO + "\" check=\"no\">"
						+ "<img alt=\"doc\" src=\"resources/images/erp/gw/ea/doc.png\">"
						+ "<span>" + apvDocTypeList[j].APV_DOC_TYPE_NAME + "</span></span></div>";
				cnt++;
			}
		}
		
		html += "</div>";
	}
	
	$("#apvTypeListArea").html(html);
}
</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="2"></c:param>
		<c:param name="leftMenuNo" value="4"></c:param>
	</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 전자결재 &gt; 새 결재 진행</div>
	</div>
	<form action="#" id="dataForm" method="post">
		<input type="hidden" id="searchTxt" name="searchTxt" >
	</form>
	<form action="GWNewApvWrite" id="actionForm" method="post">
		<input type="hidden" id="selectedDocType" name="selectedDocType" >
	</form>
</body>
</html>