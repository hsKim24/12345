package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

	@Repository
	public class GwBoardDao implements IGwBoardDao {
		@Autowired
		public SqlSession sqlSession;

		@Override
		public int getArticleCnt(HashMap<String, String> params) throws Throwable {
			return sqlSession.selectOne("board.getArticleCnt", params);
		}

		@Override
		public List<HashMap<String, String>> getArticle(HashMap<String, String> params)throws Throwable {
			return sqlSession.selectList("board.getArticle",params);
		}
		
		@Override
		public void insertWrite(HashMap<String, String> params) throws Throwable {
			int articleNo = sqlSession.selectOne("board.ArticleNoSEQ", params);
			
			params.put("articleNo", Integer.toString(articleNo));
			
			sqlSession.insert("board.insertWrite", params);
			
		/*
		 * String[] fileName = params.get("uploadFileName").split(",");
		 * 
		 * for(int i = 0 ; i < fileName.length ; i++) { HashMap<String, String> fileData
		 * = new HashMap<String, String>();
		 * 
		 * fileData.put("articleNo", Integer.toString(articleNo));
		 * fileData.put("upload", fileName[i]);
		 * 
		 * sqlSession.insert("board.ArticleUpload", fileData); }
		 */
			if (params.get("attList") != null && params.get("attList") != "") {
				String[] attFileArr = params.get("attList").split("/");
				for (int i = 0; i < attFileArr.length; i++) {
					params.put("uploadSEQ", Integer.toString(articleNo));
					params.put("upload", attFileArr[i]);

					sqlSession.insert("board.ArticleUpload", params);
				}
			}			
		}

		@Override
		public HashMap<String, String> authCheck(HashMap<String, String> params) throws Throwable {
			return sqlSession.selectOne("board.authCheck");
		}

		@Override
		public int AritcleHit(HashMap<String, String> params) throws Throwable {
			return sqlSession.update("board.AritcleHit", params);
		}

		@Override
		public HashMap<String, String> ArticleDtl(HashMap<String, String> params) throws Throwable {
			return sqlSession.selectOne("board.AritcleDtl", params);
		}

		@Override
		public void ArticleUpdate(HashMap<String, String> params) throws Throwable {
			
			sqlSession.update("board.ArticleUpdate", params);
			sqlSession.delete("board.ArticleFileDelete", params);
			if (params.get("attList") != null && params.get("attList") != "") {
				String[] attFileArr = params.get("attList").split("/");
				for (int i = 0; i < attFileArr.length; i++) {
					params.put("uploadSEQ", params.get("no"));
					params.put("upload", attFileArr[i]);
					sqlSession.insert("board.ArticleUpload", params);
				}
			}
			
		/*
		 * String[] fileName = params.get("uploadFileName").split(",");
		 * 
		 * sqlSession.delete("board.ArticleFileDelete", params);
		 * 
		 * for(int i = 0 ; i < fileName.length ; i++) { HashMap<String, String> fileData
		 * = new HashMap<String, String>();
		 * 
		 * fileData.put("articleNo", params.get("no")); fileData.put("upload",
		 * fileName[i]);
		 * 
		 * sqlSession.insert("board.ArticleUpload", fileData); }
		 */
		
			
		}

		@Override
		public int ArticleDelete(HashMap<String, String> params) throws Throwable {
			return sqlSession.update("board.ArticleDelete", params);
		}

		@Override
		public HashMap<String, String> loginCheck(HashMap<String, String> params) throws Throwable {
			return sqlSession.selectOne("board.loginCheck", params);

		}

		@Override
		public List<HashMap<String, String>> fileDown(HashMap<String, String> params) throws Throwable {
			return sqlSession.selectList("board.fileDown",params);
		}

		@Override
		public List<HashMap<String, String>> ArticleDtlAtt(HashMap<String, String> params) throws Throwable {
			return sqlSession.selectList("board.ArticleDtlAtt",params);
		}
}
