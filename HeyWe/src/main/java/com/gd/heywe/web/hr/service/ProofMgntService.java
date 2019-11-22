package com.gd.heywe.web.hr.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.hr.dao.IProofMgntDao;

@Service
public class ProofMgntService implements IProofMgntService {
	@Autowired
	public IProofMgntDao iProofMgntDao;

	@Override
	public HashMap<String, String> getEmpDtl(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.getEmpDtl(params);
	}

	@Override
	public HashMap<String, String> getCoDtl(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.getCoDtl(params);
	}

	@Override
	public HashMap<String, String> getPlaceDtl(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.getPlaceDtl(params);
	}

	@Override
	public HashMap<String, String> date(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.date(params);
	}

	@Override
	public int insertInoffProofData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub

		return iProofMgntDao.insertInoffProofData(params);
	}

	@Override
	public int insertCareerProofData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.insertCareerProofData(params);
	}

	@Override
	public int RetireCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub

		return iProofMgntDao.RetireCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.getDeptList(params);
	}

	@Override
	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.getPosiList(params);
	}

	@Override
	public List<HashMap<String, String>> RetireList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.RetireList(params);
	}

	@Override
	public HashMap<String, String> RetireDtlData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.RetireDtlData(params);
	}

	@Override
	public int insertRetireProofData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iProofMgntDao.insertRetireProofData(params);
	}
	
	@Override
	public List<HashMap<String, String>> ReqCurrent(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.ReqCurrent(params);
	}

	@Override
	public HashMap<String, String> RetireProof(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.RetireProof(params);

	}

	@Override
	public HashMap<String, String> RetireProofCo(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.RetireProofCo(params);
	}

	@Override
	public List<HashMap<String, String>> ReqResult(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.ReqResult(params);
	}

	@Override
	public int ReqCurrentCnt(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.ReqCurrentCnt(params);
	}

	@Override
	public HashMap<String, String> RetireProofDtl(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.RetireProofDtl(params);
	}

	@Override
	public int proofapv(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.proofapv(params);
	}

	@Override
	public int proofrej(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.proofrej(params);
	}

	@Override
	public int ReqResultCnt(HashMap<String, String> params) throws Throwable {
		return iProofMgntDao.ReqResultCnt(params);
	 
	}
}
