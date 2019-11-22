package com.gd.heywe.web.as.dao;

import java.util.HashMap;
import java.util.List;

public interface IASDao_SH {

	int getLectCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getLectList(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getLectDtl(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAfcList(HashMap<String, String> params2)throws Throwable;

	public void regiLect(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAsSearchList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getplaceList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> gettchrList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getendLectList(HashMap<String, String> params)throws Throwable;

	int getendLectCnt(HashMap<String, String> params)throws Throwable;

	int getscheLectCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getscheLectList(HashMap<String, String> params)throws Throwable;

	public void regiApply(HashMap<String, String> params)throws Throwable;

	public int getplaceInfoCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getplaceInfoList(HashMap<String, String> params)throws Throwable;

	public int tchrLctCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> gettchrLectList(HashMap<String, String> params)throws Throwable;

	public void regiPlace(HashMap<String, String> params)throws Throwable;

	public void regiTchr(HashMap<String, String> params)throws Throwable;

	public int deleteLect(HashMap<String, String> params)throws Throwable;

	public int deletAfc(HashMap<String, String> params)throws Throwable;

	public int droplect(HashMap<String, String> params)throws Throwable;

	public int roomnumchek(HashMap<String, String> params)throws Throwable;

	public int phonenumchek(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> placeDtl(HashMap<String, String> params)throws Throwable;

	public void updatePlace(HashMap<String, String> params)throws Throwable;

	public void regiCareer(HashMap<String, String> params)throws Throwable;

	public int careerChek(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getchrDtl(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> careerList(HashMap<String, String> params)throws Throwable;

}
