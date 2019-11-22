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
import com.gd.heywe.web.hr.service.IProofMgntService;

@Controller
public class ProofMgntController {
	@Autowired
	public IProofMgntService iProofMgntService;

	@Autowired
	public IPagingService iPagingService;

	// 신청현황
	@RequestMapping(value = "/HRReqCurrent")
	public ModelAndView HRReqCurrent(ModelAndView mav) {

		mav.setViewName("hr/proofMgnt/HRreqCurrent");

		return mav;
	}

	@RequestMapping(value = "/HRReqCurrentAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRReqCurrentAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (!params.containsKey("page")) {
			params.put("page", "1");
		}

		int cnt = iProofMgntService.ReqCurrentCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 10);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iProofMgntService.ReqCurrent(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}

	// 신청현황  결재상세보기
	@RequestMapping(value = "/HRProofDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRProofDtlAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iProofMgntService.RetireProofDtl(params);
		HashMap<String, String> data2 = iProofMgntService.RetireProofCo(params);
		HashMap<String, String> data3 = iProofMgntService.date(params);
		
		modelMap.put("data", data);
		modelMap.put("data2", data2);
		modelMap.put("data3", data3);

		return mapper.writeValueAsString(modelMap);

	}

	
	@RequestMapping(value = "/HRCareerProofDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRCareerProofDtlAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iProofMgntService.RetireProofDtl(params);
		HashMap<String, String> data2 = iProofMgntService.RetireProofCo(params);
		HashMap<String, String> data3 = iProofMgntService.date(params);
		
		modelMap.put("data", data);
		modelMap.put("data2", data2);
		modelMap.put("data3", data3);

		return mapper.writeValueAsString(modelMap);

	}
	
	
	
	// 신청결과
	@RequestMapping(value = "/HRReqResult")
	public ModelAndView HRReqResult(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) throws Throwable {
		
		

		/*
		 * HashMap<String, String> data = iProofMgntService.RetireProofDtl(params);
		 * HashMap<String, String> data2 = iProofMgntService.RetireProofCo(params);
		 */
		
		/*
		 * mav.addObject("data", data); mav.addObject("data2", data2);
		 */
		mav.setViewName("hr/proofMgnt/HRreqResult");
		return mav;
	}

	@RequestMapping(value = "/HRReqResultAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRReqResultAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (!params.containsKey("page")) {
			params.put("page", "1");
		}

		int cnt = iProofMgntService.ReqResultCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 6, 10);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list2 = iProofMgntService.ReqResult(params);

		modelMap.put("list2", list2);
		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);

	}

	// 증명서결재
	@RequestMapping(value = "HRProofApvAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRProofApvAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int res = iProofMgntService.proofapv(params);

		if (res == 0) {
			modelMap.put("msg", " test");
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 반려
	@RequestMapping(value = "HRProofRejAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRProofRejAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int res2 = iProofMgntService.proofrej(params);

		if (res2 == 0) {
			modelMap.put("msg", " test");
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRInoffProof")
	public ModelAndView HRInoffProof(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) throws Throwable {

		// session을통해 params에 넣어준 값(sEmpNo)를 부르기 위한 방식
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		HashMap<String, String> data = iProofMgntService.getEmpDtl(params);
		HashMap<String, String> data2 = iProofMgntService.getCoDtl(params);
		HashMap<String, String> data3 = iProofMgntService.date(params);

		mav.addObject("data", data);
		mav.addObject("data2", data2);
		mav.addObject("data3", data3);

		mav.setViewName("hr/proofMgnt/HRInoffProof");

		return mav;
	}

	@RequestMapping(value = "/HRCareerProof")
	public ModelAndView HRCareerProof(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) throws Throwable {

		/* System.out.println("asdasd"+ session.getAttribute("sEmpNo")); */

		// session을통해 params에 넣어준 값(sEmpNo)를 부르기 위한 방식
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		HashMap<String, String> data = iProofMgntService.getEmpDtl(params);
		HashMap<String, String> data2 = iProofMgntService.getCoDtl(params);
		HashMap<String, String> data3 = iProofMgntService.getPlaceDtl(params);
		HashMap<String, String> data4 = iProofMgntService.date(params);

		mav.addObject("data", data);
		mav.addObject("data2", data2);
		mav.addObject("data3", data3);
		mav.addObject("data4", data4);

		mav.setViewName("hr/proofMgnt/HRCareerProof");
		return mav;
	}

	@RequestMapping(value = "/HRInoffProofAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRInoffProofAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("HRInoffProofAjax params : " + params);
		int res = iProofMgntService.insertInoffProofData(params);
		if (res == 0) {
			modelMap.put("msg", "작성에 실패하였습니다.");
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRCareerProofAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRCareerProofAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("HRInoffProofAjax params : " + params);
		int res = iProofMgntService.insertCareerProofData(params);
		if (res == 0) {
			modelMap.put("msg", "작성에 실패하였습니다.");
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRRetireProof")
	public ModelAndView HRRetireProof(ModelAndView mav) {

		mav.setViewName("hr/proofMgnt/HRRetireProof");
		return mav;
	}

	@RequestMapping(value = "/HRRetireProofAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRRetireProofAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iProofMgntService.RetireCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iProofMgntService.RetireList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	// 부서별
	@RequestMapping(value = "/HRProofDeptAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iProofMgntService.getDeptList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 직위별
	@RequestMapping(value = "/HRProofPosiAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRProofPosiAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iProofMgntService.getPosiList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 사원 클릭 팝업생성
	@RequestMapping(value = "/HRRetireProofDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRRetireProofDtlAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iProofMgntService.RetireDtlData(params);
		HashMap<String, String> data2 = iProofMgntService.getCoDtl(params);
		HashMap<String, String> data3 = iProofMgntService.getPlaceDtl(params);
		HashMap<String, String> data4 = iProofMgntService.date(params);

		modelMap.put("data", data);
		modelMap.put("data2", data2);
		modelMap.put("data3", data3);
		modelMap.put("data4", data4);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRRetireAskProofAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String HRRetireAskProofAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("HRInoffProofAjax params : " + params);
		int res = iProofMgntService.insertRetireProofData(params);
		if (res == 0) {
			modelMap.put("msg", "작성에 실패하였습니다.");
		}

		return mapper.writeValueAsString(modelMap);
	}

}
