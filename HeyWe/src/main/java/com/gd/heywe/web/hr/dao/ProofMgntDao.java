package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProofMgntDao implements IProofMgntDao {
	@Autowired SqlSession sqlSession;

	@Override
	public HashMap<String, String> getEmpDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Proof.getEmpDtl",params);
	}

	@Override
	public HashMap<String, String> getCoDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Proof.getCoDtl",params);
	}

	@Override
	public HashMap<String, String> getPlaceDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Proof.getPlaceDtl",params);
	}

	@Override
	public HashMap<String, String> date(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Proof.date",params);
	}

	@Override
	public int insertInoffProofData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("Proof.insertInoffProofData",params);
	}

	@Override
	public int insertCareerProofData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("Proof.insertCareerProofData",params);
	}
	@Override
	public int RetireCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Proof.RetireCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Proof.getDeptList",params);
	}


	@Override
	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Proof.getPosiList",params);
	}

	@Override
	public List<HashMap<String, String>> RetireList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Proof.RetireList",params);
	}

	@Override
	public HashMap<String, String> RetireDtlData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Proof.RetireDtlData",params);
	}

	@Override
	public int insertRetireProofData(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("Proof.insertRetireProofData",params);
	}
	
	@Override
	public List<HashMap<String, String>> ReqCurrent(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Proof.ReqCurrent", params);
	}

	@Override
	public HashMap<String, String> RetireProof(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Proof.RetireProof", params);
	}

	@Override
	public HashMap<String, String> RetireProofCo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Proof.RetireProofCo", params);
	}

	@Override
	public List<HashMap<String, String>> ReqResult(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Proof.ReqResult", params);
	}

	@Override
	public int ReqCurrentCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Proof.ReqCurrentCnt", params);
	}

	@Override
	public HashMap<String, String> RetireProofDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Proof.RetireProofDtl", params);

	}

	@Override
	public int proofapv(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Proof.proofapv", params);
	}

	@Override
	public int proofrej(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Proof.proofrej", params);
	}

	@Override
	public int ReqResultCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Proof.ReqResultCnt", params);
	}
}
