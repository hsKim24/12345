package com.gd.heywe.web.hr.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.hr.dao.IHRMgntServiceDao;
import com.gd.heywe.web.hr.dao.IHRMgntDao;

@Service
public class HRMgntService implements IHRMgntService{

	@Autowired
	public IHRMgntServiceDao iHRMgntServiceDao;
	
	
	@Autowired
	public IHRMgntDao iHRMgntDao;
	
	@Override
	public List<HashMap<String, String>> getVacaStd(String sEmpNo) throws Throwable {
		return iHRMgntServiceDao.getVacaStd(sEmpNo);
	}
	@Override
	public List<HashMap<String, String>> getDeptList() throws Throwable {
		return iHRMgntServiceDao.getDeptList();
	}
	@Override
	public List<HashMap<String, String>> getPosiList() throws Throwable {
		return iHRMgntServiceDao.getPosiList();
	}
	@Override
	public List<HashMap<String, String>> getEmpSearch1Popup(HashMap<String, String> params) throws Throwable {
		return iHRMgntServiceDao.getEmpSearch1Popup(params);
	}
	@Override
	public void insertvacaReq(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		iHRMgntServiceDao.insertvacaReq(params);
	}
	@Override
	public HashMap<String, String> checkLeftDate(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.checkLeftDate(params);
	}
	@Override
	public List<HashMap<String, String>> leftVacaList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.leftVacaList(params);
	}
	@Override
	public int empCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.empCnt(params);
	}
	@Override
	public int vacaStdListCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.vacaStdListCnt(params);
	}
	@Override
	public List<HashMap<String, String>> vacaStdList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.vacaStdList(params);
	}
	@Override
	public int delVacaStd(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.delVacaStd(params);
	}
	@Override
	public int updateVacaStd(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.updateVacaStd(params);
	}
	@Override
	public void insertVacaStd(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		 iHRMgntServiceDao.insertVacaStd(params);
	}
	@Override
	public List<HashMap<String, String>> VacaReqRecList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.VacaReqRecList(params);
	}
	@Override
	public int HRcancelVacaReqAjax(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.HRcancelVacaReqAjax(params);
	}
	@Override
	public List<HashMap<String, String>> getcalList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.getcalList(params);
	}
	@Override
	public List<HashMap<String, String>> getVacaReqDtl(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.getVacaReqDtl(params);
	}
	@Override
	public int HRgetconnectNo(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.HRgetconnectNo(params);
	}
	@Override
	public String HRgetApvEmpNo(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntServiceDao.HRgetApvEmpNo(params);
	}

	@Override
	public List<HashMap<String, String>> getDeptName() throws Throwable {
		return iHRMgntDao.getDeptName();
	}

	@Override
	public int deptOverlapCheck(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.deptOverlapCheck(params);
	}

	@Override
	public void deptAdd(HashMap<String, String> params) throws Throwable {
		iHRMgntDao.deptAdd(params);
	}

	@Override
	public int deptNameUpdate(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.deptNameUpdate(params);
	}

	@Override
	public List<HashMap<String, String>> getPosiName() throws Throwable {
		return iHRMgntDao.getPosiName();
	}

	@Override
	public List<HashMap<String, String>> getHrApntRecAsk(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.getHrApntRecAsk(params);
	}

	@Override
	public int getHrApntCnt(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.getHrApntCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.getEmpSearchPopup(params);
	}

	@Override
	public void hrApntReg(HashMap<String, String> params) throws Throwable {
		iHRMgntDao.hrApntReg(params);
	}

	@Override
	public int getHrApntApvStateCnt(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.getHrApntApvStateCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getHrApntApvState(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.getHrApntApvState(params);
	}

	@Override
	public List<HashMap<String, String>> getTempHrApntBatch(String sysdate) throws Throwable {
		return iHRMgntDao.getTempHrApntBatch(sysdate);
	}

	@Override
	public int deptDeleteCheck(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.deptDeleteCheck(params);
	}

	@Override
	public int deptDelete(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.deptDelete(params);
	}

	@Override
	public void empReg(HashMap<String, String> params) throws Throwable {
		iHRMgntDao.empReg(params);
	}

	@Override
	public int getHrApntNo() throws Throwable {
		return iHRMgntDao.getHrApntNo();
	}

	@Override
	public int getHrDmngr() throws Throwable {
		return iHRMgntDao.getHrDmngr();
	}

	@Override
	public String getDeptDmngr(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.getDeptDmngr(params);
	}

	@Override
	public int getRepresentEmpNo() throws Throwable {
		return iHRMgntDao.getRepresentEmpNo();
	}

	@Override
	public void hrApntBatchInsert(HashMap<String, String> hashMap) throws Throwable {
		iHRMgntDao.hrApntBatchInsert(hashMap);
	}

	@Override
	public void hrApntBatchDivUpdate(HashMap<String, String> hashMap) throws Throwable {
		iHRMgntDao.hrApntBatchDivUpdate(hashMap);
	}

	@Override
	public void hrApntFnshUpdate(HashMap<String, String> hashMap) throws Throwable {
		iHRMgntDao.hrApntFnshUpdate(hashMap);
	}
	
	@Override
	public HashMap<String, String> hmitem(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.hmitem(params);
	}

	@Override
	public List<HashMap<String, String>> qlfc(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.qlfc(params);
	}

	@Override
	public List<HashMap<String, String>> career(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.career(params);
	}

	@Override
	public List<HashMap<String, String>> AAbty(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.AAbty(params);
	}

	@Override
	public List<HashMap<String, String>> family(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.family(params);
	}

	@Override
	public void hmitemUpdate(HashMap<String, String> params) throws Throwable {
		iHRMgntDao.hmitemUpdate(params);
	}
	
	@Override
	public int getTestCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRMgntDao.getTestCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iHRMgntDao.getEmpList(params);
	}

	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iHRMgntDao.getDeptList(params);
	}

	@Override
	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iHRMgntDao.getPosiList(params);
	}

	@Override
	public HashMap<String, String> getEmpDtlData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iHRMgntDao.getEmpDtlData(params);
	}
	@Override
	public void dropEmpSequence() throws Throwable {
		iHRMgntDao.dropEmpSequence();
	}
	@Override
	public void initEmpSequence() throws Throwable {
		iHRMgntDao.initEmpSequence();
	}
	@Override
	public HashMap<String, String> hmitemApnt(HashMap<String, String> params) throws Throwable {
		return iHRMgntDao.hmitemApnt(params);
	}
}
