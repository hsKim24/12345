/**
 * makeConfirm(depth, title, contents, bgFlag, okEvent)
 * : 컨펌 팝업 생성
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * title - 제목
 * contents - 내용
 * bgFlag - 백그라운드 존재여부(true : 존재, flase : 비존재)
 * okEvent - 확인버튼 추가이벤트(없을경우 null입력)
 */
function makeConfirm(depth, title, contents, bgFlag, okEvent) {
	if(popupCheck(depth)) {
		//팝업 존재 시
	} else { // 팝업 미 존재 시
		var html = "";
		
		if(bgFlag) {
			html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
		}
		
		html += "<div class=\"popup_contents\" id=\"popup" + depth + "\">";
		html += "<div class=\"popup_top\">";
		html += "<span class=\"left\">" + title + "</span>";
		html += "<span class=\"right\"><img alt=\"exit\" src=\"resources/images/erp/common/exit.png\"></span>";
		html += "</div>";
		html += "<div class=\"popup_mid\"><div class=\"alert_txt\">";
		html += contents;
		html += "</div></div>";
		html += "<div class=\"popup_bot\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnLeft\" type=\"button\" value=\"취소\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRight\" type=\"button\" value=\"확인\">";
		html += "</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		$("#popup" + depth).css("z-index", depth * 111);
		
		$("#popup" + depth + "Bg").hide();
		$("#popup" + depth).hide();
		
		$("#popup" + depth + "Bg").fadeIn("fast");
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "BtnLeft").focus();
		
		$("#popup" + depth + "BtnLeft").off("click");
		$("#popup" + depth + "BtnLeft").on("click", function(){
			closePopup(depth);
		});
		
		$("#popup" + depth + "BtnRight").off("click");
		$("#popup" + depth + "BtnRight").on("click", function(){
			if(okEvent != null) {
				okEvent.call();
			}
			
			closePopup(depth);
		});
		
		if(bgFlag) {
			$("#popup" + depth + "Bg").off("click");
			$("#popup" + depth + "Bg").on("click", function(){
				closePopup(depth);
			});
		}
		
		$("[alt='exit']").off("click");
		$("[alt='exit']").on("click", function(){
			closePopup(depth);
		});
	}
}

/**
 * makeAlert(depth, title, contents, bgFlag, closeEvent)
 * : 알림 팝업 생성
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * title - 제목
 * contents - 내용
 * bgFlag - 백그라운드 존재여부(true : 존재, flase : 비존재)
 * closeEvent - 확인버튼 추가이벤트(없을경우 null입력)
 */
function makeAlert(depth, title, contents, bgFlag, closeEvent) {
	if(popupCheck(depth)) {
		//팝업 존재 시
	} else { // 팝업 미 존재 시
		var html = "";
		
		if(bgFlag) {
			html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
		}
		
		html += "<div class=\"popup_contents\" id=\"popup" + depth + "\">";
		html += "<div class=\"popup_top\">";
		html += "<span class=\"left\">" + title + "</span>";
		html += "<span class=\"right\"><img alt=\"exit\" src=\"resources/images/erp/common/exit.png\"></span>";
		html += "</div>";
		html += "<div class=\"popup_mid\"><div class=\"alert_txt\">";
		html += contents;
		html += "</div></div>";
		html += "<div class=\"popup_bot\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnLeft\" type=\"button\" value=\"확인\">";
		html += "</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		$(".popup_mid .alert_txt").slimScroll({
			width: "280px",
			height: "48px"
		});
		
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		$("#popup" + depth).css("z-index", depth * 111);
		
		$("#popup" + depth + "Bg").hide();
		$("#popup" + depth).hide();
		
		$("#popup" + depth + "Bg").fadeIn("fast");
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "BtnLeft").focus();
		
		$("#popup" + depth + "BtnLeft").off("click");
		$("#popup" + depth + "BtnLeft").on("click", function(){
			if(closeEvent != null) {
				closeEvent.call();
			}
			
			closePopup(depth);
		});
		
		if(bgFlag) {
			$("#popup" + depth + "Bg").off("click");
			$("#popup" + depth + "Bg").on("click", function(){
				if(closeEvent != null) {
					closeEvent.call();
				}
				
				closePopup(depth);
			});
		}
		
		$("[alt='exit']").off("click");
		$("[alt='exit']").on("click", function(){
			if(closeEvent != null) {
				closeEvent.call();
			}
			
			closePopup(depth);
		});
	}
}

