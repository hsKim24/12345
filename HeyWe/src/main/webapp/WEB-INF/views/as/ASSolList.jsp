<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>솔루션 현황</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/as/Solution_HS.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	/* 솔루션등록 버튼 (팝업 생성) */
	$("#registerBtn").on("click", function() {
		if("${sAuthNo}"==7){
		
		var html = "";
		html += "<div class=\"input_area\">";
		html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
		html += "<div class=\"input_area_line\">";
		html += "<div class=\"input_area_txt1\">보유 솔루션</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"solNm\" name=\"solNm\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_line\">"
		html += "<div class=\"input_area_txt1\">최소 작업 인원</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"solPp\" name=\"solPp\" placeholder=\"숫자값만 입력해주세요\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_line\">";
		html += "<div class=\"input_area_txt1\">단 가 (만 원)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\"  id =\"solCost\" name=\"solCost\" placeholder=\"숫자값만 입력해주세요\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_line\">";
		html += "<div class=\"input_area_txt1\">월 유지보수비(만 원)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\"/ id =\"solMcost\" name=\"solMcost\" /></div>";
		html += "</div>";   
		
		html += "<div id = \"fake_file_area\">";
		html += "<div class=\"input_area_line\">";
		html += "<div class=\"input_area_txt1\">매뉴얼</div>";
		html += "<div class=\"input_area_txt3\"><input type=\"text\" placeholder=\"파일을 추가하세요\" size=\"20\" readonly=\"readonly\" id=\"fileName1\" /><input type=\"hidden\" id=\"solMn\" name=\"solMn\" /></div>";
		
		html += "<div class=\"input_area_line_button\">";
		html += "<div class=\"btn\"><input type=\"button\" value=\"파일찾기\" id=\"fileBtn1\" /></div>";
		html += "</div>";
		html += "</div>";
		html += "<div class=\"input_area_line\">"
		html += "<div class=\"input_area_txt1\">브로슈어</div>";
		html += "<div class=\"input_area_txt3\"><input type=\"text\" placeholder=\"파일을 추가하세요\" size=\"20\" readonly=\"readonly\" id=\"fileName2\" /><input type=\"hidden\" id=\"solBro\" name=\"solBro\" /></div>";
		html += "</form>";	
		html += "<div class=\"input_area_line_button\">"
		html += "<div class=\"btn\"><input type=\"button\" value=\"파일찾기\" id=\"fileBtn2\" /></div>";
		html += "</div>";
		html += "</div>";
		html += "</div>";
		
		html += "<div class=\"real_file_area\">";
		html += "<form action = \"fileUploadAjax\" method=\"post\"  id=\"uploadForm\" enctype=\"multipart/form-data\"  >";
		html += "<input type=\"file\" name=\"attFile1\" id=\"attFile1\"><br/>";
		html += "<input type=\"file\" name=\"attFile2\" id=\"attFile2\"><br/>";
		html += "</form>";
		html += "</div>";
		
		html += "</div>";	
		html += "<div id=\"finish\"></div>";
		
		makePopup(1, "솔루션 등록", html, true, 600, 460,
				function() {
			// 컨텐츠 이벤트
			   $("#solPp").bind("keyup", function(event) {
                var regNumber = /^[0-9]*$/;
                var temp = $("#solPp").val();
                if(!regNumber.test(temp))
                {
                    makeAlert(2, "", "숫자만 입력하세요", null, null);
                    $("#solPp").val(temp.replace(/[^0-9]/g,""));
                    $("#solPp").focus();
                }
            });
			
			   $("#solCost").bind("keyup", function(event) {
                var regNumber = /^[0-9]*$/;
                var temp = $("#solCost").val();
                if(!regNumber.test(temp))
                {
                    makeAlert(2, "", "숫자만 입력하세요", null, null);
                    $("#solCost").val(temp.replace(/[^0-9]/g,""));
                    $("#solCost").focus();
                }
            });
			
					$("#fake_file_area").on("click", "input", function() {
						clickFile($(this).attr("id"));
					});
							
					$(".real_file_area").on("change","input", function() {
				        insertFileName($(this).attr("id"));
				});
						 
		}, "등록하기", function(){
			if($.trim($("#solNm").val())==""){
               makeAlert(2, "", "솔루션명을 입력하세요", null, null);
               $("#solNm").focus();
            } else if($.trim($("#solPp").val())==""){
            	makeAlert(2, "", "최소 작업 인원을 입력하세요", null, null);
	            $("#solPp").focus();
            } else if($.trim($("#solCost").val())==""){
            	makeAlert(2, "", "단가(만원)을 입력하세요", null, null);
	            $("#solCost").focus();
            } else if($.trim($("#solMcost").val())==""){
            	makeAlert(2, "", "월 유지보수비(만원)을 입력하세요", null, null);
	            $("#solMcost").focus();
            } else {
				var uploadForm = $("#uploadForm");
				               
				uploadForm.ajaxForm({//폼을 실행 할 때는 ajax형태로 동작 하겠다. (form안에 있는 형태로 , submit을 해야 ajax가 동작한다.)
					success : function(result) {
						if(result.result == "SUCCESS"){
							if($("#fileName1").val() != "") {
								$("#solMn").val(result.fileName[0]);
								
								if(result.fileName.length > 1) {
									$("#solBro").val(result.fileName[1]);
								}
							} else if($("#fileName1").val() == "" && $("#fileName2").val() != "") {
								$("#solBro").val(result.fileName[0]);
							}
							
							ASRegiSolAjax();
						}else {
							alert("저장 실패");
						}   
					}, error : function(request, status, error){
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				}); // ajaxForm end 
						 
		               
		        uploadForm.submit(); 
				
				
	      	  }
			});
		} else {
			makeAlert(1, "", "권한이 없습니다!", null, null);
		}
	});
	
	/* 페이징 */
	if($("#page").val() == "") {
		$("#page").val("1");
	}
	
	reloadList();
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		reloadList();
	});

	$("#pagingArea").on("click", "input", function() {
		$("#page").val($(this).attr("name"));
		reloadList();
	});

        
	/* 데이터 상세보기 */
	$("tbody").on("click", "td", function() {
		if($(this).children("input").attr("type") != "button" && !$(this).children().is("a")){
			$("#dataForm #solNo").val($(this).parent().attr("name"));
			dtlForm();
		}	
		
	});
	
	$(".Btn_4").on("click", function() {
		
	});
});

