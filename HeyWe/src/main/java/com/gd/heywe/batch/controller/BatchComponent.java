package com.gd.heywe.batch.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.heywe.web.bm.service.IBmService;


@Component
public class BatchComponent {
	@Autowired IBmService iBmService;
	/*
	 * cron -> 초 분 시 일 월 요일 연도(생략가능)
	 * * -> 모든
	 * a-b -> a부터 b까지 매 1간격마다
	 * a/b -> a부터 매 b간격만큼 
	 */
	//구현 시 삭제할것
	
	// 급여 계산 리스트 삽입
	@Scheduled(cron = "0 0 14 1 * *")
	public void BMInsertSalCalcList() throws Throwable{
		try {
			iBmService.insertSalCalcList();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
