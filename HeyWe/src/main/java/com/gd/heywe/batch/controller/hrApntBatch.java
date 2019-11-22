package com.gd.heywe.batch.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.heywe.web.hr.service.IHRMgntService;

@Component
public class hrApntBatch {
	@Autowired
	public IHRMgntService iHRMgntService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void hrApntBatchCron() throws Throwable {
		Calendar c = Calendar.getInstance();
		String date = c.get(Calendar.YEAR) +"/" + (c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.DATE);
		
		List<HashMap<String, String>> list = iHRMgntService.getTempHrApntBatch(date);
		
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).put("prevDate", c.get(Calendar.YEAR) +"/" + (c.get(Calendar.MONTH) + 1) + "/" + (c.get(Calendar.DATE) - 1));
			try {
				//현재 인사발령을 종료
				//승인된 TEMP_HR_APNT테이블에서 HR_APNT테이블로 이동
				//옮겨진 데이터의 BATCH_DIV를 0 으로 변경
				
				//퇴직발령일때
				if(list.get(i).get("DEPT_NO") == null && list.get(i).get("POSI_NO") == null) {
					list.get(i).put("flag", "0");
					iHRMgntService.hrApntFnshUpdate(list.get(i));
					iHRMgntService.hrApntBatchDivUpdate(list.get(i));
				}else {
					list.get(i).put("flag", "1");
					iHRMgntService.hrApntFnshUpdate(list.get(i));
					iHRMgntService.hrApntBatchInsert(list.get(i));
					iHRMgntService.hrApntBatchDivUpdate(list.get(i));
				}
			} catch (Exception e) {
				return ;
			}
		}
	}

}
