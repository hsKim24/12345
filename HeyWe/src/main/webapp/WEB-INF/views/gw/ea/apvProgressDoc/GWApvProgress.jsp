<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재 처리 상세페이지</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvDocCommon.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvProgress.css" />
<style type="text/css">
@media print { 
  @page { 
    size:21cm 29.7cm; /*A4*/ 
  } 
} 
h1, h2, h3, h4, h5, dl, dt, dd, ul, li, ol, th, td, p, blockquote, form, fieldset, legend, div,body { -webkit-print-color-adjust:exact; }

</style>
<script src="resources/script/common/popup.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script> <!-- 메뉴에 필요함 -->
<script type="text/javascript">
$(document).ready(function(){
	$(".exit_btn").on("click", function() {
		location.href="GWApvProgressDoc";
	});
	
	// 인쇄 버튼
	$("#printBtn").on("click", function() {
		$(".attFileArea").css("display","none");
		pageprint();
	});
	
    // 수정 버튼
	$("#updateBtn").on("click",function(){
		$("#dataForm").attr("action","GWApvUpdate")
		$("#dataForm").submit();
	})
	
   	// 삭제버튼
   	$("#deleteBtn").on("click",function(){
   		makeConfirm(1, "삭제", "해당 결재를 삭제 하시겠습니까?", true, 
   			function() {
   				delApv();
   			}	
   		);
   	});
    
    // 결재 버튼
	$("#apvBtn").on("click",function(){
		$("#apvStateNo").val("3");
   		makeConfirm(1, "확인", "결재 하시겠습니까?", true, 
   			function() {
   				doApv();
			}
   		);
   	});
    
	//전결, 반려 버튼
	$("#allApvBtn, #rejBtn").on("click",function(){
		console.log($(this).val());
		$("#apvStateNo").val($(this).attr("name"));
		var html ="";
		
		html += "&emsp;${sName}님 " + $(this).val() + " 하시겠습니까?<br/><br/>";
		html += "&emsp;<b>" + $(this).val() + " 사유</b></br>";
		html += "&emsp;<textarea id=\"apvCommentTxt\" rows=\"5\" cols=\"40\" style=\"resize: none;\"></textarea>";
		
		makePopup(1, $(this).val() + " 진행", html , true, 350, 250, 
			function() {
				$("#apvCommentTxt").focus();
			}, 
			"확인", 
			function() {
				$("#apvComment").val($("#apvCommentTxt").val());
				doApv();
			}	
		);
   	}); 
});

//결재문서 삭제
function delApv() {
	var params = $("#dataForm").serialize();
		
	$.ajax({
		type : "post",
		url : "GWdelApvAjax",
		dataType : "json",
		data : params,
		success : function(result){
			closePopup(1);
			makeAlert(2,"확인","삭제 되었습니다.",true,function(){
				location.href="GWApvProgressDoc";
			});
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);	
			console.log("text : " + request.responseText);	
			console.log("error : " + error);	
		}
	});
}

//결재처리
function doApv() {
	var params = $("#dataForm").serialize();
		
	$.ajax({
		type : "post",
		url : "GWapvAjax",
		dataType : "json",
		data : params,
		success : function(result){
			closePopup(1);
			makeAlert(2,"확인","결재 되었습니다.",true,function(){
				location.href="GWApvProgressDoc";
			});
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);	
			console.log("text : " + request.responseText);	
			console.log("error : " + error);	
		}
	});
}

// 인쇄(-by 제호-)
var initBody;

function beforePrint()
{
    initBody = document.body.innerHTML;
    document.body.innerHTML = printArea.innerHTML;
}

function afterPrint()
{
    document.body.innerHTML = initBody;
}

