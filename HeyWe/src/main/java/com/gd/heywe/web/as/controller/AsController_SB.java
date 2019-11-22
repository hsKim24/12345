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
import com.gd.heywe.common.service.IPagingService;
import com.gd.heywe.web.as.service.iAsService_SB;

@Controller
public class AsController_SB {

	@Autowired
	public iAsService_SB iasService;

	@Autowired
	public IPagingService iPagingService;

	// 자산목록
	@RequestMapping(value = "/ASAsList")
	public ModelAndView ASAsList(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {

		mav.setViewName("as/ASAsList");

		return mav;
	}

	// 목록 ajax
	@RequestMapping(value = "/ASAsListAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASAsListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (!params.containsKey("page")) {
			params.put("page", "1");
		}

		int cnt = iasService.getAsListCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 4, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iasService.getAsList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("listPage", params.get("listPage"));

		return mapper.writeValueAsString(modelMap);
	}

	// 등록(쓰기) ajax
	@RequestMapping(value = "/ASAsListWriteAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASAsListWriteAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iasService.insertAs(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 상세보기 ajax
	@RequestMapping(value = "/AsListDtlAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String AsListDtlAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iasService.getAsDtl(params);

		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);
	}

	// 사용자검색 ajax
	@RequestMapping(value = "/AsListSearchEmpAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String AsListSearchEmpAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list2 = iasService.getAsSearchList(params);

		if (!params.containsKey("listPage2")) {
			params.put("listPage2", "1");
		}

		int cnt = iasService.getAsSearchListCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("listPage2")), cnt, 4, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		modelMap.put("pb", pb);
		modelMap.put("listPage2", params.get("listPage2"));
		modelMap.put("list2", list2);

