package com.gd.heywe.web.common.service;

import java.util.HashMap;
import java.util.List;

public interface ICommonService {

	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable;
	
	public String menuAuthCheck(String authNo, String menuNo) throws Throwable;

	public List<HashMap<String, String>> getTopMenu(String authNo) throws Throwable;

	public List<HashMap<String, String>> getLeftMenu(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getCmnCdAjax(int cdL) throws Throwable;

	public List<HashMap<String, String>> selectCommonSchList(HashMap<String, String> params) throws Throwable;

	public void deleteCommonSch(HashMap<String, String> params) throws Throwable;

	public void insertCommonSch(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getArticle(HashMap<String, String> params) throws Throwable;

	public int getNotiCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getNotiDtl(HashMap<String, String> params) throws Throwable;


}
