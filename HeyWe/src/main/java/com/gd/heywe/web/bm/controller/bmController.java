package com.gd.heywe.web.bm.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.gd.heywe.web.bm.service.IBmService;
import com.gd.heywe.web.gw.service.IGwApvService;

@Controller
public class bmController {
	@Autowired IBmService iBmService;
	
	@Autowired IPagingService iPagingService;
	
	@Autowired
	public IGwApvService iGwApvService;
	// 김영찬
	// 경영관리 메인 페이지
	@RequestMapping(value="/BMBsnsMgntMain")
	public ModelAndView BMBsnsMgntMain(ModelAndView mav) {
		
		mav.setViewName("bm/bsnsMgntMain");
		
		return mav;
	}
	// 캘린더 데이터 가져오기
	@RequestMapping(value = "/BMCalAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String BMCalAjax(@RequestParam HashMap<String, String> params,
						  HttpSession session)
						  throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> data = iBmService.getCal(params);

		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);
	}
	// 일정 목록
	@RequestMapping(value = "/BMSchListAjax",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String BMSchListAjax(@RequestParam HashMap<String, String> params,
								HttpSession session)
								throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iBmService.getSchList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}
	
	// 신용카드 관리
	@RequestMapping(value="/BMCrdtCardMgnt")
	public ModelAndView BMCrdtCardMain(ModelAndView mav) {
		
		mav.setViewName("bm/crdtCardAcntMgnt/crdtCardMgnt");
		
		return mav;
	}
	// 신용카드 관리 페이지 그리기
	@RequestMapping(value="/BMCrdtCardMgntAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCrdtCardMgntAjax(@RequestParam HashMap<String, String> params)
								 	 throws Throwable {
		if(!params.containsKey("page")) {
			params.put("page", "1");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iBmService.getCrdtCardMgntCnt(params);
		
		PagingBean pb
		= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iBmService.getCrdtCardMgntList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 카드사 리스트 가져오기 (드롭다운)
	@RequestMapping(value="/BMCardCoListAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCardCoListAjax(@RequestParam HashMap<String, String> params)
								   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> cardCoList = iBmService.getCardCoList(params);
		
		modelMap.put("cardCoList", cardCoList);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 신용카드 신규등록 (팝업)
	@RequestMapping(value="/BMCrdtCardNewRegAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCrdtCardNewRegAjax(@RequestParam HashMap<String, String> params)
									   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iBmService.insertCrdtCard(params);
			modelMap.put("flag", 0);
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	//사원검색 (팝업)
	@RequestMapping(value="/BMEmpSearchAjax", 
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMEmpSearchAjax(@RequestParam HashMap<String, String> params)
								throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> list = iBmService.getEmpSearchPopup(params);
		
		modelMap.put("list",list);
		
		return mapper.writeValueAsString(modelMap);	
	}
	// 체크박스가 선택된 카드 정보 가져오기
	@RequestMapping(value="/BMSltedCardInfoAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSltedCardInfoAjax(@RequestParam HashMap<String, String> params)
									  throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iBmService.getCrdtCardInfo(params);
		
		modelMap.put("params", params);
		modelMap.put("data", data);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 신용카드 수정 (팝업)
	@RequestMapping(value="/BMCrdtCardUpdateAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCrdtCardUpdateAjax(@RequestParam HashMap<String, String> params)
									   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iBmService.updateCrdtCard(params);
			modelMap.put("flag", 0);
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	// 신용카드 삭제
	@RequestMapping(value="/BMCrdtCardDelAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCrdtCardDelAjax(@RequestParam HashMap<String, String> params)
									throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int res = iBmService.delCrdtCard(params);
		
		if(res == 0) {
			modelMap.put("flag", 1);
		} else {
			params.remove("sltedCardMgntNo");
			modelMap.put("flag", 0);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 계좌 관리
	@RequestMapping(value="/BMAcntMgnt")
	public ModelAndView BMAcntMgnt(ModelAndView mav) {
		
		mav.setViewName("bm/crdtCardAcntMgnt/acntMgnt");
		
		return mav;
	}
	// 계좌 관리 페이지 그리기
	@RequestMapping(value="BMAcntMgntAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMAcntMgntAjax(@RequestParam HashMap<String, String> params)
								 throws Throwable {
		if(!params.containsKey("page")) {
			params.put("page", "1");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iBmService.getAcntMgntCnt(params);
		
		PagingBean pb
		= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iBmService.getAcntMgntList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 은행 리스트 가져오기 (드롭다운)
	@RequestMapping(value="/BMBankListAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMBankListAjax(@RequestParam HashMap<String, String> params)
								 throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> bankList = iBmService.getBankList(params);
		
		modelMap.put("bankList", bankList);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 계좌 신규등록 (팝업)
	@RequestMapping(value="/BMAcntNewRegAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMAcntNewRegAjax(@RequestParam HashMap<String, String> params)
								   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iBmService.insertAcnt(params);
			modelMap.put("flag", 0);
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	// 체크박스가 선택된 계좌 정보 가져오기
	@RequestMapping(value="/BMSltedAcntInfoAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSltedAcntInfoAjax(@RequestParam HashMap<String, String> params)
									  throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iBmService.getAcntInfo(params);
		
		modelMap.put("params", params);
		modelMap.put("data", data);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 계좌 수정 (팝업)
	@RequestMapping(value="/BMAcntUpdateAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMAcntUpdateAjax(@RequestParam HashMap<String, String> params)
								   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iBmService.updateAcnt(params);
			modelMap.put("flag", 0);
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	// 계좌 삭제
	@RequestMapping(value="/BMAcntDelAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMAcntDelAjax(@RequestParam HashMap<String, String> params)
								throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int res = iBmService.delAcnt(params);
		
		if(res == 0) {
			modelMap.put("flag", 1);
		} else {
			params.remove("sltedAcntMgntNo");
			modelMap.put("flag", 0);
		}
		
		return mapper.writeValueAsString(modelMap);
	}	
	
	// 급여 계산
	@RequestMapping(value="/BMSalCalc")
	public ModelAndView BMSalCalc(ModelAndView mav) {
		
		mav.setViewName("bm/salCalc/salCalc");
		
		return mav;
	}
	// 급여 계산 페이지 그리기
	@RequestMapping(value="/BMSalCalcAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSalCalcAjax(@RequestParam HashMap<String, String> params)
								throws Throwable {
		if(!params.containsKey("page")) {
			params.put("page", "1");
		}
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iBmService.getSalCalcCnt(params);
		
		PagingBean pb
		= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iBmService.getSalCalcList(params);
		
		String apvState = iBmService.getSalCalcApvState(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("apvState", apvState);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 부서 리스트 가져오기 (드롭다운)
	@RequestMapping(value="/BMDeptListAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMDeptListAjax(@RequestParam HashMap<String, String> params)
								 throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> deptList = iBmService.getDeptList(params);
		
		modelMap.put("deptList", deptList);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 직위 리스트 가져오기 (드롭다운)
	@RequestMapping(value="/BMPosiListAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMPosiListAjax(@RequestParam HashMap<String, String> params)
								 throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> posiList = iBmService.getPosiList(params);
		
		modelMap.put("posiList", posiList);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 급여 자동 계산
	@RequestMapping(value="/BMSalAutoCalcAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSalAutoCalcAjax(@RequestParam HashMap<String, String> params)
									throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			iBmService.insertSalAutoCalc(params);
			iBmService.updateSalAutoCalc(params);
			modelMap.put("flag", 0);
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	// 급여 명세 내역 (팝업)
	@RequestMapping(value="/BMSalBkdwnHistAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSalBkdwnHistAjax(@RequestParam HashMap<String, String> params)
								 	 throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iBmService.getSalBkdwnHist(params);
		
		modelMap.put("params", params);
		modelMap.put("data", data);
		
		return mapper.writeValueAsString(modelMap);
	}
	// 급여 계산 결재권자 가져오기
	@RequestMapping(value="/BMSalApvReqAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSalApvReqAjax(@RequestParam HashMap<String, String> params,
								  HttpSession session)
								  throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("sEmpNo",session.getAttribute("sEmpNo").toString());
		
		List<HashMap<String, String>> apvAuther = iBmService.getSalCalcApvAuther(params);
		
		String str = "";
		
		for(int i = 0; i < apvAuther.size(); i++) {
			str += ","+ String.valueOf(apvAuther.get(i).get("EMP_NO"));
		}
		str = str.substring(1);
		params.put("apverNos", str);
		
		String expCon = "";
		
		expCon += "<table>";
		expCon += "   <tbody>";
		expCon += "      <tr>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>사원번호</strong></span></td>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>사원명</strong></span></td>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>부서</strong></span></td>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>직위</strong></span></td>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>기준일자</strong></span></td>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>세전급여</strong></span></td>";
		expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; \"\"><span style=\"font-size:14px\"><strong>세후급여</strong></span></td>";
		expCon += "      </tr>";  
		List<HashMap<String, String>> apvList = iBmService.getSalCalcApvList(params);
		for(int i = 0; i < apvList.size(); i++) {
			expCon += "<tr>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("EMP_NO")) + "</td>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("NAME")) + "</td>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("DEPT_NAME")) + "</td>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("POSI_NAME")) + "</td>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("STD_DATE")) + "</td>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("TAX_PREV_SAL")) + "</td>";
			expCon += "<td style=\"border-color:#134074; height:50px;font-size:12pt; text-align:center;\">" +  String.valueOf(apvList.get(i).get("TAX_NEXT_SAL")) + "</td>";
			expCon += "</tr>";
		}
		expCon += "   </tbody>";
		expCon += "</table>";
		
		params.put("expCon",expCon);
		params.put("impDate",String.valueOf(apvList.get(0).get("STD_DATE")));
		
		iGwApvService.reportApv(params);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 급여 조회
	@RequestMapping(value="/BMSalAsk")
	public ModelAndView BMSalAsk(ModelAndView mav) {
		
		mav.setViewName("bm/salAsk/salAsk");
		
		return mav;
	}
	// 급여 명세 내역
	@RequestMapping(value="/BMSalAskAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSalAskAjax(@RequestParam HashMap<String, String> params,
									  HttpSession session)
								 	 throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());

		HashMap<String, String> data = iBmService.getSalAsk(params);
		String apvState = iBmService.getSalCalcApvState(params);
		
		modelMap.put("data", data);
		modelMap.put("apvState", apvState);
		
		return mapper.writeValueAsString(modelMap);
	}

	
	// 최익섭
	
	// 매입채무 관리
	@RequestMapping(value="/BMPurcDebtMgnt")
	public ModelAndView BMPurcDebtMgnt(ModelAndView mav) {
		
		mav.setViewName("bm/loanMgnt/purcDebtMgnt");
		
		return mav;
	}
	@RequestMapping(value="/BMPurcDebtMgntAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMPurcDebtMgntAjax(@RequestParam HashMap<String, String> params)
								 	 	 throws Throwable{
		if(!params.containsKey("page")) {
			params.put("page", "1");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iBmService.getPurcDebtMgntCnt(params);
		
		PagingBean pb
		= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iBmService.getPurcDebtMgntList(params);
		List<HashMap<String, String>> CsptsNameDivList = iBmService.getCsptsNameDivList(params);		
		List<HashMap<String, String>> CstmDivList = iBmService.getCstmDivList(params);
		List<HashMap<String, String>> loanTypeDivList = iBmService.getLoanTypeDivList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("CsptsNameDivList", CsptsNameDivList);
		modelMap.put("CstmDivList", CstmDivList);
		modelMap.put("loanTypeDivList", loanTypeDivList);
		
		
		return mapper.writeValueAsString(modelMap);
		}
	
	
	// 매입채무 신규등록 팝업
	@RequestMapping(value="/BMPurcDebtNewRegAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMPurcDebtNewRegAjax(HttpSession session,
									   @RequestParam HashMap<String, String> params)
									   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		
		System.out.println("---------------------------");
		System.out.println(params);
		
		try {
			iBmService.insertPurcDebt(params);
			modelMap.put("msg", "등록에 성공하였습니다");
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("msg", "등록에 실패하였습니다");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 체크박스가 선택된 카드 정보 가져오기 (매입채무)
		@RequestMapping(value="/BMSltedPurcDebtInfoAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSltedPurcDebtInfoAjax(@RequestParam HashMap<String, String> params)
										  throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			HashMap<String, String> data = iBmService.getPurcDebtInfo(params);
			
			modelMap.put("params", params);
			modelMap.put("data", data);
			
			return mapper.writeValueAsString(modelMap);
		}
		// 매입채무 수정 (팝업)
		@RequestMapping(value="/BMPurcDebtUpdateAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMPurcDebtUpdateAjax(@RequestParam HashMap<String, String> params)
										   throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				iBmService.updatePurcDebt(params);
				modelMap.put("msg", "수정에 성공하였습니다");
			} catch(Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "수정에 실패하였습니다");
			}
			
			return mapper.writeValueAsString(modelMap);
		}
		
		// 매입채무 삭제
		@RequestMapping(value="/BMPurcDebtDelAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMPurcDebtDelAjax(@RequestParam HashMap<String, String> params)
									throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			
			try {
				iBmService.delPurcDebt(params);
				modelMap.put("flag", 1);
			} catch(Exception e) {
				e.printStackTrace();
				modelMap.put("flag", 0);
			}
			
			return mapper.writeValueAsString(modelMap);
		}
		
		// 매입채무, 매출채권 상환
		@RequestMapping(value="/BMRpayRtnAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMRpayRtnAjax(HttpSession session,
										   @RequestParam HashMap<String, String> params)
										   throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
			
			try {
				iBmService.rpayRtn(params);
				modelMap.put("msg", "완료되었습니다");
			} catch(Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "실패하였습니다");
			}
			
			return mapper.writeValueAsString(modelMap);
		}
	
	// 매출채권 관리
	@RequestMapping(value="/BMSalesBondMgnt")
	public ModelAndView BMSalesBondMgnt(ModelAndView mav) {
		
		mav.setViewName("bm/loanMgnt/salesBondMgnt");
		
		return mav;
	}
	@RequestMapping(value="/BMSalesBondMgntAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSalesBondMgntAjax(@RequestParam HashMap<String, String> params)
								 	 	 throws Throwable{
		if(!params.containsKey("page")) {
			params.put("page", "1");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iBmService.getSalesBondMgntCnt(params);
		
		PagingBean pb
		= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iBmService.getSalesBondMgntList(params);
		List<HashMap<String, String>> CsptsNameDivList = iBmService.getCsptsNameDivList(params);
		List<HashMap<String, String>> CstmDivList = iBmService.getCstmDivList(params);
		List<HashMap<String, String>> loanTypeDivList = iBmService.getLoanTypeDivList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("CsptsNameDivList", CsptsNameDivList);
		modelMap.put("CstmDivList", CstmDivList);
		modelMap.put("loanTypeDivList", loanTypeDivList);
		
		return mapper.writeValueAsString(modelMap);
		}
	
	// 매출채권 신규등록 팝업
	@RequestMapping(value="/BMSalesBondNewRegAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMSalesBondNewRegAjax(HttpSession session,
									   @RequestParam HashMap<String, String> params)
									   throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		try {
			iBmService.insertSalesBond(params);
			modelMap.put("msg", "등록에 성공하였습니다");
		} catch(Exception e) {
			e.printStackTrace();
			modelMap.put("msg", "등록에 실패하였습니다");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
		// 체크박스가 선택된 카드 정보 가져오기 (매출채권)
		@RequestMapping(value="/BMSltedSalesBondInfoAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSltedSalesBondInfoAjax(@RequestParam HashMap<String, String> params)
										  throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			HashMap<String, String> data = iBmService.getSalesBondInfo(params);
			
			modelMap.put("params", params);
			modelMap.put("data", data);
			
			return mapper.writeValueAsString(modelMap);
		}
		// 매출채권 수정 (팝업)
		@RequestMapping(value="/BMSalesBondUpdateAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSalesBondUpdateAjax(@RequestParam HashMap<String, String> params)
										   throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				iBmService.updateSalesBond(params);
				modelMap.put("msg", "수정에 성공하였습니다");
			} catch(Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "수정에 실패하였습니다");
			}
			
			return mapper.writeValueAsString(modelMap);
		}
		
		// 매출채권 삭제
		@RequestMapping(value="/BMSalesBondDelAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSalesBondDelAjax(@RequestParam HashMap<String, String> params)
									throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
						
			try {
				iBmService.delSalesBond(params);
				modelMap.put("flag", 1);
			} catch(Exception e) {
				e.printStackTrace();
				modelMap.put("flag", 0);
			}
			
			return mapper.writeValueAsString(modelMap);
		}
	
	
			
			
			// 상세내역 가져오기 (매입채무, 매출채권) - 상환내역 제외
			@RequestMapping(value="/BMDtlHistAjax",
							method=RequestMethod.POST,
							produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMDtlHistAjax(@RequestParam HashMap<String, String> params)
											  throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaa");
				System.out.println(params);
				
				HashMap<String, String> data = iBmService.getDtlHist(params);
				
				modelMap.put("params", params);
				modelMap.put("data", data);
				
				return mapper.writeValueAsString(modelMap);
			}
			
			// 상세내역 가져오기 (매입채무, 매출채권) - 상환내역
			@RequestMapping(value="/BMRpayRtnHistAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMRpayRtnHistAjax(@RequestParam HashMap<String, String> params)
												throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				List<HashMap<String, String>> list = iBmService.getRpayRtnHistList(params);
				
				modelMap.put("list", list);
				System.out.println(list);
				
				return mapper.writeValueAsString(modelMap);
			}
			
			// 계정과목 관리
			@RequestMapping(value="/BMUnitSbjctMgnt")
			public ModelAndView BMUnitSbjctMgnt(ModelAndView mav) {
				
				mav.setViewName("bm/unitSbjMgnt/unitSbjctMgnt");
				
				return mav;
			}
			
			@RequestMapping(value="/BMUnitSbjctMgntAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMUnitSbjctMgntnAjax(@RequestParam HashMap<String, String> params)
					throws Throwable{
				if(!params.containsKey("page")) {
					params.put("page", "1");
				}
				
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				int cnt = iBmService.getUnitSbjctMgntCnt(params);
				
				PagingBean pb
				= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
				
				params.put("startCnt", Integer.toString(pb.getStartCount()));
				params.put("endCnt", Integer.toString(pb.getEndCount()));
				
				List<HashMap<String, String>> list = iBmService.getUnitSbjctMgntList(params);
				
				modelMap.put("list", list);
				modelMap.put("pb", pb);
				
				return mapper.writeValueAsString(modelMap);
			}
			
			// 계정과목 신규등록 팝업
			@RequestMapping(value="/BMUnitSbjctNewRegAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMUnitSbjctNewRegAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					iBmService.insertUnit(params);
					modelMap.put("msg", "등록에 성공하였습니다");
				} catch(Exception e) {
					e.printStackTrace();
					modelMap.put("msg", "이미 존재하는 계정과목 입니다");
				}
				
				return mapper.writeValueAsString(modelMap);
			}
			
			// 체크박스가 선택된 정보 가져오기 (계정과목)
			@RequestMapping(value="/BMSltedUnitSbjctInfoAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMSltedUnitSbjctInfoAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				HashMap<String, String> data = iBmService.getUnitSbjctInfo(params);
				
				modelMap.put("params", params);
				modelMap.put("data", data);
				
				return mapper.writeValueAsString(modelMap);
			}
			// 계정과목 수정 (팝업)
			@RequestMapping(value="/BMUnitSbjctUpdateAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMUnitSbjctUpdateAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					iBmService.updateUnitSbjct(params);
					modelMap.put("msg", "수정에 성공하였습니다");
				} catch(Exception e) {
					e.printStackTrace();
					modelMap.put("msg", "수정에 실패하였습니다");
				}
				
				return mapper.writeValueAsString(modelMap);
			}
	
			// 계정과목 삭제
			@RequestMapping(value="/BMUnitSbjctDelAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMUnitSbjctDelAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					System.out.println("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
					System.out.println(params);
					iBmService.delUnitSbjct(params);
					modelMap.put("flag", 1);
				} catch(Exception e) {
					e.printStackTrace();
					modelMap.put("flag", 0);
				}
				
				return mapper.writeValueAsString(modelMap);
			}
			
			
			// 거래처 관리
			@RequestMapping(value="/BMCstmMgnt")
			public ModelAndView BMCstmMgnt(ModelAndView mav) {
				
				mav.setViewName("bm/cstmMgnt/cstmMgnt");
				return mav;
			}
			
			@RequestMapping(value="/BMCstmMgntAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMCstmMgntnAjax(@RequestParam HashMap<String, String> params)
					throws Throwable{
				if(!params.containsKey("page")) {
					params.put("page", "1");
				}
				
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				int cnt = iBmService.getCstmMgntCnt(params);
				
				PagingBean pb
				= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
				
				params.put("startCnt", Integer.toString(pb.getStartCount()));
				params.put("endCnt", Integer.toString(pb.getEndCount()));
				
				List<HashMap<String, String>> list = iBmService.getCstmMgntList(params);
				
				modelMap.put("list", list);
				modelMap.put("pb", pb);
				
				return mapper.writeValueAsString(modelMap);
			}
			
			// 거래처 신규등록 팝업
			@RequestMapping(value="/BMCstmNewRegAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMCstmNewRegAjax(@RequestParam HashMap<String, String> params)
											throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					iBmService.insertCstm(params);
					modelMap.put("msg", "등록에 성공하였습니다");
				} catch(Exception e) {
					e.printStackTrace();
					modelMap.put("msg", "이미 존재하는 거래처 입니다");
				}
				
				return mapper.writeValueAsString(modelMap);
			}
			
			// 체크박스가 선택된 정보 가져오기 (거래처)
			@RequestMapping(value="/BMSltedCstmInfoAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMSltedCstmInfoAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				HashMap<String, String> data = iBmService.getCstmInfo(params);
				
				modelMap.put("params", params);
				modelMap.put("data", data);
				
				return mapper.writeValueAsString(modelMap);
			}
			// 거래처 수정 (팝업)
			@RequestMapping(value="/BMCstmUpdateAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMcstmUpdateAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					iBmService.updateCstm(params);
					modelMap.put("msg", "수정에 성공하였습니다");
				} catch(Exception e) {
					e.printStackTrace();
					modelMap.put("msg", "수정에 실패하였습니다");
				}
				
				return mapper.writeValueAsString(modelMap);
			}
	
			// 거래처 삭제
			@RequestMapping(value="/BMCstmDelAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
			@ResponseBody
			public String BMCstmDelAjax(@RequestParam HashMap<String, String> params)
					throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				int res = iBmService.delCstm(params);
				
				if(res == 0) {
					modelMap.put("flag", 0);
				} else {
					modelMap.put("flag", 1);
				}

				return mapper.writeValueAsString(modelMap);
			}
	
	//위지훈
	
	// 비용관리
	@RequestMapping(value="/BMCostMgnt")
	public ModelAndView BMCost(ModelAndView mav) {
		
		mav.setViewName("bm/costMgnt/costMgnt");
		
		return mav;
	}
	
	// 비용관리 Ajax처리
	@RequestMapping(value="/BMCostMgntAjax",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCostMgntAjax(@RequestParam HashMap<String, String> params)
							 	 throws Throwable{
	if(!params.containsKey("page")) {
		params.put("page", "1");
	}
	
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	// 비용관리 조회화면 페이징 카운트
	int cnt = iBmService.getCostMgntCnt(params);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
	System.out.println(cnt);
	System.out.println(params);
	// 페이징 범위 처리
	PagingBean pb
	= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
	System.out.println(pb);
	// 페이지 start지점
	params.put("startCnt", Integer.toString(pb.getStartCount()));
	// 페이지 end지정
	params.put("endCnt", Integer.toString(pb.getEndCount()));
	// 비용관리 조회목록
	List<HashMap<String, String>> list = iBmService.getCostMgntList(params);
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	System.out.println(params);
	// 계정과목 드롭다운
	List<HashMap<String, String>> unitSbjList = iBmService.getUnitSbjList(params);
	// 지출유형  드롭다운
	List<HashMap<String, String>> expsTypeList = iBmService.getExpsTypeList(params);
	// 분류  드롭다운
	List<HashMap<String, String>> typeList = iBmService.getTypeList(params);
	// 이름  드롭다운
	List<HashMap<String, String>> empNameList = iBmService.getEmpNameList(params);
	
	// 비용관리 조회목록 데이터 넣기
	modelMap.put("list", list);
	// 페이지 데이터 넣기
	modelMap.put("pb", pb);
	// 계정과목 데이터 넣기
	modelMap.put("unitSbjList", unitSbjList);
	// 지출유형 데이터 넣기
	modelMap.put("expsTypeList", expsTypeList);
	// 분류 데이터 넣기
	modelMap.put("typeList", typeList);
	// 이름  데이터 넣기
	modelMap.put("empNameList", empNameList);
	
	return mapper.writeValueAsString(modelMap);
	}
	// 비용관리 신규등록
	@RequestMapping(value="/BMCostMgntNewRegAjax",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCostMgntNewRegAjax(@RequestParam HashMap<String, String> params)
								   throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	try {
		iBmService.insertCostMgnt(params);
		modelMap.put("msg", "비용 등록에 성공하였습니다");
	} catch(Exception e) {
		System.out.println(params +"=");
		e.printStackTrace();
		modelMap.put("msg", "비용 등록에 실패하였습니다");
	}
	
	return mapper.writeValueAsString(modelMap);
	}
	// 체크박스가 선택된 비용 가져오기
		@RequestMapping(value="/BMSltedCostInfoAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSltedCostInfoAjax(@RequestParam HashMap<String, String> params)
										  throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			HashMap<String, String> data = iBmService.getCostMgntInfo(params);
			
			modelMap.put("params", params);
			modelMap.put("data", data);
			
			return mapper.writeValueAsString(modelMap);
		}
	// 비용관리 수정 (팝업)
		@RequestMapping(value="/BMCostMgntUpdateAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMCostMgntUpdateAjax(@RequestParam HashMap<String, String> params)
										   throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
			System.out.println(params);
			try {
				iBmService.updateCostMgnt(params);
				modelMap.put("msg", "수정에 성공하였습니다");
			} catch(Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "수정에 실패하였습니다");
			}
			
			return mapper.writeValueAsString(modelMap);
		}
	// 비용관리 삭제
	@RequestMapping(value="/BMCostMgntDelAjax",
					method=RequestMethod.POST,
					produces="text/json;charset=UTF-8")
	@ResponseBody
	public String BMCostMgntDelAjax(@RequestParam HashMap<String, String> params)
								throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int res = iBmService.delCostMgnt(params);
		
		if(res == 0) {
			modelMap.put("msg", "삭제에 실패하였습니다");
			modelMap.put("flag", 0);
		} else {
			params.remove("sltedCardMgntNo");
			modelMap.put("msg", "삭제에 성공하였습니다");
			modelMap.put("flag", 1);
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 매출액 관리
	@RequestMapping(value="/BMSalesAmtMgnt")
	public ModelAndView salesMain(ModelAndView mav) {
		
		mav.setViewName("bm/salesMgnt/salesAmtMgnt");
		
		return mav;
	}
	// 매출액관리 Ajax처리
		@RequestMapping(value="/BMSalesAmtMgntAjax",
				method=RequestMethod.POST,
				produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSalesAmtMgntAjax(@RequestParam HashMap<String, String> params)
								 	 throws Throwable{
		if(!params.containsKey("page")) {
			params.put("page", "1");
		}
		if(!params.containsKey("Cstm")) {
			params.put("Cstm", "전체");
		}
		if(!params.containsKey("Cspts")) {
			params.put("Cspts", "전체");
		}
		if(!params.containsKey("payProvCond")) {
			params.put("payProvCond", "전체");
		}
		if(!params.containsKey("dept")) {
			params.put("dept", "전체");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// 매출액관리 조회화면 페이징 카운트
		System.out.println("paramsparamsparamsparamsparamsparamsparams" + params);
		int cnt = iBmService.getSalesAmtMgntCnt(params);
		
		// 페이징 범위 처리
		PagingBean pb
		= iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		// 페이지 start지점
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		// 페이지 end지정
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		// 매출액관리 조회목록
		System.out.println("paramspa"+ params);
		List<HashMap<String, String>> list = iBmService.getSalesAmtMgntList(params);
		System.out.println("paramspalistramsparlistamsparamlistsparalistmlistsparams"+ list);
		// 고객사 드롭다운
		List<HashMap<String, String>> CstmList = iBmService.getCstmList(params);
		// 적요명 드롭다운
		List<HashMap<String, String>> CsptsList = iBmService.getCsptsList(params);
		// 지급방법 드롭다운
		List<HashMap<String, String>> PayProvList = iBmService.getPayProvList(params);
		// 부서 드롭다운
		List<HashMap<String, String>> DeptList = iBmService.getDeptList(params);
		// 계좌명 가져오기
		List<HashMap<String, String>> AcntList = iBmService.AcntList(params);
		// 매출액관리 조회목록 데이터 넣기
		modelMap.put("list", list);
		// 페이지 데이터 넣기
		modelMap.put("pb", pb);
		// 고객사 데이터 넣기
		modelMap.put("CstmList", CstmList);
		// 적요명 데이터 넣기
		modelMap.put("CsptsList", CsptsList);
		// 지급방법 데이터 넣기
		modelMap.put("PayProvList", PayProvList);
		// 부서 데이터 넣기
		modelMap.put("DeptList", DeptList);
		modelMap.put("AcntList", AcntList);
		
		return mapper.writeValueAsString(modelMap);
		}
	// 체크박스가 선택된 비용 가져오기
		@RequestMapping(value="/BMSltedSalesInfoAjax",
						method=RequestMethod.POST,
						produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMSltedSalesInfoAjax(@RequestParam HashMap<String, String> params)
										  throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			HashMap<String, String> data = iBmService.getSalesInfo(params);
			
			modelMap.put("params", params);
			modelMap.put("data", data);
			
			return mapper.writeValueAsString(modelMap);
		}
		
		// 매출액관리 계좌연동 수정 (팝업)
				@RequestMapping(value="/BMSalesAcntUpdateAjax",
								method=RequestMethod.POST,
								produces="text/json;charset=UTF-8")
				@ResponseBody
				public String BMSalesAcntUpdateAjax(@RequestParam HashMap<String, String> params)
												   throws Throwable {
					ObjectMapper mapper = new ObjectMapper();
					Map<String, Object> modelMap = new HashMap<String, Object>();
					try {
						System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!"+params);
						iBmService.updateSalesAcnt(params);
						modelMap.put("msg", "연동에 성공하였습니다");
					} catch(Exception e) {
						e.printStackTrace();
						modelMap.put("msg", "연동에 실패하였습니다");
					}
					
					return mapper.writeValueAsString(modelMap);
				}
	//통계
		
		//통계비용
		@RequestMapping(value="/BMStcCost")
		public ModelAndView BMStcSales(ModelAndView mav) {
			
			mav.setViewName("bm/stc/stcCost");
			
			return mav;
		}
		// 통계비용 Ajax 처리
		@RequestMapping(value="/BMStcCostAjax",
				method=RequestMethod.POST,
				produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMStcCostAjax(@RequestParam HashMap<String, String> params)
										  throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			// 통계 월 데이터 가져오기
			List<HashMap<String, String>> yearlist = iBmService.getStsCostYearList(params);
			// 통계 년 데이터 가져오기
			List<HashMap<String, String>> Monthlist = iBmService.getStsCostMonthList(params);
			modelMap.put("params", params);
			modelMap.put("yearlist", yearlist);
			modelMap.put("Monthlist", Monthlist);
			return mapper.writeValueAsString(modelMap);
		}
		// 통계 비용 제목 그리기 Ajax
		@RequestMapping(value="/BMStcCostTitleAjax",
				method=RequestMethod.POST,
				produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMStcCostTitleAjax(@RequestParam HashMap<String, String> params)
				throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			if(!params.containsKey("month")) {
				params.put("month", "전체");
			}
			if(!params.containsKey("year")) {
				params.put("year", "2019");
			}
			// 통계 적요명 데이터 가져오기
			List<HashMap<String, String>> unitSbjlist = iBmService.getStsUnitSbjList(params);
			System.out.println("------unitSbjlist-------- =" +params);
			// 통계 내용 데이터 가져오기
			List<HashMap<String, String>> unitSbjConlist = iBmService.getStsUnitSbjConList(params);
			System.out.println("-------unitSbjConlist------- =" +params);
			// 가로줄 년도 갯수 ex 3 = (1999, 2000, 2001), typelist는 List이므로 .size로 해서 길이를 구한다.
			int size = unitSbjConlist.size();
			System.out.println("sizesizesizesizesize="+size);
			
			// 컬럼 갯수 ex 3 = (파견 , 챗봇, 솔루션), typeConlist는 List이므로 .size로 해서 길이를 구한다.
			int series = unitSbjlist.size();
			System.out.println("series=series=series="+series);
			
			// 최종 series 에 넣을 값
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			
			// 컬럼의 갯수 만큼 늘려 주기 위해서
			for(int s = 0 ; s < series ; s++) {
				HashMap<String, Object> data = new HashMap<String, Object>();
				
				// 예를들어 파견, 솔루션, 챗봇등의 컬럼을 가르킨다.
					data.put("name", unitSbjlist.get(s).get("UNIT_SBJ_NAME"));
				// ArrayList y 생성
				ArrayList<Long> y = new ArrayList<Long>();
				
				// 사이즈별로 랜덤한 값을 y에 넣는다.
				y.add(Long.parseLong(String.valueOf(unitSbjConlist.get(s).get("COST_AMT")))); 
				// data : (5) <- 5는 예를들어 년도에 갯수
				data.put("data", y);
				list.add(data);
			}
			
			List<String> cate = new ArrayList<String>();
			
			for(int i = 0 ; i < unitSbjConlist .size() - 1 ; i++) {
				cate.add(String.valueOf(unitSbjConlist.get(i).get("YEAR_DATE")));
			}
			System.out.println("----cate-cate-cate-===" + cate);
			cate.add("적요");
			modelMap.put("unitSbjConlist", unitSbjConlist);
			modelMap.put("unitSbjlist", unitSbjlist);
			modelMap.put("list", list);
			modelMap.put("cate", cate);
			return mapper.writeValueAsString(modelMap);
		}
		
		// 통계매출
		@RequestMapping(value="/BMStcSales")
		public ModelAndView BMStcCost(ModelAndView mav) {
			
			mav.setViewName("bm/stc/stcSales");
			
			return mav;
		}
		// 통계매출 Ajax 처리
		@RequestMapping(value="/BMStcSalesAjax",
				method=RequestMethod.POST,
				produces="text/json;charset=UTF-8")
		@ResponseBody
		public String BMStcSalesAjax(HttpServletRequest request,
									 @RequestParam HashMap<String, String> params)
										  throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			if(!params.containsKey("month")) {
				params.put("month", "전체");
			}
			
			if(!params.containsKey("year")) {
				params.put("year", "2019");
			}
			// 통계 년데이터 가져오기
			List<HashMap<String, String>> yearlist = iBmService.getStsSalesYearList(params);
			// 통계 월데이터 가져오기
			List<HashMap<String, String>> monthlist = iBmService.getStsSalesMonthList(params);
			// 통계 적요명 가져오기
			List<HashMap<String, String>> typelist = iBmService.getStsSalesTypeList(params);
			System.out.println("---typelist--typelist--typelist-"+params);
			System.out.println("--11----111-11----11------1--------"+ typelist);
			// 통계 적요명 내용 가져오기
			List<HashMap<String, String>> typeConlist = iBmService.getStsSalesTypeConList(params);
			System.out.println("---typeConlist--typeConlist--typeConlist-"+params);
			System.out.println("--11----111-11----11------1--------"+ typeConlist);
			// 가로줄 년도 갯수 ex 3 = (1999, 2000, 2001), typelist는 List이므로 .size로 해서 길이를 구한다.
			int size = typeConlist.size();
			System.out.println("1=1===1=1======11=11==11"+size);
			// 컬럼 갯수 ex 3 = (파견 , 챗봇, 솔루션), typeConlist는 List이므로 .size로 해서 길이를 구한다.
			int series = typelist.size();
			System.out.println("------33--3-3-3=13=131=31=3-3----"+series);
			// 최종 series 에 넣을 값
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			// 컬럼의 갯수 만큼 늘려 주기 위해서
			for(int s = 0 ; s < series ; s++) {
				HashMap<String, Object> data = new HashMap<String, Object>();
				// 예를들어 파견, 솔루션, 챗봇등의 컬럼을 가르킨다.
				data.put("name", typelist.get(s).get("NAME"));
				// ArrayList y 생성
				ArrayList<Long> y = new ArrayList<Long>();
				// 사이즈별로 랜덤한 값을 y에 넣는다.
				y.add(Long.parseLong(String.valueOf(typeConlist.get(s).get("AMT")))); 
				System.out.println("---12---12----12---12---12---12--12-12-"+y);
				// data : (5) <- 5는 예를들어 년도에 갯수
				data.put("data", y);
				list.add(data);
				System.out.println("listlistlistlistlistlistlist"+list);
			}
			
			List<String> cate = new ArrayList<String>();
			
			for(int i = 0 ; i < typeConlist.size() ; i++) {
				cate.add(String.valueOf(typeConlist.get(i).get("CONT_DATE")));
			}
			
			cate.add("적요");
			modelMap.put("params", params);
			modelMap.put("yearlist", yearlist);
			modelMap.put("monthlist", monthlist);
			modelMap.put("typelist", typelist);
			modelMap.put("typeConlist", typeConlist);
			modelMap.put("list", list);
			modelMap.put("cate", cate);
			
			return mapper.writeValueAsString(modelMap);
		}
}
