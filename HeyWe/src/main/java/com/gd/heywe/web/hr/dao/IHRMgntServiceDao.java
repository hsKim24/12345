package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

public interface IHRMgntServiceDao {
	
	List<HashMap<String, String>> getVacaStd(String sEmpNo) throws Throwable;

	List<HashMap<String, String>> getDeptList() throws Throwable;

	List<HashMap<String, String>> getPosiList() throws Throwable;

	List<HashMap<String, String>> getEmpSearch1Popup(HashMap<String, String> params) throws Throwable;

	void insertvacaReq(HashMap<String, String> params) throws Throwable;

	HashMap<String, String> checkLeftDate(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> leftVacaList(HashMap<String, String> params) throws Throwable;

	int empCnt(HashMap<String, String> params) throws Throwable;

	int vacaStdListCnt(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> vacaStdList(HashMap<String, String> params) throws Throwable;

	int delVacaStd(HashMap<String, String> params) throws Throwable;

	int updateVacaStd(HashMap<String, String> params) throws Throwable;

	void insertVacaStd(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> VacaReqRecList(HashMap<String, String> params) throws Throwable;

	int HRcancelVacaReqAjax(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> getcalList(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, String>> getVacaReqDtl(HashMap<String, String> params) throws Throwable;

	int HRgetconnectNo(HashMap<String, String> params) throws Throwable;

	String HRgetApvEmpNo(HashMap<String, String> params) throws Throwable;

	
}
