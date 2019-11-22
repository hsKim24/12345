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
import com.gd.heywe.common.bean.PagingBean;
import com.gd.heywe.common.service.IPagingService;
import com.gd.heywe.web.gw.service.IGwBoardService;

@Controller
public class GwBoardController {

	@Autowired
	public IGwBoardService iGwBoardService;	
	
	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value="/GWComBoard")
	public ModelAndView gwBoard(HttpSession session, ModelAndView mav,
			 			@RequestParam HashMap<String, String> params)throws Throwable {
		System.out.println("sAuthNo : "+session.getAttribute("sAuthNo"));
		mav.addObject("boardMngtNo", 2);
		mav.setViewName("gw/board/boardList/gwBoard");
		return mav;
	}
	@RequestMapping(value="/GWDeptBoard")
	public ModelAndView GWDeptBoard(HttpSession session, ModelAndView mav,
			@RequestParam HashMap<String, String> params)throws Throwable {
		
		mav.addObject("boardMngtNo", 1);
		mav.setViewName("gw/board/boardList/gwBoard");
		
		
		return mav;
	}
	@RequestMapping(value="/GWNotice")
	public ModelAndView GWNotice(HttpSession session, ModelAndView mav,
			@RequestParam HashMap<String, String> params)throws Throwable {
		mav.addObject("boardMngtNo", 0);
		mav.setViewName("gw/board/boardList/gwBoard");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/GWArticleListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody 
	//게시판
	public String gwArticleListAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			
			if(!params.containsKey("page")) {
				params.put("page", "1");
			}
		
		int cnt = iGwBoardService.getArticleCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iGwBoardService.getArticle(params);
		
		modelMap.put("cnt", Integer.toString(cnt));
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("page", params.get("page"));
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/GWArticleDtl")
	public ModelAndView gwBoardDtl (ModelAndView mav,
									@RequestParam HashMap<String, String> params) throws Throwable{
		System.out.println(params);
		HashMap<String, String> dtl = iGwBoardService.ArticleDtl(params);
		List<HashMap<String, String>> att_dtl = iGwBoardService.fileDown(params);
		iGwBoardService.AritcleHit(params);
		
		mav.addObject("dtl", dtl);
		mav.addObject("att_dtl", att_dtl);
		mav.setViewName("gw/board/boardDtl/gwArticleDtl");
		return mav;
	}
	
	@RequestMapping(value="/GWBoardWrite")
	public ModelAndView gwBoardWrite (ModelAndView mav,
										HttpSession session) {
		
		//HashMap<String, String> auth = iGwBoardService.authCheck(params);
		mav.setViewName("gw/board/boardArticle/gwBoardWrite");
		return mav;
	}
	
	@RequestMapping(value = "/GWBoardWriteAjax", 
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String gwBoardWriteAjax(HttpSession session, @RequestParam HashMap<String, String> params) 
						throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	iGwBoardService.insertWrite(params);
	
	return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/GWArticleUpdate")
	public ModelAndView gwBoardUpdate (ModelAndView mav,
										HttpSession session,
										@RequestParam HashMap<String, String> params) throws Throwable {
		
		try {
			System.out.println(params.toString());
			
			HashMap<String, String> data = iGwBoardService.ArticleDtl(params);
			List<HashMap<String, String>> att_dtl = iGwBoardService.ArticleDtlAtt(params);
			mav.addObject("data", data);
			mav.addObject("att_dtl", att_dtl);
			mav.setViewName("gw/board/boardArticle/gwArticleUpdate");
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/GWArticleUpdateAjax", 
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String GWArticleUpdateAjax(HttpSession session, @RequestParam HashMap<String, String> params) 
						throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	iGwBoardService.ArticleUpdate(params);
	
	return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/GWArticleDelAjax", 
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String GWArticleDelAjax(HttpSession session, @RequestParam HashMap<String, String> params) 
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int res = iGwBoardService.ArticleDelete(params);
		
		return mapper.writeValueAsString(modelMap);
	}
}
