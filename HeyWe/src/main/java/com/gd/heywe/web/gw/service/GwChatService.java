package com.gd.heywe.web.gw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.gw.dao.IGwChatDao;

@Service
public class GwChatService implements IGwChatService{

   @Autowired
   IGwChatDao igwChatDao;

   public void insertChat(HashMap<String, String> params) throws Throwable{
      igwChatDao.insertChat(params);
   }

   @Override
   public List<HashMap<String, String>> getChatList(HashMap<String, String> number) throws Throwable {
      return igwChatDao.chatList(number);
   }

   @Override
   public int getMaxNo() throws Throwable {
      return igwChatDao.getMaxNo();
   }

   @Override
	public List<HashMap<String, String>> getChatRoomList(HashMap<String, String> params) throws Throwable {
		return igwChatDao.getChatRoomList(params);
	}

   @Override
	public void insertChatRoom(HashMap<String, String> params) throws Throwable {
	   igwChatDao.insertChatRoom(params);
	}

   @Override
	public void insertChatRoomEmp(HashMap<String, String> params) throws Throwable {
	   igwChatDao.insertChatRoomEmp(params);
	}

   @Override
	public List<HashMap<String, String>> selectChatRoomListEmp(HashMap<String, String> params) throws Throwable {
	   return igwChatDao.selectChatRoomListEmp(params);
}

	@Override
	public HashMap<String, String> makedChatRoom(HashMap<String, String> params) throws Throwable {
		return igwChatDao.makedChatRoom(params);
	}

	@Override
	public void deleteChatRoom(HashMap<String, String> params) throws Throwable {
		igwChatDao.deleteChatRoom(params);
	}

	@Override
	public void updateLastChatNo(HashMap<String, String> params) throws Throwable {
		igwChatDao.updateLastChatNo(params);
	}

   
      


}