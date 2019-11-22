package com.gd.heywe.web.hr.dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gd.heywe.util.Utils;

@Repository
public class HRMgntDao implements IHRMgntDao{
	@Autowired
	public SqlSession sqlsession;

	@Override
	public List<HashMap<String, String>> getDeptName() throws Throwable {
		return sqlsession.selectList("HRMgnt.getDeptName");
	}

	@Override
	public int deptOverlapCheck(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.deptOverlapCheck", params);
	}

	@Override
	public void deptAdd(HashMap<String, String> params) throws Throwable {
		int deptNo = sqlsession.selectOne("HRMgnt.getInsertDeptNo");
		params.put("deptNo", Integer.toString(deptNo));
		sqlsession.insert("HRMgnt.deptAdd", params);
		
		HashMap<String, String> data = sqlsession.selectOne("HRMgnt.getLastDept", params);
		
		sqlsession.insert("document.DocTypeNum", data);
	}

	@Override
	public int deptNameUpdate(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("HRMgnt.deptNameUpdate", params);
	}

	@Override
	public List<HashMap<String, String>> getPosiName() throws Throwable {
		return sqlsession.selectList("HRMgnt.getPosiName");
	}

	@Override
	public List<HashMap<String, String>> getHrApntRecAsk(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.getHrApntRecAsk", params);
	}

