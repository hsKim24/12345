package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HRSalMgntDao implements IHRSalMgntDao{
   @Autowired
   public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> HRGeuntaeList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRSalMgnt.HRGeuntaeList",params);
	}

	@Override
	public int HRgetGeuntaeCnt() throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRSalMgnt.HRgetGeuntaeCnt");
	}

	@Override
	public int HRaddGeuntae(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("HRSalMgnt.HRaddGeuntae",params);
	}

	@Override
	public int HRdelGeuntae(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("HRSalMgnt.HRdelGeuntae",params);
	}

	@Override
	public int HRupdateGeuntae(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("HRSalMgnt.HRupdateGeuntae",params);
	}

	@Override
	public List<HashMap<String, String>> HRGetSalCalcList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRSalMgnt.HRGetSalCalcList",params);
	}

	@Override
	public int HRsalCalcCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRSalMgnt.HRsalCalcCnt", params);
	}

	@Override
	public List<HashMap<String, String>> HRGetApvSalCalcM() throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRSalMgnt.HRGetApvSalCalcM");
	}

	@Override
	public int setEmpApvChange(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("HRSalMgnt.setEmpApvChange",params);
	}

	@Override
	public List<HashMap<String, String>> HRgetEmpSalList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRSalMgnt.HRgetEmpSalList",params);
	}

	@Override
	public List<HashMap<String, String>> getStdList() throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRSalMgnt.getStdList");
	}

	@Override
	public int oneInsertSal(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("HRSalMgnt.oneInsertSal",params);
	}

	@Override
	public int oneUpdateSal(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return  sqlSession.update("HRSalMgnt.oneUpdateSal",params);
	}


   
}