function clickFile(obj) {
	var num = obj.substring(obj.length - 1, obj.length);
	
	$("#attFile" + num).click();
	
}

function insertFileName(obj) {
	var num = obj.substring(obj.length - 1, obj.length);
	var fileName = $("#" + obj).val().substring();
	fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

	$("#fileName" + num).val(fileName);
}

////////////////////// ** Ajax Area ** //////////////////////

function ASRegiSolAjax(){
	var params = $("#actionForm").serialize();
	
	console.log(params);
	
	$.ajax({
		type : "post",
		url : "ASRegiSolAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			makeAlert(2, "", "등록하였습니다!", true, function () {
				reloadList();			
				closePopup(1);
			});
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadList() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "ASSolListAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function redrawList(list) {
	var html = "";
	if(list.length == 0) {
		html += "<tr><td colspan=\"7\">조회결과가 없습니다.</td></tr>";
	} else {
		for(var i = 0 ; i < list.length ; i++) {
			if(i % 2 == 0){
				 html += "<tr name=\"" + list[i].SOL_NO + "\">";
			}else{
				 html += "<tr name=\"" + list[i].SOL_NO + "\" class=\"sec_tr\">";
			}  
			html += "<td>" + list[i].SOL_NAME + "</td>";
			html += "<td>" + list[i].SOL_MINIMUM_TASK_PPL + "</td>";
			html += "<td>" + list[i].SOL_PRICE + "</td>";
			html += "<td>" + list[i].SOL_MON_M_COST + "</td>";
			if(list[i].SOL_MANUAL_FILE != null && list[i].SOL_MANUAL_FILE != "") {
				html += "<td><a href=\"resources/upload/" + list[i].SOL_MANUAL_FILE + "\" download><input type=\"button\" value=\"다운로드\" class=\"Btn_4\" /></a></td>";				
			} else {
				html += "<td>-</td>";				
			}
			
			if(list[i].SOL_BROC_FILE != null && list[i].SOL_BROC_FILE != "") {
				html += "<td><a href=\"resources/upload/" + list[i].SOL_BROC_FILE + "\" download><input type=\"button\" value=\"다운로드\" class=\"Btn_4\" /></a></td>";				
			} else {
				html += "<td>-</td>";			
			}
			html += "</tr>";
		}
	}
	
	$("#board tbody").html(html);
}

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

