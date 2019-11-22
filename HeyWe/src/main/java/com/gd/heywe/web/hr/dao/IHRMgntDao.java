package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

public interface IHRMgntDao {

	List<HashMap<String, String>> getDeptName() throws Throwable;

	int deptOverlapCheck(HashMap<String, String> params) throws Throwable;

	void deptAdd(HashMap<String, String> params) throws Throwable;

	int deptNameUpdate(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> getPosiName() throws Throwable;

	List<HashMap<String, String>> getHrApntRecAsk(HashMap<String, String> params) throws Throwable;

	int getHrApntCnt(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) throws Throwable;

	void hrApntReg(HashMap<String, String> params) throws Throwable;

	int getHrApntApvStateCnt(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> getHrApntApvState(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> getTempHrApntBatch(String sysdate) throws Throwable;

	int deptDeleteCheck(HashMap<String, String> params) throws Throwable;

	int deptDelete(HashMap<String, String> params) throws Throwable;

	void empReg(HashMap<String, String> params) throws Throwable;

	int getHrApntNo() throws Throwable;

	int getHrDmngr() throws Throwable;

	String getDeptDmngr(HashMap<String, String> params) throws Throwable;

	int getRepresentEmpNo() throws Throwable;

	void hrApntBatchInsert(HashMap<String, String> hashMap) throws Throwable;

	void hrApntBatchDivUpdate(HashMap<String, String> hashMap) throws Throwable;

	void hrApntFnshUpdate(HashMap<String, String> hashMap) throws Throwable;
	
	public HashMap<String, String> hmitem(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> qlfc(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> career(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> AAbty(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> family(HashMap<String, String> params)throws Throwable;

	void hmitemUpdate(HashMap<String, String> params) throws Throwable;
	
	public int getTestCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params);

	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params);

	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params);

	public HashMap<String, String> getEmpDtlData(HashMap<String, String> params);

	void dropEmpSequence() throws Throwable;

	void initEmpSequence() throws Throwable;

	public HashMap<String, String> hmitemApnt(HashMap<String, String> params)throws Throwable;
}
