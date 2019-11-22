package com.gd.heywe.web.gw.controller;

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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.heywe.web.gw.service.GwMainService;

@Controller
public class GWMainController {

	@Autowired
	public GwMainService gwMainService;
	
	
	@RequestMapping(value="/GWMain")
	public ModelAndView erp_gw_Main(ModelAndView mav) {
		
		mav.setViewName("gw/main/GWMain");
		
		return mav;
	}
	
	//일정등록
	@RequestMapping(value ="AjaxGWInsertSch",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxInsertSch(@RequestParam HashMap<String, String> params,
								HttpSession session)
										throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			gwMainService.insertSch(params);
		}catch(Exception e){
			modelMap.put("msg", "저장에 실패했습니다");
			e.printStackTrace();
		}
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//모든 일정
	@RequestMapping(value ="AjaxGWAllSchList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxAllSchList(@RequestParam HashMap<String, String> params,
			HttpSession session)
					throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		try {
			List<HashMap<String, String>> list = gwMainService.allSchList(params);
			modelMap.put("list", list);
		}catch(Exception e){
			modelMap.put("msg", "일정이 없습니다. 일정을 등록해주세요");
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	// 일정 삭제
	@RequestMapping(value ="AjaxGWDeleteSch",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxDeleteSch(@RequestParam HashMap<String, String> params,
			HttpSession session)
					throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			gwMainService.deleteSch(params);
		}catch(Exception e){
			modelMap.put("msg", "실패");
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//월별일정 리스트
	@RequestMapping(value ="AjaxSelectSchList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxSelectSchList(@RequestParam HashMap<String, String> params,
			HttpSession session)
					throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		try {
			List<HashMap<String, String>> list = gwMainService.selectSchList(params);
			modelMap.put("list", list);
		}catch(Exception e){
			modelMap.put("msg", "일정이 없습니다. 일정을 등록해주세요");
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	// 결재문서 가져오기
	@RequestMapping(value ="AjaxGWMainApvProgressDoc",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxGWMainApvProgressDoc(@RequestParam HashMap<String, String> params,
			HttpSession session)
					throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
		System.out.println("엥??" + params);
		
		try {
			List<HashMap<String, String>> list = gwMainService.selectMainApvDoc(params);
			modelMap.put("list", list);
		}catch(Exception e){
			modelMap.put("msg", "결재문서받아오기 실패");
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 게시글 가져오기
	@RequestMapping(value ="AjaxGWMainArticle",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String AjaxGWMainArticle(@RequestParam HashMap<String, String> params,
			HttpSession session)
					throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
		System.out.println("게시글에서 sEmpNo" + params);
		
		try {
			List<HashMap<String, String>> list = gwMainService.selectArticleList(params);
			modelMap.put("list", list);
		}catch(Exception e){
			modelMap.put("msg", "게시글가져오기 실패");
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	
	
	
	
	

	
}
