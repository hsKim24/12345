package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

public interface IProofMgntDao {

	public HashMap<String, String> getEmpDtl(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getCoDtl(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getPlaceDtl(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> date(HashMap<String, String> params) throws Throwable;

	public int insertInoffProofData(HashMap<String, String> params) throws Throwable;

	public int insertCareerProofData(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable;

	public int RetireCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> RetireList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> RetireDtlData(HashMap<String, String> params);

	public int insertRetireProofData(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, String>> ReqCurrent(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> RetireProof(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> RetireProofCo(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> ReqResult(HashMap<String, String> params)throws Throwable;

	public int ReqCurrentCnt(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> RetireProofDtl(HashMap<String, String> params)throws Throwable;

	public int proofapv(HashMap<String, String> params)throws Throwable;

	public int proofrej(HashMap<String, String> params)throws Throwable;

	public int ReqResultCnt(HashMap<String, String> params)throws Throwable;

}
