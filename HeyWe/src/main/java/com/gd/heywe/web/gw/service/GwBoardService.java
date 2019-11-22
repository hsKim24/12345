package com.gd.heywe.web.gw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.gw.dao.IGwBoardDao;

@Service
public class GwBoardService implements IGwBoardService{
	@Autowired
	public IGwBoardDao iGwBoardDao;

	@Override
	public List<HashMap<String, String>> getArticle(HashMap<String, String> params) throws Throwable{
		return iGwBoardDao.getArticle(params);
	}

	@Override
	public int getArticleCnt(HashMap<String, String> params) throws Throwable{
		return iGwBoardDao.getArticleCnt(params);
	}

	@Override
	public void insertWrite(HashMap<String, String> params) throws Throwable {
		iGwBoardDao.insertWrite(params);
	}
	
	//공지권한체크
	@Override
	public HashMap<String, String> authCheck(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.authCheck(params);
	}
	//조회수
	@Override
	public int AritcleHit(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.AritcleHit(params);
	}

	@Override
	public HashMap<String, String> ArticleDtl(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.ArticleDtl(params);
	}

	@Override
	public void ArticleUpdate(HashMap<String, String> params) throws Throwable {
		iGwBoardDao.ArticleUpdate(params);
	}

	@Override
	public int ArticleDelete(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.ArticleDelete(params);
	}

	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.loginCheck(params);
	}

	@Override
	public List<HashMap<String, String>> fileDown(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.fileDown(params);
	}

	@Override
	public List<HashMap<String, String>> ArticleDtlAtt(HashMap<String, String> params) throws Throwable {
		return iGwBoardDao.ArticleDtlAtt(params);
	}


}
