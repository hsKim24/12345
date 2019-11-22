package com.gd.heywe.web.crm.controller;

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
import com.gd.heywe.web.common.service.ICommonService;
import com.gd.heywe.web.crm.service.ICrmService;

@Controller
public class CrmController {

	@Autowired
	public IPagingService iPagingService;

	@Autowired
	public ICrmService iCrmService;

	@Autowired
	public ICommonService iCommonService;
	

		

	
	@RequestMapping(value = "/CRMCstmAsk")
	public ModelAndView CRMCstmAsk(@RequestParam HashMap<String, String> params, ModelAndView mav,
			HttpSession session) {
		HashMap<String, String> data = iCrmService.getCRMCstmDtl(params);
		List<HashMap<String, String>> cstmAtt = iCrmService.CRMgetCstmAtt(params);
		session.getAttribute("sEmpNo");
		mav.addObject("data", data);
		mav.addObject("cstmAtt", cstmAtt);
		mav.setViewName("crm/CRMCstmAsk");
		return mav;
	}

	@RequestMapping(value = "/CRMMarkChanceAsk")
	public ModelAndView CRMMarkChanceAsk(@RequestParam HashMap<String, String> params, ModelAndView mav,
			HttpSession session) {
		System.out.println(params.get("markno"));

		HashMap<String, String> data = iCrmService.getCRMMarkChanceDtl(params);

		session.getAttribute("sEmpNo");

		mav.addObject("data", data);

		mav.setViewName("crm/CRMMarkChanceAsk");

		return mav;
	}

	@RequestMapping(value = "/CRMCstm")
	public ModelAndView Cstm(ModelAndView mav, HttpSession session) {
		session.getAttribute("sEmpNo");
		mav.setViewName("crm/CRMCstm");

		return mav;
	}

	@RequestMapping(value = "/CRMMarkChanceWrite")
	public ModelAndView CRMMarkChanceWrite(ModelAndView mav, HttpSession session) {
		session.getAttribute("sEmpNo");
		mav.setViewName("crm/CRMMarkChanceWrite");

		return mav;
	}

	@RequestMapping(value = "/OfferWrite")
	public ModelAndView OfferWrite(ModelAndView mav, HttpSession session) {
		session.getAttribute("sEmpNo");
		mav.setViewName("crm/OfferWrite");

		return mav;
	}

	@RequestMapping(value = "/CRMMarkActivityAsk")
	public ModelAndView CRMMarkActivityCalOfferAsk(ModelAndView mav, @RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		session.getAttribute("sEmpNo");
		
		String auth = iCommonService.menuAuthCheck(session.getAttribute("sAuthNo").toString(), "19");
		HashMap<String, String> data = iCrmService.getMACDtl(params);

		mav.addObject("auth", auth);
		mav.addObject("data", data);

		mav.setViewName("crm/CRMMarkActivityAsk");

		return mav;
	}

	@RequestMapping(value = "/CRMMarkActivityUpdate")
	public ModelAndView CRMMarkActivityUpdate(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) {
		session.getAttribute("sEmpNo");

		HashMap<String, String> data = iCrmService.getMACDtl(params);

		mav.addObject("data", data);

		mav.setViewName("crm/CRMMarkActivityUpdate");

		return mav;
	}

	@RequestMapping(value = "/CRMMarkChanceUpdate")
	public ModelAndView CRMMarkChanceUpdate(ModelAndView mav, @RequestParam HashMap<String, String> params,
			HttpSession session) {
		session.getAttribute("sEmpNo");

		HashMap<String, String> data = iCrmService.getCRMMarkChanceDtl(params);
		System.out.println(data);
		mav.addObject("data", data);

		mav.setViewName("crm/CRMMarkChanceUpdate");

		return mav;
	}

