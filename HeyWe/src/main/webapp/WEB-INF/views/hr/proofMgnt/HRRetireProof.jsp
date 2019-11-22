<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 퇴직증명서</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	drawSelectBox();
	drawPSelectBox();
	$("#searchTxt").on("keypress",function(event){
		if(event.keyCode==13){
			$("#searchBtn").click();
			return false;
		}
	});

	
   if($("#page").val() == "") {

      $("#page").val("1");

   }

   

   reloadList();

   

   $("#searchBtn").on("click", function() {
      $("#page").val("1");
      /* alert($("#deptSelectBox").val());
      alert($("#posiSelectBox").val()); */
      $("#deptNo").val($("#deptSelectBox").val());
      $("#posiNo").val($("#posiSelectBox").val());
      reloadList();

   });

   

   $("#pagingArea").on("click", "input", function() {

      $("#page").val($(this).attr("name"));

      reloadList();

   });
   
});

 
function drawSelectBox(){
	$.ajax({

	      type : "post",
	      url : "HRProofDeptAjax",
	      dataType : "json",
	      success : function(result) {
	         drawDeptSelectBox(result.list);
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }

	   });
}

function drawDeptSelectBox(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ;i++){
		html += "<option value=\""+ list[i].DEPT_NO +"\">"+ list[i].DEPT_NAME +"</option>";
		
	}
	
	
	$("#deptSelectBox").append(html);
}

function drawPSelectBox(){
	$.ajax({

	      type : "post",
	      url : "HRProofPosiAjax",
	      dataType : "json",
	      success : function(result) {
	         drawPosiSelectBox(result.list);
	      },
	      error : function(request, status, error) {
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }

	   });
} 

function drawPosiSelectBox(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ;i++){
		html += "<option value=\""+ list[i].POSI_NO +"\">"+ list[i].POSI_NAME +"</option>";
	}
	
	$("#posiSelectBox").append(html);
}

