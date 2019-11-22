package com.gd.heywe.web.hr.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GeuntaeMgntDao implements IGeuntaeMgntDao{
	@Autowired
	public SqlSession sqlsession;
	
	@Override
	public List<HashMap<String, String>> getGeuntaeName() throws Throwable {
		return sqlsession.selectList("GeuntaeMgnt.getGeuntaeName");
	}

	@Override
	public int geuntaeOverlapCheck(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("GeuntaeMgnt.geuntaeOverlapCheck", params);
	}

	@Override
	public void geuntaeAdd(HashMap<String, String> params) throws Throwable {
		sqlsession.insert("GeuntaeMgnt.geuntaeAdd", params);
	}

	@Override
	public int geuntaeUpdate(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("GeuntaeMgnt.geuntaeUpdate", params);
	}

	@Override
	public int geuntaeDeleteCheck(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("GeuntaeMgnt.geuntaeDeleteCheck", params);
	}

	@Override
	public int geuntaeDelete(HashMap<String, String> params) throws Throwable {
		return sqlsession.delete("GeuntaeMgnt.geuntaeDelete", params);
	}

	@Override
	public int geuntaeUpdateOverlapCheck(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("GeuntaeMgnt.geuntaeUpdateOverlapCheck", params);
	}

	@Override
	public List<HashMap<String, Object>> addWorkGeuntaeList() throws Throwable {
		return sqlsession.selectList("GeuntaeMgnt.addWorkGeuntaeList");
	}

	@Override
	public void addWorkReg(HashMap<String, String> params) throws Throwable {
		sqlsession.insert("GeuntaeMgnt.addWorkReg", params);
	}
	
	@Override
	public List<HashMap<String, String>> getGeunTaeList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("GeuntaeMgnt.getGeunTaeList",params);
	}

	@Override
	public int getGeunTaeCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("GeuntaeMgnt.getGeunTaeCnt",params);
	}

	@Override
	public HashMap<String, String> getGeunTaeData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("GeuntaeMgnt.getGeunTaeData",params);
	}

	@Override
	public List<HashMap<String, String>> GeunTaeList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("GeuntaeMgnt.GeunTaeList",params);
	}

	@Override
	public List<HashMap<String, String>> getGeunTaeAdminList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("GeuntaeMgnt.getGeunTaeAdminList",params);
	}

	@Override
	public int getGeunTaeAdminCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("GeuntaeMgnt.getGeunTaeAdminCnt",params);
	}

	@Override
	public List<HashMap<String, String>> DeptList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("GeuntaeMgnt.DeptList",params);
	}

	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) {
		return sqlsession.selectList("GeuntaeMgnt.getEmpSearchPopup",params);
	}

	@Override
	public int insertGeunTaeData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.insert("GeuntaeMgnt.insertGeunTaeData",params);
	}
	
}
