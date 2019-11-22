package com.gd.heywe.web.gw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.heywe.common.CommonProperties;
import com.gd.heywe.web.gw.service.IGwChatService;

@Controller
public class GWChatController {

   @Autowired
   public IGwChatService iGwChatService;
   
   @RequestMapping(value="/GWChat")
   public ModelAndView GWChat(ModelAndView mav) {
      
      mav.setViewName("gw/msg/GWChat");
      
      return mav;
   }

   @RequestMapping(value="/EXChat")
   public ModelAndView EXChat(ModelAndView mav) throws Throwable {
      
      int maxNo = iGwChatService.getMaxNo();

      mav.addObject("maxNo", maxNo);
      
      mav.setViewName("gw/msg/EXChat");
      
      return mav;
   }
   //채팅 정보 집어넣기~
   @RequestMapping(value ="AjaxGWinsertChat",
         method = RequestMethod.POST,
         produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWinsertMsg(@RequestParam HashMap<String, String> params)
                              throws Throwable {
      ObjectMapper mapper = new ObjectMapper();
      Map<String, Object> modelMap = new HashMap<String, Object>();
      System.out.println(params);
      
      try {
         iGwChatService.insertChat(params);
      }catch(Exception e){
         modelMap.put("msg", "실패");
         e.printStackTrace();
      }
      
      return mapper.writeValueAsString(modelMap);
   }
   
   // 채팅리스트 뿌리기
   @RequestMapping(value = "/AjaxGWChatList",
         method = RequestMethod.POST,
         produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWChatList(HttpServletRequest request, @RequestParam HashMap<String, String> params,
                        ModelAndView mav)
                              throws Throwable {

      ObjectMapper mapper = new ObjectMapper();
      Map<String, Object> modelMap = new HashMap<String, Object>();
      
      String lastChatNo = request.getParameter("lastChatNo");
      String chatRoomNo = request.getParameter("chatRoomNo");

      HashMap<String, String> number = new HashMap<String, String>(); 
      number.put("lastChatNo", lastChatNo);
      number.put("chatRoomNo", chatRoomNo);
      try {
         
         List<HashMap<String, String>> list = iGwChatService.getChatList(number);

         modelMap.put("list", list);
         modelMap.put("message", CommonProperties.RESULT_SUCCESS);
      } catch (Exception e) {
         modelMap.put("message", CommonProperties.RESULT_ERROR);
         modelMap.put("errorMessage", e.getMessage());
      }

      return mapper.writeValueAsString(modelMap);
   }
   
   
   
   // 내 채팅방 리스트 가져오기~
   @RequestMapping(value ="AjaxGWChatRoomList",
         method = RequestMethod.POST,
         produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWChatRoomList(@RequestParam HashMap<String, String> params)
                              throws Throwable {
      ObjectMapper mapper = new ObjectMapper();
      Map<String, Object> modelMap = new HashMap<String, Object>();
      System.out.println(params);
      
      try {
         List<HashMap<String, String>> ChatRoomlist = iGwChatService.getChatRoomList(params);
         modelMap.put("ChatRoomlist", ChatRoomlist);
      }catch(Exception e){
         modelMap.put("msg", "실패");
         e.printStackTrace();
      }
      
      return mapper.writeValueAsString(modelMap);
   }
   
   //채팅방을만들고, 만든 채팅방PK가져오기
   @RequestMapping(value ="AjaxGWInsertChatRoom",
		   method = RequestMethod.POST,
		   produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWInsertChatRoom(@RequestParam HashMap<String, String> params)
		   throws Throwable {
	   ObjectMapper mapper = new ObjectMapper();
	   Map<String, Object> modelMap = new HashMap<String, Object>();
	   System.out.println(params);
	   
	   try {
		   iGwChatService.insertChatRoom(params);
		   HashMap<String, String> data = iGwChatService.makedChatRoom(params);
		   modelMap.put("data", data);
		   //iGwChatService.insertChatRoomEmp(params);

	   }catch(Exception e){
		   modelMap.put("msg", "실패");
		   e.printStackTrace();
	   }
	   
	   return mapper.writeValueAsString(modelMap);
   }
   
   //만든 채팅방에 Emp를 넣는 Ajax
   @RequestMapping(value ="AjaxGWInsertChatEmp",
		   method = RequestMethod.POST,
		   produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWInsertChatEmp(@RequestParam HashMap<String, String> params)
		   throws Throwable {
	   ObjectMapper mapper = new ObjectMapper();
	   Map<String, Object> modelMap = new HashMap<String, Object>();
	   System.out.println(params);
	   
	   try {
		   iGwChatService.insertChatRoomEmp(params);
		   
	   }catch(Exception e){
		   modelMap.put("msg", "실패");
		   e.printStackTrace();
	   }
	   
	   return mapper.writeValueAsString(modelMap);
   }

   // 현재 채팅방에 몇명이 참석되어있고, 이름 뿌려주는 Ajax
   @RequestMapping(value ="AjaxGWSelectChatRoomListEmp",
		   method = RequestMethod.POST,
		   produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWSelectChatRoomListEmp(@RequestParam HashMap<String, String> params)
		   throws Throwable {
	   ObjectMapper mapper = new ObjectMapper();
	   Map<String, Object> modelMap = new HashMap<String, Object>();
	   System.out.println(params);
	   
	   try {
		   List<HashMap<String, String>> list = iGwChatService.selectChatRoomListEmp(params);
		   modelMap.put("list", list);
		   
	   }catch(Exception e){
		   modelMap.put("msg", "실패");
		   e.printStackTrace();
	   }
	   
	   return mapper.writeValueAsString(modelMap);
   }

   // 마지막 채팅번호 저장시키기!
   @RequestMapping(value ="AjaxLastChatNoUpdate",
		   method = RequestMethod.POST,
		   produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxLastChatNoUpdate(HttpSession session,
		   				@RequestParam HashMap<String, String> params)
		   throws Throwable {
	   ObjectMapper mapper = new ObjectMapper();
	   Map<String, Object> modelMap = new HashMap<String, Object>();
	   params.put("sEmpNo",session.getAttribute("sEmpNo").toString());
	   System.out.println("업데이트 lastChatNo 쿼리문");
	   System.out.println(params);
	   
	   try {
		   iGwChatService.updateLastChatNo(params);
		   
	   }catch(Exception e){
		   modelMap.put("msg", "실패");
		   e.printStackTrace();
	   }
	   
	   return mapper.writeValueAsString(modelMap);
   }
   
   
   // 채팅방 나가기!
   @RequestMapping(value ="AjaxGWExitChatRoom",
		   method = RequestMethod.POST,
		   produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String AjaxGWExitChatRoom(@RequestParam HashMap<String, String> params)
		   throws Throwable {
	   ObjectMapper mapper = new ObjectMapper();
	   Map<String, Object> modelMap = new HashMap<String, Object>();
	   System.out.println(params);
	   
	   try {
		  iGwChatService.deleteChatRoom(params);
		   
	   }catch(Exception e){
		   modelMap.put("msg", "실패");
		   e.printStackTrace();
	   }
	   
	   return mapper.writeValueAsString(modelMap);
   }
   
   
}