		return mapper.writeValueAsString(modelMap);
	}

	// 수정 ajax
	@RequestMapping(value = "/AsListUpdateAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String AsListUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		iasService.UpdateAs(params);

		return mapper.writeValueAsString(modelMap);
	}

	// 삭제ajax
	@RequestMapping(value = "/AsListDeleteAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String AsListDeleteAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		iasService.deleteAs(params);

		return mapper.writeValueAsString(modelMap);
	}

	// 파기 ajax
	@RequestMapping(value = "/AsListUpdateDelAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String AsListUpdateDelAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		iasService.UpdateAsListDel(params);

		return mapper.writeValueAsString(modelMap);
	}


	// 파기목록
	@RequestMapping(value = "/ASAsDeList")
	public ModelAndView ASAsDelList(ModelAndView mav) {

		mav.setViewName("as/ASAsDeList");

		return mav;
	}
	// 파기목록리스트  ajax
	@RequestMapping(value = "/ASAsDeListAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASAsDeListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (!params.containsKey("page")) {
			params.put("page", "1");
		}

		int cnt = iasService.getAsdeListCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 4, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iasService.getAsdeList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("listPage", params.get("listPage"));

		return mapper.writeValueAsString(modelMap);
	}
	

	// 프로젝트목록
	@RequestMapping(value = "/ASProjList")
	public ModelAndView ASProjList(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {

		mav.setViewName("as/ASProjList");

		return mav;
	}

	// 프로젝트목록 ajax
	@RequestMapping(value = "/ASProjListAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (!params.containsKey("page")) {
			params.put("page", "1");
		}

		int cnt = iasService.getAsProjListCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 4, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list3 = iasService.getAsProjList(params);
		
		modelMap.put("list3", list3);
		modelMap.put("pb", pb);
		modelMap.put("listPage3", params.get("listPage3"));

		return mapper.writeValueAsString(modelMap);
	}

	// 프로젝트목록 등록(쓰기) ajax
	@RequestMapping(value = "/ASProjListWriteAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListWriteAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iasService.insertAsProj(params);

			modelMap.put("message", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("message", CommonProperties.RESULT_ERROR);
			modelMap.put("errorMessage", e.getMessage());
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 프로젝트 sol가져오기 ajax
	@RequestMapping(value = "/ASProjListSolTakeAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListSolTakeAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list4 = iasService.getProjSol(params);

		modelMap.put("list4", list4);

		return mapper.writeValueAsString(modelMap);
	}

	// 프로젝트 mk가져오기 ajax
	@RequestMapping(value = "/ASProjListMkTakeAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListMkTakeAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list5 = iasService.getProjMk(params);

		modelMap.put("list5", list5);

		return mapper.writeValueAsString(modelMap);
	}

	// 프로젝트 area가져오기 ajax
	@RequestMapping(value = "/ASProjListAreaTakeAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListAreaTakeAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list6 = iasService.getProjArea(params);

		modelMap.put("list6", list6);

		return mapper.writeValueAsString(modelMap);
	}

	// 프로젝트 프로젝트매니저 가져오기 ajax
	@RequestMapping(value = "/ASProjListPmTakeAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListPmTakeAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list7 = iasService.getProjPm(params);

		modelMap.put("list7", list7);

		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 상세보기 ajax
	@RequestMapping(value = "/ASProjListDtlAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListDtlAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iasService.getAsProjListDtl(params);
		
		List<HashMap<String, String>> list = iasService.getAsProjListSubDtl(params);
		
		modelMap.put("data", data);
		System.out.println("datadatadatadatadatadata");
		System.out.println(data);
		modelMap.put("list", list);
		System.out.println("listlistlistlistlist");
		System.out.println(list);
		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 목록 수정 ajax
	@RequestMapping(value = "/ASProjListUpdateAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(params);
		iasService.UpdateAsProj(params);
		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 목록 인원추가 ajax
	@RequestMapping(value = "/ASProjListAddEmpAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListAddEmpAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		List<HashMap<String, String>> list = iasService.getProjAddEmp(params);
		
		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 목록 업무 ajax
	@RequestMapping(value = "/ASProjListTaskAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListTaskAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		List<HashMap<String, String>> list = iasService.getProjListTask(params);
		
		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 등록(쓰기) ajax
	@RequestMapping(value = "/ASProjListAddAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListAddAjax(@RequestParam HashMap<String, String> params) throws Throwable {

			
		System.out.println(params.toString());
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
			iasService.insertAsProjAdd(params);


		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 상세보기 인원추가 리로디 ajax
	@RequestMapping(value = "/ASProjListAddEmpReloadAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListAddEmpReloadAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		List<HashMap<String, String>> list = iasService.getProjListAddReload(params);
		
		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}
	// 인원제거 삭제ajax
	@RequestMapping(value = "/ASProjListDelEmpAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListDelEmpAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("paramsparamsparamsparamsparams");
		System.out.println(params);
		iasService.deleteAsProjDelEmp(params);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 프로젝트 삭제ajax
	@RequestMapping(value = "/ASProjListDelProjAjax", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")

	@ResponseBody
	public String ASProjListDelProjAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		iasService.deleteAsProjListDelFirst(params);

		iasService.deleteAsProjListDel(params);

		return mapper.writeValueAsString(modelMap);
	}
	
	//제품코드 중복체크 AJAX
	@RequestMapping(value = "/ASAsListItemNoCheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8") // 문서

	@ResponseBody // 컨트롤러의 역할 , 주소가 넘어왔을 때 해당 화면에서 띄우겠다. view로 가장하여(인척하여) Spring에게 정보를 넘긴다.
	public String ASAsListItemNoCheckAjax(@RequestParam  HashMap<String, String> params,  ModelAndView mav) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int itemNo = iasService.itemNoCheck(params);
		
		 int result =0;
		
		 if(itemNo >= 1) {
			 System.out.println("중복");
			 result =1; 
		 }else {
			 System.out.println("중복X");
		 }	 	
		  modelMap.put("result", result);
				
		return mapper.writeValueAsString(modelMap);

	}
	

}
