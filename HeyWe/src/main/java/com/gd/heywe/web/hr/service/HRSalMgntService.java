package com.gd.heywe.web.hr.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.hr.dao.IHRSalMgntDao;

@Service
public class HRSalMgntService implements IHRSalMgntService{

	@Autowired
	public IHRSalMgntDao iHRSalMgntDao;

	@Override
	public List<HashMap<String, String>> HRGeuntaeList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRGeuntaeList(params);
	}

	@Override
	public int HRgetGeuntaeCnt() throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRgetGeuntaeCnt();
	}

	@Override
	public int HRaddGeuntae(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRaddGeuntae(params);
	}

	@Override
	public int HRdelGeuntae(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRdelGeuntae(params);
	}

	@Override
	public int HRupdateGeuntae(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRupdateGeuntae(params);
	}

	@Override
	public List<HashMap<String, String>> HRGetSalCalcList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRGetSalCalcList(params);
	}

	@Override
	public int HRsalCalcCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRsalCalcCnt(params);
	}

	@Override
	public List<HashMap<String, String>> HRGetApvSalCalcM() throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRGetApvSalCalcM();
	}

	@Override
	public int setEmpApvChange(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.setEmpApvChange(params);
	}

	@Override
	public List<HashMap<String, String>> HRgetEmpSalList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.HRgetEmpSalList(params);
	}

	@Override
	public List<HashMap<String, String>> getStdList() throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.getStdList();
	}

	@Override
	public int oneInsertSal(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.oneInsertSal(params);
	}

	@Override
	public int oneUpdateSal(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iHRSalMgntDao.oneUpdateSal(params);
	}

	
	
	
}
