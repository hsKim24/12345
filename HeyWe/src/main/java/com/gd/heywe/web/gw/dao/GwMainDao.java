package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GwMainDao implements IGwMainDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void insertSch(HashMap<String, String> params) throws Throwable{
		sqlSession.insert("gw.insertSch",params);
	}

	@Override
	public List<HashMap<String, String>> selectSchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("gw.selectSchList", params);
	}

	@Override
	public List<HashMap<String, String>> allSchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("gw.allSchList", params);
	}

	@Override
	public void delectSch(HashMap<String, String> params) throws Throwable {
		sqlSession.update("gw.delectSch", params);
	}

	@Override
	public List<HashMap<String, String>> selectMainApvDoc(HashMap<String, String> params) {
		return sqlSession.selectList("gw.selectMainApvDoc", params);
	}

	@Override
	public List<HashMap<String, String>> selectArticleList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("gw.selectArticleList", params);
	}
}
