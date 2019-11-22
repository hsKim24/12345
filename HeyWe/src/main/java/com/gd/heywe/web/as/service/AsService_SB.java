package com.gd.heywe.web.as.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.as.dao.iAsDao_SB;

@Service
public class AsService_SB implements iAsService_SB {
	@Autowired
	public iAsDao_SB iasDao;

	@Override
	public List<HashMap<String, String>> getAsList(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsList(params);
	}

	@Override
	public int getAsListCnt(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsListCnt(params);
	}

	@Override
	public void insertAs(HashMap<String, String> params) throws Throwable {
		iasDao.insertAs(params);
	}

	@Override
	public List<HashMap<String, String>> getAsSearchList(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsSearchList(params);
	}

	@Override
	public int getAsSearchListCnt(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsSearchListCnt(params);
	}

	@Override
	public int UpdateAs(HashMap<String, String> params) throws Throwable {
		return iasDao.UpdateAs(params);
	}

	@Override
	public HashMap<String, String> getAsDtl(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsDtl(params);
	}

	@Override
	public int deleteAs(HashMap<String, String> params) throws Throwable {
		return iasDao.deleteAs(params);
	}

	@Override
	public List<HashMap<String, String>> getAsProjList(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsProjList(params);
	}

	@Override
	public int getAsProjListCnt(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsProjListCnt(params);
	}

	@Override
	public void insertAsProj(HashMap<String, String> params) throws Throwable {
		iasDao.insertAsProj(params);
	}

	@Override
	public List<HashMap<String, String>> getProjSol(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjSol(params);
	}

	@Override
	public List<HashMap<String, String>> getProjMk(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjMk(params);
	}

	@Override
	public List<HashMap<String, String>> getProjArea(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjArea(params);
	}

	@Override
	public List<HashMap<String, String>> getProjPm(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjPm(params);
	}

	@Override
	public HashMap<String, String> getAsProjListDtl(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsProjListDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getAsProjListSubDtl(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsProjListSubDtl(params);
	}

	@Override
	public int getAsProjListDtlCnt(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsProjListDtlCnt(params);
	}

	@Override
	public int UpdateAsProj(HashMap<String, String> params) throws Throwable {
		return iasDao.UpdateAsProj(params);
	}

	@Override
	public HashMap<String, String> getAsProjListSide(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsProjListSide(params);
	}

	@Override
	public List<HashMap<String, String>> getProjAddEmp(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjAddEmp(params);
	}

	@Override
	public List<HashMap<String, String>> getProjListTask(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjListTask(params);
	}

	@Override
	public void insertAsProjAdd(HashMap<String, String> params) throws Throwable {
		iasDao.insertAsProjAdd(params);
	}

	@Override
	public List<HashMap<String, String>> getProjListAddReload(HashMap<String, String> params) throws Throwable {
		return iasDao.getProjListAddReload(params);
	}

	@Override
	public int deleteAsProjDelEmp(HashMap<String, String> params) throws Throwable {
		return iasDao.deleteAsProjDelEmp(params);
	}

	@Override
	public List<HashMap<String, String>> getAsdeList(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsdeList(params);
	}

	@Override
	public int getAsdeListCnt(HashMap<String, String> params) throws Throwable {
		return iasDao.getAsdeListCnt(params);
	}

	@Override
	public int UpdateAsListDel(HashMap<String, String> params) throws Throwable {
		return iasDao.UpdateAsListDel(params);
	}

	@Override
	public int deleteAsProjListDel(HashMap<String, String> params) throws Throwable {
		return iasDao.deleteAsProjListDel(params);
	}

	@Override
	public int deleteAsProjListDelFirst(HashMap<String, String> params) throws Throwable {
		return iasDao.deleteAsProjListDelFirst(params);
	}

	@Override
	public int itemNoCheck(HashMap<String, String> params) throws Throwable {
		return iasDao.itemNoCheck(params);
	}

}
