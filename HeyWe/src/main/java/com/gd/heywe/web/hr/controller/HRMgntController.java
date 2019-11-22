package com.gd.heywe.web.hr.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import com.gd.heywe.util.Utils;
import com.gd.heywe.web.common.service.ICommonService;
import com.gd.heywe.web.gw.service.IGwApvService;
import com.gd.heywe.web.hr.service.IHRMgntService;

@Controller
public class HRMgntController {// 인사관리

	@Autowired
	public IHRMgntService iHRMgntService;
	@Autowired
	public IPagingService iPagingService;
	@Autowired
	public IGwApvService iGwApvService;

	@Autowired
	public ICommonService iCommonService;

	// 휴가 신청
	@RequestMapping(value = "/HRVacaReq")
	public ModelAndView HRVacaReq(ModelAndView mav, HttpSession session) throws Throwable {

		System.out.println(session.getAttribute("sEmpNo").toString());
		List<HashMap<String, String>> vList = iHRMgntService.getVacaStd(session.getAttribute("sEmpNo").toString());
		mav.addObject("vList", vList);
		List<HashMap<String, String>> deptList = iHRMgntService.getDeptList();
		mav.addObject("deptList", deptList);
		List<HashMap<String, String>> posiList = iHRMgntService.getPosiList();
		mav.addObject("posiList", posiList);

		mav.setViewName("hr/hrMgnt/VacaMgnt/HRVacaReq");
		return mav;
	}

	// 팝업 사원 조회
	@RequestMapping(value = "/HRempSearch1Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRempSearch1Ajax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		params.put("sDeptNo", session.getAttribute("sDeptNo").toString());
		System.out.println(params);
		List<HashMap<String, String>> list = iHRMgntService.getEmpSearch1Popup(params);

		modelMap.put("list", list);
		System.out.println(list);
		return mapper.writeValueAsString(modelMap);
	}

