package com.gd.heywe.web.as.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AsDao_HS implements IAsDao_HS {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int ASGetSolCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.ASGetSolCnt",params);
	}

	@Override
	public List<HashMap<String, String>> ASGetSolList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.ASGetSolList",params);
	}

	@Override
	public HashMap<String, String> ASGetSolDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.ASGetSolDtl",params);
	}

	@Override
	public void ASRegiSol(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("as.ASRegiSol", params);
		
	}

	@Override
	public int ASGetEmpCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.ASGetEmpCnt",params);
	}

	@Override
	public List<HashMap<String, String>> ASGetEmpList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.ASGetEmpList",params);
	}

	@Override
	public void ASRegiEmp(HashMap<String, String> params) throws Throwable {
		System.out.println(params);
		sqlSession.insert("as.ASRegiEmp", params);
		sqlSession.insert("as.ASRegiQl", params);
	}

	@Override
	public HashMap<String, String> AsSolDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.AsSolDtl",params);
	}

	@Override
	public int AsSolUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("as.AsSolUpdate", params);
	}

	@Override
	public int AsSolDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("as.AsSolDelete", params);
	}

	@Override
	public HashMap<String, String> AsEmpDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.AsEmpDtl",params);
	}

	@Override
	public int AsEmpUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("as.AsEmpUpdate", params);
	}

	@Override
	public int AsEmpDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("as.AsEmpDelete", params);
	}

	@Override
	public void ASRegiCar(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("as.ASRegiCar", params);
		
	}

	@Override
	public List<HashMap<String, String>> AsTableDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.AsTableDtl",params);
	}

}
