package com.gd.heywe.web.common.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.common.dao.ICommonDao;

@Service
public class CommonService implements ICommonService {
	@Autowired
	public ICommonDao iCommonDao;

	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable {
		return iCommonDao.loginCheck(params);
	}
	
	/*
	 menuAuthCheck
	 param : authNo - 권한번호
	       : menuNo - 메뉴번호
	 return : 권한타입 - 0(권한없음), 1(읽기), 2(읽기,쓰기)
	 */
	@Override
	public String menuAuthCheck(String authNo, String menuNo) throws Throwable {
		HashMap<String, String> params = new HashMap<String, String>();
		
		params.put("authNo", authNo);
		params.put("menuNo", menuNo);
		
		return iCommonDao.menuAuthCheck(params);
	}

	@Override 
	public List<HashMap<String, String>> getTopMenu(String authNo) throws Throwable {
		return iCommonDao.getTopMenu(authNo);
	}

	@Override
	public List<HashMap<String, String>> getLeftMenu(HashMap<String, String> params) throws Throwable {
		return iCommonDao.getLeftMenu(params);
	}

	@Override
	public List<HashMap<String, String>> getCmnCdAjax(int cdL) throws Throwable {
		return iCommonDao.getCmnCdAjax(cdL);
	}

	@Override
	public List<HashMap<String, String>> selectCommonSchList(HashMap<String, String> params) throws Throwable {
		return iCommonDao.selectCommonSchList(params);
	}

	@Override
	public void deleteCommonSch(HashMap<String, String> params) throws Throwable {
		iCommonDao.deleteCommonSch(params);
	}

	@Override
	public void insertCommonSch(HashMap<String, String> params) throws Throwable {
		iCommonDao.insertCommonSch(params);
	}
	
	@Override
	public List<HashMap<String, String>> getArticle(HashMap<String, String> params) throws Throwable {
		
		return iCommonDao.getArticle(params);
	}

	@Override
	public int getNotiCnt(HashMap<String, String> params) throws Throwable {
		return iCommonDao.getNotiCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getNotiDtl(HashMap<String, String> params) throws Throwable {
		return iCommonDao.getNotiDtl(params);
	}
}
