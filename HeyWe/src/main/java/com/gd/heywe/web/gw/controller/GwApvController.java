package com.gd.heywe.web.gw.controller;

import java.util.Arrays;  
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

@Controller
public class GwApvController {
	
	@Autowired
	public IGwApvService iGwApvService;		
	
	@Autowired
	public IPagingService iPagingService;
	
	//************************* 새 결재 진행  *************************
	
	//************ 1.결재양식 선택  ************
	
	//새결재 - 결재양식 선택 
	@RequestMapping(value="/GWNewApv")
	public ModelAndView GWNewApv(ModelAndView mav) {
		
		mav.setViewName("gw/ea/newApv/GWNewApv");
		
		return mav;
	}
	
	//결재양식 리스트ajax
	@RequestMapping(value="/GWapvTypeListAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWapvTypeListAjax(	HttpSession session,
										@RequestParam HashMap<String, String> params) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		System.out.println(params.toString());
		
		List<HashMap<String, String>> apvTypeDivList = iGwApvService.getApvTypeDivList(params);
		List<HashMap<String, String>> apvDocTypeList = iGwApvService.getApvDocTypeList(params);
		
		modelMap.put("apvTypeDivList", apvTypeDivList);
		modelMap.put("apvDocTypeList", apvDocTypeList);
	
