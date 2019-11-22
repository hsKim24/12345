package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

public interface IGwApvDao {

	public int getApvDocCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getApvDocList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getApvTypeDivList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getApvDocTypeList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getApvDocType(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getSApvLineNames(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getSApvLineList(HashMap<String, String> params) throws Throwable;

	public void saveNewApvLine(HashMap<String, String> params) throws Throwable;

	public int delApvLine(HashMap<String, String> params) throws Throwable;
	
	public HashMap<String, String> getApvDocDtl(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, String>> getApverList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getApvDocDtlMenList(HashMap<String, String> params) throws Throwable;

	public void reportApv(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getOpinion(HashMap<String, String> params) throws Throwable;

	public void deleteApvDoc(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getAttFileList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getApvState(HashMap<String, String> params) throws Throwable;

	public void doApv(HashMap<String, String> params) throws Throwable;

	public int updateApv(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getApvComplete(HashMap<String, String> params) throws Throwable;

	public int getSavedApvLineCnt(HashMap<String, String> params) throws Throwable;

}
