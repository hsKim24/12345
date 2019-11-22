package com.gd.heywe.web.as.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.as.dao.IASDao_SH;

@Service
public class ASServiceSH implements IASServiceSH{
	
	@Autowired
	public IASDao_SH iASDao;

	@Override
	public String getMsg(String a) {
		return "Hello!";
	}

	@Override
	public int getLectCnt(HashMap<String, String> params) throws Throwable {
		return iASDao.getLectCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getLectList(HashMap<String, String> params) throws Throwable {
		return iASDao.getLectList(params);
	}

	@Override
	public HashMap<String, String> getLectDtl(HashMap<String, String> params) throws Throwable {
		return iASDao.getLectDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getAfcList(HashMap<String, String> params2) throws Throwable {
		return iASDao.getAfcList(params2);
	}

	@Override
	public void regiLect(HashMap<String, String> params) throws Throwable {
		iASDao.regiLect(params);
		
	}

	@Override
	public List<HashMap<String, String>> getAsSearchList(HashMap<String, String> params) throws Throwable {
		return iASDao.getAsSearchList(params);
		
	}

	@Override
	public List<HashMap<String, String>> getplaceList(HashMap<String, String> params) throws Throwable {
		return iASDao.getplaceList(params);
	}

	@Override
	public List<HashMap<String, String>> gettchrList(HashMap<String, String> params) throws Throwable {
		return iASDao.gettchrList(params);
	}

	@Override
	public List<HashMap<String, String>> getendLectList(HashMap<String, String> params) throws Throwable {
		return iASDao.getendLectList(params);
	}

	@Override
	public int getendLectCnt(HashMap<String, String> params) throws Throwable {
		return iASDao.getendLectCnt(params);
	}

	@Override
	public int getscheLectCnt(HashMap<String, String> params) throws Throwable {
		return iASDao.getscheLectCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getscheLectList(HashMap<String, String> params) throws Throwable {
		return iASDao.getscheLectList(params);
	}

	@Override
	public void regiApply(HashMap<String, String> params) throws Throwable {
		iASDao.regiApply(params);
		
	}

	@Override
	public int getplaceInfoCnt(HashMap<String, String> params) throws Throwable {
		return iASDao.getplaceInfoCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getplaceInfoList(HashMap<String, String> params) throws Throwable {
		return iASDao.getplaceInfoList(params);
	}

	@Override
	public int tchrLctCnt(HashMap<String, String> params) throws Throwable {
		return iASDao.tchrLctCnt(params);
	}

	@Override
	public List<HashMap<String, String>> gettchrLectList(HashMap<String, String> params) throws Throwable {
		return iASDao.gettchrLectList(params);
	}

	@Override
	public void regiPlace(HashMap<String, String> params) throws Throwable {
		iASDao.regiPlace(params);
	}

	@Override
	public void regiTchr(HashMap<String, String> params) throws Throwable {
		iASDao.regiTchr(params);
	}

	@Override
	public int deleteLect(HashMap<String, String> params) throws Throwable {
		return iASDao.deleteLect(params);
	}

	@Override
	public int deletAfc(HashMap<String, String> params) throws Throwable {
		return iASDao.deletAfc(params);
	}

	@Override
	public int droplect(HashMap<String, String> params) throws Throwable {
		return iASDao.droplect(params);
	}

	@Override
	public int roomnumchek(HashMap<String, String> params) throws Throwable {
		return iASDao.roomnumchek(params);
	}

	@Override
	public int phonenumchek(HashMap<String, String> params) throws Throwable {
		return iASDao.phonenumchek(params);
	}

	@Override
	public HashMap<String, String> placeDtl(HashMap<String, String> params) throws Throwable {
		return iASDao.placeDtl(params);
	}

	@Override
	public void updatePlace(HashMap<String, String> params) throws Throwable {
		iASDao.updatePlace(params);
		
	}

	@Override
	public void regiCareer(HashMap<String, String> params) throws Throwable {
		iASDao.regiCareer(params);
		
	}

	@Override
	public int careerChek(HashMap<String, String> params) throws Throwable {
		return iASDao.careerChek(params);
	}

	@Override
	public HashMap<String, String> getchrDtl(HashMap<String, String> params) throws Throwable {
		return iASDao.getchrDtl(params);
	}

	@Override
	public List<HashMap<String, String>> careerList(HashMap<String, String> params) throws Throwable {
		return iASDao.careerList(params);
	}

	

}
