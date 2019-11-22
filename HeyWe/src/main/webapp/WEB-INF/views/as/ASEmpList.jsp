<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인재 현황</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/as/Emp_HS.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

// 우편번호
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

$(document).ready(function() {
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'button',
		closeText: '닫기',
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd'    
	});
	$("#date_start").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
			$("#eprtnDateValue").val($("#date_start").val());
			console.log(startDate);
		}
	});
		
	/* 인재등록 버튼 (팝업 생성) */
	
	$("#empRegiBtn").on("click", function() {
		if("${sAuthNo}"==7){
		
		var html = "";
		html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
		html += "<div class=\"input_area\">";
		html += "<div class=\"input_area_ex\">필수입력사항은 * 표시</div>";
		html += "<div class=\"input_area_left\">";
		html += "<div class=\"input_area_txt1\">성 명(*)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"empNm\" name=\"empNm\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_right\">";
		html += "<div class=\"input_area_txt1\">E-Mail(*)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"empMail\" name=\"empMail\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_right\">";
		html += "<div class=\"input_area_txt1\">연락처(*)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"empPn\" name=\"empPn\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_left\">";
		html += "<div class=\"input_area_txt1\">나 이(*)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"empAge\" name=\"empAge\" placeholder=\"숫자만 입력\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_left\">";
		html += "<div class=\"input_area_txt1\">사용기술(*)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" size=\"20\" id =\"empSk\" name=\"empSk\" /></div>";
		html += "</div>";
		html += "<div class=\"input_area_picture\">";
		html += "<div class=\"input_area_txt1\">사 진</div>";
		html += "<div class=\"input_area_pic\">";
		html += "<input type=\"hidden\" id=\"empPic\" name=\"empPic\" />";
		html += "<div id=\"finish\"></div>";
		html += "</div>";
		
		html += "<div class=\"input_area_button\">";
		html += "<input type=\"hidden\" id=\"fileName1\" readonly=\"readonly\" />";
		html += "<div class=\"btn\"><input type=\"button\" value=\"사진찾기\" id=\"fileBtn1\" /></div>";
		
		
		html += "</div>";
		html += "</div>";
		html += "<div class=\"input_area_left\">";
		html += "<div class=\"input_area_txt1\">우편번호(*)</div>";
		html += "<div class=\"input_area_txt5\"><input type=\"text\" id=\"sample6_postcode\" name=\"empPo\" placeholder=\"숫자만 입력\"></div>";
		html += "<div class=\"btn\"><input type=\"button\" onclick=\"sample6_execDaumPostcode()\" value=\"찾기\"></div>";
		html += "</div>";		
		html += "<div class=\"input_area_left\">";
		html += "<div class=\"input_area_txt1\">주 소(*)</div>";
		html += "<div class=\"input_area_txt2\"><input type=\"text\" id=\"sample6_address\" name=\"empAd\" placeholder=\"주소\" readonly=\"readonly\"></div>";
		html += "</div>";		
		html += "<div class=\"input_area_left\">";
		html += "<div class=\"input_area_txt3\"><input type=\"text\" id=\"sample6_detailAddress\" name=\"empAdD\" placeholder=\"상세주소\"><input type=\"hidden\" id=\"sample6_extraAddress\" placeholder=\"참고항목\"></div>";
		html += "</form>";	
		html += "<div class=\"real_file_area\">";
		html += "<form action = \"fileUploadAjax\" method=\"post\"  id=\"uploadForm\" enctype=\"multipart/form-data\"  >";
		html += "<input type=\"file\" name=\"attFile1\" id=\"attFile1\"><br/>";
		html += "</form>";
		html += "</div>";
		html += "</div>";	
		html += "</div>";
	

		makePopup(1, "인재 등록", html, true, 850, 600,
				function() {
			// 컨텐츠 이벤트
			 $("#fileBtn1").on("click", function() {
				$("#attFile1").click();
			 });
			
			   $("#empAge").bind("keyup", function(event) {
	                var regNumber = /^[0-9]*$/;
	                var temp = $("#empAge").val();
	                if(!regNumber.test(temp))
	                {
	                    makeAlert(2, "", "숫자만 입력하세요", null, null);
	                    $("#empAge").val(temp.replace(/[^0-9]/g,""));
	                    $("#empAge").focus();
	                }
	            });
			   
			   $("#sample6_postcode").bind("keyup", function(event) {
	                var regNumber = /^[0-9]*$/;
	                var temp = $("#sample6_postcode").val();
	                if(!regNumber.test(temp))
	                {
	                    makeAlert(2, "", "숫자만 입력하세요", null, null);
	                    $("#sample6_postcode").val(temp.replace(/[^0-9]/g,""));
	                    $("#sample6_postcode").focus();
	                }
	            });
			
			 $(".real_file_area").on("change","input", function() {
					 var uploadForm = $("#uploadForm");
	               
	               uploadForm.ajaxForm({//폼을 실행 할 때는 ajax형태로 동작 하겠다. (form안에 있는 형태로 , submit을 해야 ajax가 동작한다.)
	                  beforeSubmit: function() {//Form 실행 전 실행될 내용
	                     
	                  },
	                  success : function(result) {
	                  	if(result.result == "SUCCESS"){
	                     	var html = "";
	                     
	                     	html= "<img src=\"resources/upload/" + result.fileName[0] +  "\" />";
	                     
	                     	$("#empPic").val(result.fileName[0]);
	                        $("#finish").html(html);
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
			});	
			 
			 
		}, 
		"입력하기", function(){
			var regNumber =  /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
            var temp = $("#empPn").val();
			
			if($.trim($("#empNm").val())==""){
	               makeAlert(2, "", "성명을 입력하세요", null, null);
	               $("#empNm").focus();
	            } else if($.trim($("#empMail").val())==""){
	            	makeAlert(2, "", "E-Mail을 입력하세요", null, null);
		            $("#empMail").focus();
	            } else if($.trim($("#empPn").val())==""){
	            	makeAlert(2, "", "연락처를 입력하세요", null, null);
		            $("#empPn").focus();
	            } else if(!regNumber.test(temp)){
                    makeAlert(2,"","휴대전화 번호를 확인하세요",null, null);
                    $("#empPn").val('');
                    $("#empPn").focus();
                 }else if($.trim($("#empAge").val())==""){
	            	makeAlert(2, "", "나이를 입력하세요", null, null);
		            $("#empAge").focus();
	            } else if($.trim($("#empSk").val())==""){
	            	makeAlert(2, "", "사용기술을 입력하세요", null, null);
		            $("#empSk").focus();
	            } else if($.trim($("#sample6_postcode").val())==""){
	            	makeAlert(2, "", "우편번호를 입력하세요", null, null);
		            $("#sample6_postcode").focus();
	            } else if($.trim($("#sample6_address").val())==""){
	            	makeAlert(2, "", "주소를 입력하세요", null, null);
		            $("#sample6_address").focus();
	            } else if($.trim($("#sample6_detailAddress").val())==""){
	            	makeAlert(2, "", "상세주소를 입력하세요", null, null);
		            $("#sample6_detailAddress").focus();
	            } else {
			$("#actionForm").attr("action","ASEmpList")
				ASRegiEmpAjax();
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
		$("#dataForm #empNo").val($(this).parent().attr("name"));
		dtlForm();
	});
	
});

//////////////////////** Ajax Area ** //////////////////////

function ASRegiEmpAjax(){
	var params = $("#actionForm").serialize();

	$.ajax({
		type : "post",
		url : "ASRegiEmpAjax",
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

function ASRegiCarAjax(){
	var params = $("#actionForm").serialize();
	console.log(params);
	$.ajax({
		type : "post",
		url : "ASRegiCarAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			makeAlert(3, "", "등록하였습니다!", true, function () {
				reloadList();			
				closePopup(2);
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
		url : "ASEmpListAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			if(result.list.length == 0 && $("#page").val() != 1) {
				$("#page").val($("#page").val() * 1 - 1);
				reloadList();
			} else {
				redrawList(result.list);
				redrawPaging(result.pb);
			}
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
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for(var i = 0 ; i < list.length ; i++) {
			if(i % 2 == 0){
				 html += "<tr name=\"" + list[i].EMP_NO + "\">";
			}else{
				 html += "<tr name=\"" + list[i].EMP_NO + "\" class=\"sec_tr\">";
			}  
			html += "<td>" + list[i].NAME + "</td>";
			html += "<td>" + list[i].POSI_NAME + "</td>";
			html += "<td>" + list[i].AGE + "</td>";
			html += "<td>" + list[i].FLAG + "</td>";	
			html += "<td>" + list[i].SUM_WORK + "</td>";	
			html += "<td>" + list[i].IP_CNT + "</td>";	
			html += "<td>" + list[i].INPUT_FLAG + "</td>";	
			html += "<td></td>";					
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
		url : "AsEmpDtlAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList2(result.data,result.list);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

/* function redrawList3(list) {
	var html = "";
		for(var i = 0 ; i < list.length ; i++) {
			if(i % 2 == 0){
				 html += "<tr name=\"" + list[i].ENO + "\">";
			}else{
				 html += "<tr name=\"" + list[i].ENO + "\" class=\"sec_tr\">";
			}  
			html += "<td>" + list[i].SOLNM + "</td>";
			html += "<td>" + list[i].PSTD + "</td>";
			html += "<td>" + list[i].MKNM + "</td>";
			html += "<td>" + list[i].PTYPE + "</td>";	
			html += "<td>" + list[i].PAPPSOL + "</td>";						
			html += "</tr>";
		}
	$("#table_2_wrap tbody").html(html);
} */

function drawPosi(list){
	var html = "";
	
	for(var i = 0 ; i < list.length ; i++){
		html += "<option value=\""+ list[i].POSI_NO +"\">"+ list[i].POSI_NAME +"</option>";
	}
	
	$("#slt").append(html);
}

function redrawList2(data,list){

	var html = "";
	
	html +=	"<form action=\"#\" id=\"updateDataForm\" method=\"post\">";
	html += "<input type=\"hidden\" name=\"empNo\" id=\"empNo\" value=\"" + data.EMP_NO  + "\" >";
	html += "<div class=\"input_area2\">";
	html += "<div class=\"input_area_profile1\">";
	html += "<div class=\"input_area_pic\">";
	if(data.PIC == null || data.PIC == "") {
		html += "<img alt=\"사진없음\" src=\"resources/images/erp/common/nopic.png\"/>";
	} else {
		html += "<img src=\"resources/upload/"+ data.PIC + "\" id=\"empPic\">";
	}
	html += "</div>";
	html += "<div class=\"io\">" + data.FLAG + "</div>";
	html += "<div class=\"profile\">";
	html += "<div class=\"input_area_txt2\">성명 : <input type=\"text\" size=\"20\" id =\"empNm\" name=\"empNm\" value=\"" + data.NAME + "\" /></div>";
	html += "<div class=\"input_area_txt2\">직급 : <input type=\"text\" size=\"20\" id =\"empPs\" name=\"empPs\" value=\"" + data.POSI_NAME + "\" readonly=\"readonly\" /></div>";
	html += "<div class=\"input_area_txt2\">나이 : <input type=\"text\" size=\"20\" id =\"empAge\" name=\"empAge\" value=\"" + data.AGE + "\" /></div>";
	html += "</div>";
	html += "</div>";
	html += "<div class=\"input_area_profile2\">";
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">사용기술</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empSk\" name=\"empSk\" value=\"" + data.SKILL + "\" /><br/>";
	html += "</div>"
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">경력</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empSw\" name=\"empSw\" value=\"" + data.SUM_WORK + "\" readonly=\"readonly\" /><br/>";
	html += "</div>"
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">진행건수</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empCnt\" name=\"empCnt\" value=\"" + data.IP_CNT + "\" readonly=\"readonly\" /><br/>";
	html += "</div>"
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">연락처</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empPn\" name=\"empPn\" value=\"" + data.MOBILE_NO + "\" /><br/>";
	html += "</div>"
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">E-Mail</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empMail\" name=\"empMail\" value=\"" + data.EMAIL + "\" /><br/>";
	html += "</div>"
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">주소</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empAd\" name=\"empAd\" value=\"" + data.ADDR + "\" /><br/>";
	html += "</div>"
	html += "<div class=\"input_area_txt\">";
	html += "<div class=\"input_area_txt3\">상세 주소</div>";
	html += "<input type=\"text\" size=\"20\" id =\"empAdD\" name=\"empAdD\" value=\"" + data.DTL_ADDR + "\" /><br/>";
	html += "</div>"

	html += "<div class=\"btn\"><input type=\"button\" value=\"경력 등록\" id=\"carBtn\" /></div>";

	html += "</div>";
	html += "<div class=\"table_area2\">";
	html += "<table id=\"table_2\">";
	html +="<colgroup>";
	html +="<col width=\"112\" />"
		html += "<col width=\"112\" />";
		html += "<col width=\"112\" />";
		html += "<col width=\"112\" />";
		html += "<col width=\"112\" />";
		html += "</colgroup>";
		html += "<thead>";
		html += "<tr id=\"table_upper\">"
			html += "<th>프로젝트명</th>";
			html += "<th>기 간</th>";
			html += "<th>고객사</th>";
			html += "<th>유 형</th>";
			html += "<th>적용솔루션</th>";
			html += "</tr>";
			html += "</thead>";
			html += "</table>";
			html += "<div id=\"table_2_wrap\">";
			html += "<table id=\"table_2\">";
			html += "<colgroup>";
			html += "<col width=\"112\" />";
			html += "<col width=\"112\" />";
			html += "<col width=\"112\" />";
			html += "<col width=\"112\" />";
			html += "<col width=\"112\" />";
			html += "</colgroup>";
			html += "<tbody>";
			
			if(list.length == 0) {
				html += "<tr><td colspan=\"5\">조회결과가 없습니다.</td></tr>";
			} else {
				for(var i = 0 ; i < list.length ; i++) {
				if(i % 2 == 0){
					 html += "<tr name=\"" + list[i].ENO + "\">";
				}else{
					 html += "<tr name=\"" + list[i].ENO + "\" class=\"sec_tr\">";
				}  
				html += "<td>" + list[i].SOLNM + "</td>";
				html += "<td>" + list[i].PSTD + "</td>";
				html += "<td>" + list[i].MKNM + "</td>";
				html += "<td>" + list[i].PTYPE + "</td>";	
				html += "<td>" + list[i].PAPPSOL + "</td>";						
				html += "</tr>";
				}
			}
			$("#table_2_wrap tbody").html(html);
			
			html += "</tbody>";
			html += "</table>";
			html += "</div>";
			html += "</div>";
			html += "</div>";
			html +=	"</form>"; 

if(data.FLAG == "외부") {			
	makeTwoBtnPopup(1, "인재 상세정보", html, true, 600, 610,
			function() {
				$("#empAge").bind("keyup", function(event) {
		            var regNumber = /^[0-9]*$/;
		            var temp = $("#empAge").val();
		            if(!regNumber.test(temp))
		            {
		                makeAlert(2, "", "숫자만 입력하세요", null, null);
		                $("#empAge").val(temp.replace(/[^0-9]/g,""));
		                $("#empAge").focus();
		            }
		        });
		$("#carBtn").on("click", function() {
			if("${sAuthNo}"==7){
				
			var html = "";
			html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
			html += "<input type=\"hidden\" name=\"empNo\" id=\"empNo\" value=\"" + $("#updateDataForm #empNo").val() + "\" >";
			html += "<input type=\"hidden\" id=\"stdt\" name=\"stdt\" value=\"${stdt}\" />";
			html += "<input type=\"hidden\" id=\"eddt\" name=\"eddt\" value=\"${eddt}\" />";
			html += "<div class=\"input_area3\">";
			html += "<div class=\"input_area_line\">";
			html += "<div class=\"input_area_txt1\">직장명</div>";
			html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"carNm\" name=\"carNm\" /></div>";
			html += "</div>";
			html += "<div class=\"input_area_line\">";
			html += "<div class=\"input_area_txt1\">직위</div>";
			html += "<div class=\"input_area_txt3\">";
			html += "<select id=\"slt\">";
			html += "<option value=\"1000\">선택</option>";
			html += "</select>";
			html += "</div>";
			html += "</div>";
			html += "<div class=\"input_area_line\">";
			html += "<div class=\"input_area_txt1\">근무시작일</div>";
			html += "<div class=\"input_area_txt3\"><input type=\"date\" size=\"20\" id=\"WrkSt\" name=\"WrkSt\" value=\"\" readonly=\"readonly\" /></div>";
			html += "</div>";
			html += "<div class=\"input_area_line\">";
			html += "<div class=\"input_area_txt1\">근무종료일</div>";
			html += "<div class=\"input_area_txt3\"><input type=\"date\" size=\"20\" id=\"WrkEnd\" name=\"WrkEnd\" value=\"\" readonly=\"readonly\" /></div>";
			html += "</div>";
			html += "<div class=\"input_area_line\">";
			html += "<div class=\"input_area_txt1\">업무</div>";
			html += "<div class=\"input_area_txt3\"><input type=\"text\" size=\"20\" id =\"WrkTsk\" name=\"WrkTsk\" /></div>";
			html += "</div>";
			html += "</div>";
			html += "</form>";
			
			makePopup(2, "경력 등록", html, true, 400, 400,
					function() {
				//직위 선택
				$.ajax({
					type : "post",
					url : "HRPosiAskAjax",
					dataType : "json",
					success : function(result){
						drawPosi(result.list);
					},
					error : function(request, status, error){
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});			
				
				// 컨텐츠 이벤트
				$("#WrkSt").datepicker({
							dateFormat : 'yy-mm-dd',
							duration: 200,
							onSelect:function(dateText, inst){
								var startDate = parseInt($("#WrkEnd").val().replace("-", '').replace("-", ''));
								var endDate = parseInt(dateText.replace(/-/g,''));
								
					            if (endDate > startDate) {
					            	makeAlert(3, "", "조회 기간 재설정 요망!", true, function () {
						        		$("#WrkSt").val($("#stdt").val());					            		
					            	});
								} else {
									$("#stdt").val($("#WrkSt").val());
								}
							}
						});

				$("#WrkEnd").datepicker({
							dateFormat : 'yy-mm-dd',
							duration: 200,
							onSelect:function(dateText, inst){
								var startDate = parseInt($("#WrkSt").val().replace("-", '').replace("-", ''));
								var endDate = parseInt(dateText.replace(/-/g,''));
								
					            if (startDate > endDate) {
					            	makeAlert(3, "", "조회 기간 재설정 요망!", true, function () {
						        		$("#WrkEnd").val($("#eddt").val());					            		
					            	});
								} else {
									$("#eddt").val($("#WrkEnd").val());
								}
							}
						});
			}, "등록하기", function(){
				var startDate = parseInt($("#WrkSt").val().replace("-", '').replace("-", ''));
				var endDate = parseInt($("#WrkEnd").val().replace("-", '').replace("-", ''));
				
				if($.trim($("#carNm").val())==""){
		               makeAlert(3, "", "직장명을 입력하세요", null, null);
		               $("#carNm").focus();
		            } else if($("#slt").val()=="1000"){
		            	makeAlert(3, "", "직위를 선택하세요", null, null);
		            } else if($.trim($("#WrkSt").val())==""){
		            	makeAlert(3, "", "근무시작일을 입력하세요", null, null);
			            $("#WrkSt").focus();
		            } else if($.trim($("#WrkTsk").val())==""){
		            	makeAlert(3, "", "업무를 입력하세요", null, null);
			            $("#WrkTsk").focus();
		            } else {
		            	if(endDate - startDate <= 365){
		            		makeAlert(3, "", "안내) 계산 결과 경력은 0년 으로 출력됩니다.", null, null);
							ASRegiCarAjax();
							closePopup(2);
		            	} else {
							ASRegiCarAjax();
							closePopup(2);
		            	}
				}
			});
		} else {
			makeAlert(3, "", "권한이 없습니다!", null, null);
		}
		});
		
	}, "수정", function(){
		if("${sAuthNo}"==7){
		makeAlert(2, "", "수정하였습니다!", true, function () {
			var params = $("#updateDataForm").serialize();
			$.ajax({
				type : "post",	
				url : "AsEmpUpdateAjax",	
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
		}, "삭제", function(){
			if("${sAuthNo}"==7){
			makeConfirm(2, "", "삭제하시겠습니까?", true, function () {
				var params = $("#dataForm").serialize();
				$.ajax({
					type : "post",	
					url : "AsEmpDeleteAjax",	
					dataType : "json",	
					data : params,
					success : function (result) {
						if(result.flag == 1){					
							$("#flag").val("삭제됨");
							reloadList();
							closePopup(1);
						} else{
							alert(result.msg);									
						}
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
	} else {
		makeNoBtnPopup(1, "인재 상세정보", html, true, 600, 610,
				function() {
			// 컨텐츠 이벤트
			$(".input_area2 input").prop("readonly", true);
			$(".btn input").prop("hidden", true);
		});
	}
}
</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="39"></c:param>
	<c:param name="leftMenuNo" value="44"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
<div class="content_area">
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 자산 &gt; 인재 현황 &gt; 인재 관리 현황</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">인재 관리 현황</div>
	<!-- 내용 영역 -->
	<form action="#" id="dataForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}" /> 
			<input type="hidden" name="empNo" id="empNo" />
		<div class="opt_line">
			<div class="left_side">
					<select name="searchGbn" class="sel">
					<option value="2">전 체</option>
					<option value="0">성 명</option>
					<option value="1">직 급</option>
				</select> 
				<input type="text" name="searchTxt" size="20" class="txt_line" placeholder="검색어 입력" /> 
				<input type="button" value="찾기" class="search" id="searchBtn" />
			</div>
			<div class="right_side">
				<input type="button" value="인재등록" class="Btn" id="empRegiBtn"/>
			</div>
		</div>
		</form>
		<div class="table_area">
			<table id="board">
				<colgroup>
					<col width="150" />
					<col width="150" />
					<col width="80" />
					<col width="170" />
					<col width="90" />
					<col width="130" />
					<col width="130" />
					<col width="50" />
				
				</colgroup>
				<thead>
					<tr>
						<th>성명</th>
						<th>직급</th>
						<th>나이</th>
						<th>내 / 외부</th>
						<th>경력</th>
						<th>진행건수</th>
						<th>투입여부</th>
						<th></th>
					
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