	@RequestMapping(value = "/CRMCstmUpdate")
	public ModelAndView CRMCstmUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav,
			HttpSession session) {
		session.getAttribute("sEmpNo");

		HashMap<String, String> data = iCrmService.getCRMCstmDtl(params);

		System.out.println("aaaaaaaaaaaaaaaaaa" + data);

		mav.addObject("data", data);

		mav.setViewName("crm/CRMCstmUpdate");

		return mav;
	}

	@RequestMapping(value = "/CRMMarkChanceList")
	public ModelAndView CRMMarkChanceList(ModelAndView mav, HttpSession session) {
		session.getAttribute("sEmpNo");
		mav.setViewName("crm/CRMMarkChanceList");

		return mav;
	}

	@RequestMapping(value = "/CRMMarkChanceListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMarkChanceListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iCrmService.getCRMMarkChanceCnt(params);

		System.out.println(params.get("page"));

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		System.out.println(params.get("startCnt"));
		System.out.println(params.get("endCnt"));

		List<HashMap<String, String>> list = iCrmService.getCRMMarkChanceList(params);

		List<HashMap<String, String>> State = iCrmService.getProgressState(params);

		modelMap.put("State", State);

		modelMap.put("list", list);

		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}
	@RequestMapping(value = "/deleteAttFileAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteAttFileAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		iCrmService.deleteAttFileAjax(params);
		
		return mapper.writeValueAsString(modelMap);
	}
	@RequestMapping(value = "/deleteCstmAttFileAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteCstmAttFileAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		iCrmService.deleteCstmAttFileAjax(params);
		
		return mapper.writeValueAsString(modelMap);
	}
	@RequestMapping(value = "/deleteaMarkAttFileAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteaMarkAttFileAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		iCrmService.deleteMarkAttFileAjax(params);
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkActivityCalListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMarkActivityCalListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iCrmService.CRMMarkActivityCalListCnt(params);

		System.out.println(params.get("page"));
		


		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		System.out.println(params.get("startCnt"));
		System.out.println(params.get("endCnt"));

		List<HashMap<String, String>> list = iCrmService.CRMMarkActivityCalList(params);

		modelMap.put("list", list);

		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMCstm2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstm2Ajax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iCrmService.getCRMCstmCnt(params);

		System.out.println(params.get("page"));

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		System.out.println(params.get("startCnt"));
		System.out.println(params.get("endCnt"));

		List<HashMap<String, String>> list = iCrmService.getCrmCstmList(params);

		modelMap.put("list", list);

		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkopnionDeleteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkopnionDeleteAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		iCrmService.MarkOpnionDelete(params);

		/* List<HashMap<String, String>> e2list = iCrmService.getEMPList(params); */

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CstmopnionDeleteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CstmopnionDeleteAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		iCrmService.CstmOpnionDelete(params);

		/* List<HashMap<String, String>> e2list = iCrmService.getEMPList(params); */

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/calAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String calAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> cal = iCrmService.getcalList(params);

		modelMap.put("cal", cal);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadCalListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadCalListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> callist = iCrmService.getcalList2(params);

		modelMap.put("callist", callist);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadCalMainListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadCalMainListAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelMap = new HashMap<String, Object>();

		int cnt = iCrmService.CalMainListCnt(params);
		System.out.println("++++++++++++++++++++++++++++" + cnt);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		System.out.println("----------++++++++------+++++++++++++=");
		List<HashMap<String, String>> callist = iCrmService.getcalMainList2(params);

		modelMap.put("pb", pb);

		modelMap.put("callist", callist);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMngr2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMngr2Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> dept = iCrmService.getDept(params);
		modelMap.put("dept", dept);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMEmpAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMEmpAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> emp = iCrmService.getEmp(params);
		modelMap.put("emp", emp);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CstmOpnionInsertAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CstmOpnionInsertAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.opinionInsert(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkopnionInsertAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkopnionInsertAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.MarkopinionInsert(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMCstmWrite")
	public ModelAndView CRMCstmWrite(ModelAndView mav, HttpSession session) {
		session.getAttribute("sEmpNo");
		mav.setViewName("crm/CRMCstmWrite");

		return mav;
	}

	@RequestMapping(value = "/CstmDiv2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CstmDiv2Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> Div = iCrmService.getCstmDiv(params);
		List<HashMap<String, String>> Grade = iCrmService.getCstmGrade(params);
		List<HashMap<String, String>> State = iCrmService.getProgressState(params);
		List<HashMap<String, String>> bt = iCrmService.getBsnsType(params);
		List<HashMap<String, String>> sd = iCrmService.getSalesDiv(params);
		List<HashMap<String, String>> rp = iCrmService.getRecogPath(params);

		modelMap.put("rp", rp);
		modelMap.put("sd", sd);
		modelMap.put("bt", bt);
		modelMap.put("Div", Div);
		modelMap.put("Grade", Grade);
		modelMap.put("State", State);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMCstmWrite2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmWrite2Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		iCrmService.getCstmWrite(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkChanceWrite2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkChanceWrite2Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.getMarkChanceWrite(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMngrWrite")
	public ModelAndView CRMMngrWrite(ModelAndView mav) {
		mav.setViewName("crm/CRMMngrWrite");
		return mav;
	}

	@RequestMapping(value = "/CRMMarkActivityList")
	public ModelAndView CRMMarkActivityCalOfferList(ModelAndView mav) {
		mav.setViewName("crm/CRMMarkActivityList");
		return mav;
	}

	@RequestMapping(value = "/CRMCstmUpdate2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmUpdate2Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.getCstmUpdate(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkChanceUpdate2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkChanceUpdate2Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		System.out.println(params.get("markNo"));

		iCrmService.getChanceUpdate(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkActivityWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkActivityWriteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (params.get("psname").toString().equals("기회")) {
			System.out.println("test");
			params.put("color", "#ED1C24");
		} else if (params.get("psname").toString().equals("제안")) {
			params.put("color", "#00A2E8");
		} else if (params.get("psname").toString().equals("협상")) {
			params.put("color", "#22B14C");

		} else if (params.get("psname").toString().equals("계약")) {
			params.put("color", "#FFC90E");
		}
		System.out.println("------------------------" + params.get("color"));

		iCrmService.MarkActivityWriteAjax(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkActivityUpdateAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkActivityUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		System.out.println("+++++++++++++++++++++++++++++++++" + params.get("psname"));

		if (params.get("psname").toString().equals("기회")) {
			System.out.println("test");
			params.put("color", "#ED1C24");
		} else if (params.get("psname").toString().equals("제안")) {
			params.put("color", "#00A2E8");
		} else if (params.get("psname").toString().equals("협상")) {
			params.put("color", "#22B14C");

		} else if (params.get("psname").toString().equals("계약")) {
			params.put("color", "#FFC90E");
		}
		System.out.println("------------------------" + params.get("color"));

		iCrmService.MarkActivityUpdateAjax(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MarkActivityDeleteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkActivityDeleteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		iCrmService.MarkActivityDeleteAjax(params);
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/crmEmpSearchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String crmEmpSearchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> list = iCrmService.getEmpSearchPopup(params);
		modelMap.put("list", list);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/cstmSearchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String cstmSearchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> list = iCrmService.getCstmSearchPopup(params);
		modelMap.put("list", list);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/chanceSearchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String chanceSearchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> list = iCrmService.getChanceSearchPopup(params);
		modelMap.put("list", list);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/mngrSearchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String mngrSearchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> list = iCrmService.getMngrSearchPopup(params);
		modelMap.put("list", list);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadempAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadempAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String, String> selectemp = iCrmService.selectemp(params);
		modelMap.put("selectemp", selectemp);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadcstmAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadcstmAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String, String> selectcstm = iCrmService.selectcstm(params);
		modelMap.put("selectcstm", selectcstm);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadchanceAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadchanceAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String, String> selectchance = iCrmService.selectchance(params);
		modelMap.put("selectchance", selectchance);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadmngrAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadmngrAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String, String> selectmngr = iCrmService.selectmngr(params);
		modelMap.put("selectmngr", selectmngr);
		return mapper.writeValueAsString(modelMap);
	}

//	성훈이꺼 

	@RequestMapping(value = "/updateContAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String updateContAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.updateCont(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntContUpdate")
	public ModelAndView CRMMarkMgntContUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {
		mav.setViewName("crm/CRMMarkMgntContUpdate");
		HashMap<String, String> dtl = iCrmService.getUpdateContList(params);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/CRMMarkMgntNegoAsk")
	public ModelAndView CRMMarkMgntNegoAsk(HttpSession Session, @RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		mav.setViewName("crm/CRMMarkMgntNegoAsk");
		String auth = iCommonService.menuAuthCheck(Session.getAttribute("sAuthNo").toString(), "19");
		HashMap<String, String> dtl = iCrmService.getMMNDtl(params);
		mav.addObject("auth", auth);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/writeContAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String writeContAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.writeCont(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntNegoList")
	public ModelAndView CRMMarkMgntNegoList(ModelAndView mav, HttpSession Session) throws Throwable{
		String auth = iCommonService.menuAuthCheck(Session.getAttribute("sAuthNo").toString(), "19");
		mav.setViewName("crm/CRMMarkMgntNegoList");
		mav.addObject("auth", auth);
		return mav;
	}

	@RequestMapping(value = "/CRMMMNListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMMNListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.getMMNCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iCrmService.getMMNList(params);
		modelMap.put("list", list);
		modelMap.put("totalCnt", Integer.toString(cnt));
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntContList")
	public ModelAndView CRMMarkMgntContList(ModelAndView mav) {
		mav.setViewName("crm/CRMMarkMgntContList");
		return mav;
	}

	@RequestMapping(value = "/CRMMarkMgntContWrite")
	public ModelAndView CRMMarkMgntContWrite(@RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {
		mav.setViewName("crm/CRMMarkMgntContWrite");
		HashMap<String, String> dtl = iCrmService.getInsertContList(params);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/ContWrite")
	public ModelAndView ContWrite(ModelAndView mav) {
		mav.setViewName("crm/ContWrite");
		return mav;
	}

	@RequestMapping(value = "/ContWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String ContWriteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.ContWriteCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iCrmService.ContWriteList(params);
		modelMap.put("list", list);
		modelMap.put("totalCnt", Integer.toString(cnt));
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntContAsk")
	public ModelAndView CRMMarkMgntContAsk(HttpSession Session, @RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		mav.setViewName("crm/CRMMarkMgntContAsk");
		HashMap<String, String> dtl = iCrmService.getMCContDtl(params);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/CRMMarkMgntOfferList")
	public ModelAndView CRMMarkMgntOfferList(ModelAndView mav) {

		mav.setViewName("crm/CRMMarkMgntOfferList");
		return mav;
	}

	@RequestMapping(value = "/CRMMarkMgntOfferAsk")
	public ModelAndView CRMMarkMgntOfferAsk(HttpSession Session, @RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		mav.setViewName("crm/CRMMarkMgntOfferAsk");
		Session.getAttribute("sEmpNo");
		HashMap<String, String> dtl = iCrmService.getMCODtl(params);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/MCCOpinionAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MCCOpinionAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.getMCCOpiCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> opinion = iCrmService.getMCCopinion(params);
		modelMap.put("pb", pb);
		modelMap.put("opinion", opinion);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMCOListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMCOListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.getMCOCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iCrmService.getMCOList(params);
		modelMap.put("list", list);
		modelMap.put("totalCnt", Integer.toString(cnt));
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MCCinsertOpinionAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MCCinsertOpinionAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.insertMCCOpinion(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MCCdeleteOpinionAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MCCdeleteOpinionAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.deleteMCCOpinion(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/NegoWrite")
	public ModelAndView NegoWrite(ModelAndView mav) {
		mav.setViewName("crm/NegoWrite");
		return mav;
	}

	@RequestMapping(value = "/CRMMarkActivity")
	public ModelAndView CRMMarkActivity(ModelAndView mav, HttpSession session) throws Throwable{
		String auth = iCommonService.menuAuthCheck(session.getAttribute("sAuthNo").toString(), "19");
		mav.setViewName("crm/CRMMarkActivity");
		mav.addObject("auth", auth);
		return mav;
	}

	@RequestMapping(value = "/CRMMarkActivityWrite")
	public ModelAndView CRMMarkActivityCalOfferReg(ModelAndView mav) {
		mav.setViewName("crm/CRMMarkActivityWrite");
		return mav;
	}

	@RequestMapping(value = "/activtyTypeListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String activtyTypeListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> at = iCrmService.reloadactivityType(params);

		modelMap.put("at", at);
		return mapper.writeValueAsString(modelMap);
	}

	// 찐성훈

	@RequestMapping(value = "/CRMMngr")
	public ModelAndView CRMMngr(ModelAndView mav) {
		mav.setViewName("crm/CRMMngr");
		return mav;
	}

	@RequestMapping(value = "/CRMMngrAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMngrAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.CRMgetTestCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iCrmService.CRMgetMngrList(params);
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMngrAsk")
	public ModelAndView CRMMngrAsk(HttpSession Session, ModelAndView mav, @RequestParam HashMap<String, String> params)
			throws Throwable {
		mav.setViewName("crm/CRMMngrAsk");
		HashMap<String, String> mngr = iCrmService.CRMgetMngr(params);
		Session.getAttribute("sEmpNo");
		List<HashMap<String, String>> mngrAtt = iCrmService.CRMgetMngrAtt(params);

		mav.addObject("mngrAtt", mngrAtt);
		mav.addObject("mngr", mngr);
		return mav;
	}

	@RequestMapping(value = "/MngrOpinionAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MngrOpinionAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.CRMgetOpiCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> opinion = iCrmService.CRMgetMngropinion(params);
		modelMap.put("opinion", opinion);
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MngrinsertOpinionAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MngrinsertOpinionAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.CRMinsertOpinion(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MngrdeleteOpinionAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MngrdeleteOpinionAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.CRMdeleteOpinion(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MngrAttAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MngrAttAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> mngrAtt = iCrmService.CRMgetMngrAtt(params);
		modelMap.put("mngrAtt", mngrAtt);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CstmAttAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CstmAttAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> cstmAtt = iCrmService.CRMgetCstmAtt(params);
		modelMap.put("cstmAtt", cstmAtt);
		return mapper.writeValueAsString(modelMap);
	}
	
	  @RequestMapping(value = "/MarkAttAjax", method = RequestMethod.POST, produces
	  = "text/json;charset=UTF-8")
	  
	  @ResponseBody public String MarkAttAjax(@RequestParam HashMap<String, String>
	  params) throws Throwable { ObjectMapper mapper = new ObjectMapper();
	  Map<String, Object> modelMap = new HashMap<String, Object>();
	  List<HashMap<String, String>> markAtt = iCrmService.CRMgetMarkAtt(params);
	  modelMap.put("markAtt", markAtt); 
	  return mapper.writeValueAsString(modelMap);
	  }
	 

	@RequestMapping(value = "/MngrUpdateAttAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MngrUpdateAttAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> mngrAtt = iCrmService.CRMgetMngrAtt(params);
		
		modelMap.put("mngrAtt", mngrAtt);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MngrUpdateAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MngrUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.updateMngr(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMngrUpdate")
	public ModelAndView CRMMngrUpdate(HttpSession Session, ModelAndView mav,
			@RequestParam HashMap<String, String> params) throws Throwable {
		mav.setViewName("crm/CRMMngrUpdate");
		HashMap<String, String> mngrUpdate = iCrmService.getUpdate(params);
		List<HashMap<String, String>> mngrAtt = iCrmService.CRMgetMngrAtt(params);
		HashMap<String, String> data = iCrmService.CRMgetMngr(params);
		System.out.println(data);
		mav.addObject("data", data);

		mav.addObject("mngrAtt", mngrAtt);
		mav.addObject("mngrUpdate", mngrUpdate);
		return mav;
	}

	@RequestMapping(value = "/insertMngrAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String insertMngrAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		System.out.println(params.toString());

		iCrmService.insertMngr(params);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMCContListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMMCContListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.getMCContCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iCrmService.getMCContList(params);
		modelMap.put("list", list);
		modelMap.put("totalCnt", Integer.toString(cnt));
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MCCsel3Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MCCsel3Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> dept = iCrmService.getMccDept(params);
		modelMap.put("dept", dept);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MCCsel4Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MCCsel4Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> emp = iCrmService.getMccEmp(params);
		modelMap.put("emp", emp);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/MCCsel5Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MCCsel5Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> pse = iCrmService.getMccPse(params);
		modelMap.put("pse", pse);
		return mapper.writeValueAsString(modelMap);
	}

	// 신희 고객사
	@RequestMapping(value = "/CRMCstmUpdateGradeAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmUpdateGradeAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			iCrmService.updateGrade(params);
			modelMap.put("res", "success");
		} catch (Exception e) {
			modelMap.put("res", "failed");
		}
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMCstmGetDeptAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmGetDeptAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> mdm = new HashMap<String, Object>();

		List<HashMap<String, String>> listD = iCrmService.getDept(params);

		mdm.put("listD", listD);

		return mapper.writeValueAsString(mdm);
	}

	@RequestMapping(value = "/CRMCstmGetEmpAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmGetEmpAjax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> mdm = new HashMap<String, Object>();

		List<HashMap<String, String>> listE = iCrmService.getEmp(params);

		mdm.put("listE", listE);

		return mapper.writeValueAsString(mdm);
	}

	@RequestMapping(value = "/CRMCstmGradeAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmGradeAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		if (!params.containsKey("page")) {
			params.put("page", "1");
		}

		int cnt = iCrmService.getCrmGradeCnt(params);

		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iCrmService.getCrmGrade(params);

		modelMap.put("list", list);
		modelMap.put("pb", pb);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntNegoUpdate")
	public ModelAndView CRMMarkMgntNegoUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {
		mav.setViewName("crm/CRMMarkMgntNegoUpdate");
		HashMap<String, String> dtl = iCrmService.CRMgetUpdateNegoList(params);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/updateNegoAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String updateNegoAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.CRMupdateNego(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/NegoWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String NegoWriteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.NegoWriteCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iCrmService.NegoWriteList(params);
		modelMap.put("list", list);
		modelMap.put("totalCnt", Integer.toString(cnt));
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntNegoWrite")
	public ModelAndView CRMMarkMgntNegoWrite(@RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {
		mav.setViewName("crm/CRMMarkMgntNegoWrite");
		HashMap<String, String> dtl = iCrmService.getInsertNegoList(params);
		mav.addObject("dtl", dtl);
		return mav;
	}

	@RequestMapping(value = "/writeNegoAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String writeNegoAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.writeNego(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMMarkMgntOfferWrite")
	public ModelAndView CRMMarkMgntOfferWrite(HttpSession Session, @RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		mav.setViewName("crm/CRMMarkMgntOfferWrite");
		Session.getAttribute("sEmpNo");
		HashMap<String, String> dataMO = iCrmService.getMngntOfferHit(params);
		mav.addObject("dataMO", dataMO);

		return mav;
	}

	@RequestMapping(value = "/CRMMarkMgntOfferUpdate")
	public ModelAndView CRMMarkMgntOfferUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {
		mav.setViewName("crm/CRMMarkMgntOfferUpdate");
		HashMap<String, String> dtl = iCrmService.getMMODtl(params);
		mav.addObject("dtl", dtl);
		HashMap<String, String> dtl2 = iCrmService.getMCODtl(params);
		mav.addObject("dtl2", dtl2);

		return mav;
	}

	@RequestMapping(value = "/updateMngntOfferAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String updateMngntOfferAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.updateMngntOffer(params);
		iCrmService.insertMngntOffer(params);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/updateMngntOfferAskAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String updateMngntOfferAskAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		iCrmService.updateMngntOfferAsk(params);

		return mapper.writeValueAsString(modelMap);
	}

	// 등급
	@RequestMapping(value = "/CRMCstmGrade")
	public ModelAndView CRMCstmGrade(@RequestParam HashMap<String, String> params, ModelAndView mav,
			HttpSession session) throws Throwable {
		String auth = iCommonService.menuAuthCheck(session.getAttribute("sAuthNo").toString(), "37");
		session.getAttribute("sEmpNo");
		mav.addObject("auth", auth);
		mav.setViewName("crm/CRMCstmGrade");

		return mav;
	}

	@RequestMapping(value = "/CRMupdatePseAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMupdatePseAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		iCrmService.CRMupdatePseAjax(params);
		return mapper.writeValueAsString(modelMap);
	}

	// 통계
	@RequestMapping(value = "/CRMStcTotalPresentCond")
	public ModelAndView CRMStcTotalPresentCond(ModelAndView mav) {

		mav.setViewName("crm/CRMStcTotalPresentCond");

		return mav;
	}

	// 고객 등급 그래프 조회
	@RequestMapping(value = "/stcGradeGraphAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String stcCstmGraphAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		// 총 고객 수 조회
		int cnt = iCrmService.getStcCstmCnt(params);
		modelMap.put("cnt", cnt);

		// 등급별 고객 비율 조회
		List<HashMap<String, String>> graphG = iCrmService.getStcGradeGraph(params);
		modelMap.put("graphG", graphG);

		return mapper.writeValueAsString(modelMap);
	}

	// 고객 등급 데이터 조회
	@RequestMapping(value = "/stcCstmGradeAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String stcCstmGradeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		// 고객 수 조회
		int cnt = iCrmService.getStcCstmCnt(params);

		List<HashMap<String, String>> stcG = iCrmService.getStcCstmGrade(params);
		modelMap.put("stcG", stcG);
		modelMap.put("cnt", cnt);

		return mapper.writeValueAsString(modelMap);
	}

	// 영업 기회 데이터 조회
	@RequestMapping(value = "/stcMarkChanceAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String stcMarkChanceAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		// 진행 별 영업 수 조회
		List<HashMap<String, String>> cnt = iCrmService.getStcChanceCnt(params);

		List<HashMap<String, String>> stcC = iCrmService.getStcMarkChance(params);
		modelMap.put("stcC", stcC);
		modelMap.put("cnt", cnt);

		return mapper.writeValueAsString(modelMap);
	}

	// 월별 활동 데이터 조회
	@RequestMapping(value = "/stcActGraphAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String stcActGraphAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> graphA = iCrmService.getStcActGraph(params);
		modelMap.put("graphA", graphA);

		return mapper.writeValueAsString(modelMap);
	}

	// 월별 영업 데이터 조회
	@RequestMapping(value = "/stcMarkGraphAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String stcMarkGraphAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		List<HashMap<String, String>> graphM = iCrmService.getStcMarkGraph(params);
		modelMap.put("graphM", graphM);

		return mapper.writeValueAsString(modelMap);
	}

	// 영업히스토리 팝업

	@RequestMapping(value = "/CRMreloadHistAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMreloadHistAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String, String>> histList = iCrmService.gethistList(params);
		modelMap.put("histList", histList);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/CRMGradeHistAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMGradeHistAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> dataH = iCrmService.getGradeHist(params);
		modelMap.put("dataH", dataH);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/CRMCstmHistAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CRMCstmHistAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, String>> dataC = iCrmService.getCstmHist(params);
		modelMap.put("dataC", dataC);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/MarkChanceOpnion2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String MarkChanceOpnion2Ajax(@RequestParam HashMap<String, String> params, HttpSession session)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.CRMgetMarkChanceOpinionCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> oplist = iCrmService.getMarkChanceOpnionList(params);
		modelMap.put("pb", pb);
		modelMap.put("oplist", oplist);
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/CstmOpnion2Ajax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String CstmOpnion2Ajax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iCrmService.CRMgetCstmOpinionCnt(params);
		PagingBean pb = iPagingService.getPageingBean(Integer.parseInt(params.get("page")), cnt, 5, 5);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> oplist = iCrmService.getCstmOpnionList(params);
		modelMap.put("pb", pb);
		modelMap.put("oplist", oplist);
		return mapper.writeValueAsString(modelMap);
	}
}