function pageprint()
{
	window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
    window.print();
}
</script>
</head>
<body>
<!-- form 영역 -->
<form action="#" id="dataForm" method="post">
	<input type="hidden" id="apvNo" name="apvNo" value="${data.APV_NO}"/>
	<input type="hidden" id="selectedDocType" name="selectedDocType" value="${data.APV_DOC_TYPE_NO}"/>
	<!-- 결재(전결 반려 포함)시 결재상태번호 -->
	<input type="hidden" id="apvStateNo" name="apvStateNo"/>
	<!-- 전결, 반려시 코멘트 -->
	<input type="hidden" id="apvComment" name="apvComment"/>
	
	<input type="hidden" name="topMenuNo" value="${param.topMenuNo}"/>
	<input type="hidden" name="leftMenuNo" value="${param.leftMenuNo}"/>
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="5"></c:param>
</c:import>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 전자결재 &gt; 결재진행 문서함</div>
	<div class="content_title">
		결재처리 페이지
	</div>
	<div class="apvDocType" >
		<div class="bg0">
			<div class="exit_btn">
				<img alt="exit" src="resources/images/erp/gw/ea/exit.png">
			</div>
		</div>
		<div class="bg1">
			<div class="bg1_left">
				<a href="javascript:history.go(0)">
					<input type="button" value="인쇄" id="printBtn"/>
				</a>
				<input type="checkbox" id="checkAllApv" disabled="disabled" <c:if test="${data.ALLAPV_WHETHER eq 0}">checked="checked"</c:if> />
				<label for="checkAllApv" style="color:#8DA9C4">전결가능</label>
			</div>
			<div class="bg1_right">
				<c:choose>
					<c:when test="${(sEmpNo eq data.EMP_NO) and (apvState.DOC_STATE eq 0)}">
						<c:if test="${empty data.OUT_APV_TYPE_NO}">
							<input type="button" value="수정" id="updateBtn"/>
							<input type="button" value="삭제" id="deleteBtn"/>
						</c:if>
					</c:when>
					<c:when test="${(sEmpNo ne data.EMP_NO) and (apvState.DOC_STATE <= 1)}">
						<c:forEach var="apver" items="${list}" varStatus="index">
							<c:if test="${(sEmpNo eq apver.EMP_NO) and (apver.APV_STATE_NO eq 0)}">
								<input type="button" value="결재" id="apvBtn"/>
								<c:if test="${data.ALLAPV_WHETHER eq 0}"> <!-- 마지막 결재자도 전결 가능 (제외:and (!index.last)) -->
									<input type="button" name="2" value="전결" id="allApvBtn"/>
								</c:if>
								<input type="button" name="1" value="반려" id="rejBtn"/>
							</c:if>
						</c:forEach>
					</c:when>
				</c:choose>
			</div>
		</div>
		<div id="printArea">
			<div class="bg2">
				<div class="apvTypeName">
					${data.APV_DOC_TYPE_NAME}
				</div>
				<div class="docCommonArea">
					<div class="doc_info">
						<table class="doc_info_table">
							<colgroup>
								<col width="100" />
								<col width="200" />
							</colgroup>
							<tbody>
								<tr>
									<th>기안자</th>
									<td>${data.NAME}</td>
								</tr>
								<tr>
									<th>소속</th>
									<td>${data.DEPT_NAME}</td>
								</tr>
								<tr>
									<th>기안일</th>
									<td>${data.DRAFT_DATE}</td>
								</tr>
								<c:if test="${!empty data.IMP_DATE}">
									<tr>
										<th>시행일</th>
										<td>${data.IMP_DATE}</td>
									</tr>
								</c:if>
								<tr>
									<th>품의번호</th>
									<td>${data.CONSULT_NO}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="apverArea">
						<span><br/><br/>결재</span>
						<c:forEach var="apver" items="${list}">
							<div class="apver">
								<div class="posi">${apver.POSI_NAME}</div>
								<div class="empName">
									<div>
										${apver.NAME}
										<c:choose>
											<c:when test="${apver.APV_STATE_NO eq 1}">
												<img alt="turndown" src="resources/images/erp/gw/ea/turndown.png" />
											</c:when>
											<c:when test="${apver.APV_STATE_NO eq 2}">
												<img alt="allapproval" src="resources/images/erp/gw/ea/allapproval.png" />
											</c:when>
											<c:when test="${apver.APV_STATE_NO eq 3}">
												<img alt="approval" src="resources/images/erp/gw/ea/approval.png" />
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="apvDate">
									<c:choose>
										<c:when test="${!empty apver.APV_DATE}">
											${apver.APV_DATE}
										</c:when>
										<c:otherwise>
											<span style="color: #8B8786;"><i>결재일</i></span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="docSimpleInfoArea"> 
					<div>
					<table class="docNameAndCon">
						<tbody>
							<tr>
								<th>제목</th>
								<td>${data.TITLE}</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>${data.CON}</td>
							</tr>
						</tbody>
					</table>
					</div>
				</div>
				<div class="docUnCommonArea">
					<div class="expCon"> 
						${data.EXP_CON}
					</div>
				</div>
				<c:if test="${!empty attFileList}">
					<div class="attFileArea"> 
						<div class="fakeArea">
							<div style="font-size:12pt; text-align:left;">첨부파일 목록</div>
							<div class="attFileList">
								<c:forEach var="att" items="${attFileList}">
									<div name="attFile${att.RNUM}">
										<div class="fLeft">
											<a href="resources/upload/${att.ATT_FILE_NAME}" download="${att.ATT_FILE_NAME.substring(20)}">${att.ATT_FILE_NAME.substring(20)}</a><br/>
										</div>
									</div>
	         					</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
		<c:if test="${!empty comment}">
			<div class="bg3">
				comment.
				<div class="commentArea">
					<div class="commentArea_profill">
	 					<c:choose>
	 						<c:when test="${comment.CD_NAME eq '반려'}">
	 							<a id="turndown">[반려]</a><br>
	 						</c:when>
	 						<c:otherwise>
	 							<a id="allapproval">[전결]</a><br>
	 						</c:otherwise>
	 					</c:choose>
	 					<c:choose>
	 						<c:when test="${empty comment.PIC}">
	 							<img alt="user" src="resources/images/erp/common/user.png">
	 						</c:when>
	 						<c:otherwise>
								<img alt="user" src="resources/upload/${comment.PIC}">
	 						</c:otherwise>
	 					</c:choose>
						<div class="comment_profill">
							[${comment.DEPT_NAME}]<br/>  
							${comment.NAME} ${comment.POSI_NAME}
						</div>
					</div>
					<div class="apvComment">${comment.OPINION_CON}</div>
				</div>
			</div>
		</c:if>
	</div>	
</div>

</body>
</html>