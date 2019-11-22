package com.gd.heywe.web.gw.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.gw.dao.IGwApvDao;

@Service
public class GwApvService implements IGwApvService{
	@Autowired
	IGwApvDao iGwApvDao;

	@Override
	public int getApvDocCnt(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvDocCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getApvDocList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvDocList(params);
	}

	@Override
	public List<HashMap<String, String>> getApvTypeDivList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvTypeDivList(params);
	}

	@Override
	public List<HashMap<String, String>> getApvDocTypeList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvDocTypeList(params);
	}

	@Override
	public HashMap<String, String> getApvDocType(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvDocType(params);
	}

	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getDeptList(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getEmpList(params);
	}

	@Override
	public List<HashMap<String, String>> getSApvLineNames(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getSApvLineNames(params);
	}

	@Override
	public List<HashMap<String, String>> getSApvLineList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getSApvLineList(params);
	}

	@Override
	public void saveNewApvLine(HashMap<String, String> params) throws Throwable {
		iGwApvDao.saveNewApvLine(params);
	}

	@Override
	public int delApvLine(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.delApvLine(params);
	}

	@Override
	public HashMap<String, String> getApvDocDtl(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvDocDtl(params);
	}
	@Override
	public List<HashMap<String, String>> getApvDocDtlMenList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvDocDtlMenList(params);
	}
	@Override
	public List<HashMap<String, String>> getApverList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApverList(params);
	}


	@Override
	public void reportApv(HashMap<String, String> params) throws Throwable {
		iGwApvDao.reportApv(params);
	}

	@Override
	public HashMap<String, String> getOpinion(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getOpinion(params);
	}

	@Override
	public void deleteApvDoc(HashMap<String, String> params) throws Throwable {
		iGwApvDao.deleteApvDoc(params);
	}

	@Override
	public List<HashMap<String, String>> getAttFileList(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getAttFileList(params);
	}

	@Override
	public HashMap<String, String> getApvState(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvState(params);
	}

	@Override
	public void doApv(HashMap<String, String> params) throws Throwable {
		iGwApvDao.doApv(params);
	}

	@Override
	public int updateApv(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.updateApv(params);
	}

	@Override
	public List<HashMap<String, String>> getApvComplete(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getApvComplete(params);
	}

	@Override
	public int getSavedApvLineCnt(HashMap<String, String> params) throws Throwable {
		return iGwApvDao.getSavedApvLineCnt(params);
	}



	
	
}
