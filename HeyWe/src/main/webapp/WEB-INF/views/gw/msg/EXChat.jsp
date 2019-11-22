<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   refreshInterval = setInterval(read,1000);

   $("#SendMsgBtn").on("click", function(){
      if($.trim($("#msg").val()) == null) {
         alert("내용을 입력해 주세요.");
      } else {
         insertMsg();
      }
   });
   
   $("#chatRoom1").on("click",function(){
      $("#chatRoom1").css("background-color","yellow");
      $("#chatRoom2").css("background-color","white");
      $(".chatDataList").remove();
      
      $("#changeChatRoomNo").val("3");
      $("#lastChatNo").val("1");
   });

   $("#chatRoom2").on("click",function(){
      $("#chatRoom2").css("background-color","yellow");
      $("#chatRoom1").css("background-color","white");
      $(".chatDataList").remove();
      
      $("#changeChatRoomNo").val("4");
      $("#lastChatNo").val("1");
   });
   
});
//엔터키 처리
function enterCheck(){
   if(event.keyCode == 13){
      if($.trim($("#con").val()) == "") {
         alert("내용을 입력해 주세요.");
      } else {
         insert();
      }
      return;
   }
}

function insertMsg(){
   var params = $("#SendForm").serialize();
   
   $.ajax({
      type : "post",
      url : "AjaxinsertChat",
      dataType : "json",
      data : params,
      success : function(result) {
         $("#con").val("");
         $("#msg").val("");
      },
      error : function(result) {
         alert(result.errorMessage);
         $("#con").val("");
         $("#msg").val("");
      }
   });
}

function read() {
   clearInterval(refreshInterval);
   var params =  $("#readForm").serialize();
   
   $.ajax({
      type : "post",
      url : "AjaxChatList",
      dataType : "json",
      data : params,
      success : function(result) {
         if(result.list.length != 0) {
            var html = "";
            for(var i = 0 ; i < result.list.length ; i++) {
               
                  html += "<div class=\"chatDataList\">";
                  html += result.list[i].CON;
                  html += "</div>";
            }
            $(".chatList").append(html);
            $("#lastChatNo").val(result.list[result.list.length - 1].CHAT_NO);
         }
         
         refreshInterval = setInterval(read,1000);
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
</script>
</head>
<body>
   <form method="post" id="readForm">
      <input type="hidden" id="lastChatNo" name="lastChatNo" value="1"/>
      <input type="hidden" id="changeChatRoomNo" name="changeChatRoomNo" value="3"/>
   </form>

<div class="chatList">
</div>
<div>
   <form action="#" id="SendForm" method="post">
      <input type="hidden" name="chatRoomNo" value="3"/>
      <input type="hidden" name="empNo" value="${sEmpNo}"/>
      <input type="hidden" name="fileName" value=""/>
      
      <input type="text" id="con" name="con" onkeydown="enterCheck();"/>
      <input type="button" id="SendMsgBtn" value="보내기" />
   </form>
</div>
<div>
   <div id="chatRoom1">제호</div>
   <div id="chatRoom2">중학</div>
</div>


</body>
</html>