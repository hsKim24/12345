package com.gd.heywe.web.hr.service;

import java.util.HashMap;
import java.util.List;


public interface IHRMgntService {

	public List<HashMap<String, String>> getVacaStd(String sEmpNo) throws Throwable;

	public List<HashMap<String, String>> getDeptList() throws Throwable;

	public List<HashMap<String, String>> getPosiList() throws Throwable;

	public List<HashMap<String, String>> getEmpSearch1Popup(HashMap<String, String> params) throws Throwable;

	public void insertvacaReq(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> checkLeftDate(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> leftVacaList(HashMap<String, String> params) throws Throwable;

	public int empCnt(HashMap<String, String> params) throws Throwable;

	public int vacaStdListCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> vacaStdList(HashMap<String, String> params) throws Throwable;

	public int delVacaStd(HashMap<String, String> params) throws Throwable;

	public int updateVacaStd(HashMap<String, String> params) throws Throwable;

	public void insertVacaStd(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> VacaReqRecList(HashMap<String, String> params) throws Throwable;

	public int HRcancelVacaReqAjax(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getcalList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getVacaReqDtl(HashMap<String, String> params) throws Throwable;

	public int HRgetconnectNo(HashMap<String, String> params) throws Throwable;

	public String HRgetApvEmpNo(HashMap<String, String> params) throws Throwable;


	public List<HashMap<String, String>> getDeptName() throws Throwable;

	public int deptOverlapCheck(HashMap<String, String> params) throws Throwable;

	public void deptAdd(HashMap<String, String> params) throws Throwable;

	public int deptNameUpdate(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getPosiName() throws Throwable;

	public List<HashMap<String, String>> getHrApntRecAsk(HashMap<String, String> params) throws Throwable;

	public int getHrApntCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) throws Throwable;

	public void hrApntReg(HashMap<String, String> params) throws Throwable;

	public int getHrApntApvStateCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getHrApntApvState(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getTempHrApntBatch(String sysdate) throws Throwable;

	public int deptDeleteCheck(HashMap<String, String> params) throws Throwable;

	public int deptDelete(HashMap<String, String> params) throws Throwable;

	public void empReg(HashMap<String, String> params) throws Throwable;

	public int getHrApntNo() throws Throwable;

	public int getHrDmngr() throws Throwable;

	public String getDeptDmngr(HashMap<String, String> params) throws Throwable;

	public int getRepresentEmpNo() throws Throwable;

	public void hrApntBatchInsert(HashMap<String, String> hashMap) throws Throwable;

	public void hrApntBatchDivUpdate(HashMap<String, String> hashMap) throws Throwable;

	public void hrApntFnshUpdate(HashMap<String, String> hashMap) throws Throwable;

	public HashMap<String, String> hmitem(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> qlfc(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> career(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> AAbty(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> family(HashMap<String, String> params) throws Throwable;

	public void hmitemUpdate(HashMap<String, String> params) throws Throwable;
	
	public int getTestCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params);

	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params);

	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params);

	public HashMap<String, String> getEmpDtlData(HashMap<String, String> params);

	public void dropEmpSequence() throws Throwable;

	public void initEmpSequence() throws Throwable;

	public HashMap<String, String> hmitemApnt(HashMap<String, String> params)throws Throwable;
}
