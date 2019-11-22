package com.gd.heywe.web.gw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.gw.dao.GWIDocumentDao;
@Service
public class GWDocumentService implements GWIDocumentService {
	@Autowired
	public GWIDocumentDao iDocumentDao;
	
	@Override
	public List<HashMap<String, String>> getDocBoardList(HashMap<String, String> params) throws Throwable{
		return iDocumentDao.getDocBoardList(params);
	}

	@Override
	public int getDocBoardCnt(HashMap<String, String> params) throws Throwable {
		return iDocumentDao.getDocBoardCnt(params);
	}

	@Override
	public HashMap<String, String> DocDtl(HashMap<String, String> params) throws Throwable {
		return iDocumentDao.DocDtl(params);
	}

	@Override
	public void DocWrite(HashMap<String, String> params) throws Throwable {
		iDocumentDao.DocWrite(params);
	}

	@Override
	public int DocDel(HashMap<String, String> params) throws Throwable {
		return iDocumentDao.DocDel(params);
	}

	@Override
	public void DocUpdate(HashMap<String, String> params) throws Throwable {
		iDocumentDao.DocUpdate(params);
	}

	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable {
		return iDocumentDao.loginCheck(params);
	}

	@Override
	public int DocHitUpdate(HashMap<String, String> params) throws Throwable {
		return iDocumentDao.DocHitUpdate(params);
	}

	@Override
	public List<HashMap<String, String>> DocDtlAtt(HashMap<String, String> params) throws Throwable {
		return iDocumentDao.DocDtlAtt(params);
	}

}
