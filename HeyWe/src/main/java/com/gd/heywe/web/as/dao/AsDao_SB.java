package com.gd.heywe.web.as.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AsDao_SB implements iAsDao_SB{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getAsList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getAsList", params);
	}

	@Override
	public int getAsListCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsListCnt", params);
	}

	@Override
	public void insertAs(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("as.insertAs", params);
	}

	@Override
	public List<HashMap<String, String>> getAsSearchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getAsSearchList", params);
	}

	@Override
	public int getAsSearchListCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsSearchListCnt", params);
	}

	@Override
	public int UpdateAs(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("as.UpdateAs", params);
	}

	@Override
	public HashMap<String, String> getAsDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsDtl", params);
	}

	@Override
	public int deleteAs(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("as.deleteAs", params);
	}

	@Override
	public List<HashMap<String, String>> getAsProjList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getAsProjList", params);
	}

	@Override
	public int getAsProjListCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsProjListCnt", params);
	}

	@Override
	public void insertAsProj(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("as.insertAsProj", params);
	}

	@Override
	public List<HashMap<String, String>> getProjSol(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjSol", params);
	}

	@Override
	public List<HashMap<String, String>> getProjMk(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjMk", params);
	}

	@Override
	public List<HashMap<String, String>> getProjArea(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjArea", params);
	}

	@Override
	public List<HashMap<String, String>> getProjPm(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjPm", params);
	}

	@Override
	public HashMap<String, String> getAsProjListDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsProjListDtl", params);
	}

	@Override
	public List<HashMap<String, String>> getAsProjListSubDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getAsProjListSubDtl", params);
	}

	@Override
	public int getAsProjListDtlCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsProjListDtlCnt", params);
	}

	@Override
	public int UpdateAsProj(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("as.UpdateAsProj", params);
	}

	@Override
	public HashMap<String, String> getAsProjListSide(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsProjListSide", params);
	}

	@Override
	public List<HashMap<String, String>> getProjAddEmp(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjAddEmp", params);
	}


	@Override
	public List<HashMap<String, String>> getProjListTask(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjListTask", params);
	}

	@Override
	public void insertAsProjAdd(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("as.insertAsProjAdd", params);
	}

	@Override
	public List<HashMap<String, String>> getProjListAddReload(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getProjListAddReload", params);
	}

	@Override
	public int deleteAsProjDelEmp(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("as.deleteAsProjDelEmp", params);
	}

	@Override
	public List<HashMap<String, String>> getAsdeList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("as.getAsdeList", params);
	}

	@Override
	public int getAsdeListCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.getAsdeListCnt", params);
	}

	@Override
	public int UpdateAsListDel(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("as.UpdateAsListDel", params);
	}

	@Override
	public int deleteAsProjListDel(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("as.deleteAsProjListDel", params);
	}

	@Override
	public int deleteAsProjListDelFirst(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("as.deleteAsProjListDelFirst", params);
	}

	@Override
	public int itemNoCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("as.itemNoCheck", params);
	}


	
}