/**
 * makeNoBtnPopup(depth, title, contents, bgFlag, width, height, contentsEvent, rightText, rightEvent)
 * : 팝업 생성
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * title - 제목
 * contents - 내용
 * bgFlag - 백그라운드 존재여부(true : 존재, flase : 비존재)
 * contentsEvent - 내용 추가이벤트(없을경우 null입력)
 * closeEvent - 확인버튼 추가이벤트(없을경우 null입력, null인경우 닫기실행), 이벤트 존재 시 완료 후 팝업닫을 경우 closePopup(depth)호출
 */
function makeNoBtnPopup(depth, title, contents, bgFlag, width, height,
				   contentsEvent, closeEvent) {
	if(popupCheck(depth)) {
		//팝업 존재 시
	} else { // 팝업 미 존재 시
		var html = "";
		
		if(bgFlag) {
			html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
		}
		
		html += "<div class=\"popup_contents\" id=\"popup" + depth + "\">";
		html += "<div class=\"popup_top\">";
		html += "<span class=\"left\">" + title + "</span>";
		html += "<span class=\"right\"><img alt=\"exit\" src=\"resources/images/erp/common/exit.png\"></span>";
		html += "</div>";
		html += "<div class=\"popup_mid\">";
		html += contents;
		html += "</div>";
		html += "<div class=\"popup_bot\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnLeft\" type=\"button\" value=\"확인\">";
		html += "</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		if(contentsEvent != null) {
			contentsEvent.call();
		}
		
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		$("#popup" + depth).css("z-index", depth * 111);
		$("#popup" + depth).css("width", width + "px");
		$("#popup" + depth).css("height", height + "px");
		$("#popup" + depth).css("left", "calc(50% - " + (width / 2) + "px");
		$("#popup" + depth).css("top", "calc(50% - " + (height / 2) + "px");
		
		$("#popup" + depth + "Bg").hide();
		$("#popup" + depth).hide();
		
		$("#popup" + depth + "Bg").fadeIn("fast");
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "BtnLeft").focus();
		
		$("#popup" + depth + "BtnLeft").off("click");
		$("#popup" + depth + "BtnLeft").on("click", function(){
			if(closeEvent != null) {
				closeEvent.call();
			} else {
				closePopup(depth);
			}
		});
		
		if(bgFlag) {
			$("#popup" + depth + "Bg").off("click");
			$("#popup" + depth + "Bg").on("click", function(){
				closePopup(depth);
			});
		}
		
		$("[alt='exit']").off("click");
		$("[alt='exit']").on("click", function(){
			closePopup(depth);
		});
	}
}


/**
 * makePopup(depth, title, contents, bgFlag, width, height, contentsEvent, rightText, rightEvent)
 * : 팝업 생성
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * title - 제목
 * contents - 내용
 * bgFlag - 백그라운드 존재여부(true : 존재, flase : 비존재)
 * contentsEvent - 내용 추가이벤트(없을경우 null입력)
 * rightText - 우측 버튼 텍스트
 * rightEvent - 우측버튼 추가이벤트(없을경우 null입력), 완료 후 팝업닫을 경우 closePopup(depth)호출
 */