	// 신청버튼
	@RequestMapping(value = "/HRvacaReqAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRvacaReqAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		
		String apvEmpNo = iHRMgntService.HRgetApvEmpNo(params);
		params.put("apverNos", apvEmpNo.toString());
		System.out.println("HRvacaReqAjax : " + params);

		HashMap<String, String> checkLeft = iHRMgntService.checkLeftDate(params);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = formatter.parse(params.get("startDate"));
		Date endDate = formatter.parse(params.get("endDate"));
		int res = iHRMgntService.HRgetconnectNo(params);
		params.put("connectNo", Integer.toString(res));
		params.put("vacaSeq", Integer.toString(res));
		// 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff / (24 * 60 * 60 * 1000) + 1;
		int diffDay = (int) (long) diffDays;
		if (Integer.parseInt(String.valueOf(checkLeft.get("LEFT_VACA"))) - diffDay < 0) {
			modelMap.put("checkLeftError", "잔여 일수를 초과하였습니다.");
		} else {
			iGwApvService.reportApv(params);
			iHRMgntService.insertvacaReq(params);
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 남은휴가 가져오기
	@RequestMapping(value = "/HRleftVacaListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRleftVacaListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		System.out.println(params);
		if (params.get("page") == null || params.get("page") == "") {
			params.put("page", "1");
		}
		System.out.println("여기냐");
		int cnt = iHRMgntService.empCnt(params);
		System.out.println("여긴가");
		// 최대크기가져와야됨 ㅅㅂ
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		System.out.println("여기야?");
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> leftVacaList = iHRMgntService.leftVacaList(params);
		modelMap.put("list", leftVacaList);
		modelMap.put("pb", pb);
		modelMap.put("page", params.get("page"));
		return mapper.writeValueAsString(modelMap);
	}

	// 남은휴가 가져오기
	@RequestMapping(value = "/HRVacaStdListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRVacaStdListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		System.out.println(params);
		if (params.get("page") == null || params.get("page") == "") {
			params.put("page", "1");
		}
		int cnt = iHRMgntService.vacaStdListCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> vacaStdList = iHRMgntService.vacaStdList(params);
		modelMap.put("list", vacaStdList);
		modelMap.put("pb", pb);
		modelMap.put("page", params.get("page"));
		System.out.println("VacaStdListAjax page : " + params.get("page"));
		return mapper.writeValueAsString(modelMap);
	}

	// vaca_std 삭제
	@RequestMapping(value = "/HRdelVacaStdAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRdelVacaStdAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int res = iHRMgntService.delVacaStd(params);
		if (res == 0) {
			modelMap.put("msg", "삭제에 실패했습니다.");
		} else {
			modelMap.put("msg", "삭제에 성공했습니다.");
		}
		return mapper.writeValueAsString(modelMap);
	}

	// vaca_std update
	@RequestMapping(value = "/HRupdateVacaStdAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRupdateVacaStdAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		boolean flag = false;
		if ((params.get("salDiv")).equals("유급")) {
			params.put("salDiv", "0");
			flag = true;
		} else if ((params.get("salDiv")).equals("무급")) {
			params.put("salDiv", "1");
			flag = true;
		} else {
			// modelMap.put("msg", "급여 구분을 확인하세요.(유급 or 무급)");
			int res = 9;
			modelMap.put("res", res);
			System.out.println("updateVacaStdAjax res : " + res);
		}
		if (flag == true) {
			int res = iHRMgntService.updateVacaStd(params);
			modelMap.put("res", res);
			System.out.println("updateVacaStdAjax res : " + res);
		}
		return mapper.writeValueAsString(modelMap);
	}

	// vaca_std insert
	@RequestMapping(value = "/HRinsertVacaStdAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRinsertVacaStdAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		boolean flag = false;
		if ((params.get("salDiv")).equals("유급")) {
			params.put("salDiv", "0");
			flag = true;
		} else if ((params.get("salDiv")).equals("무급")) {
			params.put("salDiv", "1");
			flag = true;
		} else {
			// modelMap.put("msg", "급여 구분을 확인하세요.(유급 or 무급)");
			int res = 9;
			modelMap.put("res", res);
			System.out.println("insertVacaStdAjax res : " + res);
		}
		if (flag == true) {
			try {
				iHRMgntService.insertVacaStd(params);
				int res = 1;
				modelMap.put("res", res);
			} catch (Exception e) {
				int res = 0;
				modelMap.put("res", res);
				System.out.println("insertVacaStdAjax res : " + res);
			}
		}
		return mapper.writeValueAsString(modelMap);
	}

	// vaca_req_rec 가져오기
	@RequestMapping(value = "/HRVacaReqRecListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRVacaReqRecListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		/*
		 * if(params.get("stdDate")==null || params.get("stdDate") =="") { Calendar cal
		 * = new GregorianCalendar(Locale.KOREA); cal.setTime(new Date()); //
		 * cal.add(Calendar.YEAR, 1); // 1년을 더한다. // cal.add(Calendar.MONTH, 1); // 한달을
		 * 더한다. // cal.add(Calendar.DAY_OF_YEAR, 1); // 하루를 더한다. //
		 * cal.add(Calendar.HOUR, 1); // 시간을 더한다 SimpleDateFormat fm = new
		 * SimpleDateFormat("yy/MM"); String stdDate = fm.format(cal.getTime());
		 * System.out.println("time : "+stdDate); params.put("stdDate",stdDate);
		 * modelMap.put("stdDate",stdDate); cal.add(Calendar.MONTH, 1); String endDate =
		 * fm.format(cal.getTime()); System.out.println("time : "+endDate);
		 * params.put("endDate",endDate); modelMap.put("endDate",endDate); }
		 */
		params.put("sEmpNo", session.getAttribute("sEmpNo").toString());
		List<HashMap<String, String>> vacaReqRecList = iHRMgntService.VacaReqRecList(params);
		System.out.println("vacaReqRecList : " + vacaReqRecList);
		modelMap.put("list", vacaReqRecList);

		return mapper.writeValueAsString(modelMap);
	}

	// date next!
	@RequestMapping(value = "/HRdateNextAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRdateNextAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(new Date());
		// cal.add(Calendar.YEAR, 1); // 1년을 더한다.
		// cal.add(Calendar.MONTH, 1); // 한달을 더한다.
		// cal.add(Calendar.DAY_OF_YEAR, 1); // 하루를 더한다.
		// cal.add(Calendar.HOUR, 1); // 시간을 더한다
		int check = Integer.parseInt(params.get("clickTime"));
		while (check != 0) {
			if (check > 0) {
				cal.add(Calendar.MONTH, 1);
				check--;
			}
			if (check < 0) {
				cal.add(Calendar.MONTH, -1);
				check++;
			}
		}
		SimpleDateFormat fm = new SimpleDateFormat("yy/MM");
		String stdDate = fm.format(cal.getTime());
		System.out.println("time : " + stdDate);
		params.put("stdDate", stdDate);
		modelMap.put("stdDate", stdDate);
		cal.add(Calendar.MONTH, 1);
		String endDate = fm.format(cal.getTime());
		System.out.println("time : " + endDate);
		params.put("endDate", endDate);
		modelMap.put("endDate", endDate);
		return mapper.writeValueAsString(modelMap);
	}

	// date next!
	@RequestMapping(value = "/HRcancelVacaReqAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRcancelVacaReqAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int res = iHRMgntService.HRcancelVacaReqAjax(params);
		// modelMap.put("endDate",endDate);
		modelMap.put("res", res);
		return mapper.writeValueAsString(modelMap);
	}

	// 잔여 휴가 조회
	@RequestMapping(value = "/HRRmidVacaAsk")
	public ModelAndView HRRmidVacaAsk(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) throws Throwable {
		List<HashMap<String, String>> deptList = iHRMgntService.getDeptList();
		mav.addObject("deptList", deptList);

		mav.setViewName("hr/hrMgnt/VacaMgnt/HRRmidVacaAsk");
		return mav;
	}

	// 휴가 신청 조회
	@RequestMapping(value = "/HRVacaReqAsk")
	public ModelAndView HRVacaReqAsk(ModelAndView mav) {

		mav.setViewName("hr/hrMgnt/VacaMgnt/HRVacaReqAsk");
		return mav;

	}

	// 휴가 기준 수정
	@RequestMapping(value = "/HRVacaStdUpdate")
	public ModelAndView HRVacaStdUpdate(ModelAndView mav) {

		mav.setViewName("hr/hrMgnt/VacaMgnt/HRVacaStdUpdate");
		return mav;
	}

	// 월별 휴가 현황
	@RequestMapping(value = "/HRMonthVacaCurrent")
	public ModelAndView HRMonthVacaCurrent(ModelAndView mav, HttpSession session) throws Throwable {
		List<HashMap<String, String>> deptList = iHRMgntService.getDeptList();
		mav.addObject("deptList", deptList);
		mav.setViewName("hr/hrMgnt/VacaMgnt/HRMonthVacaCurrent");
		return mav;
	}

	// 캘린더
	@RequestMapping(value = "/HRcalAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRcalAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> cal = iHRMgntService.getcalList(params);
		modelMap.put("cal", cal);

		return mapper.writeValueAsString(modelMap);
	}

	// 팝업 휴가 dtl
	@RequestMapping(value = "/HRVacaReqDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRVacaReqDtlAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> list = iHRMgntService.getVacaReqDtl(params);
		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 부서관리
	@RequestMapping(value = "/HRDeptMgnt")
	public ModelAndView HRDeptMgnt(ModelAndView mav) {

		mav.setViewName("/hr/hrMgnt/deptMgnt/deptMgnt");

		return mav;
	}

	// 부서목록조회
	@RequestMapping(value = "/HRDeptMgntAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptMgntAjax() throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iHRMgntService.getDeptName();

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 부서중복체크
	@RequestMapping(value = "/HRDeptOverlapCheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptOverlapCheckAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iHRMgntService.deptOverlapCheck(params);

		modelMap.put("cnt", cnt);

		return mapper.writeValueAsString(modelMap);
	}

	// 부서추가
	@RequestMapping(value = "/HRDeptAddAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptAddAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iHRMgntService.deptAdd(params);
			modelMap.put("errorCheck", "0");
		} catch (Exception e) {
			modelMap.put("errorCheck", "1");
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 부서수정
	@RequestMapping(value = "/HRDeptNameUpdateAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptNameUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iHRMgntService.deptOverlapCheck(params);

		// 중복된 부서명이 없을경우
		if (cnt == 0) {
			int updateResult = iHRMgntService.deptNameUpdate(params);

			modelMap.put("updateResult", updateResult);
		}

		modelMap.put("cnt", cnt);

		return mapper.writeValueAsString(modelMap);
	}

	// 부서삭제가능여부
	@RequestMapping(value = "/HRDeptDeleteCheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptDeleteCheckAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iHRMgntService.deptDeleteCheck(params);

		modelMap.put("cnt", cnt);

		return mapper.writeValueAsString(modelMap);
	}

	// 부서삭제
	@RequestMapping(value = "/HRDeptDeleteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptDeleteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int deleteCnt = iHRMgntService.deptDelete(params);

		modelMap.put("deleteCnt", deleteCnt);

		return mapper.writeValueAsString(modelMap);
	}

	// 인사발령 기록조회
	@RequestMapping(value = "/HRHrApntRecAsk")
	public ModelAndView HRHrApntRecAsk(ModelAndView mav, HttpSession session) throws Throwable {

		String auth = iCommonService.menuAuthCheck(session.getAttribute("sAuthNo").toString(), "53");

		mav.addObject("auth", auth);
		mav.setViewName("/hr/hrMgnt/hrApnt/hrApntRecAsk");

		return mav;
	}

	// 직위조회
	@RequestMapping(value = "/HRPosiAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRPosiAskAjax() throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iHRMgntService.getPosiName();

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 인사발령검색버튼
	@RequestMapping(value = "/HRHrApntRecAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRHrApntRecAskAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int totalCnt = iHRMgntService.getHrApntCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("hrApntRecAskPage")), totalCnt, 10,
				5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iHRMgntService.getHrApntRecAsk(params);

		modelMap.put("hrApntRecAskPage", params.get("hrApntRecAskPage"));
		modelMap.put("pb", pb);
		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 인사발령등록
	@RequestMapping(value = "/HRHrApntReg")
	public ModelAndView HRHrApntRec(ModelAndView mav, HttpSession session) {

		mav.setViewName("/hr/hrMgnt/hrApnt/hrApntReg");

		return mav;
	}

	// 사원검색팝업
	@RequestMapping(value = "/HREmpSearchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HREmpSearchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iHRMgntService.getEmpSearchPopup(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 인사발령등록
	@RequestMapping(value = "/HRHrApntRegAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRHrApntRegAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			// 등록할 인사발련 번호
			int hrApntNo = iHRMgntService.getHrApntNo();
			params.put("hrApntNo", Integer.toString(hrApntNo));

			// 인사발령등록(TEMP_HR_APNT)
			iHRMgntService.hrApntReg(params);

			// 인사부서장 사원번호
			int hrDmngr = iHRMgntService.getHrDmngr();
			// 인사발령이 나는 부서의 부서장 사원번호
			String deptDmngr = iHRMgntService.getDeptDmngr(params);
			// 대표 사원번호
			int representEmpNo = iHRMgntService.getRepresentEmpNo();

			String apverNos = "";
			HashMap<String, String> data = new HashMap<String, String>();
			data.put("sEmpNo", params.get("sEmpNo"));
			data.put("title", "인사발령");
			data.put("con", "인사발령");
			data.put("expCon", params.get("expCon"));
			data.put("outApvTypeNo", "0");
			data.put("connectNo", Integer.toString(hrApntNo));
			// 인사부서장이 인사발령을 했다면 중복되지 않게
			if (Integer.parseInt(params.get("sEmpNo")) != hrDmngr) {
				apverNos += hrDmngr + ",";
			}

			if (deptDmngr != null && hrDmngr != Integer.parseInt(deptDmngr)) {
				apverNos += deptDmngr + ",";
			}

			apverNos += representEmpNo;

			data.put("apverNos", apverNos);
			data.put("impDate", params.get("formApntDate"));
			data.put("apvDocTypeNo", "");
			data.put("allApvWhether", "1");

			iGwApvService.reportApv(data);

			modelMap.put("flag", 0);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("flag", 1);
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 인사기록카드등록
	@RequestMapping(value = "/HRHmitemReg")
	public ModelAndView HRHmitemReg(ModelAndView mav) {

		mav.setViewName("/hr/hrMgnt/hrRecCard/hmitemReg");

		return mav;
	}

	// 인사기록카드등록 - 셀렉트박스
	@RequestMapping(value = "/HRDrawSelectBoxAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDrawSelectBoxAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> deptlist = iHRMgntService.getDeptName();
		List<HashMap<String, String>> posilist = iHRMgntService.getPosiName();

		modelMap.put("deptlist", deptlist);

		modelMap.put("posilist", posilist);

		return mapper.writeValueAsString(modelMap);
	}

	// 인사기록카드등록
	@RequestMapping(value = "/HREmpRegAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HREmpRegAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iHRMgntService.empReg(params);
			modelMap.put("empRegFlag", 0);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("empRegFlag", 1);
		}

		return mapper.writeValueAsString(modelMap);
	}

	// 인사기록카드수정
	@RequestMapping(value = "/HRHmitemUpdate")
	public ModelAndView HRHmitemUpdate(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) {

		mav.addObject("selectEmpNo", params.get("selectEmpNo"));
		mav.setViewName("/hr/hrMgnt/hrRecCard/hmitemUpdate");

		return mav;
	}

	// 인사기록카드수정
	@RequestMapping(value = "/HRHmitemUpdateAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRHmitemUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			iHRMgntService.hmitemUpdate(params);
			modelMap.put("empUpdateFlag", 0);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("empUpdateFlag", 1);
		}

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/HRHmitemAsk")
	public ModelAndView HRHmitemAsk(ModelAndView mav, HttpSession session) throws Throwable {

		String auth = iCommonService.menuAuthCheck(session.getAttribute("sAuthNo").toString(), "51");

		mav.addObject("auth", auth);

		mav.setViewName("hr/hrMgnt/hrRecCard/hmitemAsk");
		return mav;
	}

	@RequestMapping(value = "/HRHmitemAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRHmitemAskAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iHRMgntService.hmitem(params);
		HashMap<String, String> data2 = iHRMgntService.hmitemApnt(params);

		
		modelMap.put("pw", Utils.decryptAES128(data.get("PW")));

		modelMap.put("data", data);
		modelMap.put("data2", data2);

		return mapper.writeValueAsString(modelMap);

	}

	@RequestMapping(value = "/HRQlfcAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRQlfcAskAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iHRMgntService.qlfc(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);

	}

	@RequestMapping(value = "/HRCareerAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRCareerAskAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list2 = iHRMgntService.career(params);

		modelMap.put("list2", list2);

		return mapper.writeValueAsString(modelMap);

	}

	@RequestMapping(value = "/HRAAbtyAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRAAbtyAskAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list3 = iHRMgntService.AAbty(params);

		modelMap.put("list3", list3);

		return mapper.writeValueAsString(modelMap);

	}

	@RequestMapping(value = "/HRFamilyInfoAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRFamilyInfoAskAjax(@RequestParam HashMap<String, String> params,

			HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list4 = iHRMgntService.family(params);

		modelMap.put("list4", list4);

		return mapper.writeValueAsString(modelMap);

	}

	@RequestMapping(value = "/HREmpAsk")
	public ModelAndView EmpAsk(ModelAndView mav) {

		mav.setViewName("hr/hrMgnt/EmpAsk/HREmpAsk");

		return mav;
	}

	@RequestMapping(value = "/HREmpAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HREmpAskAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iHRMgntService.getTestCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iHRMgntService.getEmpList(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	// 부서별
	@RequestMapping(value = "/HRDeptAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HRDeptAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iHRMgntService.getDeptList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	// 직위별
	@RequestMapping(value = "/HRPosiAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String PosiAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> list = iHRMgntService.getPosiList(params);

		modelMap.put("list", list);

		return mapper.writeValueAsString(modelMap);
	}

	/*
	 * @RequestMapping(value="/HREmpAsk2") public ModelAndView EmpAsk2(ModelAndView
	 * mav) {
	 * 
	 * mav.setViewName("hr/hrMgnt/EmpAsk/HREmpAsk2");
	 * 
	 * return mav; }
	 * 
	 * @RequestMapping(value="/HREmpOrg") public ModelAndView HREmpOrg(ModelAndView
	 * mav) {
	 * 
	 * mav.setViewName("hr/hrMgnt/EmpAsk/HREmpOrg");
	 * 
	 * return mav; }
	 */

	// 사원 클릭 상세데이터
	@RequestMapping(value = "/HREmpAskDtlAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String HREmpAskDtlAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		HashMap<String, String> data = iHRMgntService.getEmpDtlData(params);

		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);
	}
}