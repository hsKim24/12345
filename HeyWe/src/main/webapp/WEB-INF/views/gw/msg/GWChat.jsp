<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - Chat Main</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/msg/chat.css" />
<style>
.right_chat{
	display: none;
}
.org{
	font-size: 12pt;
	font-weight: bold;
}
img[alt='folder'], img[alt='user']{
	height: 20pt;
}
.orgArea span:hover{
	cursor: pointer;
}
.orgArea{
	font-size:12pt;
	color: black;
	height: 250px;
}
.chat span{
	display: inline-block;
}
.chat_list_con{
	font-size: 12pt;
	color: black;
}
.profile_con input type['button']{
	font-size:12pt;
}
#makeChatRoomEmp{
	font-size: 12pt;
}
.chat > .left_chat > .profile{
	height: calc(20% - 0px);
}
.profile_con{
	height: 116px;
}
.chat_con{
	background-color: #a3d6eb;
}
.Ycon, .down{
	background-color: #F2F2F2;
}

img[alt='사진']{
	width : 38px;
	height : 38px;
}
#con{
    height: 80px;
    width: 411px;
}
/* #chat_Btn{
	width: 660px;
	height: 600px;
} */
#chatRoomTxt{
	width: 200px;
	height: 100px;
}
#insertChatRoomEmpBtn{
	font-size: 11pt;
	color: black;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
