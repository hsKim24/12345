package com.gd.heywe.web.as.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ASDao_SH implements IASDao_SH {
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getLectCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.getLectCnt" , params);
	}

	@Override
	public List<HashMap<String, String>> getLectList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.getLectList" , params);
	}

	@Override
	public HashMap<String, String> getLectDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.getLectDtl" , params);
	}

	@Override
	public List<HashMap<String, String>> getAfcList(HashMap<String, String> params2) throws Throwable {
		return sqlSession.selectList("ASSH.getAfcList" , params2);
	}

	@Override
	public void regiLect(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ASSH.regiLect",params);
		
	}

	@Override
	public List<HashMap<String, String>> getAsSearchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.getAsSearchList" , params);
	}

	@Override
	public List<HashMap<String, String>> getplaceList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.getplaceList" , params);
		}

	@Override
	public List<HashMap<String, String>> gettchrList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.gettchrList" , params);
	}

	@Override
	public List<HashMap<String, String>> getendLectList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.getendLectList" , params);
	}

	@Override
	public int getendLectCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.getendLectCnt" , params);
	}

	@Override
	public int getscheLectCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.getscheLectCnt" , params);
	}

	@Override
	public List<HashMap<String, String>> getscheLectList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.getscheLectList" , params);
	}

	@Override
	public void regiApply(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ASSH.regiApply",params);
		
	}

	@Override
	public int getplaceInfoCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.getplaceInfoCnt" , params);
	}

	@Override
	public List<HashMap<String, String>> getplaceInfoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.getplaceInfoList" , params);
	}

	@Override
	public int tchrLctCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.tchrLctCnt" , params);
	}

	@Override
	public List<HashMap<String, String>> gettchrLectList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.gettchrLectList" , params);
	}

	@Override
	public void regiPlace(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ASSH.regiPlace",params);
		
	}

	@Override
	public void regiTchr(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ASSH.regiTchr",params);
		
	}

	@Override
	public int deleteLect(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("ASSH.deleteLect", params);
	}

	@Override
	public int deletAfc(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("ASSH.deletAfc", params);
	}

	@Override
	public int droplect(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("ASSH.droplect", params);
	}

	@Override
	public int roomnumchek(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.roomnumchek" , params);
	}

	@Override
	public int phonenumchek(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.phonenumchek" , params);
	}

	@Override
	public HashMap<String, String> placeDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.placeDtl" , params);
	}

	@Override
	public void updatePlace(HashMap<String, String> params) throws Throwable {
		sqlSession.update("ASSH.updatePlace",params);
		
	}

	@Override
	public void regiCareer(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ASSH.regiCareer",params);
		
	}

	@Override
	public int careerChek(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.careerChek" , params);
	}

	@Override
	public HashMap<String, String> getchrDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ASSH.getchrDtl" , params);
	}

	@Override
	public List<HashMap<String, String>> careerList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ASSH.careerList" , params);
	}
}
