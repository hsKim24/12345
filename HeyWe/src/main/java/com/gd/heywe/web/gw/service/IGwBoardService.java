package com.gd.heywe.web.gw.service;

import java.util.HashMap;
import java.util.List;

public interface IGwBoardService {

	public List<HashMap<String, String>> getArticle(HashMap<String, String> params)throws Throwable;

	public int getArticleCnt(HashMap<String, String> params)throws Throwable;

	public void insertWrite(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> authCheck(HashMap<String, String> params) throws Throwable;

	public int AritcleHit(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> ArticleDtl(HashMap<String, String> params)throws Throwable;

	public void ArticleUpdate(HashMap<String, String> params) throws Throwable;

	public int ArticleDelete(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> fileDown(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> ArticleDtlAtt(HashMap<String, String> params)throws Throwable;

}
