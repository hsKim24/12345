package com.gd.heywe.web.crm.service;

import java.util.HashMap;
import java.util.List;

public interface ICrmService {

	public int getCRMMarkChanceCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getCRMMarkChanceList(HashMap<String, String> params) throws Throwable;

	public int getCRMCstmCnt(HashMap<String, String> params);

	public List<HashMap<String, String>> getCrmCstmList(HashMap<String, String> params);

	public List<HashMap<String, String>> getDEPTList(HashMap<String, String> params);

	public List<HashMap<String, String>> getDept(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmp(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getCRMCstmDtl(HashMap<String, String> params);

	public List<HashMap<String, String>> getCstmOpnionList(HashMap<String, String> params);

	public HashMap<String, String> loginCheck(HashMap<String, String> params);

	public void opinionInsert(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getCstmDiv(HashMap<String, String> params);

	public List<HashMap<String, String>> getCstmGrade(HashMap<String, String> params);

	public List<HashMap<String, String>> getProgressState(HashMap<String, String> params);

	public void getCstmWrite(HashMap<String, String> params) throws Throwable;

	public void getCstmUpdate(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params);

	public HashMap<String, String> selectemp(HashMap<String, String> params);

	public HashMap<String, String> getCRMMarkChanceDtl(HashMap<String, String> params);

	public List<HashMap<String, String>> getMarkChanceOpnionList(HashMap<String, String> params);

	public void MarkopinionInsert(HashMap<String, String> params);

	public List<HashMap<String, String>> getcalList(HashMap<String, String> params);

	public List<HashMap<String, String>> getBsnsType(HashMap<String, String> params);

	public List<HashMap<String, String>> getSalesDiv(HashMap<String, String> params);

	public List<HashMap<String, String>> getRecogPath(HashMap<String, String> params);

	public HashMap<String, String> selectcstm(HashMap<String, String> params);

	public List<HashMap<String, String>> getCstmSearchPopup(HashMap<String, String> params);

	public HashMap<String, String> selectmngr(HashMap<String, String> params);

	public List<HashMap<String, String>> getMngrSearchPopup(HashMap<String, String> params);

	public void getMarkChanceWrite(HashMap<String, String> params);

	public void getChanceUpdate(HashMap<String, String> params);

	public int getCRMMarkMgntContCnt(HashMap<String, String> params);

	public List<HashMap<String, String>> getCRMMarkMgntContList(HashMap<String, String> params);

	public HashMap<String, String> getCRMMarkMgntContAsk(HashMap<String, String> params);

	public List<HashMap<String, String>> getcalList2(HashMap<String, String> params);

	public void MarkOpnionDelete(HashMap<String, String> params);

	// 성훈이꺼

	public List<HashMap<String, String>> getMngrList(HashMap<String, String> params) throws Throwable;

	public int getTestCnt(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMngr(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMngropinion(HashMap<String, String> params) throws Throwable;

	public void insertOpinion(HashMap<String, String> params) throws Throwable;

	public void deleteOpinion(HashMap<String, String> params) throws Throwable;

	public int getOpiCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMngrAtt(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getUpdate(HashMap<String, String> params) throws Throwable;

	public void updateMngr(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getcstmSearchPopup(HashMap<String, String> params) throws Throwable;

	public void insertMngr(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMCCList(HashMap<String, String> params) throws Throwable;

	public int getMCCCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMccDept(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMccEmp(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMccPse(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMCCDtl(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMCCopinion(HashMap<String, String> params) throws Throwable;

	public int getMCCOpiCnt(HashMap<String, String> params) throws Throwable;

	public void insertMCCOpinion(HashMap<String, String> params) throws Throwable;

	public void deleteMCCOpinion(HashMap<String, String> params) throws Throwable;

	public int getMCOCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMCOList(HashMap<String, String> params) throws Throwable;

	public int getMCContCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMCContList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMCODtl(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMCContDtl(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMMOList(HashMap<String, String> params) throws Throwable;

	public int getMMOCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getmngrSearchPopup(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getchanceSearchPopup(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> selectchance(HashMap<String, String> params) throws Throwable;

	public void insertOffer(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getcalMainList(HashMap<String, String> params);

	public List<HashMap<String, String>> getcalMainList2(HashMap<String, String> params);

	public List<HashMap<String, String>> reloadactivityType(HashMap<String, String> params);

	public List<HashMap<String, String>> getChanceSearchPopup(HashMap<String, String> params);

	public void MarkActivityWriteAjax(HashMap<String, String> params);

	public int CRMMarkActivityCalListCnt(HashMap<String, String> params);

	public List<HashMap<String, String>> CRMMarkActivityCalList(HashMap<String, String> params);

	public HashMap<String, String> getMACDtl(HashMap<String, String> params);

	public void MarkActivityUpdateAjax(HashMap<String, String> params);
	
	//찐성훈
	public List<HashMap<String, String>> CRMgetMngrList(HashMap<String, String> params) throws Throwable;
	public int CRMgetTestCnt(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> CRMgetMngrAtt(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> CRMgetMngr(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> CRMgetMngropinion(HashMap<String, String> params) throws Throwable;
	public int CRMgetOpiCnt(HashMap<String, String> params) throws Throwable;
	public void CRMinsertOpinion(HashMap<String, String> params) throws Throwable;
	public void CRMdeleteOpinion(HashMap<String, String> params) throws Throwable;
	public int ContWriteCnt(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> ContWriteList(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> getMMNList(HashMap<String, String> params) throws Throwable;
	public int getMMNCnt(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> getInsertContList(HashMap<String, String> params) throws Throwable;
	public void writeCont(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> getMMNDtl(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> getUpdateContList(HashMap<String, String> params) throws Throwable;
	public void updateCont(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> CRMgetUpdateNegoList(HashMap<String, String> params) throws Throwable;
	public void CRMupdateNego(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> NegoWriteList(HashMap<String, String> params) throws Throwable;
	public int NegoWriteCnt(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> getInsertNegoList(HashMap<String, String> params) throws Throwable;
	public void writeNego(HashMap<String, String> params) throws Throwable;
	//신
	public void updateGrade(HashMap<String, String> params) throws Throwable;
	public int getCrmGradeCnt(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> getMngntOfferHit(HashMap<String, String> params) throws Throwable;
	public void updateMngntOffer(HashMap<String, String> params) throws Throwable;
	public void insertMngntOffer(HashMap<String, String> params) throws Throwable;
	public void updateMngntOfferAsk(HashMap<String, String> params) throws Throwable;
	public HashMap<String, String> getMMODtl(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> getCrmGrade(HashMap<String, String> params) throws Throwable;

	public void CstmOpnionDelete(HashMap<String, String> params);

	public int CalMainListCnt(HashMap<String, String> params);

	public void CRMupdatePseAjax(HashMap<String, String> params);
	
	// 통계
	
	public List<HashMap<String, String>> getStcCstmGrade(HashMap<String, String> params) throws Throwable;

	public int getStcCstmCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getStcChanceCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getStcMarkChance(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getStcGradeGraph(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getStcActGraph(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getStcMarkGraph(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> CRMgetCstmAtt(HashMap<String, String> params);

	public List<HashMap<String, String>> gethistList(HashMap<String, String> params);



	public List<HashMap<String, String>> getGradeHist(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> CRMgetMarkAtt(HashMap<String, String> params);

	public void MarkActivityDeleteAjax(HashMap<String, String> params);

	public List<HashMap<String, String>> getCstmHist(HashMap<String, String> params) throws Throwable;

	public void deleteAttFileAjax(HashMap<String, String> params);

	public int CRMgetMarkChanceOpinionCnt(HashMap<String, String> params) throws Throwable;
	public int CRMgetCstmOpinionCnt(HashMap<String, String> params) throws Throwable;

	public void deleteCstmAttFileAjax(HashMap<String, String> params);

	public void deleteMarkAttFileAjax(HashMap<String, String> params);
}
