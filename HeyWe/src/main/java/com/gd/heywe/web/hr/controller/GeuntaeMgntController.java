package com.gd.heywe.web.hr.controller;

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
import com.gd.heywe.web.hr.service.IGeuntaeMgntService;

@Controller
public class GeuntaeMgntController {
	@Autowired
	public IGeuntaeMgntService iGeuntaeMgntService;
	
	@Autowired
	public IPagingService iPagingService;
	
	//근태항목
	@RequestMapping(value="/HRGeuntaeItem")
	public ModelAndView HRGeuntaeItem(ModelAndView mav) {
		
		mav.setViewName("hr/geuntaeMgnt/geuntaeItem");
		
		return mav;
	}
	
	//근태목록
	@RequestMapping(value = "/HRGeuntaeMgntAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRGeuntaeMgntAjax() throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> list = iGeuntaeMgntService.getGeuntaeName();
		
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//근태명 중복확인
	@RequestMapping(value = "/HRGeuntaeOverlapCheckAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRGeuntaeOverlapCheckAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iGeuntaeMgntService.geuntaeOverlapCheck(params);
		
		modelMap.put("cnt",cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//근태추가
	@RequestMapping(value = "/HRGeuntaeAddAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRGeuntaeAddAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iGeuntaeMgntService.geuntaeAdd(params);
			modelMap.put("errorCheck", "0");
		} catch (Exception e) {
			modelMap.put("errorCheck", "1");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//근태수정
	@RequestMapping(value = "/HRGeuntaeUpdateAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRGeuntaeUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iGeuntaeMgntService.geuntaeUpdateOverlapCheck(params);
		
		if(cnt == 0) {
			int updateResult = iGeuntaeMgntService.geuntaeUpdate(params);
			
			modelMap.put("updateResult",updateResult);
		}
		
		modelMap.put("cnt", cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//근태 삭제가능여부확인
	@RequestMapping(value = "/HRGeuntaeDeleteCheckAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRGeuntaeDeleteCheckAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iGeuntaeMgntService.geuntaeDeleteCheck(params);
		
		modelMap.put("cnt", cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//근태삭제
	@RequestMapping(value = "/HRGeuntaeDeleteAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRGeuntaeDeleteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iGeuntaeMgntService.geuntaeDelete(params);
		
		modelMap.put("cnt", cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//추가근무등록
	@RequestMapping(value="/HRAddWorkReg")	
	public ModelAndView HRAddWorkReg(ModelAndView mav) {
		
		mav.setViewName("hr/geuntaeMgnt/addWorkReg");
		
		return mav;
	}
	
	//추가근무등록 (근태명 조회)
	@RequestMapping(value = "/HRAddWorkGeuntaeListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRAddWorkGeuntaeListAjax() throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String,Object>> list = iGeuntaeMgntService.addWorkGeuntaeList();
		
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//추가근무등록 (근태명 조회)
	@RequestMapping(value = "/HRAddWorkRegAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")	
	@ResponseBody	
	public String HRAddWorkRegAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iGeuntaeMgntService.addWorkReg(params);
			modelMap.put("errorCheck", "0");
		} catch (Exception e) {
			modelMap.put("errorCheck", "1");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRGeuntaeCurrent")
	public ModelAndView HRGeuntaeCurrent(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) {

		mav.setViewName("hr/geuntaeMgnt/HRGeuntaeCurrent");

		return mav;
	}

	@RequestMapping(value = "/HRGeuntaeCurrentAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String HRGeuntaeCurrentAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iGeuntaeMgntService.getGeunTaeCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iGeuntaeMgntService.getGeunTaeList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}

	// 근태별
	@RequestMapping(value = "/HRGeunTaeAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRGeunTaeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iGeuntaeMgntService.GeunTaeList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRGeuntaeCurrentAdmin")
	public ModelAndView HRGeuntaeCurrentAdmin(ModelAndView mav) {

		mav.setViewName("hr/geuntaeMgnt/HRGeuntaeCurrentAdmin");

		return mav;
	}

	// 근태 관리자 ajax문
	@RequestMapping(value = "/HRGeuntaeCurrentAdminAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRGeuntaeCurrentAdminAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iGeuntaeMgntService.getGeunTaeAdminCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iGeuntaeMgntService.getGeunTaeAdminList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}

	// 근태별
	@RequestMapping(value = "/HRGeunTaeAdminAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRGeunTaeAdminAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iGeuntaeMgntService.GeunTaeList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 부서별
	@RequestMapping(value = "/HRDeptAdminAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptAdminAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iGeuntaeMgntService.DeptList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRempSearchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRempSearchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> list = iGeuntaeMgntService.getEmpSearchPopup(params);
		modelMap.put("list", list);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRGeunTaeApplyAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String HRGeunTaeApplyAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int res = iGeuntaeMgntService.insertGeunTaeData(params);
		if (res == 0) {
			modelMap.put("msg", "작성에 실패하였습니다.");
		}

		return mapper.writeValueAsString(modelMap);
	}
}
