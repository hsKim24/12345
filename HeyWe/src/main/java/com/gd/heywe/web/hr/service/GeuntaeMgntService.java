package com.gd.heywe.web.hr.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.hr.dao.IGeuntaeMgntDao;

@Service
public class GeuntaeMgntService implements IGeuntaeMgntService{
	@Autowired
	public IGeuntaeMgntDao iGeuntaeMgntDao;
	
	@Override
	public List<HashMap<String, String>> getGeuntaeName() throws Throwable {
		return iGeuntaeMgntDao.getGeuntaeName();
	}

	@Override
	public int geuntaeOverlapCheck(HashMap<String, String> params) throws Throwable {
		return iGeuntaeMgntDao.geuntaeOverlapCheck(params);
	}

	@Override
	public void geuntaeAdd(HashMap<String, String> params) throws Throwable {
		iGeuntaeMgntDao.geuntaeAdd(params);
	}

	@Override
	public int geuntaeUpdate(HashMap<String, String> params) throws Throwable {
		return iGeuntaeMgntDao.geuntaeUpdate(params);
	}

	@Override
	public int geuntaeDeleteCheck(HashMap<String, String> params) throws Throwable {
		return iGeuntaeMgntDao.geuntaeDeleteCheck(params);
	}

	@Override
	public int geuntaeDelete(HashMap<String, String> params) throws Throwable {
		return iGeuntaeMgntDao.geuntaeDelete(params);
	}

	@Override
	public int geuntaeUpdateOverlapCheck(HashMap<String, String> params) throws Throwable {
		return iGeuntaeMgntDao.geuntaeUpdateOverlapCheck(params);
	}

	@Override
	public List<HashMap<String, Object>> addWorkGeuntaeList() throws Throwable {
		return iGeuntaeMgntDao.addWorkGeuntaeList();
	}

	@Override
	public void addWorkReg(HashMap<String, String> params) throws Throwable {
		iGeuntaeMgntDao.addWorkReg(params);
	}
	
	@Override
	public List<HashMap<String, String>> getGeunTaeList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.getGeunTaeList(params);
	}

	@Override
	public int getGeunTaeCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.getGeunTaeCnt(params);
	}

	@Override
	public HashMap<String, String> getGeunTaeData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.getGeunTaeData(params);
	}

	@Override
	public List<HashMap<String, String>> GeunTaeList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.GeunTaeList(params);
	}

	@Override
	public List<HashMap<String, String>> getGeunTaeAdminList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.getGeunTaeAdminList(params);
	}

	@Override
	public int getGeunTaeAdminCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.getGeunTaeAdminCnt(params);
	}

	@Override
	public List<HashMap<String, String>> DeptList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.DeptList(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) {
		return iGeuntaeMgntDao.getEmpSearchPopup(params);
	}

	@Override
	public int insertGeunTaeData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iGeuntaeMgntDao.insertGeunTaeData(params);
	}
}
