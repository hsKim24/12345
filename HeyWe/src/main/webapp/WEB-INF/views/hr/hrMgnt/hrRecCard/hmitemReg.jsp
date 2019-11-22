<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 인사기록카드등록 </title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/hrRecCard/hmitemReg.css" />

<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<style type="text/css">
	.ui-datepicker select.ui-datepicker-year {
	    width: 48%;
	    font-size: 11px;
	}
	
	.ui-datepicker select.ui-datepicker-month {
	    width: 40%;
	    font-size: 11px;
	}
</style>
<!-- calendar select script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
	var aabtyIndex = 0;
	var licenseIndex = -1;
	var careerIndex = -1;
	var familyIndex = -1;
	
	$(document).ready(function(){
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			showOn: 'both',
			closeText: '닫기',
			changeMonth: true,
		    changeYear: true,
			buttonImage: 'resources/images/calender.png',
			buttonImageOnly: true,
			dateFormat: 'yy/mm/dd',
			yearRange: "-100:+0"
		});
		
		drawSelectBox();
		
		//인적사항버튼
		$("#hm_state").on("click",function(){
			hmstateBtnOn();
		});
		
		//학력버튼
		$("#aabty").on("click",function(){
			aabtyBtnOn();
		});
		
		//자격면허버튼
		$("#qlfc_license").on("click",function(){
			licenseBtnOn();
		});
		
		//경력버튼
		$("#career").on("click",function(){
			careerBtnOn();
		});
		
		//가족버튼
		$("#family").on("click",function(){
			familyBtnOn();
		});
		
		//인사발렬버튼
		$("#hrApnt").on("click",function(){
			hrApntBtnOn();
		});
		
		$(".tabbtn_area").children(".tabbtn").eq(0).click();
		
		$("#imageAdd").on("click", function(){
			$("#profileImgeFile").click();
		});
		
		//파일등록
		$("#profileDiv").on("change" , "input",function(){
			var fileName = $(this).val();

			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
			
			var uploadForm = $("#uploadForm");
			
			uploadForm.ajaxForm({
				beforSubmit : function(){
					
				},
				success : function(result){
					$("#formProfileImg").val(result.fileName[0]);
					$("#profileImage").attr("src", "resources/upload/" + result.fileName[0]);
				},
				error : function(request, status, error){
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				} 
			});
			
			uploadForm.submit();
		})
		
		$("#postNo, #addrSearchBtn, #addr").on("click", function(){
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
	                
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $("#postNo").val(data.zonecode);
	                $("#addr").val(addr +" " + extraAddr);
	                
	                $("#dtlAddr").focus();
	            }
	        }).open();
		});
		
		$("#rrnum1").on("change", function(){
			if(isNaN($(this).val() * 1)) {
				makeAlert(1, "주민등록번호", "숫자를 입력하세요.", true, null);
				$("#rrnum1").val("");
				$("#rrnum1").focus();
			}else if($(this).val().length != 6){
				makeAlert(1, "주민등록번호", "주민등록번호 앞 6자리를 입력해주세요.", true, null);
				$("#rrnum1").val("");
				$("#rrnum1").focus();
			}
		});
		
		$("#rrnum2").on("change", function(){
			if(isNaN($(this).val() * 1)) {
				makeAlert(1, "주민등록번호", "숫자를 입력하세요.", true, null);
				$("#rrnum2").val("");
				$("#rrnum2").focus();
			}else if($(this).val().length != 7){
				makeAlert(1, "주민등록번호", "주민등록번호 뒤 7자리를 입력해주세요.", true, null);
				$("#rrnum2").val("");
				$("#rrnum2").focus();
			}
		});
		
		$("#exte").on("change", function(){
			if(isNaN($(this).val() * 1)) {
				makeAlert(1, "내선번호", " 숫자만 입력하세요.", true, null);
				$("#exte").val("");
				$("#exte").focus();
			}
		});
		
		$("#mobileNo").on("change", function(){
			if(isNaN($(this).val() * 1)) {
				makeAlert(1, "휴대폰번호", " - 없이 숫자만 입력하세요.", true, null);
				$("#mobileNo").val("");
				$("#mobileNo").focus();
			}else if($.trim($(this).val()).length != 11){
				makeAlert(1, "휴대폰번호", "11자리를 입력해주세요.", true, null);
				$("#mobileNo").val("");
				$("#mobileNo").focus();
			}
		});
		
		$("#milserv").on("change" , function(){
			if($("#milserv").val() == "1"){
				$("#milserv_rank").attr("disabled", "disabled");
				$("#milserv_rank").val("");
			}else {
				$("#milserv_rank").removeAttr("disabled");
				$("#milserv_rank").val("");
			}
		});
		
		$("#disa").on("change", function(){
			if($("#disa").val() == "1"){
				$("#disa_con").attr("disabled", "disabled");
				$("#disa_con").val("");
			}else{
				$("#disa_con").removeAttr("disabled");
				$("#disa_con").val("");
			}
		});
		
		$("#scGrdDay0").on("keyup", function(){
			if($(this).val().length == 4){
				$(this).val($(this).val()+"-");
			}else if($(this).val().length > 4 && $(this).val().lastIndexOf("-") == -1){
				var yyyy = $(this).val().substring(0,4);
				var mm = $(this).val().substring(4,$(this).val().length - 1);
				
				$(this).val(yyyy + "-" + mm);
			}
			
			if($(this).val().length < 8){
				if(isNaN(($(this).val().substring(0,4) + $(this).val().substring(5,7)) * 1)) {
					makeAlert(1, "졸업연도", "숫자를 입력하세요.", true, null);
					$(this).val("");
				}
			}
		});
		
		$("#scGrdDay0").on("change", function(){
			if($(this).val().length != 7){
				$(this).val("");
				makeAlert(1, "졸업연도", "졸업연도를 정확히 작성하세요.", true, null);
			}
		});
		
		$("#degree_box0").on("change", function(){
			if($("#degree_box0").val() == "0" || $("#degree_box0").val() == "1" ){
				$("#scGrdDay0").removeAttr("disabled");	
				$("#scGrdDay0").val("");
			}else{
				$("#scGrdDay0").val("");
				$("#scGrdDay0").attr("disabled", "disabled");
			}
		});
		
		$("#aabtyPlusBtn").on("click", function(){
			if(aabtyIndex < 6){
				drawAabty();
			}
		});
		
		$("#aabtyMinusBtn").on("click", function(){
			if(aabtyIndex > 0){
				$("#aabty_tr" + aabtyIndex).remove();
				aabtyIndex--;
			}
		});
		
		$("#licensePlusBtn").on("click", function(){
			if(licenseIndex < 6){
				drawLicense();
			}
		});
		
		$("#licenseMinusBtn").on("click", function(){
			if(licenseIndex > -1){
				$("#license_tr" + licenseIndex).remove();
				licenseIndex--;
			}
		});
		
		$("#careerPlusBtn").on("click", function(){
			if(careerIndex < 6){
				drawCareer();
			}
		});
		
		$("#careerMinusBtn").on("click", function(){
			if(careerIndex > -1){
				$("#career_tr" + careerIndex).remove();
				careerIndex--;
			}
		});
		
		$("#familyPlusBtn").on("click", function(){
			if(familyIndex < 6){
				drawFamily();
			}
		});
		
		$("#familyMinusBtn").on("click", function(){
			if(familyIndex > -1){
				$("#family_tr" + familyIndex).remove();
				familyIndex--;
			}
		});
		
		$("#cancelBtn").on("click", function(){
			location.href = "HRHmitemAsk";
		});
		
		$("#hmitemRegBtn").on("click", function(){
			makeConfirm(1, "등록", "등록하시겠습니까?", true, function(){
				if(dataInputCheck() == true){
					/* 사원정보 */
					$("#formName").val($.trim($("#name").val()));
					$("#formRrnum1").val($.trim($("#rrnum1").val()));
					$("#formRrnum2").val($.trim($("#rrnum2").val()));
					$("#formEmail").val($.trim($("#email").val()));
					$("#formMobileNo").val($.trim($("#mobileNo").val()));
					$("#formExte").val($.trim($("#exte").val()));
					$("#formPostNo").val($("#postNo").val());
					$("#formAddr").val($("#addr").val());
					$("#formDtlAddr").val($.trim($("#dtlAddr").val()));
					$("#formAuth").val($("#auth").val());
					
					/* 인적사항 */
					$("#formMarry").val($("#marry").val());
					$("#formMilserv").val($("#milserv").val());
					$("#formDisa").val($("#disa").val());
					$("#formMilservRank").val($.trim($("#milserv_rank").val()));
					$("#formDisaCon").val($.trim($("#disa_con").val()));
					
					/* 학력 */
					var scDiv = "";
					var scName = "";
					var scMajor = "";
					var scGrdDay = "";
					var scDegreeDiv = "";
					
					for(var i = 0 ; i <= aabtyIndex ; i++){
						scDiv += "田" + $("#sc_box" + i).val();
						scName += "田" + $.trim($("#scName" + i).val());
						scMajor += "田" + $.trim($("#scMajor" + i).val());
						scGrdDay += "田" + $("#scGrdDay" + i).val();
						scDegreeDiv += "田" + $("#degree_box" + i).val();
					}
					
					$("#formScDiv").val(scDiv.substring(1));
					$("#formScName").val(scName.substring(1));
					$("#formScMajor").val(scMajor.substring(1));
					$("#formScGrdDay").val(scGrdDay.substring(1));
					$("#formDegreeDiv").val(scDegreeDiv.substring(1));
					
					/* 자격면허 */
					var licenseName = "";
					var getDay = "";
					var licensePubc = "";
					var licenseOlfcNo = "";
					
					for(var i = 0 ; i <= licenseIndex ; i++){
						licenseName += "田" + $.trim($("#licenseName" + i).val());
						getDay += "田" + $("#getDay" + i).val();
						licensePubc += "田" + $.trim($("#licensePubc" + i).val());
						licenseOlfcNo += "田" + $.trim($("#licenseOlfcNo" + i).val());
					}
					
					$("#formLicenseLength").val(licenseIndex);
					$("#formLicenseName").val(licenseName.substring(1));
					$("#formGetDay").val(getDay.substring(1));
					$("#formLicensePubc").val(licensePubc.substring(1));
					$("#formLicenseOlfcNo").val(licenseOlfcNo.substring(1));
					
					/* 경력 */
					var wplaceName = "";
					var posiName = "";
					var workStart = "";
					var workFnsh = "";
					var task = "";
					
					for(var i = 0 ; i <= careerIndex ; i++){
						wplaceName += "田" + $.trim($("#wplaceName" + i).val());
						posiName += "田" + $.trim($("#posiName" + i).val());
						workStart += "田" + $.trim($("#workStart" + i).val());
						workFnsh += "田" + $.trim($("#workFnsh" + i).val());
						task += "田" + $.trim($("#task" + i).val());
					}
					
					$("#formCareerLength").val(careerIndex);
					$("#formWplaceName").val(wplaceName.substring(1));
					$("#formPosiName").val(posiName.substring(1));
					$("#formWorkStart").val(workStart.substring(1));
					$("#formWorkFnsh").val(workFnsh.substring(1));
					$("#formTask").val(task.substring(1));
					
					/* 가족 */
					var familyName = "";
					var familyBirth = "";
					var famDiv = "";
					
					for(var i = 0 ; i <= familyIndex ; i++){
						familyName += "田" + $.trim($("#familyName" + i).val());
						familyBirth += "田" + $("#familyBirth" + i).val();
						famDiv += "田" + $("#fam_div" + i).val();
					}
					
					$("#formFamilyLength").val(familyIndex);
					$("#formFamilyName").val(familyName.substring(1));
					$("#formFamilyBirth").val(familyBirth.substring(1));
					$("#formFamDiv").val(famDiv.substring(1));
					
					/* 인사발령 */
					$("#formDeptNo").val($("#dept").val());
					$("#formPosiNo").val($("#posi").val());
					$("#formDmngrDiv").val($("#dmngr").val());
					
					var params = $("#actionForm").serialize(); 

					$.ajax({
						type : "post",
						url : "HREmpRegAjax",
						dataType : "json",
						data : params,
						success : function(result){
							if(result.empRegFlag == 0){
								location.href = "HRHmitemReg";
								
							}else {
								makeAlert(2, "인사기록카드", "사원등록에 실패하였습니다.", true, null);
							}
						},
						error : function(request, status, error){
							console.log("status : " + request.status);
							console.log("text : " + request.responseText);
							console.log("error : " + error);
						}
					});
					
				}
			})
			
		});
	});
	
	function drawSelectBox(){
		$.ajax({
			type : "post",
			url : "HRDrawSelectBoxAjax",
			dataType : "json",
			success : function(result){
				drawDept(result.deptlist);
				drawPosi(result.posilist);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function drawDept(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			html += "<option value=\""+ list[i].DEPT_NO +"\">"+ list[i].DEPT_NAME +"</option>";
		}
		
		$("#dept").append(html);
	}
	
	function drawPosi(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			html += "<option value=\""+ list[i].POSI_NO +"\">"+ list[i].POSI_NAME +"</option>";
		}
		
		$("#posi").append(html);
	}
	
	function dataInputCheck(){
		//인적사항 확인
		if($.trim($("#name").val()) == ''){
			makeAlert(2, "인적사항", "이름을 입력해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($.trim($("#rrnum1").val()) == ''){
			makeAlert(2, "인적사항", "주민번호를 입력해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($.trim($("#rrnum2").val()) == ''){
			makeAlert(2, "인적사항", "주민번호를 입력해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($.trim($("#email").val()) == ''){
			makeAlert(2, "인적사항", "E-mail을 입력해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($("#mobileNo").val() == ''){
			makeAlert(2, "인적사항", "휴대폰번호를 입력해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($("#postNo").val() == ''){
			makeAlert(2, "인적사항", "우편번호를 검색해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($("#dtlAddr").val() == ''){
			makeAlert(2, "인적사항", "상세주소를 입력해주세요.", true, null);
			hmstateBtnOn();
			return false;
		}else if($("#milserv").val() != 1){
			if($.trim($("#milserv_rank").val()) == ''){
				makeAlert(2, "인적사항", "계급을 입력해주세요.", true, null);
				hmstateBtnOn();
				return false;
			}
		}else if($("#disa").val() == 0){
			if($.trim($("#disa_con").val()) == ''){
				makeAlert(2, "인적사항", "장애내용을 입력해주세요.", true, null);
				hmstateBtnOn();
				return false;
			}
		}
		
		//학력 확인
		for(var i = 0 ; i <= aabtyIndex ; i++){
			if($("#sc_box" + i).val() == 1000){
				makeAlert(2, "학력", "학교구분을 선택해주세요.", true, null);
				aabtyBtnOn();
				return false;
			}else if($.trim($("#scName" + i).val()) == ''){
				makeAlert(2, "학력", "학교명을 입력해주세요.", true, null);
				aabtyBtnOn();
				return false;
			}else if(i != 0 && $.trim($("#scMajor" + i).val()) == ''){
				makeAlert(2, "학력", "전공을 입력해주세요.", true, null);
				aabtyBtnOn();
				return false;
			}else if($("#degree_box" + i).val() == 1000){
				makeAlert(2, "학력", "학위취득여부를 선택해주세요.", true, null);
				aabtyBtnOn();
				return false;
			}else if($("#degree_box" + i).val() == 0 || $("#degree_box" + i).val() == 1){
				if($.trim($("#scGrdDay" + i).val()) == ''){
					makeAlert(2, "학력", "졸업연도를 입력해주세요.", true, null);
					aabtyBtnOn();
					return false;
				}
			}
		}
		
		//자격면허 확인
		for(var i = 0 ; i <= licenseIndex ; i++){
			if($.trim($("#licenseName" + i).val()) == ''){
				makeAlert(2, "자격면허", "자격증명을 입력해주세요.", true, null);
				licenseBtnOn();
				return false;
			}else if($("#getDay" + i).val() == ''){
				makeAlert(2, "자격면허", "취득일을 입력해주세요.", true, null);
				licenseBtnOn();
				return false;
			}else if($.trim($("#licensePubc" + i).val()) == ''){
				makeAlert(2, "자격면허", "발급처를 입력해주세요.", true, null);
				licenseBtnOn();
				return false;
			}else if($.trim($("#licenseOlfcNo" + i).val()) == ''){
				makeAlert(2, "자격면허", "자격번호를 입력해주세요.", true, null);
				licenseBtnOn();
				return false;
			}
		}
		
		//경력 확인
		for(var i = 0 ; i <= careerIndex ; i++){
			if($.trim($("#wplaceName" + i).val()) == ''){
				makeAlert(2, "경력", "직장명을 입력해주세요.", true, null);
				careerBtnOn();
				return false;
			}else if($.trim($("#posiName" + i).val()) == ''){
				makeAlert(2, "경력", "직위명을 입력해주세요.", true, null);
				careerBtnOn();
				return false;
			}else if($("#workStart" + i).val() == ''){
				makeAlert(2, "경력", "근무시작날짜를 입력해주세요.", true, null);
				careerBtnOn();
				return false;
			}else if($("#workFnsh" + i).val() == ''){
				makeAlert(2, "경력", "근무종료날짜를 입력해주세요.", true, null);
				careerBtnOn();
				return false;
			}else if($.trim($("#task" + i).val()) == ''){
				makeAlert(2, "경력", "업무를 입력해주세요.", true, null);
				careerBtnOn();
				return false;
			}
		}
		
		//가족 확인
		for(var i = 0 ; i <= familyIndex; i++){
			if($.trim($("#familyName" + i).val()) == ''){
				makeAlert(2, "가족", "이름을 입력해주세요.", true, null);
				familyBtnOn();
				return false;
			}else if($("#familyBirth" + i).val() == ''){
				makeAlert(2, "가족", "생년월일을 입력해주세요.", true, null);
				familyBtnOn();
				return false;
			}else if($("#fam_div" + i).val() == 1000){
				makeAlert(2, "가족", "가족구분을 선택해주세요.", true, null);
				familyBtnOn();
				return false;
			}
		}
		
		//인사발령 확인
		if($("#dept").val() == 1000){
			makeAlert(2, "인사발령", "부서를 선택해주세요.", true, null);
			hrApntBtnOn();
			return false;
		}else if($("#posi").val() == 1000){
			makeAlert(2, "인사발령", "직위를 선택해주세요.", true, null);
			hrApntBtnOn();
			return false;
		}
		
		return true;
	}
	
	function hmstateBtnOn(){
		$(".tabbtn_area [type='button']").removeClass("on");
		$("#hm_state").attr("class", "on");
		
		$(".aabty_div").css("display", "none");
		$(".family_div").css("display", "none");
		$(".qlfc_license_div").css("display", "none");
		$(".career_div").css("display", "none");
		$(".hrApnt_div").css("display", "none");
		$(".hmstate_div").css("display", "");
	}
	
	function aabtyBtnOn(){
		$(".tabbtn_area [type='button']").removeClass("on");
		$("#aabty").attr("class", "on");
		
		$(".hmstate_div").css("display", "none");
		$(".qlfc_license_div").css("display", "none");
		$(".career_div").css("display", "none");
		$(".family_div").css("display", "none");
		$(".hrApnt_div").css("display", "none");
		$(".aabty_div").css("display", "");
	}
	
	function licenseBtnOn(){
		$(".tabbtn_area [type='button']").removeClass("on");
		$("#qlfc_license").attr("class", "on");
		
		$(".hmstate_div").css("display", "none");
		$(".aabty_div").css("display", "none");
		$(".career_div").css("display", "none");
		$(".family_div").css("display", "none");
		$(".hrApnt_div").css("display", "none");
		$(".qlfc_license_div").css("display", "");
	}
	
	function careerBtnOn(){
		$(".tabbtn_area [type='button']").removeClass("on");
		$("#career").attr("class", "on");
		
		$(".hmstate_div").css("display", "none");
		$(".aabty_div").css("display", "none");
		$(".family_div").css("display", "none");
		$(".qlfc_license_div").css("display", "none");
		$(".hrApnt_div").css("display", "none");
		$(".career_div").css("display", "");
	}
	
	function familyBtnOn(){
		$(".tabbtn_area [type='button']").removeClass("on");
		$("#family").attr("class", "on");
		
		$(".hmstate_div").css("display", "none");
		$(".aabty_div").css("display", "none");
		$(".qlfc_license_div").css("display", "none");
		$(".career_div").css("display", "none");
		$(".hrApnt_div").css("display", "none");
		$(".family_div").css("display", "");
	}
	
	function hrApntBtnOn(){
		$(".tabbtn_area [type='button']").removeClass("on");
		$("#hrApnt").attr("class", "on");
		
		$(".hmstate_div").css("display", "none");
		$(".aabty_div").css("display", "none");
		$(".qlfc_license_div").css("display", "none");
		$(".career_div").css("display", "none");
		$(".family_div").css("display", "none");
		$(".hrApnt_div").css("display", "");
	}
	
	function drawFamily(){
		familyIndex++;
		
		var html = "";
		
		html += "<tr id=\"family_tr" + familyIndex + "\">";
		html += "<td><input type=\"text\" id=\"familyName" + familyIndex + "\" class=\"familyName\"></td>";
		html += "<td><input type=\"text\" id=\"familyBirth" + familyIndex + "\" class=\"familyBirth\" placeholder=\"YYYY-MM-DD\" readonly=\"readonly\"></td>";
		html += "<td>";
		html += "<select id=\"fam_div" + familyIndex + "\" class=\"fam_div\">";
		html += "<option value=\"1000\">선택</option>";
		html += "<option value=\"0\">자녀</option>";
		html += "<option value=\"1\">자녀아님</option>";
		html += "</select>";
		html += "</td>";
		html += "</tr>";
		
		$(".family_table tbody").append(html);
		
		var date = new Date();
		var sysDate = date.getFullYear() + leadingZeros(date.getMonth() + 1, 2) + leadingZeros(date.getDate(),2);
		
		$("#familyBirth" + familyIndex).datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var date = parseInt($("#" + inst.id).val().replace("-", '').replace("-", ''));

				if(sysDate < date){
					makeAlert(1, "생년월일", "미래 날짜는 등록할 수 없습니다.", true, null);
					$("#" + inst.id).val("");
				}
				
			}
		});
	}
	
	function drawCareer(){
		careerIndex ++;
		
		var html = "";
		
		html += "<tr id=\"career_tr" + careerIndex + "\">";
		html += "<td><input type=\"text\" id=\"wplaceName" + careerIndex + "\" class=\"wplaceName\"></td>";					
		html += "<td><input type=\"text\" id=\"posiName" + careerIndex + "\" class=\"posiName\"></td>";			
		html += "<td><input type=\"text\" id=\"workStart" + careerIndex + "\" class=\"workStart\" placeholder=\"YYYY-MM-DD\" readonly=\"readonly\"></td>";					
		html += "<td><input type=\"text\" id=\"workFnsh" + careerIndex + "\" class=\"workFnsh\" placeholder=\"YYYY-MM-DD\" readonly=\"readonly\"></td>";					
		html += "<td><input type=\"text\" id=\"task" + careerIndex + "\" class=\"task\"></td>";					
		html += "</tr>";
		
		$(".career_table tbody").append(html);
		
		var date = new Date();
		var sysDate = date.getFullYear() + leadingZeros(date.getMonth() + 1, 2) + leadingZeros(date.getDate(),2);
		
		$("#workStart" + careerIndex).datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var date = parseInt($("#" + inst.id).val().replace("-", '').replace("-", ''));

				if(sysDate < date){
					makeAlert(1, "근무시작", "미래 날짜는 등록할 수 없습니다.", true, null);
					$("#" + inst.id).val("");
				}else {
					if($("#workFnsh" + inst.id.substring(9)).val() != ''){
						if($("#workFnsh" + inst.id.substring(9)).val() < $("#" + inst.id).val()){
							makeAlert(1, "근무시작", "날짜를 다시 선택해주세요.", true, null);
							$("#" + inst.id).val("");
						}
					}
				}
				
			}
		});
		
		$("#workFnsh" + careerIndex).datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var date = parseInt($("#" + inst.id).val().replace("-", '').replace("-", ''));

				if(sysDate < date){
					makeAlert(1, "근무종료", "미래 날짜는 등록할 수 없습니다.", true, null);
					$("#" + inst.id).val("");
				}else {
					if($("#workStart" + inst.id.substring(8)).val() > $("#" + inst.id).val()){
						makeAlert(1, "근무종료", "날짜를 다시 선택해주세요.", true, null);
						$("#" + inst.id).val("");
					}
				}
				
			}
		});
	}
	
	function drawLicense(){
		licenseIndex++;
		
		var html = "";
		
		html += "<tr id=\"license_tr" + licenseIndex + "\">";
		html += "<td><input type=\"text\" id=\"licenseName" + licenseIndex +"\" class=\"licenseName\"></td>";
		html += "<td><input type=\"text\" placeholder=\"YYYY-MM-DD\" readonly=\"readonly\" id=\"getDay" + licenseIndex + "\" class=\"getDay\"></td>";
		html += "<td><input type=\"text\" id=\"licensePubc" + licenseIndex + "\" class=\"licensePubc\"></td>";
		html += "<td><input type=\"text\" id=\"licenseOlfcNo" + licenseIndex + "\" class=\"licenseOlfcNo\"></td>";
		html += "</tr>";
		
		$(".license_table tbody").append(html);
		
		var date = new Date();
		var sysDate = date.getFullYear() + leadingZeros(date.getMonth() + 1, 2) + leadingZeros(date.getDate(),2);
		
		$("#getDay" + licenseIndex).datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var date = parseInt($("#" + inst.id).val().replace("-", '').replace("-", ''));

				if(sysDate < date){
					makeAlert(1, "취득일", "미래 날짜는 등록할 수 없습니다.", true, null);
					$("#" + inst.id).val("");
				}
				
			}
		});
	}
	
	function drawAabty(){
		aabtyIndex++;
		
		var html = "";
		
		html += "<tr id=\"aabty_tr" + aabtyIndex + "\">";
		html += "<td>";
		html += "<select id=\"sc_box" + aabtyIndex + "\" class=\"sc_box\">";
		html += "<option value=\"1000\">선택</option>";
		html += "<option value=\"1\">전문대학</option>";
		html += "<option value=\"2\">대학교</option>";
		html += "<option value=\"3\">대학원</option>";
		html += "</select>";
		html += "</td>";
		html += "<td><input type=\"text\" id=\"scName" + aabtyIndex + "\" class=\"scName\"></td>";
		html += "<td><input type=\"text\" id=\"scMajor" + aabtyIndex + "\" class=\"scMajor\"></td>";
		html += "<td>";
		html += "<select id=\"degree_box" + aabtyIndex + "\" class=\"degree_box\">";
		html += "<option value=\"1000\">선택</option>";
		html += "<option value=\"0\" >졸업</option>";
		html += "<option value=\"1\" >졸업예정</option>";
		html += "<option value=\"2\" >재학</option>";
		html += "<option value=\"3\" >휴학</option>";
		html += "<option value=\"4\" >중퇴</option>";
		html += "</select>";
		html += "</td>";
		html += "<td><input type=\"text\" id=\"scGrdDay" + aabtyIndex + "\" class=\"scGrdDay\" maxlength=\"7\" disabled=\"disabled\" placeholder=\"YYYY-MM\"></td>";
		html += "</tr>";
		
		$(".aabty_table tbody").append(html);
		
		$("#scGrdDay" + aabtyIndex).on("keyup", function(){
			if($(this).val().length == 4){
				$(this).val($(this).val()+"-");
			}else if($(this).val().length > 4 && $(this).val().lastIndexOf("-") == -1){
				var yyyy = $(this).val().substring(0,4);
				var mm = $(this).val().substring(4,$(this).val().length - 1);
				
				$(this).val(yyyy + "-" + mm);
			}
			
			if($(this).val().length < 8){
				
				if(isNaN(($(this).val().substring(0,4) + $(this).val().substring(5,7)) * 1)) {
					makeAlert(1, "졸업연도", "숫자를 입력하세요.", true, null);
					$(this).val("");
				}
			}
		});
		
		$("#scGrdDay" + aabtyIndex).on("change", function(){
			if($(this).val().length != 7){
				$(this).val("");
				makeAlert(2, "졸업연도", "졸업연도를 정확히 작성하세요.", true, null);
			}
		});
		
		$("#degree_box" + aabtyIndex).on("change", function(){
			if($(this).val() == "0" || $(this).val() == "1" ){
				$(this).parent().parent().children().eq(4).children(".scGrdDay").removeAttr("disabled");	
				$(this).parent().parent().children().eq(4).children(".scGrdDay").val("");
			}else{
				$(this).parent().parent().children().eq(4).children(".scGrdDay").val("");
				$(this).parent().parent().children().eq(4).children(".scGrdDay").attr("disabled", "disabled");
			}
		});
		
	}
	
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
			zero += '0';
		}
		return zero + n;
	}
