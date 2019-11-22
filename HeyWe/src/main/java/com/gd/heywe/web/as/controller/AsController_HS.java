package com.gd.heywe.web.as.controller;

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
import com.gd.heywe.common.CommonProperties;
import com.gd.heywe.common.bean.PagingBean;
import com.gd.heywe.common.service.IPagingService;
import com.gd.heywe.web.as.service.IAsService_HS;

@Controller
public class AsController_HS {
	@Autowired
	public IAsService_HS iAsService;

	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value="/ASSolList")
	public ModelAndView ASSolList(ModelAndView mav) {
		
		mav.setViewName("as/ASSolList");
		
		return mav;
	}
	
	@RequestMapping(value = "/ASSolListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	   @ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	   public String ASSolListAjax(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

	      ObjectMapper mapper = new ObjectMapper();
	      Map<String, Object> modelMap = new HashMap<String, Object>();

	      if(!params.containsKey("listPage")) { params.put("listPage", "1"); }
	      
	      int solCnt = iAsService.ASGetSolCnt(params);
	      
	      PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), solCnt, 4, 5);
	      
	      params.put("startCnt", Integer.toString(pb.getStartCount()));
	      params.put("endCnt", Integer.toString(pb.getEndCount()));

	      
	      List<HashMap<String, String>> list = iAsService.ASGetSolList(params);
	      //List<HashMap<String, String>> list = iAsService.getTest2(params);
	   //   HashMap<String, String> data2 = iAsService.getSolDtl(params);
	      
	      modelMap.put("list", list);
	      modelMap.put("pb", pb);
	     // modelMap.put("data2", data2);
	      
	      return mapper.writeValueAsString(modelMap);

	   }
	// 솔루션 등록 ajax
	@RequestMapping(value = "/ASRegiSolAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ASRegiSolAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iAsService.ASRegiSol(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	// 솔루션 상세보기 ajax
		@RequestMapping(value = "/AsSolDtlAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")
		@ResponseBody
		public String AsSolDtlAjax(@RequestParam HashMap<String, String> params) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			HashMap<String, String> data = iAsService.AsSolDtl(params);
		  
			modelMap.put("data", data);

			return mapper.writeValueAsString(modelMap);
		}

	// 솔루션 수정 ajax
		@RequestMapping(value = "/AsSolUpdateAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

		@ResponseBody
		public String AsSolUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			iAsService.AsSolUpdate(params); 

			return mapper.writeValueAsString(modelMap);
		}	
		
	// 솔루션 삭제 ajax
		@RequestMapping(value="/AsSolDeleteAjax", method = RequestMethod.POST,
				produces = "text/json; charset=UTF-8")
		
		@ResponseBody
		public String AsSolDeleteAjax(@RequestParam HashMap<String, String> params ) throws Throwable{ 
			
			ObjectMapper mapper = new ObjectMapper();		
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			iAsService.AsSolDelete(params);
			
			return mapper.writeValueAsString(modelMap);
		}

		
		
	@RequestMapping(value="/ASEmpList")
	public ModelAndView ASEmpList(ModelAndView mav) {
		
		mav.setViewName("as/ASEmpList");
		
		return mav;
	}
	
	@RequestMapping(value = "/ASEmpListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	   @ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	   public String ASEmpListAjax(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

	      ObjectMapper mapper = new ObjectMapper();
	      Map<String, Object> modelMap = new HashMap<String, Object>();

	      if(!params.containsKey("listPage")) { params.put("listPage", "1"); }
	      
	      int empCnt = iAsService.ASGetEmpCnt(params);
	      
	      PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), empCnt, 4, 5);
	      
	      params.put("startCnt", Integer.toString(pb.getStartCount()));
	      params.put("endCnt", Integer.toString(pb.getEndCount()));

	      
	      List<HashMap<String, String>> list = iAsService.ASGetEmpList(params);
	      //List<HashMap<String, String>> list = iAsService.getTest2(params);
	   //   HashMap<String, String> data2 = iAsService.getSolDtl(params);
	      
	      modelMap.put("list", list);
	      modelMap.put("pb", pb);
	     // modelMap.put("data2", data2);
	      
	      return mapper.writeValueAsString(modelMap);

	   }	
	// 인재 등록 ajax
	@RequestMapping(value = "/ASRegiEmpAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ASRegiEmpAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iAsService.ASRegiEmp(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 인재정보 상세보기 ajax
	@RequestMapping(value = "/AsEmpDtlAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String AsEmpDtlAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iAsService.AsEmpDtl(params);
		List<HashMap<String, String>> list = iAsService.AsTableDtl(params);
	  
		modelMap.put("data", data);
		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 인재정보 수정 ajax
	@RequestMapping(value = "/AsEmpUpdateAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String AsEmpUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		iAsService.AsEmpUpdate(params); 

		return mapper.writeValueAsString(modelMap);
	}	
	
	// 인재정보 삭제 ajax
	@RequestMapping(value="/AsEmpDeleteAjax", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	
	@ResponseBody
	public String AsEmpDeleteAjax(@RequestParam HashMap<String, String> params ) throws Throwable{ 
		
		ObjectMapper mapper = new ObjectMapper();		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int res = iAsService.AsEmpDelete(params);
		
		if(res == 0) {
			modelMap.put("msg", "삭제에 실패하였습니다");
			modelMap.put("flag", 0);
		} else {
			params.remove("empNo");
			modelMap.put("msg", "삭제에 성공하였습니다");
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}

// 인재경력 등록 ajax
@RequestMapping(value = "/ASRegiCarAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
@ResponseBody
public String ASRegiCarAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
		throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();

	try {
		iAsService.ASRegiCar(params);

		modelMap.put("message", CommonProperties.RESULT_SUCCESS);
	} catch (Exception e) {
		e.printStackTrace();
		modelMap.put("message", CommonProperties.RESULT_ERROR);
		modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}
}
