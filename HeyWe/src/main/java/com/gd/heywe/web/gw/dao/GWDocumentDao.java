package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GWDocumentDao implements GWIDocumentDao {
	
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public List<HashMap<String, String>> getDocBoardList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("document.getDocBoardList", params);
	}

	@Override
	public int getDocBoardCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("document.getDocBoardCnt", params);
	}

	@Override
	public HashMap<String, String> DocDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("document.DocDtl", params);
	}

	@Override
	public void DocWrite(HashMap<String, String> params) throws Throwable {
		int docNo = sqlSession.selectOne("document.DocNoSEQ", params);
		
		params.put("docNo", Integer.toString(docNo));
		
		sqlSession.insert("document.DocWrite", params);
		
		/*
		 * String[] fileName = params.get("uploadFileName").split(",");
		 * 
		 * for(int i = 0 ; i < fileName.length ; i++) { HashMap<String, String> fileData
		 * = new HashMap<String, String>();
		 * 
		 * fileData.put("uploadSEQ", Integer.toString(docNo)); fileData.put("upload",
		 * fileName[i]);
		 * 
		 * sqlSession.insert("document.DocUpload", fileData);
		 */
		if(params.get("attList") != null && params.get("attList") != "") {
		String[] attFileArr = params.get("attList").split("/");
		for(int i = 0; i < attFileArr.length; i++) {
			params.put("uploadSEQ", Integer.toString(docNo));
			params.put("upload", attFileArr[i]);
			
			sqlSession.insert("document.DocUpload", params);
		}
		}
		
	}

	@Override
	public void DocUpdate(HashMap<String, String> params) throws Throwable {
		System.out.println("수정" + params);
		sqlSession.update("document.DocUpdate", params);
		
			sqlSession.delete("document.DocFileDelete", params);
		
		if(params.get("attList") != null && params.get("attList") != "") {
			String[] attFileArr = params.get("attList").split("/");
			for(int i = 0; i < attFileArr.length; i++) {
				params.put("uploadSEQ", params.get("no"));
				params.put("upload", attFileArr[i]);
				sqlSession.insert("document.DocUpload", params);
			}
		}
		
		/*
		 * String[] fileName = params.get("uploadFileName").split(",");
		 * 
		 * sqlSession.delete("document.DocFileDelete", params);
		 * 
		 * for(int i = 0 ; i < fileName.length ; i++) { HashMap<String, String> fileData
		 * = new HashMap<String, String>();
		 * 
		 * fileData.put("uploadSEQ", params.get("no"));
		 * fileData.put("upload",fileName[i]);
		 * 
		 * sqlSession.insert("document.DocUpload", fileData);
		 */
		}

	
	@Override
	public int DocDel(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("document.DocDel", params);
	}


	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("document.loginCheck", params);
	}

	@Override
	public int DocHitUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("document.DocHit", params);
	}

	@Override
	public List<HashMap<String, String>> DocDtlAtt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("document.DocDtlAtt", params);
	}

}