function reloadList() {

   var params = $("#dataForm").serialize();

   

   $.ajax({

      type : "post",

      url : "HRRetireProofAjax",

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
	console.log(list);

   var html = "";
   html +=	"<tr class= \"title\" ><th>사번</th><th>부서명</th><th>직위</th><th>입사일</th><th>퇴사일</th><th>성명</th></tr>"
   if(list.length == 0) {

      html += "<tr class= \"title_content\"><td colspan=\"6\">조회결과가 없습니다.</td></tr>";

   } else {

      for(var i = 0 ; i < list.length ; i++) {

         html += "<tr class =  \"title_content\" name=\"" + list[i].EMP_NO + "\">";

         html += "<td>" + list[i].EMP_NO + "</td>";
         
         html += "<td>" + list[i].DEPT_NAME + "</td>";

         html += "<td>" + list[i].POSI_NAME + "</td>";

         html += "<td>" + list[i].APNT_DATE + "</td>";

         html += "<td>" + list[i].FNSH_DATE + "</td>";
         
         html += "<td>" + list[i].NAME + "</td>";
         

         html += "</tr>";

      }

   }
	   $("#board tbody").html(html);

	$("tbody").on("click",".title_content",function(){
		 $("#no").val($(this).attr("name"));
		 /* alert($("#no").val()); */ /*들어오는 #no값 확인 */
	 	dataList();
	});
}

/* 사원조회 사원클릭시 데이터값 불러올 Ajax처리문 */
function dataList() {

	   var params = $("#dataForm").serialize();

	   $.ajax({
	      type : "post",
	      url : "HRRetireProofDtlAjax",
	      dataType : "json",
	      data : params,
	      success : function(result) {
	    	  makePopup(1, "퇴직증명서", empDtlPopup(result.data,result.data2,result.data3,result.data4), true, 1000, 900,
	    				function() {
	    			// 컨텐츠 이벤트
	    			
	    		}, "신청", function(){
	    			$("#contents").val($("#cons").val());
	    			makeAlert(2, "퇴직증명서", "신청되었습니다.", true, ProofApply);
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
	
function ProofApply() {
	
	$("tbody").on("click",".title_content",function(){
		 $("#no").val($(this).attr("name"));
	});
	
	var params = $("#dataForm").serialize();
	console.log( $("#no").val());
	console.log($("#contents").val());
	
	console.log(params);
	
	$.ajax({ 
		type : "post",  		//데이터 전송방식
		url : "HRRetireAskProofAjax",		//주소
		dataType : "json",		//데이터 전송 규격
		data : params,
		// json양식 -> {키:값,키:값,...}
		success : function(result) {  //성공했을 때 넘어오는 값을 result변수로 받겠다.
			
			if(result.msg=="" || result.msg== null){
			console.log(result.msg);
			
			}else{
				alert(result.msg);
			}
		},
		
		error : function(request, status, error) {
			console.log("status :" + request.status);
			console.log("text :" + request.responseText);
			console.log("error :" + error);
			
			
		}
	});
};

function empDtlPopup(data,data2,data3,data4) {

	var html = "";
	
	
	html+="<div class=\"jms\">";
	html+="<div class=\"bg\">";
	html+="<div class=\"popup\">";
	html+="<div class=\"popuptitle\">퇴직증명서</div>";
	html+="<div class=\"poptxt\">인적사항</div>";
	html+="<table class=\"jmspoptable\" border=\"1\" cellspacing=\"0\" >";
	html+="<colgroup>";
	html+="<col width=\"70px\" />";
	html+="<col width=\"100px\" />";
	html+="<col width=\"70px\" />";
	html+="<col width=\"100px\" />";
	html+="</colgroup>";
	html+="<thead></thead>";
	html+="<tbody>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td >성&nbsp;&nbsp;&nbsp;명</td>";
	html+="<td>"+data.NAME+"</td>";
	html+="<td>주민등록번호</td>";
	html+="<td>"+ data.RRNUM1 + - + data.RRNUM2 +"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>주&nbsp;&nbsp;&nbsp;소</td>";
	html+="<td colspan=\"3\">"+data.ADDR+"</td>";
	html+="</tr>";
	html+="</tbody>";
	html+="<tfoot></tfoot>";
	html+="</table>";
	html+="<div class=\"poptxt\">퇴직사항</div>";
	html+="<table class=\"jmspoptable\" border=\"1\" cellspacing=\"0\">";
	html+="<colgroup>";
	html+="<col width=\"70px\" />";
	html+="<col width=\"100px\" />";
	html+="<col width=\"70px\" />";
	html+="<col width=\"100px\" />";
	html+="</colgroup>";
	html+="<thead></thead>";
	html+="<tbody>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>회 사 명</td>";
	html+="<td>"+data2.CO_NAME+"</td>";
	html+="<td rowspan=\"2\">사업자 등록번호</td>";
	html+="<td rowspan=\"2\">"+data2.CO_REG_NO+"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>대 표 자</td>";
	html+="<td>"+data2.CO_RPSTNER+"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>소  재  지</td>";
	html+="<td colspan=\"3\">"+data2.ADDR+"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>퇴직당시부서</td>";
	html+="<td>"+data.DEPT_NAME+"</td>";
	html+="<td >퇴직당시직위</td>";
	html+="<td >"+data.POSI_NAME+"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>퇴직&nbsp;년&nbsp;월&nbsp;일</td>";
	html+="<td colspan=\"3\">"+data.FNSH_DATE+"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>용 도</td>";
	html+="<td colspan=\"3\" ><input type=\"text\" id=\"cons\" ></td>";
	html+="</tr>";
	html+="</tbody>";
	html+="<tfoot></tfoot>";
	html+="</table>";
	html+="<div class=\"poptxt\">발급처</div>";
	html+="<table class=\"jmspoptable\" border=\"1\" cellspacing=\"0\" >";
	html+="<colgroup>";
	html+="<col width=\"70px\" />";
	html+="<col width=\"100px\" />";
	html+="<col width=\"70px\" />";
	html+="<col width=\"100px\" />";
	html+="</colgroup>";
	html+="<thead></thead>";
	html+="<tbody >";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>발급부서</td>";
	html+="<td>"+data3.DEPT_NAME+"</td>";
	html+="<td>담 당 자</td>";
	html+="<td>"+data3.NAME+"</td>";
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>직책</td>";
	html+="<td>"+data3.POSI_NAME+"</td>";
	html+="<td>연 락 처</td>";
	html+="<td>"+data2.CO_CONTACT+"</td>";
	html+="</tr>";
	html+="</tbody>";
	html+="<tfoot></tfoot>";	
	html+="</table>";
	html+="<div class=\"poptxt2\"> <pre>위와 같이 퇴직사항을 증명하며, 이 증명이 허위작성 또는 위조 등으로 다를 때에는</br>"
	html+="공,사문서의 위조, 변조, 통행사 등으로 인한 형사 처분도 감수하겠습니다.";
	html+="</br>"+data4.A+"</pre></div>";
	html+="<table class=\"jmspoptable2\" border=\"1\" cellspacing=\"0\" >";
	html+="<thead></thead>";
	html+="<tbody>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<td>담 당 자</td>";
	
	html+="</tr>";
	html+="<tr class=\"jmspopcnt\">";
	html+="<br/><th>"+data3.NAME+"</th>";

	html+="</tr>";
	html+="</tbody>";
	html+="<tfoot></tfoot>";
	html+="</table>";
	html+="<div class=\"popbtn_area\">";
	
	html+="</div>";		
	html+="</div>";
	html+="</div>";
	html+="</div>";	 
		
	
			return html;
	
}


function redrawPaging(pb){
      var html = "";
      html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";
      
      if($("#page").val() == "1"){
         html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
      } else {
         html += "<input type=\"button\" value=\"&lt\" name=\"" + ($("#page").val() * 1 - 1) + "\">";
      }
      
      for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
         if(i == $("#page").val()){
            html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" disabled=\"disabled\" class=\"paging_on\">";
         } else {
            html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i +  "\" class=\"paging_off\">";
         }
      }
      
      if($("#page").val() == pb.maxPcount) {
         html += "<input type=\"button\" value=\"&gt\" name=\"" + pb.maxPcount +  "\">"; 
      }else {
         html += "<input type=\"button\" value=\"&gt\" name=\"" + ($("#page").val() * 1 + 1) +   "\">";
      }
      
      html += "<input type=\"button\" value=\"&gt&gt\" name=\"" + pb.maxPcount +  "\">";
      
      $(".paging_group").html(html);
   }
 


</script>

<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/proofMgnt/HRRetireProof.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />

<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
</head>
<body>
<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
	<%-- <c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="55"></c:param> --%>
	 <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>
<div class="content_area">
<form action="#" id="dataForm" method="post">
		<input type="hidden" id="deptNo" name="deptNo" value="1000">
		<input type="hidden" id="posiNo" name="posiNo" value="1000">
		<input type="hidden" name="page" id="page" value="${page}" />
		<input type="hidden" name="no" id="no" />
		<input type="hidden" name="contents" id="contents" />
	<div class="content_nav">HeyWe &gt; 인사 &gt; 증명서관리 &gt; 퇴직자조회</div>
	<!-- 내용 영역 -->
	 <div class="content_title">
      
      <div class="content_title_text">증명서 관리 <퇴직자조회></div>
   </div>
   <br/>
   <br/>
<div class = "content">
	<div class="부서명">부서명 :</div>
	<select id="deptSelectBox">
		<option disabled="disabled"  value="1000">부서명</option>
		<option value="1000" selected="selected">전체</option>
	</select>
	
	<div class="직위명">직위명 :</div>
	<select id="posiSelectBox">
		<option disabled="disabled"  value="1000">직위명</option>
		<option value="1000" selected="selected">전체</option>
	</select>



	<div class="사원명">
		<input class="사원이름" type="text" placeholder="사원 이름" name="searchTxt" id="searchTxt" ></input>

	</div>
	<img class= "돋보기" alt="" src="resources/images/erp/hr/d.png" id="searchBtn" ></img>
</div>
	<div class="content_down"> 
	<table id="board" class="table" border='1' cellspacing='0'>
		<tbody></tbody>
	</table>
	
	<div id="pagingArea" class="paging_group"></div>
	
	</div>
</form>
</div>
</body>
</html>