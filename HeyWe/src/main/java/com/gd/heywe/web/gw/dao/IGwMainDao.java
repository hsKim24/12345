package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

public interface IGwMainDao {

	public void insertSch(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> selectSchList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> allSchList(HashMap<String, String> params) throws Throwable;

	public void delectSch(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> selectMainApvDoc(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> selectArticleList(HashMap<String, String> params) throws Throwable;

}