//상세보기 관련
function dtlForm(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",	
		url : "AsSolDtlAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList2(result.data);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function redrawList2(data){

	var html = "";
	
	html +=	"<form action=\"#\" id=\"updateDataForm\" method=\"post\">"; 
	html += "<input type=\"hidden\" name=\"solNo\" id=\"solNo\" value=\"" + data.SOL_NO  + "\" >";
	html += "<div class=\"input_area\">";
	html += "<div class=\"input_area_line\">";
	html += "<div class=\"input_area_txt1\">보유 솔루션</div>";
	html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solNm\" name=\"solNm\" value=\"" + data.SOL_NAME + "\" /></div>";
	html += "</div>";
	html += "<div class=\"input_area_line\">";
	html += "<div class=\"input_area_txt1\">최소 작업 인원</div>";
	html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solPp\" name=\"solPp\" value=\"" + data.SOL_MINIMUM_TASK_PPL + "\" /></div>";
	html += "</div>";
	html += "<div class=\"input_area_line\">";
	html += "<div class=\"input_area_txt1\">단가 (만원)</div>";
	html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solCost\" name=\"solCost\" value=\"" + data.SOL_PRICE + "\" /></div>";
	html += "</div>";
	html += "<div class=\"input_area_line\">";
	html += "<div class=\"input_area_txt1\">월 유지보수비 (만원)</div>";
	html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solMcost\" name=\"solMcost\" value=\"" + data.SOL_MON_M_COST + "\" /></div>";
	html += "</div>";
	html += "<div class=\"input_area_line\">";
	html += "<div class=\"input_area_txt1\">출시일</div>";
	html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solNm\" name=\"solNm\" readonly=\"readonly\" value=\"" + data.SOL_LAUNCH_DAY + "\" /></div>";
	html += "</div>";
	html += "<div class=\"input_area_line\">";
	html += "<div class=\"input_area_txt1\">파기일</div>";
	if(data.SOL_DSTR_DAY != null){
		html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solNm\" name=\"solNm\" readonly=\"readonly\" value=\"" + data.SOL_DSTR_DAY + "\" /></div>";
	}else{
		html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"solNm\" name=\"solNm\" readonly=\"readonly\" value=\"-\" /></div>";
	}
	html += "</div>";
	html += "</div>";
	html +=	"</form>"; 

	makeTwoBtnPopup(1, "솔루션 상세정보", html, true, 450, 450,
			function() {
		$("#solPp").bind("keyup", function(event) {
            var regNumber = /^[0-9]*$/;
            var temp = $("#solPp").val();
            if(!regNumber.test(temp))
            {
                makeAlert(2, "", "숫자만 입력하세요", null, null);
                $("#solPp").val(temp.replace(/[^0-9]/g,""));
                $("#solPp").focus();
            }
        });
		
		$("#solCost").bind("keyup", function(event) {
            var regNumber = /^[0-9]*$/;
            var temp = $("#solCost").val();
            if(!regNumber.test(temp))
            {
                makeAlert(2, "", "숫자만 입력하세요", null, null);
                $("#solCost").val(temp.replace(/[^0-9]/g,""));
                $("#solCost").focus();
            }
        });
	}, "수정", function(){
		if("${sAuthNo}"==7){
		makeAlert(2, "", "수정하였습니다!", true, function () {
			var params = $("#updateDataForm").serialize();
			$.ajax({
				type : "post",	
				url : "AsSolUpdateAjax",	
				dataType : "json",	
				data : params,
				success : function (result) {
					reloadList();
					closePopup(1);
				},
				error : function (request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
						}
					});
				});
			} else {
				makeAlert(2, "", "권한이 없습니다!", null, null);
			}
		}, "폐기", function(){
			if("${sAuthNo}"==7){
			makeConfirm(2, "", "삭제하시겠습니까?", true, function () {
			var params = $("#dataForm").serialize();
			$.ajax({
				type : "post",	
				url : "AsSolDeleteAjax",	
				dataType : "json",	
				data : params,
				success : function (result) {
					reloadList();
					closePopup(1);
					},
				error : function (request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
					}
				});
			});
		} else {
			makeAlert(2, "", "권한이 없습니다!", null, null);
		}
		}); 
}

</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="39"></c:param>
		<c:param name="leftMenuNo" value="43"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<!-- 메뉴 네비게이션 -->
		<div class="content_nav">HeyWe &gt; 자산 &gt; 솔루션 &gt; 솔루션 현황</div>
		<!-- 현재 메뉴 제목 -->
		<div class="content_title">솔루션</div>
		<!-- 내용 영역 -->
		<form action="#" id="dataForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}" /> 
			<input type="hidden" name="solNo" id="solNo" />
		<div class="opt_line">
			<div class="left_side">
				<select name="searchGbn" class="sel">
					<option value="2">전 체</option>
					<option value="0">보유 솔루션</option>
					<option value="1">단가</option>
				</select> 
				<input type="text" name="searchTxt" size="20" class="txt_line" placeholder="검색어 입력" /> 
				<input type="button" value="찾기" class="search" id="searchBtn" />
			</div>
			<div class="right_side">
				<input type="button" value="솔루션등록" class="Btn_1" id="registerBtn" />
			</div>
		</div>
		</form>
		<div class="table_area">
			<table id="board">
				<colgroup>
					<col width="150" />
					<col width="150" />
					<col width="100" />
					<col width="250" />
					<col width="150" />
					<col width="150" />
				</colgroup>
				<thead>
					<tr>						
						<th>보유 솔루션</th>
						<th>최소 작업 인원</th>
						<th>단가</th>
						<th>월 유지보수비 (만 원)</th>
						<th>매뉴얼</th>
						<th>브로슈어</th>
					</tr>
				</thead>

				<tbody>

				</tbody>

			</table>
			<div id="pagingArea"></div>
		</div>
	</div>
</body>

</html>