	@Override
	public int getHrApntCnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.getHrApntCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.getEmpSearchPopup", params);
	}

	@Override
	public void hrApntReg(HashMap<String, String> params) throws Throwable {
		sqlsession.insert("HRMgnt.hrApntReg", params);
	}

	@Override
	public int getHrApntApvStateCnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.getHrApntApvStateCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getHrApntApvState(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.getHrApntApvState", params);
	}

	//TEMP_HR_APNT에서 결재가 승인 된 것중 오늘날짜로 발령나는 사람 가져오기
	@Override
	public List<HashMap<String, String>> getTempHrApntBatch(String sysdate) throws Throwable {
		return sqlsession.selectList("HRMgnt.getTempHrApntBatch", sysdate);
	}

	@Override
	public int deptDeleteCheck(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.deptDeleteCheck", params);
	}

	@Override
	public int deptDelete(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("HRMgnt.deptDelete", params);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public void empReg(HashMap<String, String> params) throws Throwable {
		int empNo = sqlsession.selectOne("HRMgnt.getEmpNo");
		
		params.put("empNo",Integer.toString(empNo));
		params.put("defaultPw", Utils.encryptAES128("1234"));
		
		
		//사원
		sqlsession.insert("HRMgnt.empReg", params);
		//인적사항
		sqlsession.insert("HRMgnt.hmStateReg", params);
		
		//학력
		String[] scDiv = params.get("formScDiv").split("田", -1);
		String[] scName = params.get("formScName").split("田", -1);
		String[] scMajor = params.get("formScMajor").split("田", -1);
		String[] scGrdDay = params.get("formScGrdDay").split("田", -1);
		String[] scDegreeDiv = params.get("formDegreeDiv").split("田", -1);

		for(int i = 0 ; i < scDiv.length ; i++) {
			HashMap<String, String> data = new HashMap<String, String>();
			data.put("empNo", params.get("empNo"));
			data.put("scDiv", scDiv[i]);
			data.put("scName", scName[i]);
			data.put("scMajor", scMajor[i]);
			data.put("scGrdDay", scGrdDay[i]);
			data.put("scDegreeDiv", scDegreeDiv[i]);
			
			sqlsession.insert("HRMgnt.aabtyReg", data);
		}
		
		//자격면허
		if(!params.get("formLicenseLength").equals("-1")) {
			String[] licenseName = params.get("formLicenseName").split("田", -1);
			String[] getDay = params.get("formGetDay").split("田", -1);
			String[] licensePubc = params.get("formLicensePubc").split("田", -1);
			String[] licenseOlfcNo = params.get("formLicenseOlfcNo").split("田", -1);
			for(int i = 0 ; i < licenseName.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("empNo", params.get("empNo"));
				data.put("licenseName", licenseName[i]);
				data.put("getDay", getDay[i]);
				data.put("licensePubc", licensePubc[i]);
				data.put("licenseOlfcNo", licenseOlfcNo[i]);
				
				sqlsession.insert("HRMgnt.licenseReg", data);
			}
		}
		
		//경력
		if(!params.get("formCareerLength").equals("-1")) {
			String[] wplaceName = params.get("formWplaceName").split("田", -1);
			String[] posiName = params.get("formPosiName").split("田", -1);
			String[] workStart = params.get("formWorkStart").split("田", -1);
			String[] workFnsh = params.get("formWorkFnsh").split("田", -1);
			String[] task = params.get("formTask").split("田", -1);
			for(int i = 0 ; i < wplaceName.length ;i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("empNo", params.get("empNo"));
				data.put("wplaceName", wplaceName[i]);
				data.put("posiName", posiName[i]);
				data.put("workStart", workStart[i]);
				data.put("workFnsh", workFnsh[i]);
				data.put("task", task[i]);
				
				sqlsession.insert("HRMgnt.careerReg", data);
			}
		}
		
		//가족
		if(!params.get("formFamilyLength").equals("-1")) {
			String[] familyName = params.get("formFamilyName").split("田", -1);
			String[] familyBirth = params.get("formFamilyBirth").split("田", -1);
			String[] famDiv = params.get("formFamDiv").split("田", -1);
			for(int i = 0 ; i < familyName.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("empNo", params.get("empNo"));
				data.put("familyName", familyName[i]);
				data.put("familyBirth", familyBirth[i]);
				data.put("famDiv", famDiv[i]);
				
				sqlsession.insert("HRMgnt.familyReg", data);
			}
		}
		
		//인사발령
		sqlsession.insert("HRMgnt.empRegHrApnt", params);
	}

	
	@Override
	public int getHrApntNo() throws Throwable {
		return sqlsession.selectOne("HRMgnt.getHrApntNo");
	}

	@Override
	public int getHrDmngr() throws Throwable {
		return sqlsession.selectOne("HRMgnt.getHrDmngr");
	}

	@Override
	public String getDeptDmngr(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.getDeptDmngr", params);
	}

	@Override
	public int getRepresentEmpNo() throws Throwable {
		return sqlsession.selectOne("HRMgnt.getRepresentEmpNo");
	}

	@Override
	public void hrApntBatchInsert(HashMap<String, String> hashMap) throws Throwable {
		sqlsession.insert("HRMgnt.hrApntBatchInsert", hashMap);
	}

	@Override
	public void hrApntBatchDivUpdate(HashMap<String, String> hashMap) throws Throwable {
		sqlsession.update("HRMgnt.hrApntBatchDivUpdate", hashMap);
	}

	@Override
	public void hrApntFnshUpdate(HashMap<String, String> hashMap) throws Throwable {
		sqlsession.update("HRMgnt.hrApntFnshUpdate", hashMap);
	}
	
	@Override
	public HashMap<String, String> hmitem(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.hmitem",params);
	}

	@Override
	public List<HashMap<String, String>> qlfc(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.qlfc", params);
	}

	@Override
	public List<HashMap<String, String>> career(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.career", params);
	}

	@Override
	public List<HashMap<String, String>> AAbty(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.AAbty", params);
	}

	@Override
	public List<HashMap<String, String>> family(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("HRMgnt.family", params);
	}

	@Override
	public void hmitemUpdate(HashMap<String, String> params) throws Throwable {
		if(!params.get("formPW").equals("")) {
			//PW 암호화
			params.put("formPW", Utils.encryptAES128(params.get("formPW")));
		}
		
		//사원정보 수정
		sqlsession.update("HRMgnt.empUpdate", params);
		
		//인적사항 수정
		sqlsession.update("HRMgnt.hmStateUpdate", params);
		
		//학력 삭제
		sqlsession.delete("HRMgnt.aabtyDelete", params);
		
		String[] aabtyNo = params.get("formAabtyNo").split(",");
		String[] scDiv = params.get("formScDiv").split(",", -1);
		String[] scName = params.get("formScName").split(",", -1);
		String[] scMajor = params.get("formScMajor").split(",", -1);
		String[] scGrdDay = params.get("formScGrdDay").split(",", -1);
		String[] degreeDiv = params.get("formDegreeDiv").split(",", -1);
		//학력 수정
		for(int i = 0 ; i < aabtyNo.length; i++) {
			HashMap<String, String> data = new HashMap<String, String>();
			data.put("aabtyNo", aabtyNo[i]);
			data.put("scDiv", scDiv[i]);
			data.put("scName", scName[i]);
			data.put("scMajor", scMajor[i]);
			data.put("scGrdDay", scGrdDay[i]);
			data.put("degreeDiv", degreeDiv[i]);
			
			sqlsession.update("HRMgnt.aabtyUpdate", data);
		}
		//학력 추가
		for(int i = aabtyNo.length ; i < scDiv.length ; i++) {
			HashMap<String, String> data = new HashMap<String, String>();
			data.put("empNo", params.get("empNo"));
			data.put("scDiv", scDiv[i]);
			data.put("scName", scName[i]);
			data.put("scMajor", scMajor[i]);
			data.put("scGrdDay", scGrdDay[i]);
			data.put("degreeDiv", degreeDiv[i]);
			
			sqlsession.insert("HRMgnt.aabtyInsert", data);
		}
		
		//자격
		String[] licenseNo = {};
		
		if(!params.get("formLicenseNo").equals("")) {
			licenseNo = params.get("formLicenseNo").split(",");
			params.put("licenseNoLength", Integer.toString(licenseNo.length));
		}else { //기존자격증을 다 삭제한다면
			params.put("licenseNoLength", "1000");
		}
		
		//자격면허삭제
		sqlsession.delete("HRMgnt.licenseDelete", params);
		
		//자격면허수정,추가
		if(!params.get("formLicenseLength").equals("-1")) {
			
			String[] licenseName = params.get("formLicenseName").split(",");
			String[] getDay = params.get("formGetDay").split(",");
			String[] licensePubc = params.get("formLicensePubc").split(",");
			String[] licenseOlfcNo = params.get("formLicenseOlfcNo").split(",");
			//수정
			for(int i = 0 ; i < licenseNo.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("licenseNo", licenseNo[i]);
				data.put("licenseName", licenseName[i]);
				data.put("getDay", getDay[i]);
				data.put("licensePubc", licensePubc[i]);
				data.put("licenseOlfcNo", licenseOlfcNo[i]);
				
				sqlsession.update("HRMgnt.licenseUpdate", data);
			}
			
			//추가
			for(int i = licenseNo.length ; i < licenseName.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("empNo", params.get("empNo"));
				data.put("licenseName", licenseName[i]);
				data.put("getDay", getDay[i]);
				data.put("licensePubc", licensePubc[i]);
				data.put("licenseOlfcNo", licenseOlfcNo[i]);
				
				sqlsession.insert("HRMgnt.licenseInsert", data);
			}
		}
		
		//경력
		String[] careerNo = {};
		
		if(!params.get("formCareerNo").equals("")) {
			careerNo = params.get("formCareerNo").split(",");
			params.put("careerNoLength", Integer.toString(careerNo.length));
		}else { //기존경력을 다 삭제한다면
			params.put("careerNoLength", "1000");
		}
		
		//경력삭제
		sqlsession.delete("HRMgnt.careerDelete", params);
		
		//자격면허수정,추가
		if(!params.get("formCareerLength").equals("-1")) {
			
			String[] wplaceName = params.get("formWplaceName").split(",");
			String[] posiName = params.get("formPosiName").split(",");
			String[] workStart = params.get("formWorkStart").split(",");
			String[] workFnsh = params.get("formWorkFnsh").split(",");
			String[] task = params.get("formTask").split(",");
			//수정
			for(int i = 0 ; i < careerNo.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("careerNo", careerNo[i]);
				data.put("wplaceName", wplaceName[i]);
				data.put("posiName", posiName[i]);
				data.put("workStart", workStart[i]);
				data.put("workFnsh", workFnsh[i]);
				data.put("task", task[i]);
				
				sqlsession.update("HRMgnt.careerUpdate", data);
			}
			
			//추가
			for(int i = careerNo.length ; i < wplaceName.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("empNo", params.get("empNo"));
				data.put("wplaceName", wplaceName[i]);
				data.put("posiName", posiName[i]);
				data.put("workStart", workStart[i]);
				data.put("workFnsh", workFnsh[i]);
				data.put("task", task[i]);
				
				sqlsession.insert("HRMgnt.careerInsert", data);
			}
		}
		
		//가족
		String[] familyNo = {};
		
		if(!params.get("formFamilyNo").equals("")) {
			familyNo = params.get("formFamilyNo").split(",");
			params.put("familyNoLength", Integer.toString(familyNo.length));
		}else { //기존가족정보를 다 삭제한다면
			params.put("familyNoLength", "1000");
		}
		
		//가족삭제
		sqlsession.delete("HRMgnt.familyDelete", params);
		
		//가족수정,추가
		if(!params.get("formFamilyLength").equals("-1")) {
			
			String[] familyName = params.get("formFamilyName").split(",");
			String[] familyBirth = params.get("formFamilyBirth").split(",");
			String[] famDiv = params.get("formFamDiv").split(",");
			//수정
			for(int i = 0 ; i < familyNo.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("familyNo", familyNo[i]);
				data.put("familyName", familyName[i]);
				data.put("familyBirth", familyBirth[i]);
				data.put("famDiv", famDiv[i]);
				
				sqlsession.update("HRMgnt.familyUpdate", data);
			}
			
			//추가
			for(int i = familyNo.length ; i < familyName.length ; i++) {
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("empNo", params.get("empNo"));
				data.put("familyName", familyName[i]);
				data.put("familyBirth", familyBirth[i]);
				data.put("famDiv", famDiv[i]);
				
				sqlsession.insert("HRMgnt.familyInsert", data);
			}
		}
	}
	
	@Override
	public int getTestCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("HRMgnt.getTestCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("HRMgnt.getEmpList",params);
	}

	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("HRMgnt.getDeptList",params);
	}

	@Override
	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectList("HRMgnt.getPosiList",params);
	}

	@Override
	public HashMap<String, String> getEmpDtlData(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("HRMgnt.getEmpDtlData",params);
	}

	@Override
	public void dropEmpSequence() throws Throwable {
		sqlsession.delete("HRMgnt.dropEmpSequence");
	}

	@Override
	public void initEmpSequence() throws Throwable {
		sqlsession.insert("HRMgnt.initEmpSequence");
	}

	@Override
	public HashMap<String, String> hmitemApnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("HRMgnt.hmitemApnt",params);
	}
}
