package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gd.heywe.util.Utils;

@Repository
public class HRMgntServiceDao implements IHRMgntServiceDao{
   @Autowired
   public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getVacaStd(String sEmpNo) throws Throwable {
		
		return sqlSession.selectList("HRMgnt.getVacaStd",sEmpNo);
	}

	@Override
	public List<HashMap<String, String>> getDeptList() throws Throwable {
		return sqlSession.selectList("HRMgnt.getDeptList");
	}

	@Override
	public List<HashMap<String, String>> getPosiList() throws Throwable {
		return sqlSession.selectList("HRMgnt.getPosiList");
	}

	@Override
	public List<HashMap<String, String>> getEmpSearch1Popup(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("HRMgnt.getEmpSearch1Popup",params);
	}

	@Override
	public void insertvacaReq(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		 sqlSession.insert("HRMgnt.insertvacaReq",params);
	}

	@Override
	public HashMap<String, String> checkLeftDate(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRMgnt.checkLeftDate",params);
	}

	@Override
	public List<HashMap<String, String>> leftVacaList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return  sqlSession.selectList("HRMgnt.leftVacaList",params);
	}

	@Override
	public int empCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRMgnt.empCnt",params);
	}

	@Override
	public int vacaStdListCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRMgnt.vacaStdListCnt",params);
	}

	@Override
	public List<HashMap<String, String>> vacaStdList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRMgnt.vacaStdList",params);
	}

	@Override
	public int delVacaStd(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("HRMgnt.delVacaStd",params);
	}

	@Override
	public int updateVacaStd(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("HRMgnt.updateVacaStd",params);
	}

	@Override
	public void insertVacaStd(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		sqlSession.insert("HRMgnt.insertVacaStd",params);
	}

	@Override
	public List<HashMap<String, String>> VacaReqRecList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRMgnt.VacaReqRecList",params);
	}

	@Override
	public int HRcancelVacaReqAjax(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.delete("HRMgnt.HRcancelVacaReqAjax",params);
	}

	@Override
	public List<HashMap<String, String>> getcalList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return Utils.toLowerListMapKey(sqlSession.selectList("HRMgnt.getcalList",params));
	}

	@Override
	public List<HashMap<String, String>> getVacaReqDtl(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HRMgnt.getVacaReqDtl",params);
	}

	@Override
	public int HRgetconnectNo(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRMgnt.HRgetconnectNo",params);
	}

	@Override
	public String HRgetApvEmpNo(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HRMgnt.HRgetApvEmpNo",params);
	}

   
}