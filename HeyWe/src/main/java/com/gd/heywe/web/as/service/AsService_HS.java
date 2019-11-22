package com.gd.heywe.web.as.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.as.dao.IAsDao_HS;

@Service
public class AsService_HS implements IAsService_HS {
	@Autowired
	public IAsDao_HS iAsDao_HS;

	@Override
	public int ASGetSolCnt(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.ASGetSolCnt(params);
	}

	@Override
	public List<HashMap<String, String>> ASGetSolList(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.ASGetSolList(params);
	}

	@Override
	public HashMap<String, String> ASGetSolDtl(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.ASGetSolDtl(params);
	}

	@Override
	public void ASRegiSol(HashMap<String, String> params) throws Throwable {
		iAsDao_HS.ASRegiSol(params);
		
	}

	@Override
	public int ASGetEmpCnt(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.ASGetEmpCnt(params);
	}

	@Override
	public List<HashMap<String, String>> ASGetEmpList(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.ASGetEmpList(params);
	}

	@Override
	public void ASRegiEmp(HashMap<String, String> params) throws Throwable {
		iAsDao_HS.ASRegiEmp(params);
	}

	@Override
	public HashMap<String, String> AsSolDtl(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsSolDtl(params);
	}

	@Override
	public int AsSolUpdate(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsSolUpdate(params);
		
	}

	@Override
	public int AsSolDelete(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsSolDelete(params);
	}

	@Override
	public HashMap<String, String> AsEmpDtl(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsEmpDtl(params);
	}

	@Override
	public int AsEmpUpdate(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsEmpUpdate(params);
	}

	@Override
	public int AsEmpDelete(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsEmpDelete(params);
	}

	@Override
	public void ASRegiCar(HashMap<String, String> params) throws Throwable {
		iAsDao_HS.ASRegiCar(params);
		
	}

	@Override
	public List<HashMap<String, String>> AsTableDtl(HashMap<String, String> params) throws Throwable {
		return iAsDao_HS.AsTableDtl(params);
	}

}