function makePopup(depth, title, contents, bgFlag, width, height,
				   contentsEvent, rightText, rightEvent) {
	if(popupCheck(depth)) {
		//팝업 존재 시
	} else { // 팝업 미 존재 시
		var html = "";
		
		if(bgFlag) {
			html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
		}
		
		html += "<div class=\"popup_contents\" id=\"popup" + depth + "\">";
		html += "<div class=\"popup_top\">";
		html += "<span class=\"left\">" + title + "</span>";
		html += "<span class=\"right\"><img alt=\"exit\" src=\"resources/images/erp/common/exit.png\"></span>";
		html += "</div>";
		html += "<div class=\"popup_mid\">";
		html += contents;
		html += "</div>";
		html += "<div class=\"popup_bot\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnLeft\" type=\"button\" value=\"취소\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRightOne\" type=\"button\" value=\"" + rightText + "\">";
		html += "</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		if(contentsEvent != null) {
			contentsEvent.call();
		}
		
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		$("#popup" + depth).css("z-index", depth * 111);
		$("#popup" + depth).css("width", width + "px");
		$("#popup" + depth).css("height", height + "px");
		$("#popup" + depth).css("left", "calc(50% - " + (width / 2) + "px");
		$("#popup" + depth).css("top", "calc(50% - " + (height / 2) + "px");
		
		$("#popup" + depth + "Bg").hide();
		$("#popup" + depth).hide();
		
		$("#popup" + depth + "Bg").fadeIn("fast");
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "BtnLeft").focus();
		
		$("#popup" + depth + "BtnLeft").off("click");
		$("#popup" + depth + "BtnLeft").on("click", function(){
			closePopup(depth);
		});
		
		$("#popup" + depth + "BtnRightOne").off("click");
		$("#popup" + depth + "BtnRightOne").on("click", function(){
			if(rightEvent != null) {
				rightEvent.call();
			}
		});
		
		if(bgFlag) {
			$("#popup" + depth + "Bg").off("click");
			$("#popup" + depth + "Bg").on("click", function(){
				closePopup(depth);
			});
		}
		
		$("[alt='exit']").off("click");
		$("[alt='exit']").on("click", function(){
			closePopup(depth);
		});
	}
}

/**
 * makeTwoBtnPopup(depth, title, contents, bgFlag, width, height, contentsEvent, rightOneText, rightOneEvent, rightTwoText, rightTwoEvent, rightThreeText, rightThreeEvent)
 * : 팝업 생성
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * title - 제목
 * contents - 내용
 * bgFlag - 백그라운드 존재여부(true : 존재, flase : 비존재)
 * contentsEvent - 내용 추가이벤트(없을경우 null입력)
 * rightOneText - 우측 버튼 텍스트
 * rightOneEvent - 우측버튼 추가이벤트(없을경우 null입력), 완료 후 팝업닫을 경우 closePopup(depth)호출
 * rightTwoText - 우측 버튼 텍스트
 * rightTwoEvent - 우측버튼 추가이벤트(없을경우 null입력), 완료 후 팝업닫을 경우 closePopup(depth)호출
 */
