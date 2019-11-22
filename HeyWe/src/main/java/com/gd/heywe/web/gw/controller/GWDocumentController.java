package com.gd.heywe.web.gw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.gd.heywe.web.gw.service.GWIDocumentService;

@Controller
public class GWDocumentController {
	@Autowired
	public GWIDocumentService iDocumentService;

	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value = "/GWDocDtl")
	public ModelAndView GWDocDtl(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		
		try {
			HashMap<String, String> dtl = iDocumentService.DocDtl(params);
			List<HashMap<String, String>> att_dtl = iDocumentService.DocDtlAtt(params);
			iDocumentService.DocHitUpdate(params);
			mav.addObject("att_dtl", att_dtl);
			mav.addObject("dtl", dtl);
			mav.setViewName("gw/document/GWDocDtl");
		} catch (Exception e) {
			mav.setViewName("redirect:GWDeptDocBoard");
		}
		return mav;
	}

	@RequestMapping(value = "/GWDeptDocBoard")
	public ModelAndView GWDeptDocBoard(ModelAndView mav, @RequestParam HashMap<String, String> params)
			throws Throwable {
		mav.setViewName("gw/document/GWDocBoard");
		return mav;
	}

	@RequestMapping(value = "/GWComnDocBoard")
	public ModelAndView GWComDocBoard(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		mav.addObject("doctype", 0);
		mav.setViewName("gw/document/GWDocBoard");
		return mav;
	}

	@RequestMapping(value = "/GWPubDocBoard")
	public ModelAndView GWDipDocBoard(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		mav.addObject("doctype", 1);
		mav.setViewName("gw/document/GWDocBoard");
		return mav;
	}

	@RequestMapping(value = "/GWDocBoardAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWDocBoardAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {

			if (!params.containsKey("page")) {
				params.put("page", "1");
			}

			int cnt = iDocumentService.getDocBoardCnt(params);

			PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));

			List<HashMap<String, String>> data = iDocumentService.getDocBoardList(params);
			
			modelMap.put("cnt", Integer.toString(cnt));
			modelMap.put("data", data);
			modelMap.put("pb", pb);
			modelMap.put("page", params.get("page"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/GWDocWrite")
	public ModelAndView GWDeptDocWrite(ModelAndView mav, @RequestParam HashMap<String, String> params) {
		if(params.isEmpty()) {
			mav.setViewName("redirect:GWDeptDocBoard");
		} else {
			mav.setViewName("gw/document/GWDocWrite");
		}
		return mav;
	}

	@RequestMapping(value = "/GWDocWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWDocWriteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			modelMap.put("res", "0");
			iDocumentService.DocWrite(params);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("res", "1");
			modelMap.put("msg", "실패");
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/GWDocDelAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWDocDelAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int res = iDocumentService.DocDel(params);

		if (res == 0) {
			modelMap.put("msg", "삭제에 실패하였어요...");
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/GWDocUpdate")
	public ModelAndView GWDeptDocUpdate(ModelAndView mav, @RequestParam HashMap<String, String> params)
			throws Throwable {
		try {
			HashMap<String, String> data = iDocumentService.DocDtl(params);
			List<HashMap<String, String>> att_dtl = iDocumentService.DocDtlAtt(params);
			mav.addObject("att_dtl", att_dtl);
			mav.addObject("data", data);
			mav.setViewName("gw/document/GWDocUpdate");
		} catch (Exception e) {
			mav.setViewName("redirect:GWDeptDocBoard");
		}

		return mav;
	}

	@RequestMapping(value = "GWDocUpdateAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWDocUpdateAjax(@RequestParam HashMap<String, String> params,
								  HttpServletRequest request) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
		
			String[] existFiles = request.getParameterValues("existAttFile");
			if(existFiles != null) {
				String s = "";
				for(int i=0; i<existFiles.length; i++) {
					s += "," + existFiles[i];
				}
				params.put("existAttFiles", s.substring(1));
			}
			System.out.println("컨트" + params);
			iDocumentService.DocUpdate(params);
			
			
		} catch (Exception e) {
			modelMap.put("msg", "수정에 실패하였습니다.");
			modelMap.put("res", "0");
		}
	
		return mapper.writeValueAsString(modelMap);

	}

}