/* $(document).ready(function(){
	$("#makeChatRoomEmp").on("click",function(){
		
	});
}); */
//조직도 부서 클릭
var notiFlag = true;
$(document).ready(function(){
	
	reloadOrgList();
	AjaxGWChatRoomList();
	
	$(".orgArea").slimScroll({});
	$(".profile_con").slimScroll({height:"116"});
	$(".chat_con").slimScroll({
		height:"656",
		start: 'bottom',
		alwaysVisible: true
	});
	
	$(".right_chat").css("display","none");
	$(".chat_pati_list").css("display","none");
	$(document).on("click", ".dept", function() {
		
	   var b;
	   var sr;
	   if($(this).closest("div").find("div").attr("hidden") == "hidden"){   //조직도 부서클릭 오픈 시
	      b = false;
	      sr = "resources/images/erp/gw/ea/folder.png";
	      $("#deptNo").val($(this).attr("name"));
	      reloadEmpList();
	   } else {
	      b = true;
	      sr = "resources/images/erp/gw/ea/folderOff.png"
	   }
	   
	   $(this).find("img").attr("src", sr);                   //this는 span이고 div가 감싸고 있음
	   $(this).closest("div").find("div").attr("hidden", b);       //closest : 가장 가까운 상위 요소
	                                                //find : 모든 하위요소
		//HeyWe 클릭
		$(".orgArea>span").on("click", function() {
		   $("#deptNo").val("");
			reloadOrgList();
		});
	});
	
	//orglist 축소
	$("#orgAreaHidden").on("click",function(){
		$(".orgArea").css("display","none");
		$(".orgArea").parent().css("display","none");
		$(".org_search").css("display","none");
		$(".org").css("height","33px");
		$("#orgAreaHidden").css("display","none");
		$("#orgAreaNHidden").css("display","block");
	});
	//orglist 확대
	$("#orgAreaNHidden").on("click",function(){
		$(".orgArea").css("display","block");
		$(".org_search").css("display","block");
		$(".orgArea").parent().css("display","block");
		$(".org").css("height","322px");
		$("#orgAreaNHidden").css("display","none");
		$("#orgAreaHidden").css("display","block");
	});
	//chatRoomList 축소
	$("#chatRoomListHidden").on("click",function(){
		$(".chat_list_con").css("display","none");
		$(".chat_list_search").css("display","none")
		$("#chatRoomListHidden").css("display","none");
		$("#chatRoomListNHidden").css("display","block");
	});
	//chatRoomList 확대
	$("#chatRoomListNHidden").on("click",function(){
		$(".chat_list_con").css("display","block");
		$(".chat_list_search").css("display","block")
		$("#chatRoomListNHidden").css("display","none");
		$("#chatRoomListHidden").css("display","block");
	});
	//profile 축소
	$("#profileHidden").on("click",function(){
		$(".profile_con").css("display", "none");
		$("#profileHidden").css("display","none");
		$("#profileNHidden").css("display","block");
		$(".profile_con").parent().css("display","none");
		$(".profile").css("height","33px");
	});
	//profile 확대
	$("#profileNHidden").on("click",function(){//???? 머여 이거 ㅡㅡ,
		$(".profile_con").css("display", "block");
		$("#profileNHidden").css("display","none");
		$("#profileHidden").css("display","block");
		$(".profile_con").parent().css("display","block");
		$(".profile").css("height","161px");
	});
	
	//알람 취소기능 (구현x)
	$("#bellbell").on("click",function(){
		makeAlert(3, "삐빅", "현재 구현되지않은기능입니다", null, null);
	});
	
	
	// 체크박스를 라디오 버튼처럼 만듬
	$("body").on("click","input[type=\"checkbox\"][name=\"checkEmp\"]",function(){
		if($(this).prop("checked")){
			$("input[type=\"checkbox\"][name=\"checkEmp\"]").prop("checked", false);
			$(this).prop("checked", true);
			//밑에 val()안에 $(this).attr(name)을 가	져오고 싶은데 이건 tr 클릭이 아니라 this가 아닌데 어찌함?? 체크박스는 라인위치는 같은데
			$("#chatRoomEmpNo").val($(this).parent().parent().attr("name"));
			console.log($("#chatRoomEmpNo").val());
		}
	});
	
	$("body").on("click", "#makeChatRoomEmp", function(){
		if($("#chatRoomNo3").val() == "NoData" || $("#chatRoomNo3").val() == "${sEmpNo}"){
			makeAlert(3, "에러", "채팅방이 선택되지않았습니다.", null, null);

		}else{
			AjaxGWinsertChatEmp();
			makeAlert(3, "등록", "해당 채팅방에 사원이 초대되었습니다", null, null);
		}
	});
	
	$("#peopleInsert").on("click",function(){
		if($("#chatRoomNo3").val() == "NoData" || $("#chatRoomNo3").val() == "${sEmpNo}"){
			makeAlert(3, "에러", "채팅방이 선택되지않았습니다.", null, null);

		}else{
			AjaxGWinsertChatEmp();
			makeAlert(3, "등록", "해당 채팅방에 사원이 초대되었습니다", null, null);
		}
	});
	
	 $("body").on("click", "#insertChatRoomEmpBtn", function(){
		makePopup(3, "제목 설정", "채팅방 제목을 지정해주세요 </br> <input type=\"text\" id=\"chatRoomTxt\"/>", true, 500, 400,
		   null, "등록", function(){
			$("#chatRoomTitle").val($("#chatRoomTxt").val());
			console.log($("#chatRoomTitle").val());
			AjaxGWinsertChatRoom();
			closePopup(3);
			});
	}); 
	 
});

//채팅방 생성과 동시에 자기자신 삽입
function AjaxGWinsertChatRoom(){
	if($("#chatRoomEmpNo").val() != "${sEmpNo}"){
		$("#chatRoomEmpNo").val() = "${sEmpNo}";
	}
	var params =$("#insertChatRoomForm").serialize();
	
	$.ajax({
      type: "post",
      url: "AjaxGWInsertChatRoom",
      dataType: "json",
      data: params,
      success: function(result) {
		  $("#chatRoomNo3").val(result.data.CHATROOM_NO);
    	  AjaxGWinsertChatEmp();
      },
      error: function(request, status, error) {
         console.log("status: " + request.status);
         console.log("text: " + request.responseText);
         console.log("error: " + error);
      }
   }); 
}