function makeTwoBtnPopup(depth, title, contents, bgFlag, width, height,
		contentsEvent, rightOneText, rightOneEvent, rightTwoText, rightTwoEvent) {
	if(popupCheck(depth)) {
		//팝업 존재 시
	} else { // 팝업 미 존재 시
		var html = "";
		
		if(bgFlag) {
			html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
		}
		
		html += "<div class=\"popup_contents\" id=\"popup" + depth + "\">";
		html += "<div class=\"popup_top\">";
		html += "<span class=\"left\">" + title + "</span>";
		html += "<span class=\"right\"><img alt=\"exit\" src=\"resources/images/erp/common/exit.png\"></span>";
		html += "</div>";
		html += "<div class=\"popup_mid\">";
		html += contents;
		html += "</div>";
		html += "<div class=\"popup_bot\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnLeft\" type=\"button\" value=\"취소\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRightOne\" type=\"button\" value=\"" + rightOneText + "\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRightTwo\" type=\"button\" value=\"" + rightTwoText + "\">";
		html += "</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		if(contentsEvent != null) {
			contentsEvent.call();
		}
		
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		$("#popup" + depth).css("z-index", depth * 111);
		$("#popup" + depth).css("width", width + "px");
		$("#popup" + depth).css("height", height + "px");
		$("#popup" + depth).css("left", "calc(50% - " + (width / 2) + "px");
		$("#popup" + depth).css("top", "calc(50% - " + (height / 2) + "px");
		
		$("#popup" + depth + "Bg").hide();
		$("#popup" + depth).hide();
		
		$("#popup" + depth + "Bg").fadeIn("fast");
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "BtnLeft").focus();
		
		$("#popup" + depth + "BtnLeft").off("click");
		$("#popup" + depth + "BtnLeft").on("click", function(){
			closePopup(depth);
		});
		
		$("#popup" + depth + "BtnRightOne").off("click");
		$("#popup" + depth + "BtnRightOne").on("click", function(){
			if(rightOneEvent != null) {
				rightOneEvent.call();
			}
		});
		
		$("#popup" + depth + "BtnRightTwo").off("click");
		$("#popup" + depth + "BtnRightTwo").on("click", function(){
			if(rightTwoEvent != null) {
				rightTwoEvent.call();
			}
		});
		
		if(bgFlag) {
			$("#popup" + depth + "Bg").off("click");
			$("#popup" + depth + "Bg").on("click", function(){
				closePopup(depth);
			});
		}
		
		$("[alt='exit']").off("click");
		$("[alt='exit']").on("click", function(){
			closePopup(depth);
		});
	}
}

/**
 * makeThreeBtnPopup(depth, title, contents, bgFlag, width, height, contentsEvent, rightOneText, rightOneEvent, rightTwoText, rightTwoEvent, rightThreeText, rightThreeEvent)
 * : 팝업 생성
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * title - 제목
 * contents - 내용
 * bgFlag - 백그라운드 존재여부(true : 존재, flase : 비존재)
 * contentsEvent - 내용 추가이벤트(없을경우 null입력)
 * rightOneText - 우측 버튼 텍스트
 * rightOneEvent - 우측버튼 추가이벤트(없을경우 null입력), 완료 후 팝업닫을 경우 closePopup(depth)호출
 * rightTwoText - 우측 버튼 텍스트
 * rightTwoEvent - 우측버튼 추가이벤트(없을경우 null입력), 완료 후 팝업닫을 경우 closePopup(depth)호출
 * rightThreeText - 우측 버튼 텍스트
 * rightThreeEvent - 우측버튼 추가이벤트(없을경우 null입력), 완료 후 팝업닫을 경우 closePopup(depth)호출
 */
