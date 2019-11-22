package com.gd.heywe.web.as.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.gd.heywe.web.as.service.IASServiceSH;
import com.gd.heywe.web.as.service.ILectPagingService;

@Controller
public class AsController_SH {
	
	@Autowired
	public IASServiceSH iASSserviceSH;
	
	@Autowired
	public ILectPagingService iLectPagingService;
	
	
	
	@RequestMapping(value="/ASEduClecture")
	public ModelAndView ASEduClecture(ModelAndView mav) {
		
		mav.setViewName("erp/as/c_lecture");
		
		return mav;
	}
	
	
	
	
	
	@RequestMapping(value="/edu/c_lecture_ds")
	public ModelAndView C_Lecture_Ds(ModelAndView mav) {
		
		mav.setViewName("erp/as/edu/c_lecture_ds");
		
		return mav;
	}
	
	
	@RequestMapping(value="/ASLecEndlist")
	public ModelAndView ASLecEndlist(ModelAndView mav) {
		
		mav.setViewName("as/ASLecEndlist");
		
		return mav;
	}
	
	@RequestMapping(value = "/lectscheListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String lectscheListAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		//예정강의는 3을 붙이기
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int lectcnt = iASSserviceSH.getscheLectCnt(params);
		
		PagingBean pb3 = iLectPagingService.getPagingBean(Integer.parseInt(params.get("page3")), lectcnt, 4, 5);
		
		params.put("startCnt3", Integer.toString(pb3.getStartCount()));
		params.put("endCnt3", Integer.toString(pb3.getEndCount()));
		
		List<HashMap<String, String>> list3 = iASSserviceSH.getscheLectList(params);
	
		
		modelMap.put("list3", list3);
		modelMap.put("pb3", pb3);
		
		
		return mapper.writeValueAsString(modelMap);

	}
	
	@RequestMapping(value = "/tchrListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String tchrListAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		//예정강의는 3을 붙이기
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iASSserviceSH.tchrLctCnt(params);
		
		PagingBean pb3 = iLectPagingService.getPagingBean(Integer.parseInt(params.get("page3")), cnt, 4, 5);
		
		params.put("startCnt3", Integer.toString(pb3.getStartCount()));
		params.put("endCnt3", Integer.toString(pb3.getEndCount()));
		
		List<HashMap<String, String>> list3 = iASSserviceSH.gettchrLectList(params);
		
	  	
		
		modelMap.put("list3", list3);
		modelMap.put("pb3", pb3);
		
		
		return mapper.writeValueAsString(modelMap);

	}
	
	//호실번호 중복체크
	@RequestMapping(value = "/roomnumcheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String roomnumcheckAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		//예정강의는 3을 붙이기
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int roomnum = iASSserviceSH.roomnumchek(params);
		
		 int result =0;
		
		 if(roomnum == 1) {
			 System.out.println("중복");
			 result =1; 
		 }else {
			 System.out.println("중복X");
		 }	 	
		  modelMap.put("result", result);
				
		return mapper.writeValueAsString(modelMap);

	}
	//강사경력 중복체크
	@RequestMapping(value = "/careerCheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String careerCheckAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		//예정강의는 3을 붙이기
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int career = iASSserviceSH.careerChek(params);
		
		 int result =0;
		
		 if(career == 1) {
			 System.out.println("중복된 경력");
			 result =1; 
		 }else {
			 System.out.println("새로운 경력");
		 }	 	
		  modelMap.put("result", result);
				
		return mapper.writeValueAsString(modelMap);

	}
	
	
	
	
	
