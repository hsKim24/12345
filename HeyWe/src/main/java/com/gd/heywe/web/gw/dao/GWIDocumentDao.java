package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

public interface GWIDocumentDao {

	public List<HashMap<String, String>> getDocBoardList(HashMap<String, String> params) throws Throwable;

	public int getDocBoardCnt(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> DocDtl(HashMap<String, String> params) throws Throwable;

	public void DocWrite(HashMap<String, String> params) throws Throwable;

	public int DocDel(HashMap<String, String> params) throws Throwable;

	public void DocUpdate(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable;

	public int DocHitUpdate(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> DocDtlAtt(HashMap<String, String> params) throws Throwable;

}