function makeThreeBtnPopup(depth, title, contents, bgFlag, width, height,
		contentsEvent, rightOneText, rightOneEvent, rightTwoText, rightTwoEvent, rightThreeText, rightThreeEvent) {
	if(popupCheck(depth)) {
		//팝업 존재 시
	} else { // 팝업 미 존재 시
		var html = "";
		
		if(bgFlag) {
			html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
		}
		
		html += "<div class=\"popup_contents\" id=\"popup" + depth + "\">";
		html += "<div class=\"popup_top\">";
		html += "<span class=\"left\">" + title + "</span>";
		html += "<span class=\"right\"><img alt=\"exit\" src=\"resources/images/erp/common/exit.png\"></span>";
		html += "</div>";
		html += "<div class=\"popup_mid\">";
		html += contents;
		html += "</div>";
		html += "<div class=\"popup_bot\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnLeft\" type=\"button\" value=\"취소\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRightOne\" type=\"button\" value=\"" + rightOneText + "\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRightTwo\" type=\"button\" value=\"" + rightTwoText + "\">";
		html += "<input class=\"popup_btn\" id=\"popup" + depth + "BtnRightThree\" type=\"button\" value=\"" + rightThreeText + "\">";
		html += "</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		if(contentsEvent != null) {
			contentsEvent.call();
		}
		
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		$("#popup" + depth).css("z-index", depth * 111);
		$("#popup" + depth).css("width", width + "px");
		$("#popup" + depth).css("height", height + "px");
		$("#popup" + depth).css("left", "calc(50% - " + (width / 2) + "px");
		$("#popup" + depth).css("top", "calc(50% - " + (height / 2) + "px");
		
		$("#popup" + depth + "Bg").hide();
		$("#popup" + depth).hide();
		
		$("#popup" + depth + "Bg").fadeIn("fast");
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "BtnLeft").focus();
		
		$("#popup" + depth + "BtnLeft").off("click");
		$("#popup" + depth + "BtnLeft").on("click", function(){
			closePopup(depth);
		});
		
		$("#popup" + depth + "BtnRightOne").off("click");
		$("#popup" + depth + "BtnRightOne").on("click", function(){
			if(rightOneEvent != null) {
				rightOneEvent.call();
			}
		});
		
		$("#popup" + depth + "BtnRightTwo").off("click");
		$("#popup" + depth + "BtnRightTwo").on("click", function(){
			if(rightTwoEvent != null) {
				rightTwoEvent.call();
			}
		});
		
		$("#popup" + depth + "BtnRightThree").off("click");
		$("#popup" + depth + "BtnRightThree").on("click", function(){
			if(rightThreeEvent != null) {
				rightThreeEvent.call();
			}
		});
		
		if(bgFlag) {
			$("#popup" + depth + "Bg").off("click");
			$("#popup" + depth + "Bg").on("click", function(){
				closePopup(depth);
			});
		}
		
		$("[alt='exit']").off("click");
		$("[alt='exit']").on("click", function(){
			closePopup(depth);
		});
	}
}

/**
 * closePopup(depth)
 * : 팝업 닫기
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 */
function closePopup(depth) {
	$("#popup" + depth + "Bg").fadeOut("fast", function(){
		$("#popup" + depth + "Bg").remove();
	});
	
	$("#popup" + depth).fadeOut("fast", function(){
		$("#popup" + depth).remove();
	});
}

/**
 * popupCheck(depth)
 * : 팝업 존재여부
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 */
function popupCheck(depth) {
	if($("#popup" + depth).length > 0) {
		return true;
	} else {
		return false;
	}
}

/**
 * popupContentsChange(depth, contents, contentsEvent)
 * : 팝업 존재여부
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * contents - 내용
 * contentsEvent - 내용 추가이벤트(없을경우 null입력)
 */
function popupContentsChange(depth, contents, contentsEvent) {
	$("#popup" + depth + " .popup_mid").html(contents);
	
	if(contentsEvent != null) {
		contentsEvent.call();
	}
}

/**
 * popupBtnChange(depth, type, btnText, btnEvent)
 * : 팝업 존재여부
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * type - 버튼타입 (1 - 3번)
 * btnText - 버튼 텍스트
 * btnEvent - 버튼 변경 이벤트(없을경우 null입력)
 */
function popupBtnChange(depth, type, btnText, btnEvent) {
	if(type == 1) {
		$("#popup" + depth + "BtnRightOne").val(btnText);
		
		if(btnEvent != null) {
			$("#popup" + depth + "BtnRightOne").off("click");
			$("#popup" + depth + "BtnRightOne").on("click", function(){
				if(btnEvent != null) {
					btnEvent.call();
				}
			});
		}
	} else if(type == 2) {
		$("#popup" + depth + "BtnRightTwo").val(btnText);
		
		if(btnEvent != null) {
			$("#popup" + depth + "BtnRightTwo").off("click");
			$("#popup" + depth + "BtnRightTwo").on("click", function(){
				if(btnEvent != null) {
					btnEvent.call();
				}
			});
		}
	} else if(type == 3) {
		$("#popup" + depth + "BtnRightThree").val(btnText);
		
		if(btnEvent != null) {
			$("#popup" + depth + "BtnRightThree").off("click");
			$("#popup" + depth + "BtnRightThree").on("click", function(){
				if(btnEvent != null) {
					btnEvent.call();
				}
			});
		}
	}
}
