package com.gd.heywe.web.gw.dao;

import java.util.HashMap;
import java.util.List;

public interface IGwChatDao {

   public void insertChat(HashMap<String, String> params) throws Throwable;

   public List<HashMap<String, String>> chatList(HashMap<String, String> number) throws Throwable;

   public int getMaxNo() throws Throwable;

   public List<HashMap<String, String>> getChatRoomList(HashMap<String, String> params) throws Throwable;

   public void insertChatRoom(HashMap<String, String> params) throws Throwable;

   public void insertChatRoomEmp(HashMap<String, String> params) throws Throwable;

   public List<HashMap<String, String>> selectChatRoomListEmp(HashMap<String, String> params) throws Throwable;

   public HashMap<String, String> makedChatRoom(HashMap<String, String> params) throws Throwable;

   public void deleteChatRoom(HashMap<String, String> params) throws Throwable;

   public void updateLastChatNo(HashMap<String, String> params) throws Throwable;

}