package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GwChatDao implements IGwChatDao{

   @Autowired
   SqlSession sqlSession;

   @Override
   public void insertChat(HashMap<String, String> params) throws Throwable {
      sqlSession.insert("gw.insertChat",params);

   }

   @Override
   public List<HashMap<String, String>> chatList(HashMap<String, String> number) throws Throwable {
      return sqlSession.selectList("gw.chatList", number);
   }

   @Override
   public int getMaxNo() throws Throwable {
      return sqlSession.selectOne("gw.getMaxNo");
   }

	@Override
	public List<HashMap<String, String>> getChatRoomList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("gw.getChatRoomList", params);
	}
	
	@Override
	public void insertChatRoom(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("gw.insertChatRoom", params);
	}
	
	@Override
	public void insertChatRoomEmp(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("gw.insertChatRoomEmp", params);
	}

	@Override
	public List<HashMap<String, String>> selectChatRoomListEmp(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("gw.selectChatRoomListEmp", params);
	}

	@Override
	public HashMap<String, String> makedChatRoom(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("gw.makedChatRoom", params);
	}

	@Override
	public void deleteChatRoom(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("gw.deleteChatRoom", params);
	}

	@Override
	public void updateLastChatNo(HashMap<String, String> params) throws Throwable {
		sqlSession.update("gw.updateLastChatNo", params);
	}
   
}