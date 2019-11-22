<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - Login</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/login.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/jquery/jquery.slimscroll.js"></script>
<script type="text/javascript"
		src="resources/script/common/util.js"></script>
<script type="text/javascript"
		src="resources/script/common/popup.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#loginBtn").on("click", function() {
		if(checkEmpty("#empNo")) {
			makeAlert(1, "로그인 안내", "아이디를 입력해 주세요.", true, function() {
				$("#empNo").focus();
			});
		} else if(checkEmpty("#pw")) {
			makeAlert(1, "로그인 안내", "비밀번호를 입력해 주세요.", true, function() {
				$("#pw").focus();
			});
		} else {
			var params = $("#dataForm").serialize();
			
			$.ajax({
				type : "post",
				url : "loginAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					if(result.res == "SUCCESS") {
						location.href = "Main";
					} else if(result.res == "FAILED") {
						makeAlert(1, "로그인 실패", "아이디나 비밀번호가 틀렸습니다.", true, null);
					} else {
						makeAlert(1, "로그인 경고", "로그인 체크 중 문제가 발생하였습니다.", true, null);
					}
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
	});
	
	$(".login_input_area").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			$("#loginBtn").click();
			return false;
		}
	});
});
</script>
</head>
<body>
<div class="login_wrap">
	<div class="login_logo">HeyWe</div>
	<div class="login_form_wrap">
		<form action="#" id="dataForm">
			<div class="login_input_area">
				<div class="login_input_img_user"></div>
				<div class="login_input_txt"><input type="text" id="empNo" name="empNo" placeholder="Username" /></div>
			</div>
			<div class="login_input_area">
				<div class="login_input_img_password"></div>
				<div class="login_input_txt"><input type="password" id="pw" name="pw" placeholder="Password" /></div>
			</div>
		</form>
		<div class="login_btn_area">
			<input type="button" value="로그인" id="loginBtn" />
		</div>
	</div>
</div>
</body>
</html>