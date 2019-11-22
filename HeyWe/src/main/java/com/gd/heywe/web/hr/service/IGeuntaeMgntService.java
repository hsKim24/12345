package com.gd.heywe.web.hr.service;

import java.util.HashMap;
import java.util.List;

public interface IGeuntaeMgntService {

	List<HashMap<String, String>> getGeuntaeName() throws Throwable;

	int geuntaeOverlapCheck(HashMap<String, String> params) throws Throwable;

	void geuntaeAdd(HashMap<String, String> params) throws Throwable;

	int geuntaeUpdate(HashMap<String, String> params) throws Throwable;

	int geuntaeDeleteCheck(HashMap<String, String> params) throws Throwable;

	int geuntaeDelete(HashMap<String, String> params) throws Throwable;

	int geuntaeUpdateOverlapCheck(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, Object>> addWorkGeuntaeList() throws Throwable;

	void addWorkReg(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, String>> getGeunTaeList(HashMap<String, String> params);

	public int getGeunTaeCnt(HashMap<String, String> params);

	public HashMap<String, String> getGeunTaeData(HashMap<String, String> params);

	public List<HashMap<String, String>> GeunTaeList(HashMap<String, String> params);

	public List<HashMap<String, String>> getGeunTaeAdminList(HashMap<String, String> params);

	public int getGeunTaeAdminCnt(HashMap<String, String> params);

	public List<HashMap<String, String>> DeptList(HashMap<String, String> params);

	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params);

	public int insertGeunTaeData(HashMap<String, String> params);
}
