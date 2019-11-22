package com.gd.heywe.web.gw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.gw.dao.IGwMainDao;

@Service
public class GwMainService implements IGwMainService{

	@Autowired
	IGwMainDao igwMainDao;
	
	@Override
	public void insertSch(HashMap<String, String> params) throws Throwable{
		igwMainDao.insertSch(params);
	}
	
	@Override
	public List<HashMap<String, String>> selectSchList(HashMap<String, String> params) throws Throwable{
		return igwMainDao.selectSchList(params);
	}
	@Override
	public List<HashMap<String, String>> allSchList(HashMap<String, String> params) throws Throwable {
		return igwMainDao.allSchList(params);
	}
	@Override
	public void deleteSch(HashMap<String, String> params) throws Throwable{
		igwMainDao.delectSch(params);
	}

	@Override
	public List<HashMap<String, String>> selectMainApvDoc(HashMap<String, String> params) throws Throwable{
		return igwMainDao.selectMainApvDoc(params);
	}
	@Override
	public List<HashMap<String, String>> selectArticleList(HashMap<String, String> params) throws Throwable{
		return igwMainDao.selectArticleList(params);
	}

		


}
