<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<script type="text/javascript"
		src="resources/script/jquery/jquery.slimscroll.js"></script>
<script type="text/javascript"
		src="resources/script/common/popup.js"></script>
<script type="text/javascript"
		src="resources/script/common/util.js"></script>
<style>
.chatRoom{
	font-size: 13pt;
	color: black;
	width: 300px;
	height: 300px;
	position: relative;
	border-color: #F2F2F2;
	background-color: white;
	box-shadow: 1px 2px 4px 4px #134074;
	margin-left: -300px;
	overflow-y : scroll;
	z-index: 100;
	font-weight: bold;
	
}
.Ycolor{
	font-size: 9pt;
	color: black;
	
}
.chatListBottom{
	font-size: 9pt;
	font-weight: normal;
	color: gray;
}
</style>
<script type="text/javascript">
// 밑에 애랑 다른거임
var refreshIntervalNotiDtl = "";
var changeChatList = 0;
var notiCnt = 0;

$(document).ready(function() {
	
	refreshIntervalNotiCnt = setInterval(AjaxChatNoti,3000);

	//ScrollBar
	$(".content_area").slimScroll({
		height: "100%",
		axis: "both"
	});
	
	getLeftMenu();
	
	//Logout Button
	$("#logoutBtn").on("click", function() {
		location.href = "logout";
	});
	
	//Logo Event
	$(".top_logo_area > div > div").on("click", function() {
		location.href = $(this).attr("loc");
	});
	
	//Top Menu Event
	$(".large_menu > div > div, .large_menu_on > div > div").on("click", function() {
		console.log("aa");
		$("#leftMenuNo").val($(this).attr("leftmenuno"));
		
		$("#topMenuNo").val($(this).attr("menuno"));
		
		$("#locationForm").attr("action", $(this).attr("loc"));
		
		$("#locationForm").submit();
	});

	
	//Left Menu Location Event
	$(".left_area").on("click",
			".left_sub_menu_txt, .left_sub_detail_menu_txt, .left_sub_detail_sub_menu_txt"
			+ ", .left_sub_menu_txt_on, .left_sub_detail_menu_txt_on, .left_sub_detail_sub_menu_txt_on",
			function() {
		if($(this).is("[loc]")) { // 경로가 있는 메뉴 선택 시
			$("#leftMenuNo").val($(this).attr("menuno"));
			
			$("#locationForm").attr("action", $(this).attr("loc"));
			
			$("#locationForm").submit();
		} else {
			if($(this).parent().attr("class") == "left_sub_menu") {
				$(".left_sub_menu_on").each(function(){
					if($(this).children(".left_sub_menu_txt").attr("menuno") != $("#leftMenuNo").val()) {
						$(this).attr("class", "left_sub_menu");
					}
				});
				$(this).parent().attr("class", "left_sub_menu_on");
			} else if($(this).parent().attr("class") == "left_sub_detail_menu") {
				$(".left_sub_detail_menu_on").each(function() {
					if($(this).children(".left_sub_detail_menu_txt").attr("menuno") != $("#leftMenuNo").val()) {
						$(this).attr("class", "left_sub_detail_menu");
					}
				});
				$(this).parent().attr("class", "left_sub_detail_menu_on");
			}
		}
	});
	
	//chatNoti
	$(".chatArea").css("display","none");
	$(".top_btn").on("click",function(){
		if(changeChatList == 0 && $(".top_btn_noti").text() != "0"){
			$(".chatArea").css("display", "block");
			changeChatList = 1;
		}else{
			$(".chatArea").css("display", "none");
			changeChatList = 0;
		}
	});
	
	//page Move
	$(".chatRoom").on("click", "div", function(){
		$("#NotichatRoomNo").val($(this).attr("name"));
		$("#chatRoomForm").attr("action","GWChat");
		$("#chatRoomForm").submit();
	});
	
});