// 채팅방에 사원 삽입 (채팅방을 만들때도 최초 1회 실행)
function AjaxGWinsertChatEmp(){
	var params =$("#insertChatEmpForm").serialize();
	
	$.ajax({
      type: "post",
      url: "AjaxGWInsertChatEmp",
      dataType: "json",
      data: params,
      success: function(result) {
    	  AjaxGWChatRoomList();
    	  AjaxGWSelectChatRoomListEmp();
      },
      error: function(request, status, error) {
         console.log("status: " + request.status);
         console.log("text: " + request.responseText);
         console.log("error: " + error);
      }
   }); 
}

// 현재 채팅방 사원 리스트 조회 및 몇명인지 뿌리기
function AjaxGWSelectChatRoomListEmp(){
	var params =$("#readForm").serialize();
	
	$.ajax({
      type: "post",
      url: "AjaxGWSelectChatRoomListEmp",
      dataType: "json",
      data: params,
      success: function(result) {
    	  var html ="";
    	  for(var i = 0; i < result.list.length; i++){
    		  html += result.list[i].NAME + "<br/>";
    	  }
	      $(".pati_con").html(html);
      },
      error: function(request, status, error) {
         console.log("status: " + request.status);
         console.log("text: " + request.responseText);
         console.log("error: " + error);
      }
   }); 
}
function reloadOrgList() {
   var params = $("#dataForm").serialize();
   
   $.ajax({
      type: "post",
      url: "GWorgListAjax",
      dataType: "json",
      data: params,
      success: function(result) {
    	  console.log("여기까지 진행잘됌");
         redrawOrgList(result.deptList, result.empList);
      },
      error: function(request, status, error) {
         console.log("status: " + request.status);
         console.log("text: " + request.responseText);
         console.log("error: " + error);
      }
   }); 
}

function redrawOrgList(deptList, empList){
   var html = "";   
   
   for(var i = 0; i < deptList.length; i++){
      html += "<div>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"dept\" name=\"" + deptList[i].DEPT_NO + "\">"
            + "<img alt=\"folder\" src=\"resources/images/erp/gw/ea/folderOff.png\">" + deptList[i].DEPT_NAME + "</span>"; 
      
      for(var j = 0; j < empList.length; j++){
         if(deptList[i].DEPT_NO == empList[j].DEPT_NO){
            html += "<div hidden=\"hidden\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                  + "<span class=\"emp\" name=\"" + empList[j].EMP_NO + "\">"
                  + "<img alt=\"user\" src=\"resources/images/erp/common/user.png\">"
                  + "<span>&nbsp;" + empList[j].NAME + "&nbsp;" + empList[j].POSI_NAME + "</span></span></div>";
         }
      }
      
      html += "</div>";
   }
   
   $(".orgList").html(html);
}
function reloadEmpList() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type: "post",
		url: "GWempListAjax",
		dataType: "json",
		data: params,
		success: function(result) {
			redrawEmpList(result.empList);
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
}

function redrawEmpList(empList){
	var html = "";
	
	for(var i = 0; i < empList.length; i++){
		html +=	"<tr ";
		if(i%2 == 1){ //0번째가 표시될 때는 홀수 번째이므로
			html += "class=\"row_even\"";
		}
		html +=	"name=\"" + empList[i].EMP_NO + "\">";
		html +=		"<td><input type=\"checkbox\" id=\"c" + i + "\" name=\"checkEmp\" /></td>";
		html +=		"<td deptNo=\"" + empList[i].DEPT_NO + "\">" + empList[i].DEPT_NAME + "</td>";
		html +=		"<td posiNo=\"" + empList[i].POSI_NO + "\">" + empList[i].POSI_NAME + "</td>";
		html +=		"<td>" + empList[i].NAME + "</td>";
		html +=	"</tr>";
	}
	html += "<tr><td colspan=\"5\"><input type=\"button\" id=\"makeChatRoomEmp\" value=\"채팅방에 초대하기\"/></tr></td>";
	
	$(".profile_con tbody").html(html);
}
	
