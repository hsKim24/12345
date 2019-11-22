package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

public interface IHRSalMgntDao {

	public List<HashMap<String, String>> HRGeuntaeList(HashMap<String, String> params) throws Throwable;

	public int HRgetGeuntaeCnt() throws Throwable;

	public int HRaddGeuntae(HashMap<String, String> params) throws Throwable;

	public int HRdelGeuntae(HashMap<String, String> params) throws Throwable;

	public int HRupdateGeuntae(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> HRGetSalCalcList(HashMap<String, String> params) throws Throwable;

	public int HRsalCalcCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> HRGetApvSalCalcM() throws Throwable;

	public int setEmpApvChange(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> HRgetEmpSalList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getStdList() throws Throwable;

	public int oneInsertSal(HashMap<String, String> params) throws Throwable;

	public int oneUpdateSal(HashMap<String, String> params) throws Throwable;
	
}