function getLeftMenu() {
	var params = $("#locationForm").serialize();
	
	$.ajax({
		type : "post",
		url : "commonLeftMenuAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			drawLeftMenu(result.leftMenu, result.depth, result.flow);			
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

// 채팅 디테일하게 보여주기
function AjaxChatDtlNoti(){
	$.ajax({
		type : "post",
		url : "AjaxChatDtlNoti",
		dataType : "json",
		success : function(result){
			//result에 데이터가 있다고 치면
			var html = "";
			for(var i = 0; i <result.list.length; i++){
				html += "<div class=\"chatList\" name=\"" + result.list[i].CHATROOM_NO + "\"><span class=\"Ycolor\">" + result.list[i].CHATROOM_NAME +"</span>";
				html += result.list[i].WRITE_DAY + "  " + result.list[i].NAME;
				html += "<div>" + result.list[i].CON +"</div>";
				html += "</div><hr/>";
			}
			$(".chatRoom").html(html);
			
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}


// 채팅오는거 보기보기
function AjaxChatNoti(){
	//일단 데이터 없앰	
	$.ajax({
		type : "post",
		url : "AjaxChatNoti",
		dataType : "json",
		success : function(result){
			if(notiCnt != ($('.top_btn_noti').text()*1)){
				AjaxChatDtlNoti();
				notiCnt = ($('.top_btn_noti').text()*1);
			}
			
			$('.top_btn_noti').text(result.cnt);
			if($('.top_btn_noti').text() == "" || $('.top_btn_noti').text() == "0"){
				$(".top_btn_noti").css("display","none");
			}else{
				$(".top_btn_noti").css("display","block");
			}
		},
		error : function(request, status, error){
			console.log("실패");
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}


function drawLeftMenu(menu, depth, flow) {
	
	if(menu.length == 0) {
		/* $(".left_area").css("visibility", "hidden"); */ /* Main 왼쪽 영역 숨김으로 변경 */
		$(".left_area").css("display", "none");
	} else {
		var html = "";
		
		for(var i = 0 ; i < menu.length ; i++) {
			if(i == 0) { // 왼쪽 대메뉴
				html += "<div class=\"left_large_menu\">";
				html += "<img alt=\"" + menu[i].MENU_NAME + "\" src=\"resources/images/erp/common/docu.png\" />";
				html += menu[i].MENU_NAME;
				html += "</div>";
			} else {
				// 2depth
				if(menu[i].DEPTH == "2") {
					if(menu[i].CNT == 0) { // 하위 메뉴 없음
						html += "<div class=\"left_menu_wrap\">";
						if(flow != "" && flow.includes(menu[i].MENU_NO + "")) { // 현재메뉴 구분
							html += "<div class=\"left_sub_menu_single_on\">";
						} else {
							html += "<div class=\"left_sub_menu_single\">";
						}
						html += "<div class=\"left_sub_menu_txt\" menuno=\"" + menu[i].MENU_NO + "\" loc=\"" + menu[i].ADDR + "\">" + menu[i].MENU_NAME + "</div>";
						html += "</div>";
						html += "</div>";
					} else { // 하위메뉴 존재
						html += "<div class=\"left_menu_wrap\">";
						if(flow != "" && flow.includes(menu[i].MENU_NO + "")) { // 현재메뉴 구분
							html += "<div class=\"left_sub_menu_on\">";
						}  else {
							html += "<div class=\"left_sub_menu\">";
						}
						html += "<div class=\"left_sub_menu_txt\" menuno=\"" + menu[i].MENU_NO + "\">" + menu[i].MENU_NAME + "</div>";
						
						// 3depth
						html += "<div class=\"left_sub_detail_menu_wrap\">";
						
						for(var j = 2 ; j < menu.length ; j++) {
							if(menu[j].DEPTH == "3" && menu[j].MENU_FLOW.indexOf(menu[i].MENU_NO + ",") >= 0) { 
								if(flow != "" && flow.includes(menu[j].MENU_NO + "")) { // 현재메뉴 구분
									html += "<div class=\"left_sub_detail_menu_on\">";
								} else {
									html += "<div class=\"left_sub_detail_menu\">";
								}
								
								if(menu[j].CNT == 0) { // 하위 메뉴 없음
									html += "<div class=\"left_sub_detail_menu_txt\" menuno=\"" + menu[j].MENU_NO + "\" loc=\"" + menu[j].ADDR + "\">" + menu[j].MENU_NAME + "</div>";
								} else { // 하위 메뉴 존재
									html += "<div class=\"left_sub_detail_menu_txt\" menuno=\"" + menu[j].MENU_NO + "\">" + menu[j].MENU_NAME + "</div>";
									// 4depth
									html += "<div class=\"left_sub_detail_sub_menu_wrap\">";
									
									for(var k = 3 ; k < menu.length ; k++) {
										if(menu[k].DEPTH == "4" && menu[k].MENU_FLOW.indexOf(menu[j].MENU_NO + ",") > 0) { 
											if(flow.includes(menu[k].MENU_NO + "")) { // 현재메뉴 구분
												html += "<div class=\"left_sub_detail_sub_menu_txt_on\" menuno=\"" + menu[k].MENU_NO + "\" loc=\"" + menu[k].ADDR + "\">" + menu[k].MENU_NAME + "</div>";
											} else {
												html += "<div class=\"left_sub_detail_sub_menu_txt\" menuno=\"" + menu[k].MENU_NO + "\" loc=\"" + menu[k].ADDR + "\">" + menu[k].MENU_NAME + "</div>";
											}
										}
									}
									html += "</div>";
								}								
								
								html += "</div>"; // left_sub_detail_menu end
							}
						}
						
						html += "</div>"; // left_sub_detail_menu_wrap end
						html += "</div>"; // left_sub_menu end
						html += "</div>"; // left_menu_wrap end
					}
				} // 2depth if end
			} // left large menu if end
		} // menu for end
		
		$(".left_area").html(html);
	}
}
</script>
<form action="#" id="locationForm" method="post">
	<input type="hidden" id="topMenuNo" name="topMenuNo" value="${param.topMenuNo}" />
	<input type="hidden" id="leftMenuNo" name="leftMenuNo" value="${param.leftMenuNo}" />
</form>
<!-- Top -->
<div class="top_area">
	<div class="top_logo_area">
		<div>
			<div loc="Main">HeyWe</div>
		</div>
	</div>
	<div class="large_menu_area">
		<c:forEach var="top" items="${topMenu}">
			<c:choose>
				<c:when test="${param.topMenuNo eq top.MENU_NO}">
					<div class="large_menu_on">
						<div>
							<div menuno="${top.MENU_NO}" leftmenuno="${top.LEFT_MENU_NO}" loc="${top.ADDR}">${top.MENU_NAME}</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="large_menu">
						<div>
							<div menuno="${top.MENU_NO}" leftmenuno="${top.LEFT_MENU_NO}" loc="${top.ADDR}">${top.MENU_NAME}</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<div class="top_profile_area">
		<div class="top_profile_img">
			<c:choose>
				<c:when test="${empty sPic}">
					<img alt="사진없음" src="resources/images/erp/common/nopic.png"/>
				</c:when>
				<c:otherwise>
					<img alt="${sName}" src="resources/upload/${sPic}"/>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="top_profile_txt">
			<div>${sDeptName}</div>
			<div>${sName} ${sPosiName}</div>
		</div>
	</div>
	<div class="top_btn_area">
		<!-- <div class="top_btn">
			<div class="top_btn_noti">3</div>
			<img alt="알림" src="resources/images/erp/common/noti.png" />
		</div> -->
		<div class="top_btn">
			<div class="top_btn_noti" style="display:none;">0</div>
			<img alt="메신저" src="resources/images/erp/common/chat.png" />
			<div class="chatArea" style="display: none;">
			<form action="#" id="chatRoomForm" method="post">
				<input type="hidden" id="NotichatRoomNo" name="NotichatRoomNo"/>
				<input type="hidden" id="NotitopMenuNo" name="topMenuNo" value="2" />
			</form>
				<div class="chatRoom">
					<div class="chatList"><span class="Ycolor">Test채팅방이름</span><br> 
						<div class="chatRoomListTxt"> Test채팅내용 </div><span class="chatListBottom">07-18 서제호</span>
					</div><hr/>

				</div>
			</div>
		</div> 
		<div class="top_btn">
			<img alt="로그아웃" src="resources/images/erp/common/off.png" id="logoutBtn" />
		</div>
	</div>
</div>
<!-- Left -->
<div class="left_area">
<%--
	<!-- 왼쪽 대메뉴 -->
	<div class="left_large_menu"><img alt="자산" src="resources/images/erp/common/docu.png" />자산</div>
	
	<!-- 왼쪽 소메뉴 -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu">
			<div class="left_sub_menu_txt">신용카드/계좌 관리</div>
			<div class="left_sub_detail_menu_wrap">
				<div class="left_sub_detail_menu_on">
					<div class="left_sub_detail_menu_txt">교육 관리 현황</div>
				</div>
				<div class="left_sub_detail_menu">
					<div class="left_sub_detail_menu_txt">종료 교육 관리</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 왼쪽 소메뉴 3depth -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu_on">
			<div class="left_sub_menu_txt">휴가 신청 내역 조회</div>
			<div class="left_sub_detail_menu_wrap">
				<div class="left_sub_detail_menu_on">
					<div class="left_sub_detail_menu_txt">교육 관리 현황</div>
				</div>
				<div class="left_sub_detail_menu">
					<div class="left_sub_detail_menu_txt">종료 교육 관리</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 왼쪽 소메뉴 4depth -->
	<div class="left_menu_wrap">
		<!-- 왼쪽 소메뉴 On/Off : On의 경우 left_sub_menu_on, Off의 경우 left_sub_menu  -->
		<div class="left_sub_menu_on">
			<!-- 왼쪽 소메뉴 텍스트 -->
			<div class="left_sub_menu_txt">교육 관리</div>
			<!-- 왼쪽 소메뉴 세부메뉴 -->
			<div class="left_sub_detail_menu_wrap">
				<!-- 왼쪽 소메뉴 세부메뉴 On/Off : On의 경우 left_sub_detail_menu_on, Off의 경우 left_sub_detail_menu -->
				<div class="left_sub_detail_menu_on">
					<!-- 왼쪽 소메뉴 세부메뉴 텍스트 -->
					<div class="left_sub_detail_menu_txt">교육 관리 현황</div>
					<!-- 왼쪽 소메뉴 세부메뉴 소메뉴 -->
					<div class="left_sub_detail_sub_menu_wrap">
						<!-- 왼쪽 소메뉴 세부메뉴 소메뉴  On/Off : On의 경우 left_sub_detail_sub_menu_txt_on, Off의 경우 left_sub_detail_sub_menu_txt  -->
						<div class="left_sub_detail_sub_menu_txt_on">가나다라마바사아자</div>
						<div class="left_sub_detail_sub_menu_txt">가나다라마바사아자</div>
					</div>
				</div>
				<div class="left_sub_detail_menu">
					<div class="left_sub_detail_menu_txt">종료 교육 관리</div>
					<div class="left_sub_detail_sub_menu_wrap">
						<div class="left_sub_detail_sub_menu_txt_on">가나다라마바사아자</div>
						<div class="left_sub_detail_sub_menu_txt">가나다라마바사아자</div>
					</div>
				</div>
				<div class="left_sub_detail_menu">
					<div class="left_sub_detail_menu_txt">ABCDEFG</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 왼쪽 소메뉴 -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu">
			<div class="left_sub_menu_txt">프로젝트 관리</div>
			<div class="left_sub_detail_menu_wrap">
				<div class="left_sub_detail_menu_on">
					<div class="left_sub_detail_menu_txt">교육 관리 현황</div>
				</div>
				<div class="left_sub_detail_menu">
					<div class="left_sub_detail_menu_txt">종료 교육 관리</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 왼쪽 소메뉴 단일버전 -->
	<div class="left_menu_wrap">
		<div class="left_sub_menu_single_on">
			<div class="left_sub_menu_txt">솔루션</div>
		</div>
	</div>
 --%>
</div>