// 내 채팅방 뿌리기
function AjaxGWChatRoomList(){
var params = $("#chatRoomListForm").serialize();
	
	$.ajax({
		type: "post",
		url: "AjaxGWChatRoomList",
		dataType: "json",
		data: params,
		success: function(result) {
			console.log(result.ChatRoomlist);
			var html="";
				html += "<table>";
			for(var i = 0; i < result.ChatRoomlist.length; i++){
				html += "<tr name=\"" + result.ChatRoomlist[i].CHATROOM_NO + "\" id=\"CHL_" + result.ChatRoomlist[i].CHATROOM_NO + "\">" ;
				html += "<td>" + result.ChatRoomlist[i].CHATROOM_NAME + "</td>";
				html += "</tr>";
			// html+= <input type=\"hidden\" id=\"ChatRoomNo_" + result.ChatRoomlist[i].CHATROOM_NO + "\"/>";
			}
			html += "</table>";
			//
			html += "<input type=\"button\" id=\"insertChatRoomEmpBtn\" value=\"채팅방 생성하기\"/>"
			$(".chat_list_con").html(html);
		    if(notiFlag && "${param.NotichatRoomNo}" != ""){
			   $("#CHL_${param.NotichatRoomNo}").click();
				notiFlag = false;
				console.log("이거 실행안된거잖아");
			}

		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
}
	
</script>
<!-- 아직 위에서 구현안된게 내 채팅방 목록에서 그냥 이름만 띄움 개 구데기지만 일단 기능부터 구현하고 디테일 잡자 ex)참여인원 이런거 써주기 -->
<!-- 채팅 만들기! 7.12부터 시작하면됌 -->
<script type="text/javascript">
console.log(notiFlag);
var refreshInterval = "";
$(document).ready(function(){
	
	$("#SendMsgBtn").on("click", function(){
      if($.trim($("#msg").val()) == null) {
         alert("내용을 입력해 주세요.");
      } else {
         insertMsg();
      }
   });
   
   var background_color = "";
   $("body").on("click",".chat_list_con table tbody tr",function(){
	   console.log("?");
	 //if쪽 사실 필요없는데 살릴지 말지는 고민중
     if($("#chatRoomNo").val() == $(this).attr("name")){
	 	 $(this).css("background-color","white");
		 $("#chatRoomNo").val("Nodata");
		 $("#chatRoomNo3").val("Nodata");
     }else{
    	 //clearInterval(refreshInterval);
    	 $("#chatRoomNo").val($(this).attr("name"));
    	 $("#chatRoomNo2").val($(this).attr("name"));
    	 $("#chatRoomNo3").val($(this).attr("name"));
    	 $("#lastChatNo").val("1");
		 $("#"+ background_color).css("background-color","white");
    	 $(this).css("background-color","yellow");
    	 background_color = $(this).attr("id");
		 $(".right_chat").css("display","inline-block");
		 $(".chat_pati_list").css("display","inline-block");
		 
		 AjaxGWSelectChatRoomListEmp();
		 $(".chat_title_txt").text($(this).children().text());
		 console.log($(this).children().text());
		 
		 if(refreshInterval == ""){
			 refreshInterval = setInterval(read,1000);
		 }else {
			 clearInterval(refreshInterval);
			 $(".chat_con").empty();
			 refreshInterval = setInterval(read,1000);
		 }
     }
    
   });

   $("#chat_Btn").on("click",function(){
	   if($.trim($("#con").val()) == ""){
		   makeAlert(3,"에러","내용을 입력해주세요.",false,null);	   
	   }else{
			insertMsg();
	   }
   });
   
   $("#EXChatRoom").on("click",function(){
	   makeConfirm(3,"채팅방 삭제","정말 채팅방을 나가시겠습니까?",true,function(){
		   AjaxExitChatRoom();
		   $(".right_chat").css("display","none");
		   $(".chat_pati_list").css("display","none");
	   });
   })
   
});
//엔터키 처리
function enterCheck(){
   if(event.keyCode == 13){
      if($.trim($("#con").val()) == "") {
         makeAlert(1, "알림", "내용을 입력해 주세요.", false, null);
      } else {
    	 insertMsg();
      }
   }
}

//채팅방 나가기
function AjaxExitChatRoom(){
	var params = $("#readForm").serialize();
	  
	$.ajax({
	   type : "post",
	   url : "AjaxGWExitChatRoom",
	   dataType : "json",
	   data : params,
	   success : function(result) {
		   AjaxGWChatRoomList();
		   clearInterval(refreshInterval);
		   refreshInterval = "";
	   },
	   error : function(result) {
	      alert(result.errorMessage);
	   }
	});
}

//채팅인서트
function insertMsg(){
   var params = $("#SendForm").serialize();
   
   $.ajax({
      type : "post",
      url : "AjaxGWinsertChat",
      dataType : "json",
      data : params,
      success : function(result) {
         $("#con").val("");
         $("#msg").val("");
         AjaxLastChatNoUpdate();
      },
      error : function(result) {
         alert(result.errorMessage);
         $("#con").val("");
         $("#msg").val("");
      }
   });
}

// 인터벌을 활용해 채팅계속 받아오기
function read() {
//   clearInterval(refreshInterval);
   var params =  $("#readForm").serialize();
   
   $.ajax({
      type : "post",
      url : "AjaxGWChatList",
      dataType : "json",
      data : params,
      success : function(result) {
         if(result.list.length != 0) {
            var html = "";
            for(var i = 0 ; i < result.list.length ; i++) {
               if(result.list[i].EMP_NO == "${sEmpNo}"){
                  html += "<div class=\"me\">";
                  html += "<div class=\"Mcon\">" + result.list[i].CON + "</div>";
				  if(result.list[i].NO_READ_CNT == "0"){
	                  html += "<div class=\"no_read\"><span>" + "</span></div>";
				  }else{
	                  html += "<div class=\"no_read\"><span>" + result.list[i].NO_READ_CNT + "</span></div>";
				  }
                  html += "<div class=\"time\">" + result.list[i].WRITE_DAY + "</div>";
                  html += "</div>";
                	  
               }else{
            	  html +="<div class=\"you\">"
            	  html +="<div class=\"Ypic\"> <span> <img alt=\"사진\" src=\"resources/images/erp/gw/msg/person.png\"> </span> </div>";
            	  html +="<div class=\"Yspace\">";
            	  html +="<div class=\"Yname\">" + result.list[i].NAME +"</div>"
                  html += "<div class=\"Ycon\">" + result.list[i].CON + "</div>";
                  html += "<div class=\"Ytime\">" + result.list[i].WRITE_DAY + "</div>";
                  html += "</div>";
                  if(result.list[i].NO_READ_CNT == "0"){
                	  html += "<div class=\"no_read\"><span>" + "</span></div>";
				  }else{
	                  html += "<div class=\"Yno_read\"><span>" + result.list[i].NO_READ_CNT + "</span></div>";
                  }
                  html += "</div>";
               }
            }
            //html += "<div class=\"togglebox\"><input type=\"text\" placeholder=\"검색토글\">◀</div>";
            $(".chat_con").append(html);
            $("#lastChatNo").val(result.list[result.list.length - 1].CHAT_NO);
         }
        AjaxLastChatNoUpdate();
       	$('.chat_con').slimScroll({
       					scrollTo: $(".chat_con").height() + "px",
       					startY: 'bottom'
       	 				//wheelStep: 5
       					//scrollBy: ($(".chat_con").height() * 2) + "px" 
       	 				});
         
         //refreshInterval = setInterval(read,1000);
      },
      error : function(request, status, error){
         console.log("실패");
         console.log("status : " + request.status);
         console.log("text : " + request.responseText);
         console.log("error : " + error);
         //refreshInterval = setInterval(read,1000);
      }
   });
}

function AjaxLastChatNoUpdate(){
	var params = $("#readForm").serialize();
	  
	$.ajax({
	   type : "post",
	   url : "AjaxLastChatNoUpdate",
	   dataType : "json",
	   data : params,
	   success : function(result) {
		console.log("오우 케이 성공^^");
	   },
	   error : function(result) {
	      alert(result.errorMessage);
	   }
	});
}

</script>

</head>
<body>
<c:import url="/topLeft">
	<%-- <c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="6"></c:param> --%>
	<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
</c:import>


<div class="content_area">
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 채팅방</div>
	<!-- 내용 영역 -->

<div class="chat">
			<div class = "left_chat">
				<div class = "org">
					<div class="org_title">
						<div class = org_name>조직도</div>
						<img alt = "축소" id="orgAreaHidden" src= "resources/images/erp/gw/msg/minus2.png" width = 20px; height = 20px; align ="right" style="margin : 5px; cursor: pointer;"/>
						<img alt = "확대" id="orgAreaNHidden" src= "resources/images/erp/gw/msg/plus2.png" width = 20px; height = 20px; align ="right" style="margin : 5px; display : none; cursor: pointer;"/>
					</div>
					<div class="org_search">
						<img alt = "검색" src ="resources/images/erp/gw/msg/search2.png" width = 20px; height = 20px; style="margin : 5px;"/>
						<input type="search"/>
					</div>
					
					
					<!-- 일단 상후 조직도 뿌리는 라인 -->
					
					<form action="#" id="dataForm" method="post">
						<input type="hidden" id="deptNo" name="deptNo" />
						<input type="hidden" id="empName" name="empName" />
						<div id="except"></div>
						<input type="hidden" id="newApvLineName" name="newApvLineName" />
						<input type="hidden" id="apverEmpNo" name="apverEmpNo" />
						<input type="hidden" id="delApvLineNo" name="delApvLineNo" />
					</form>
					
					<form action="#" id="insertChatEmpForm" method="post">
						<input type="hidden" id ="chatRoomNo3" name="chatRoomNo3" value="NoData"/>
						<input type="hidden" id ="chatRoomEmpNo" name="chatRoomEmpNo" value="${sEmpNo}"/>
					</form>
					
					<div class="orgArea">
              	 		<span><img alt="folder" src="resources/images/erp/gw/ea/folder.png">HeyWe</span><br/>
              			 <div class="orgList"></div> <!-- 리스트 뿌려주는 곳 --> 
            		</div>
            		
				</div>
				<div class = "profile">
					<div class="profile_title">
						<form action="#" id="insertChatRoomForm" method="post">
							<input type="hidden" id="chatRoomTitle" name="chatRoomTitle"/>
						</form>
						<div class="profile_name">사원 프로필</div>
							<img alt = "축소" id="profileHidden" src= "resources/images/erp/gw/msg/minus2.png" width = 20px; height = 20px;  align = "right" style="margin : 5px; cursor: pointer;"/>
							<img alt = "확대" id="profileNHidden" src= "resources/images/erp/gw/msg/plus2.png" width = 20px; height = 20px;  align = "right" style="margin : 5px; display: none; cursor: pointer;"/>
					</div>
					<div class="profile_con">
						<table>
							<thead>
								<tr>
									<th>  </th><th> 부서 </th><th> 직책 </th><th> 이름 </th><th> X </th><th> X </th>
									<th><img alt="피플" id="peopleInsert" src="resources/images/erp/gw/msg/people.png" width ="20px" height = "20px" style="margin-right : 5px; cursor: pointer;"/> </th>
								</tr>
							</thead>
							<tbody> <tr><td colspan="5">조직도를 눌러 사원을 선택하여 주세요</td></tr> </tbody>
						</table>
					</div>
				</div>
				<div class = "chat_list">
					<div class="chat_list_title">
						<div class="list_name">내 채팅방 목록
							<img alt = "축소" id="chatRoomListHidden" src= "resources/images/erp/gw/msg/minus2.png" width = 20px; height = 20px;  align = "right" style="margin : 5px; cursor: pointer; margin-right: -7pt;"/>
							<img alt = "확대" id="chatRoomListNHidden" src= "resources/images/erp/gw/msg/plus2.png" width = 20px; height = 20px;  align = "right" style="margin : 5px; display: none; margin-right: -7pt; cursor: pointer;"/>
						</div>
						<form action="#" id="chatRoomListForm" method="post">
							<input type="hidden" name="empNo" value="${sEmpNo}"/>
						</form>
					</div>
					<div class="chat_list_search">
						<img alt = "검색" src ="resources/images/erp/gw/msg/search2.png" width = 20px; height = 20px; style="margin : 5px;"/>
						<input type="search"/>
						</div>
						
					<div class="chat_list_con">
						
					</div>
				</div>
			</div>
			
			<div class = "right_chat"> <!-- 채팅방 우측 -->
				<form action="#" id="readForm" method="post">
			        <input type="hidden" id="lastChatNo" name="lastChatNo" value="1"/>
					<input type="hidden" id="chatRoomNo" name="chatRoomNo" value="NoData"/>
					<input type="hidden" id="exChatRoomEmpNo" name="exChatRoomEmpNo" value="${sEmpNo}"/>
				</form>		
			
			
				<div class = "chat_title">
				 	<span class="chat_title_txt">김수한무, 동방삭, 이성훈 … 4인</span>
					<img id="bellbell" alt="벨벨" src= "resources/images/erp/gw/msg/bell.png" width = 20px; height=20px; style="margin-left: 10px; cursor: pointer;"/>
					<img id="EXChatRoom" alt = "나가기" src="resources/images/erp/gw/msg/exit.png" width ="20px" height = "20px" align = "right" style="margin : 5px; cursor: pointer;"/>
				</div>
				<div class = "chat_con">
				<div class="hi">
				<!-- 채팅방 내부 -->
				<!--<div class = "down">
							<div class = "text">인사팀 창고 장부~.ppxt<br/>
							(2019.04.08 ~ 2019.05.08)</div>
							<div class = "Btn"><input type ="button" value = "다운로드"/></div>
							</div>
							<div class = "no_read"><span>1</span></div>
							<div class = "time">16 : 32</div>
					</div>
					<div class ="you">
						<div class = "Ypic">
							<span>
							<img alt="사진" src="resources/images/erp/gw/msg/person.png" width ="38px" height = "38px"/>
							</span>
						</div>
						<div class = "Yspace">
							<div class = "Yname">치카포 대리</div>
							<div class = "Ycon">내용1</div>
							<div class = "Ytime">16 : 38</div>
						</div>
							<div class = "Yno_read"><span>1</span></div>
					</div> -->
				</div>
				</div>
				<div class ="notice">김수한무, 동방삭, 치카포가 초대되었습니다.</div>
				<div class ="send">
				<div class = "chat_write">
					<div class = "chat_write_chat">
						<form action="#" id="SendForm" method="post">
							  <input type="hidden" id="chatRoomNo2"name="chatRoomNo2" value=""/>
						      <input type="hidden" name="empNo" value="${sEmpNo}"/>
						      <input type="text" id="con" name="con" onkeydown="javascript:if(event.keyCode==13){enterCheck();return false;};"/>					
						      <input type="hidden" name="fileName" value=""/>
						</form>
					</div>
					<div class = "chat_write_space">
						<div class = "chat_write_Btn">
							<input type = "button" value="보내기" id="chat_Btn"/>
							
						
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<div class = "chat_pati_list">
			<div class = "chat_pati"> 참여인원<hr/>
				<div class = "pati_con">김수한무<br/>동방삭<br/>이성훈<br/>치카포</div>
			</div>
			<div class = "chat_etcBtn">
				<img alt = "검색토글" src = "resources/images/erp/gw/msg/search2.png" width = 40px; height = 40px style="margin-left : 10px"/>
				<img alt = "자료보내기" src ="resources/images/erp/gw/msg/box.png" width = 60px; height = 60px style="margin-left : 5px"/>
			</div>
		</div>
</div>
</body>
</html>