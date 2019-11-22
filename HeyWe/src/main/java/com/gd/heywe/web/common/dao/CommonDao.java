package com.gd.heywe.web.common.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gd.heywe.util.Utils;

@Repository
public class CommonDao implements ICommonDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("common.loginCheck", params);
	}

	@Override
	public String menuAuthCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("common.menuAuthCheck", params);
	}

	@Override
	public List<HashMap<String, String>> getTopMenu(String authNo) throws Throwable {
		return sqlSession.selectList("common.getTopMenu", authNo);
	}

	@Override
	public List<HashMap<String, String>> getLeftMenu(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("common.getLeftMenu", params);
	}

	@Override
	public List<HashMap<String, String>> getCmnCdAjax(int cdL) throws Throwable {
		return sqlSession.selectList("common.getCmnCdAjax", cdL);
	}

	@Override
	public List<HashMap<String, String>> selectCommonSchList(HashMap<String, String> params) throws Throwable {
		return Utils.toLowerListMapKey(sqlSession.selectList("common.selectCommonSchList", params));
	}

	@Override
	public void deleteCommonSch(HashMap<String, String> params) throws Throwable {
		sqlSession.update("common.deleteCommonSch", params);
	}

	@Override
	public void insertCommonSch(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("common.insertCommonSch", params);
	}
	
	@Override
	public List<HashMap<String, String>> getArticle(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("common.getArticle", params);
	}

	@Override
	public int getNotiCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("common.getNotiCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getNotiDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("common.getNotiDtl", params);
	}
}