	//강사 휴대전화 중복체크
	@RequestMapping(value = "/tchroverrapcheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String tchroverrapcheckAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		//예정강의는 3을 붙이기
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int phonemnum = iASSserviceSH.phonenumchek(params);
		
		 int result =0;
		
		 if(phonemnum >= 1) {
			 System.out.println("중복");
			 result =1; 
		 }else {
			 System.out.println("중복X");
		 }	 	
		  modelMap.put("result", result);
				
		return mapper.writeValueAsString(modelMap);

	}
	

	
	@RequestMapping(value = "/lectendListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String lectendListAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int lectcnt = iASSserviceSH.getendLectCnt(params);
		
		PagingBean pb = iLectPagingService.getPagingBean(Integer.parseInt(params.get("page")), lectcnt, 4, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iASSserviceSH.getendLectList(params);
	
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		
		return mapper.writeValueAsString(modelMap);

	}
	

	/* lectListAjax */
	@RequestMapping(value="/ASLecInfomgnt")
	public ModelAndView ASLecInfomgnt(ModelAndView mav) {
		
		mav.setViewName("as/ASLecInfomgnt");
		
		return mav;
	}
	
	@RequestMapping(value = "/placeListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String placeListAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		//예정강의는 3을 붙이기
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iASSserviceSH.getplaceInfoCnt(params);
		
		PagingBean pb = iLectPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 4, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iASSserviceSH.getplaceInfoList(params);
	
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		
		return mapper.writeValueAsString(modelMap);

	}
	
	
	
	/* lectListAjax */
	@RequestMapping(value="/ASLecList")
	public ModelAndView ASLecList(ModelAndView mav) {
		
		mav.setViewName("as/ASLecList");
		
		return mav;
	}
	
	@RequestMapping(value = "/lectListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서
	
	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String lectListAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int lectcnt = iASSserviceSH.getLectCnt(params);
		
		PagingBean pb = iLectPagingService.getPagingBean(Integer.parseInt(params.get("page")), lectcnt, 4, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iASSserviceSH.getLectList(params);
	
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		
		return mapper.writeValueAsString(modelMap);

	}
	
	//강의담당직원 선택 리스트(팝업)
	@RequestMapping(value = "/emppopupListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String emppopupListAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		  List<HashMap<String, String>> list = iASSserviceSH.getAsSearchList(params);

		 modelMap.put("list", list); 
		
		return mapper.writeValueAsString(modelMap);

	}
	
	//강의장소 Ajax(팝업)
	@RequestMapping(value = "/placepopupListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String placepopupListAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iASSserviceSH.getplaceList(params);

		modelMap.put("list", list); 
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//강의장소 Ajax(팝업)
		@RequestMapping(value = "/tchrpopupListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

		@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
		public String tchrpopupListAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			List<HashMap<String, String>> list = iASSserviceSH.gettchrList(params);

			modelMap.put("list", list); 
			
			return mapper.writeValueAsString(modelMap);
		}
		
		@RequestMapping(value = "/AsLecttDeleteAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

		@ResponseBody
		public String AsListDeleteAjax(@RequestParam HashMap<String, String> params) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			iASSserviceSH.deletAfc(params);
			iASSserviceSH.deleteLect(params);

			return mapper.writeValueAsString(modelMap);
		}
		
		@RequestMapping(value = "/AsDroplectAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

		@ResponseBody
		public String AsDroplectAjax(@RequestParam HashMap<String, String> params) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			
			iASSserviceSH.droplect(params);

			return mapper.writeValueAsString(modelMap);
		}
		
	@RequestMapping(value = "/placeDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String placeDtlAjax(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iASSserviceSH.placeDtl(params);

		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);

	}
	
	@RequestMapping(value = "/tchrDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String tchrDtlAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		
		HashMap<String, String> data2 = iASSserviceSH.getchrDtl(params);
		
		List<HashMap<String, String>> list2 = iASSserviceSH.careerList(params);
		
	
		
		modelMap.put("data2", data2);
		modelMap.put("list2", list2); 
		
		return mapper.writeValueAsString(modelMap);

	}
	
	
	

	
	@RequestMapping(value = "/lectDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String lectDtlAjax(@RequestParam HashMap<String, String> params,  ModelAndView mav) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		
		HashMap<String, String> data2 = iASSserviceSH.getLectDtl(params);
		
		  List<HashMap<String, String>> list2 = iASSserviceSH.getAfcList(params);
		
	
		
		modelMap.put("data2", data2);
		 modelMap.put("list2", list2); 
		
		return mapper.writeValueAsString(modelMap);

	}
	//강의등록
	@RequestMapping(value = "/regiLectlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String regiLectlAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iASSserviceSH.regiLect(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	//장소등록
		@RequestMapping(value = "/updatePlaceAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String updatePlaceAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
				throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			try {
				iASSserviceSH.updatePlace(params);

				modelMap.put("msg", "등록에 성공하였습니다");
			} catch (Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "등록에 실패하였습니다");
			}

			return mapper.writeValueAsString(modelMap);
		}
		//강사등록
		@RequestMapping(value = "/regiTchrAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String regiTchrAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
				throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			try {
				iASSserviceSH.regiTchr(params);

				modelMap.put("msg", "등록에 성공하였습니다");
			} catch (Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "등록에 실패하였습니다");
			}

			return mapper.writeValueAsString(modelMap);
		}	
	
		//강사경력등록
		@RequestMapping(value = "/regiCareerAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String regiCareerAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
				throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			try {
				iASSserviceSH.regiCareer(params);

				modelMap.put("msg", "등록에 성공하였습니다");
			} catch (Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "등록에 실패하였습니다");
			}

			return mapper.writeValueAsString(modelMap);
		}	
		
	//강의신청
	@RequestMapping(value = "/regiApplyAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String regiApplyAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iASSserviceSH.regiApply(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}
	

	@RequestMapping(value="/main")
	public ModelAndView Main(ModelAndView mav) {
		
		mav.setViewName("as/lecture/main");
		
		return mav;
	}
}