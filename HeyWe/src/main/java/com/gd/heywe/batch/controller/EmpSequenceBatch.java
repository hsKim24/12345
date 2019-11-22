package com.gd.heywe.batch.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.heywe.web.bm.service.IBmService;
import com.gd.heywe.web.hr.service.IHRMgntService;


@Component
public class EmpSequenceBatch {
	@Autowired
	public IHRMgntService iHRMgntService;

	//매년 1월1일에 EMP_SEQUENCE 초기화
	@Scheduled(cron = "0 0 0 1 1 *")
	public void EmpSequenceBatchCron() throws Throwable{
		try {
			iHRMgntService.dropEmpSequence();
			iHRMgntService.initEmpSequence();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
