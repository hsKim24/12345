package com.gd.heywe.web.as.dao;

import java.util.HashMap;
import java.util.List;

public interface iAsDao_SB {

	public List<HashMap<String, String>> getAsList(HashMap<String, String> params)throws Throwable;

	public int getAsListCnt(HashMap<String, String> params)throws Throwable;

	public void insertAs(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAsSearchList(HashMap<String, String> params)throws Throwable;

	public int getAsSearchListCnt(HashMap<String, String> params)throws Throwable;

	public int UpdateAs(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getAsDtl(HashMap<String, String> params)throws Throwable;

	public int deleteAs(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAsProjList(HashMap<String, String> params)throws Throwable;

	public int getAsProjListCnt(HashMap<String, String> params)throws Throwable;

	public void insertAsProj(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjSol(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjMk(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjArea(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjPm(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getAsProjListDtl(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAsProjListSubDtl(HashMap<String, String> params)throws Throwable;

	public int getAsProjListDtlCnt(HashMap<String, String> params)throws Throwable;

	public int UpdateAsProj(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getAsProjListSide(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjAddEmp(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjListTask(HashMap<String, String> params)throws Throwable;

	public void insertAsProjAdd(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getProjListAddReload(HashMap<String, String> params)throws Throwable;

	public int deleteAsProjDelEmp(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAsdeList(HashMap<String, String> params)throws Throwable;

	public int getAsdeListCnt(HashMap<String, String> params)throws Throwable;

	public int UpdateAsListDel(HashMap<String, String> params)throws Throwable;

	public int deleteAsProjListDel(HashMap<String, String> params)throws Throwable;

	public int deleteAsProjListDelFirst(HashMap<String, String> params)throws Throwable;

	public int itemNoCheck(HashMap<String, String> params)throws Throwable;





}