		return mapper.writeValueAsString(modelMap);
	}
	
	//************ 2. 결재 문서 작성 ************
	
	//새 결재 문서 작성페이지
	@RequestMapping(value="/GWNewApvWrite")
	public ModelAndView GWNewApvWrite(	ModelAndView mav,
										@RequestParam HashMap<String, String> params) throws Throwable {
		
		if(!params.containsKey("selectedDocType")) {
			mav.setViewName("redirect:GWNewApv");
		} else {
			try {
				HashMap<String, String> apvDocType = iGwApvService.getApvDocType(params); //결재 양식 가져오기
				
				mav.addObject("apvDocType", apvDocType);
				
				mav.setViewName("gw/ea/newApv/GWNewApvWrite");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;
	}
	
	//결재라인 지정 - 조직도 리스트ajax
	@RequestMapping(value="/GWorgListAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWorgListAjax(	HttpSession session,
								@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			params.put("sEmpNo", session.getAttribute("sEmpNo").toString());	
			
			List<HashMap<String, String>> deptList = iGwApvService.getDeptList(params);	//부서조회
			List<HashMap<String, String>> empList = iGwApvService.getEmpList(params);
			
			modelMap.put("deptList", deptList);
			modelMap.put("empList", empList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//결재라인 지정 - 사원 리스트ajax
	@RequestMapping(value="/GWempListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWempListAjax(HttpSession session,
								@RequestParam HashMap<String, String> params,
								HttpServletRequest request) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			String[] slist = request.getParameterValues("exceptEmpNo");
			if(slist != null) {
				String s = "";
				for(int i=0; i<slist.length; i++) {
					s += "," + slist[i];
				}
				params.put("exceptEmpNo", s.substring(1));
			}
			System.out.println(params.toString());
			
			params.put("sEmpNo", session.getAttribute("sEmpNo").toString());	
			
			List<HashMap<String, String>> empList = iGwApvService.getEmpList(params);
			
			modelMap.put("empList", empList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//결재라인 지정 - 결재자 리스트 Ajax
	@RequestMapping(value="/GWapverListAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWapverListAjax(	HttpSession session,
									@RequestParam HashMap<String, String> params,
									HttpServletRequest request) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			String[] slist = request.getParameterValues("exceptEmpNo");
			if(slist != null) {
				String s = "";
				for(int i=0; i<slist.length; i++) {
					s += "," + slist[i];
				}
				params.put("exceptEmpNo", s.substring(1));
			}
			System.out.println(params.toString());
			
			List<HashMap<String, String>> apverList = iGwApvService.getApverList(params);
			
			modelMap.put("apverList", apverList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//새 결재 진행 - 상신 Ajax
	@RequestMapping(value="/GWReportAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWReportAjax(	HttpSession session,
								@RequestParam HashMap<String, String> params,
								HttpServletRequest request) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			System.out.println(params.toString());
			
			params.put("sEmpNo", session.getAttribute("sEmpNo").toString());	
			
			iGwApvService.reportApv(params);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	
	//************************* 결재진행 문서함(apvProgressDoc) *************************
	
	//************ 1.결재 진행 문서함  ************
	
	//결재진행 문서함
	@RequestMapping(value="/GWApvProgressDoc")
	public ModelAndView GWApvProgressDoc(ModelAndView mav) {
		
		mav.setViewName("gw/ea/apvProgressDoc/GWApvProgressDoc");
		
		return mav;
	}
	
	//결재진행 문서함 - 문서 목록 Ajax
	@RequestMapping(value="/GWApvProgressDocAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWApvProgressDocAjax(	HttpSession session,
										@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			
			System.out.println(params.toString());
			
			params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
			
			int cnt = iGwApvService.getApvDocCnt(params);
			
			PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), 
							cnt, 10, 5);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String, String>> list = iGwApvService.getApvDocList(params);
			
			List<HashMap<String, String>> apvCompleteList = iGwApvService.getApvComplete(params);
			
			modelMap.put("list", list);
			modelMap.put("apvCompleteList", apvCompleteList);
			modelMap.put("pb", pb);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//************ 2.결재 문서 상세 페이지  ************
	
	//결재처리 상세페이지
	@RequestMapping(value="/GWApvProgress")
	public ModelAndView GWApvProgress(	ModelAndView mav,
										@RequestParam HashMap<String, String> params,
										HttpServletRequest request) throws Throwable{
		
		try {
			if(!params.containsKey("apvNo")) {
				mav.setViewName("redirect:GWApvProgressDoc");
			} else {
				System.out.println(params.toString());
				
				HashMap<String, String> data = iGwApvService.getApvDocDtl(params);
				HashMap<String, String> comment = iGwApvService.getOpinion(params);
				
				//해당 문서 결재상태
				HashMap<String, String> apvState = iGwApvService.getApvState(params);
				
				List<HashMap<String, String>> list = iGwApvService.getApvDocDtlMenList(params);
				
				mav.addObject("data", data);
				mav.addObject("comment", comment);
				mav.addObject("apvState", apvState);
				mav.addObject("list", list);
				
				List<HashMap<String, String>> attFileList = iGwApvService.getAttFileList(params);
				mav.addObject("attFileList", attFileList);
				
				mav.setViewName("gw/ea/apvProgressDoc/GWApvProgress");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	// 결재문서 삭제 Ajax
	@RequestMapping(value="/GWdelApvAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWdelApvAjax(	HttpSession session,
								@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iGwApvService.deleteApvDoc(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 결재문서 결재 Ajax
	@RequestMapping(value="/GWapvAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWapvAjax(HttpSession session,
							@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			System.out.println(params.toString());
			
			params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
			iGwApvService.doApv(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
		
	//************ 3.결재문서 수정페이지  ************
	
	//결재문서 수정페이지
	@RequestMapping(value="/GWApvUpdate")
	public ModelAndView GWApvUpdate(	ModelAndView mav,
										@RequestParam HashMap<String, String> params) throws Throwable {
		
		if(!params.containsKey("apvNo")) {
			mav.setViewName("redirect:GWApvProgressDoc");
		} else {
			
			HashMap<String, String> data = iGwApvService.getApvDocDtl(params);
			List<HashMap<String, String>> list = iGwApvService.getApvDocDtlMenList(params);
			List<HashMap<String, String>> attFileList = iGwApvService.getAttFileList(params);
			
			mav.addObject("data", data);
			mav.addObject("list", list);
			mav.addObject("attFileList", attFileList);
			
			if(attFileList.size() > 0) {
				String attList = "";
				for(int i=0; i<attFileList.size(); i++) {
					attList += "/" + attFileList.get(i).get("ATT_FILE_NAME");
				}
				mav.addObject("attList", attList.substring(1));
			}
			
			mav.setViewName("gw/ea/apvProgressDoc/GWApvUpdate");
		}
		
		return mav;
	}
	
	
	// 결재문서 수정 Ajax
	@RequestMapping(value="/GWApvUpdateAjax",
							method = RequestMethod.POST,
							produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWApvUpdateAjax(	HttpSession session,
									@RequestParam HashMap<String, String> params,
									HttpServletRequest request) throws Throwable{
		
		System.out.println(params.toString());
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			String[] slist = request.getParameterValues("exceptEmpNo");
			if(slist != null) {
				String s = "";
				for(int i=0; i<slist.length; i++) {
					s += "," + slist[i];
				}
				params.put("exceptEmpNo", s.substring(1));
			}
			System.out.println(params.toString());
			
			String[] existFiles = request.getParameterValues("existAttFile");
			if(existFiles != null) {
				String s = "";
				for(int i=0; i<existFiles.length; i++) {
					s += "/" + existFiles[i];
				}
				params.put("existAttFiles", s.substring(1));
			}
			System.out.println(params.toString());
			
			params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
			
			int res = iGwApvService.updateApv(params);
			if(res == 0) {
				throw new Exception();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
		
	
	//************************* 결재라인 관리 *************************
	
	//결재라인 관리
	@RequestMapping(value="/GWApvLineMngt")
	public ModelAndView GWApvLineMngt(ModelAndView mav) {
		
		mav.setViewName("gw/ea/apvLineMngt/GWApvLineMngt");
		
		return mav;
	}
	
	//결재라인 관리 - 저장된 결재라인 목록
	@RequestMapping(value="/GWSavedApvLineListAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
		public String GWSavedApvLineListAjax(	HttpSession session,
												@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
		
			System.out.println(params.toString());
			
			params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
			
			List<HashMap<String, String>> sApvLineNames = iGwApvService.getSApvLineNames(params);
			
			// 결재번호에 맞는 결재자들 뽑기
			if(sApvLineNames.size() != 0) {
				String sApvLineNo = "";
				for(int i=0; i<sApvLineNames.size(); i++) {
					sApvLineNo += "," + String.valueOf(sApvLineNames.get(i).get("SAVE_APV_LINE_NO"));
				}
				sApvLineNo = sApvLineNo.substring(1);
				params.put("sApvLineNo", sApvLineNo);
				
				List<HashMap<String, String>> sApvLineList = iGwApvService.getSApvLineList(params);
				
				modelMap.put("sApvLineList", sApvLineList);
				modelMap.put("sApvLineNames", sApvLineNames);
			}
			
			//사용자 한명당 저장가능 결재라인은 15개
			int cnt = iGwApvService.getSavedApvLineCnt(params);
			modelMap.put("cnt", cnt);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 새 결재라인 등록
	@RequestMapping(value="/GWSaveNewApvLineAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWSaveNewApvLineAjax(	HttpSession session,
										@RequestParam HashMap<String, String> params,
										HttpServletRequest request) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			params.put("sEmpNo", String.valueOf(session.getAttribute("sEmpNo")));
			
			String[] slist = request.getParameterValues("exceptEmpNo");
			if(slist != null) {
				String s = "";
				for(int i=0; i<slist.length; i++) {
					s += "," + slist[i];
				}
				params.put("exceptEmpNo", s.substring(1));
			}
			iGwApvService.saveNewApvLine(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	// 저장된 결재라인 삭제(삭제여부 변경)
	@RequestMapping(value="/GWDelApvLineAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String GWDelApvLineAjax(	HttpSession session,
									@RequestParam HashMap<String, String> params) throws Throwable{
		
		System.out.println(params.toString());
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			int res = iGwApvService.delApvLine(params);
			if(res == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
}