</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="51"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
<div class="content_area">
	<form action="#" id="actionForm" method="post">
		<!-- 공통사용 -->
		<input type="hidden" id="formEmpNo" name="formEmpNo">
		<!-- EMP -->
		<input type="hidden" id="formProfileImg" name="formProfileImg">
		<input type="hidden" id="formName" name="formName">
		<input type="hidden" id="formRrnum1" name="formRrnum1">
		<input type="hidden" id="formRrnum2" name="formRrnum2">
		<input type="hidden" id="formEmail" name="formEmail">
		<input type="hidden" id="formMobileNo" name="formMobileNo">
		<input type="hidden" id="formExte" name="formExte">
		<input type="hidden" id="formPostNo" name="formPostNo">
		<input type="hidden" id="formAddr" name="formAddr">
		<input type="hidden" id="formDtlAddr" name="formDtlAddr">
		<input type="hidden" id="formAuth" name="formAuth">
		<!-- HM_STATE -->
		<input type="hidden" id="formMarry" name="formMarry">
		<input type="hidden" id="formMilserv" name="formMilserv">
		<input type="hidden" id="formDisa" name="formDisa">
		<input type="hidden" id="formMilservRank" name="formMilservRank">
		<input type="hidden" id="formDisaCon" name="formDisaCon">
		<!-- AABTY -->
		<input type="hidden" id="formScDiv" name="formScDiv">
		<input type="hidden" id="formScName" name="formScName">
		<input type="hidden" id="formScMajor" name="formScMajor">
		<input type="hidden" id="formScGrdDay" name="formScGrdDay">
		<input type="hidden" id="formDegreeDiv" name="formDegreeDiv">
		<input type="hidden" id="formAabtyLength" name="formAabtyLength">
		<!-- LICENSE -->
		<input type="hidden" id="formLicenseName" name="formLicenseName">
		<input type="hidden" id="formGetDay" name="formGetDay">
		<input type="hidden" id="formLicensePubc" name="formLicensePubc">
		<input type="hidden" id="formLicenseOlfcNo" name="formLicenseOlfcNo">
		<input type="hidden" id="formLicenseLength" name="formLicenseLength">
		<!-- CAREER -->
		<input type="hidden" id="formWplaceName" name="formWplaceName">
		<input type="hidden" id="formPosiName" name="formPosiName">
		<input type="hidden" id="formWorkStart" name="formWorkStart">
		<input type="hidden" id="formWorkFnsh" name="formWorkFnsh">
		<input type="hidden" id="formTask" name="formTask">
		<input type="hidden" id="formCareerLength" name="formCareerLength">
		<!-- FAM_INFO -->
		<input type="hidden" id="formFamilyName" name="formFamilyName">
		<input type="hidden" id="formFamilyBirth" name="formFamilyBirth">
		<input type="hidden" id="formFamDiv" name="formFamDiv">
		<input type="hidden" id="formFamilyLength" name="formFamilyLength">
		<!-- HR_APNT -->
		<input type="hidden" id="formDeptNo" name="formDeptNo">
		<input type="hidden" id="formPosiNo" name="formPosiNo">
		<input type="hidden" id="formDmngrDiv" name="formDmngrDiv">
	</form>
	
	<div id="profileDiv">
		<form action="fileUploadAjax" id="uploadForm" method="post" enctype="multipart/form-data">
			<input type="file" name="profileImgeFile" id="profileImgeFile"  accept=".gif, .jpg, .png">
		</form>
	</div>
	
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 인사기록카드</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">
        <div class="content_title_text">등록</div>
   </div>
	<!-- 내용 영역 -->

	<!--  인적사항 -->
	 
	<div class="tabbtn_area">
	    <input class="tabbtn" type="button" value="인적사항" id="hm_state" name="hm_state">
	    <input class="tabbtn" type="button" value="학력" id="aabty">
		<input class="tabbtn" type="button" value="자격면허" id="qlfc_license">
		<input class="tabbtn" type="button" value="경력" id="career">
		<input class="tabbtn" type="button" value="가족" id="family">
		<input class="tabbtn" type="button" value="인사발령" id="hrApnt">
		<input class="tabbtn_back" type="button" value="취소" id="cancelBtn">
		<input class="tabbtn_save" type="button" value="등록" id="hmitemRegBtn">
	</div>
	<div class="bg">
		<div class="hmstate_div">
			<div class="tab_txt">사원정보</div>
			<div class="tabcnt_area">
				<div class="tabcnt_img">
					<img alt="사진없음" src="resources/images/erp/common/nopic.jpg" id="profileImage"/>
					<div class="tab_txtt" id="imageAdd">등록</div>
				</div>
			</div>
			<table class="tab_table">
		   		<colgroup>
		   		<col width="40px" />
		   		<col width="50px" />
		   		<col width="40px" />
		   		<col width="50px" />
		   		</colgroup> 
				<tbody>
		   			<tr class="tab_cnt">
			   			<td class="tab_cntt">이름(*)</td>
			   			<td class="tab_a"><input type="text" class="inputDate" id="name"></td>
			   			<td class="tab_cntt">주민등록번호(*)</td>
			   			<td> <input type="text" class="inputDate" maxlength="6" size="6" id="rrnum1"/> - <input type="text" class="inputDate" maxlength="7" size="6" id="rrnum2"/> </td>
		   			</tr>
		  			<tr class="tab_cnt">
		   				<td class="tab_cntt">E-mail(*)</td>
		   				<td ><input type="text" class="inputDate" id="email"/></td>
		   				<td class="tab_cntt">휴대폰번호(*)</td>
		   				<td><input type="text" class="inputDate" id="mobileNo" maxlength="11" placeholder="'-' 없이 입력해주세요"/></td>
		   			</tr>
		  			
		  			<tr class="tab_cnt">
		   				<td class="tab_cntt">내선번호</td>
		   				<td> <input type="text" id="exte" class="inputDate" /></td>
		   			</tr>
		  		
		  			
		  			<tr class="tab_cnt">
			  			<td class="tab_cntt">우편번호(*)</td>
			   			<td colspan="2"><input type="text" readonly="readonly" class="inputDate" id="postNo"/> <input type="button" value="우편번호검색" id="addrSearchBtn"></td>
		   			</tr>
		  			
		  			<tr class="tab_cnt">
		  				<td class="tab_cntt">주소(*)</td>
		   				<td> <input type="text" size="70" readonly="readonly" class="inputDate" id="addr"/><input type="text" size="70" class="inputDate" id="dtlAddr" placeholder="상세주소를 입력해주세요"/></td>
		   			</tr>
		   			
		   			<tr class="tab_cnt">
		  				<td class="tab_cntt">권한(*)</td>
		   				<td>
		   					<select class="selectbox" id="auth"> 
								<option value="1">인사부서</option>
								<option value="2">인사부서장</option>
								<option value="3">사업부서장</option>
								<option value="4">고객관리부서</option>
								<option value="5">고객관리부서장</option>
								<option value="6">자산부서</option>
								<option value="7">자산부서장</option>
								<option value="8">경영관리부서</option>
								<option value="9">경영관리부서장</option>
								<option value="10" selected="selected">사원</option>
							</select>
		   				</td>
		   			</tr>
				</tbody>
		  	</table> 
			<div class="tab_txt">인적사항</div>
			<table class="tab_tables" >
				<tbody>
		   			<tr class="tab_cnt">
			   			<td class="tab_cntt">결혼여부(*)</td>
			   			<td>
			   				<select class="selectbox" id="marry"> 
								<option value="0">기혼</option>
								<option value="1" selected="selected">미혼</option>
							</select>
			   			</td>
			   			<td class="tab_cntt">병역구분(*)</td>
			   			<td>
			   				<select class="selectbox" id="milserv"> 
								<option value="0">만기전역</option>
								<option value="1" selected="selected">미필(여성)</option>
								<option value="2">의가사전역</option>
								<option value="3">병역특례</option>
							</select>
			   			</td>
		   			</tr>
		  			<tr class="tab_cnt">
			  			<td class="tab_cntt">장애여부(*)</td>
			   			<td>
			   				<select class="selectbox" id="disa"> 
								<option value="0">장애</option>
								<option value="1" selected="selected">비장애</option>
							</select>
						</td>
			   			<td class="tab_cntt">계급</td>
			   			<td><input type="text" size="22" id="milserv_rank" disabled="disabled"/></td>
		   			</tr>
		  			<tr class="tab_cnt">
			  			<td class="tab_cntt">장애내용</td>
			   			<td colspan="3"><input type="text" size="79" id="disa_con" disabled="disabled"/></td>
		   			</tr>
		   		</tbody>
		  	</table> 
		</div>
		
		<div class="aabty_div">
			<div class="aabty_btn_box">
				<input type="button" value="-" id="aabtyMinusBtn" >
				<input type="button" value="+" id="aabtyPlusBtn" >
			</div>
			<table class="aabty_table">
				<colgroup>
					<col width="150px">
					<col width="200px">
					<col width="200px">
					<col width="150px">
					<col width="150px">
				</colgroup>
				<thead>
					<tr>
						<td>학교구분</td>
						<td>학교명</td>
						<td>전공</td>
						<td>학위취득여부</td>
						<td>졸업연도</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<select id="sc_box0" class="sc_box">
								<option value="0" selected="selected">고등학교</option>
							</select>
						</td>
						<td><input type="text" id="scName0" class="scName"></td>
						<td><input type="text" id="scMajor0" class="scMajor" disabled="disabled"></td>
						<td>
							<select id="degree_box0" class="degree_box">
								<option value="1000" >선택</option>
								<option value="0" >졸업</option>
								<option value="1" >졸업예정</option>
								<option value="2" >재학</option>
								<option value="3" >휴학</option>
								<option value="4" >중퇴</option>
							</select>
						</td>
						<td><input type="text" id="scGrdDay0" class="scGrdDay" placeholder="YYYY-MM" maxlength="7" disabled="disabled"></td>
					</tr>
					
				</tbody>
			</table>
		</div>
		
		<div class="qlfc_license_div">
			<div class="license_btn_box">
				<input type="button" value="-" id="licenseMinusBtn" >
				<input type="button" value="+" id="licensePlusBtn" >
			</div>
			<table class="license_table">
				<colgroup>
					<col width="250px">
					<col width="200px">
					<col width="200px">
					<col width="250px">
				</colgroup>
				<thead>
					<tr>
						<td>자격증명</td>
						<td>취득일</td>
						<td>발급처</td>
						<td>자격번호</td>
					</tr>
				</thead>
				<tbody></tbody>
				
			</table>
		</div>
		
		<div class="career_div">
			<div class="career_btn_box">
				<input type="button" value="-" id="careerMinusBtn" >
				<input type="button" value="+" id="careerPlusBtn" >
			</div>
			<table class="career_table">
				<colgroup>
					<col width="250px">
					<col width="150px">
					<col width="150px">
					<col width="150px">
					<col width="280px">
				</colgroup>
				<thead>
					<tr>
						<td>직장명</td>
						<td>직위명</td>
						<td>근무시작</td>
						<td>근무종료</td>
						<td>업무</td>
					</tr>
				</thead>
				
				<tbody></tbody>
				
			</table>
		</div>
		
		<div class="family_div">
			<div class="family_btn_box">
				<input type="button" value="-" id="familyMinusBtn" >
				<input type="button" value="+" id="familyPlusBtn" >
			</div>
			<table class="family_table">
				<colgroup>
					<col width="200px">
					<col width="200px">
					<col width="150px">
				</colgroup>
				<thead>
					<tr>
						<td>이름</td>
						<td>생년월일</td>
						<td>가족구분</td>
					</tr>
				</thead>
				
				<tbody></tbody>
				
			</table>
		</div>
		
		<div class="hrApnt_div">
			<table class="hrApnt_table">
				<colgroup>
					<col width="200px">
					<col width="200px">
					<col width="200px">
				</colgroup>
				<thead>
					<tr>
						<td>부서</td>
						<td>직위</td>
						<td>부서장구분</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<select class="selectBox" id="dept">
								<option value="1000">선택</option>
							</select>
						</td>
						<td>
							<select class="selectBox" id="posi">
								<option value="1000">선택</option>
							</select>
						</td>
						<td>
							<select class="selectBox" id="dmngr">
								<option value="0">예</option>
								<option value="1" selected="selected">아니오</option>
							</select>
						</td>
					</tr>
				</tbody>
				
			</table>
		</div>
	
	</div> <!--bg  -->

</div> <!--내용  -->
	
</body>
</html>
   			