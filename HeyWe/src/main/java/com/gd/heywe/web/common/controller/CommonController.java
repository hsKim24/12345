package com.gd.heywe.web.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.heywe.common.CommonProperties;
import com.gd.heywe.util.Utils;
import com.gd.heywe.web.common.service.ICommonService;

@Controller
public class CommonController {
	@Autowired
	public ICommonService iCommonService;
	
	@RequestMapping({ "/login", "/" })
	public ModelAndView commonLogin(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sEmpNo") != null) {
			mav.setViewName("redirect:Main");
		} else {
			mav.setViewName("common/login");
		}

		return mav;
	}
	
	@RequestMapping(value = "/loginAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String commonLoginAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		//패스워드 암호화
		params.put("pw", Utils.encryptAES128(params.get("pw")));
		
		try {
			HashMap<String, String> data = iCommonService.loginCheck(params);
			
			if(data != null && !data.isEmpty()) {
				session.setAttribute("sEmpNo", data.get("EMP_NO"));
				session.setAttribute("sName", data.get("NAME"));
				session.setAttribute("sPic", data.get("PIC"));
				session.setAttribute("sAuthNo", data.get("AUTH_NO"));
				session.setAttribute("sDeptNo", data.get("DEPT_NO"));
				session.setAttribute("sDeptName", data.get("DEPT_NAME"));
				session.setAttribute("sPosiName", data.get("POSI_NAME"));
				
				modelMap.put("res", CommonProperties.RESULT_SUCCESS);
			} else {
				modelMap.put("res", CommonProperties.RESULT_FAILED);
			}
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("res", CommonProperties.RESULT_ERROR);
		}
		
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/logout")
	public ModelAndView commonLogout(HttpSession session, ModelAndView mav) {
		session.invalidate();
		
		mav.setViewName("redirect:login");

		return mav;
	}

	@RequestMapping(value = "/topLeft")
	public ModelAndView commonTopLeft(HttpSession session, ModelAndView mav) throws Throwable {
		
		List<HashMap<String, String>> topMenu = iCommonService.getTopMenu(String.valueOf(session.getAttribute("sAuthNo")));
		
		mav.addObject("topMenu", topMenu);
		
		mav.setViewName("common/topLeft");

		return mav;
	}

	@RequestMapping(value = "/commonLeftMenuAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String commonLeftMenuAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("authNo", String.valueOf(session.getAttribute("sAuthNo")));
		
		List<HashMap<String, String>> leftMenu = iCommonService.getLeftMenu(params);
		
		modelMap.put("leftMenu", leftMenu);
		
		for(int i = 0 ; i < leftMenu.size() ; i++) {
			if(String.valueOf(leftMenu.get(i).get("MENU_NO")).equals(params.get("leftMenuNo"))) {
				modelMap.put("depth", leftMenu.get(i).get("DEPTH"));
				modelMap.put("flow", leftMenu.get(i).get("MENU_FLOW").split(","));
			}
		}
		
		if(!modelMap.containsKey("flow")) {
			modelMap.put("flow", "");
			modelMap.put("depth", "");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/contentsTest")
	public ModelAndView contentsTest(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sAuthNo") != null) {
			mav.setViewName("common/contents");
		} else {
			mav.setViewName("redirect:login");
		}

		return mav;
	}
	
	@RequestMapping(value = "/getCmnCdAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getCmnCdAjax(@RequestParam("cdL") int cdL) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> cdList = iCommonService.getCmnCdAjax(cdL);
		
		modelMap.put("cdList", cdList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/Main")
	public ModelAndView Main(ModelAndView mav) {
		
		mav.setViewName("common/Main");
		
		return mav;
	}
	
	@RequestMapping(value = "/AjaxMainSchList",
					method = RequestMethod.POST, 
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxMainSchList(HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String, String> params = new HashMap<String,String>();
		
		//스케줄 타입넘버 0 삽입 (0은 전사일정)  어찌 변할지 몰라서 일단 해쉬맵으로 넣었음 실제로는 아예 넣을 필요도 없음 (0으로 유지라)
		params.put("schTypeNo", "0");
		List<HashMap<String,String>> list = iCommonService.selectCommonSchList(params);
		try {
			modelMap.put("list", list);
		} catch (Exception e) {
			modelMap.put("msg", "실패");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/AjaxDeleteSchMain",
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxDeleteSchMain(@RequestParam HashMap<String, String> params)
										throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iCommonService.deleteCommonSch(params);
			modelMap.put("msg", "성공");
		} catch (Exception e) {
			modelMap.put("msg", "실패");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	// 달력
	@RequestMapping(value = "/AjaxInsertSchMain",
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxInsertSchMain(@RequestParam HashMap<String, String> params,
									HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		System.out.println(params);
		try {
			iCommonService.insertCommonSch(params);
			modelMap.put("msg", "성공");
		} catch (Exception e) {
			modelMap.put("msg", "실패");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 게시글 가져오기 (메인페이지에서)
	@RequestMapping(value = "/MainNoticeAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MainNoticeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> list = iCommonService.getArticle(params);
		
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);

	}
	
	// 채팅 알람 CNT
	@RequestMapping(value = "/AjaxChatNoti",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxChatNoti( HttpSession session,
								@RequestParam HashMap<String, String> params)
										throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());		
		int cnt = iCommonService.getNotiCnt(params);
		
		modelMap.put("cnt", cnt);
		
		return mapper.writeValueAsString(modelMap);
		
	}

	// 가장 마지막에 온 채팅의 상세내용
	@RequestMapping(value = "/AjaxChatDtlNoti",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxChatDtlNoti(  HttpSession session,
									@RequestParam HashMap<String, String> params)
											throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());		
		
		List<HashMap<String, String>> list = iCommonService.getNotiDtl(params);
		
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
		
	}
}
