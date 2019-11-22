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
import com.gd.heywe.web.gw.service.IGwApvService;
import com.gd.heywe.web.hr.service.IHRMgntService;
import com.gd.heywe.web.hr.service.IHRSalMgntService;

@Controller
public class HRSalMgntController { //급여관리

	@Autowired
	public IPagingService iPagingService;
	
	@Autowired 
	public IHRSalMgntService iHRSalMgntService;
	@Autowired 
	public IHRMgntService iHRMgntService;
	 
	@Autowired
	public IGwApvService iGwApvService;
	//급여계산
	@RequestMapping(value="/HRSalCalc")
	public ModelAndView HRSalCalc(ModelAndView mav) throws Throwable {

		List<HashMap<String,String>> deptList = iHRMgntService.getDeptList();
		List<HashMap<String,String>> stdList = iHRSalMgntService.getStdList();
		mav.addObject("deptList",deptList);
		mav.addObject("stdList",stdList);
		mav.setViewName("hr/salMgnt/HRSalCalc");
		return mav;
	}
	
	//급여코드관리
	@RequestMapping(value="/HRSalCodeMgnt")
	public ModelAndView HRSalCodeMgnt(ModelAndView mav) {
		
		mav.setViewName("hr/salMgnt/HRSalCodeMgnt");
		return mav;
	}
	
	  //get Geuntae List!
	@RequestMapping(value="/HRGeuntaeListAjax",
				  method = RequestMethod.POST, 
				  produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String HRGeuntaeListAjax(@RequestParam HashMap<String,String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		if(params.get("page") == null || params.get("page") == "") {
			params.put("page","1");
		}
		
		int cnt = iHRSalMgntService.HRgetGeuntaeCnt();
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")),
					cnt, 10, 5);
		params.put("startCnt",Integer.toString(pb.getStartCount()));
		params.put("endCnt",Integer.toString(pb.getEndCount()));
		List<HashMap<String,String>> geuntaeList = iHRSalMgntService.HRGeuntaeList(params);
		// modelMap.put("endDate",endDate);
		modelMap.put("list",geuntaeList);
		modelMap.put("pb",pb);
		modelMap.put("page", params.get("page"));
		return mapper.writeValueAsString(modelMap); 
	}
	
	
	//add Geuntae 
	@RequestMapping(value="/HRaddGeuntaeAjax",
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String HRaddGeuntaeAjax(@RequestParam HashMap<String,String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		int res = iHRSalMgntService.HRaddGeuntae(params);
		System.out.println("HRaddGeuntae res : "+res);
		modelMap.put("res",res);
		return mapper.writeValueAsString(modelMap); 
	}
	
	//del Geuntae 
	@RequestMapping(value="/HRdelGeuntaeAjax",
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String HRdelGeuntaeAjax(@RequestParam HashMap<String,String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		int res = iHRSalMgntService.HRdelGeuntae(params);
		System.out.println("HRdelGeuntae res : "+res);
		modelMap.put("res",res);
		return mapper.writeValueAsString(modelMap); 
	}
	//del Geuntae 
	@RequestMapping(value="/HRupdateGeuntaeAjax",
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String HRupdateGeuntaeAjax(@RequestParam HashMap<String,String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		int res = iHRSalMgntService.HRupdateGeuntae(params);
		System.out.println("HRdelGeuntae res : "+res);
		modelMap.put("res",res);
		return mapper.writeValueAsString(modelMap); 
	}
	
	//급여계산 리스트 가저오기 
	@RequestMapping(value="/HRSalCalcListAjax",
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String HRSalCalcListAjax(@RequestParam HashMap<String,String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		/*
		 * int cnt = iHRSalMgntService.HRsalCalcCnt(params); PagingBean pb =
		 * iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10,
		 * 5);
		 * 
		 * params.put("startCnt",Integer.toString(pb.getStartCount()));
		 * params.put("endCnt",Integer.toString(pb.getEndCount()));
		 */
		System.out.println("params : " + params);
		List<HashMap<String,String>> salCalcList = iHRSalMgntService.HRgetEmpSalList(params);
		/*
		 * modelMap.put("pb",pb); modelMap.put("page", params.get("page"));
		 */
		modelMap.put("list",salCalcList);
		return mapper.writeValueAsString(modelMap); 
	}
	
	//salcalc 결재 신청
		@RequestMapping(value="/HRsalCalcApvAjax", 
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String HRsalCalcApvAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			params.put("sEmpNo",session.getAttribute("sEmpNo").toString());
			List<HashMap<String, String>> apvName = iHRSalMgntService.HRGetApvSalCalcM();
			System.out.println(apvName);
			params.put("apverNos",String.valueOf(apvName.get(0).get("EMP_NO")) + ","+
					String.valueOf(apvName.get(1).get("EMP_NO")));
			System.out.println("이름ㅇ ㅓ떻게 나오닞이이징 : "+params);
			
			String[] salCalcList = params.get("salCalcList").split(",");
			String str = "";
			for(int i = 0; i < salCalcList.length;i++) {
				str+= "," + salCalcList[i];
			}
			
			str = str.substring(1);
			
			System.out.println("왜안찍혀 : " + str);
			params.put("salCalcNo",str);
		
			iGwApvService.reportApv(params);
			int res = iHRSalMgntService.setEmpApvChange(params);
			System.out.println("결과 갯수 : " + res);
			return mapper.writeValueAsString(modelMap);	
		}
		//연봉을 한명만 저장할 시
		@RequestMapping(value="/HROneSaveBtnAjax",
				method=RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String HROneSaveBtnAjax(@RequestParam HashMap<String,String> params) throws Throwable{
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			int res = iHRSalMgntService.oneInsertSal(params);
			System.out.println(res);
			modelMap.put("res",res);
			return mapper.writeValueAsString(modelMap);	
		}
		//연봉을 한명만 수정할 시
		@RequestMapping(value="/HRoneUpdateBtnAjax",
				method=RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String HRoneUpdateBtnAjax(@RequestParam HashMap<String,String> params) throws Throwable{
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			int res = iHRSalMgntService.oneUpdateSal(params);
			System.out.println(res);
			modelMap.put("res",res);
			return mapper.writeValueAsString(modelMap);	
		}
}













