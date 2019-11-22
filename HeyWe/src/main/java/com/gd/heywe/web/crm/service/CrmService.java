package com.gd.heywe.web.crm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.heywe.web.crm.dao.ICrmDao;

@Service
public class CrmService implements ICrmService {

	@Autowired
	public ICrmDao iCrmDao;

	@Override
	public int getCRMMarkChanceCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMMarkChanceCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getCRMMarkChanceList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMMarkChanceList(params);
	}

	@Override
	public int getCRMCstmCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMCstmCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getCrmCstmList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCrmCstmList(params);
	}

	@Override
	public List<HashMap<String, String>> getDEPTList(HashMap<String, String> params) {

		return iCrmDao.getDEPTList(params);
	}

	@Override
	public List<HashMap<String, String>> getDept(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getDept(params);
	}

	@Override
	public List<HashMap<String, String>> getEmp(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getEmp(params);
	}

	@Override
	public HashMap<String, String> getCRMCstmDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMCstmDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getCstmOpnionList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCstmOpnionList(params);
	}

	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.loginCheck(params);
	}

	@Override
	public void opinionInsert(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		iCrmDao.opinionInsert(params);
	}

	@Override
	public List<HashMap<String, String>> getCstmDiv(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCstmDiv(params);
	}

	@Override
	public List<HashMap<String, String>> getCstmGrade(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCstmGrade(params);
	}

	@Override
	public List<HashMap<String, String>> getProgressState(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getProgressState(params);
	}

	@Override
	public void getCstmWrite(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		iCrmDao.getCstmWrite(params);
	}

	@Override
	public void getCstmUpdate(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		iCrmDao.getCstmUpdate(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getEmpSearchPopup(params);
	}

	@Override
	public HashMap<String, String> selectemp(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.selectemp(params);
	}

	@Override
	public HashMap<String, String> getCRMMarkChanceDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMMarkChanceDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getMarkChanceOpnionList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getMarkChanceOpnionList(params);
	}

	@Override
	public void MarkopinionInsert(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.MarkopinionInsert(params);
	}

	@Override
	public List<HashMap<String, String>> getcalList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getcalList(params);
	}

	@Override
	public List<HashMap<String, String>> getBsnsType(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getBsnsType(params);
	}

	@Override
	public List<HashMap<String, String>> getSalesDiv(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getSalesDiv(params);
	}

	@Override
	public List<HashMap<String, String>> getRecogPath(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getRecogPath(params);
	}

	@Override
	public HashMap<String, String> selectcstm(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.selectcstm(params);
	}

	@Override
	public List<HashMap<String, String>> getCstmSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCstmSearchPopup(params);
	}

	@Override
	public HashMap<String, String> selectmngr(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.selectmngr(params);
	}

	@Override
	public List<HashMap<String, String>> getMngrSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getMngrSearchPopup(params);
	}

	@Override
	public void getMarkChanceWrite(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.getMarkChanceWrite(params);
	}

	@Override
	public void getChanceUpdate(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.getChanceUpdate(params);
	}

	@Override
	public int getCRMMarkMgntContCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMMarkMgntContCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getCRMMarkMgntContList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMMarkMgntContList(params);
	}

	@Override
	public HashMap<String, String> getCRMMarkMgntContAsk(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getCRMMarkMgntContAsk(params);
	}

	@Override
	public List<HashMap<String, String>> getcalList2(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getcalList2(params);
	}

	@Override
	public void MarkOpnionDelete(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.MarkOpnionDelete(params);
	}

	// 성훈이꺼

	@Override
	public List<HashMap<String, String>> getMngrList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMngrList(params);
	}

	@Override
	public int getTestCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getTestCnt(params);
	}

	@Override
	public HashMap<String, String> getMngr(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMngr(params);
	}

	@Override
	public List<HashMap<String, String>> getMngropinion(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMngropinion(params);
	}

	@Override
	public void insertOpinion(HashMap<String, String> params) throws Throwable {
		iCrmDao.insertOpinion(params);
	}

	@Override
	public void deleteOpinion(HashMap<String, String> params) throws Throwable {
		iCrmDao.deleteOpinion(params);
	}

	@Override
	public int getOpiCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getOpiCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getMngrAtt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMngrAtt(params);
	}

	@Override
	public HashMap<String, String> getUpdate(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getUpdate(params);
	}

	@Override
	public void updateMngr(HashMap<String, String> params) throws Throwable {
		iCrmDao.updateMngr(params);

	}

	@Override
	public List<HashMap<String, String>> getcstmSearchPopup(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getcstmSearchPopup(params);
	}

	@Override
	public void insertMngr(HashMap<String, String> params) throws Throwable {
		iCrmDao.insertMngr(params);
	}

	@Override
	public List<HashMap<String, String>> getMCCList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCCList(params);
	}

	@Override
	public int getMCCCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCCCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getMccDept(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMccDept(params);
	}

	@Override
	public List<HashMap<String, String>> getMccEmp(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMccEmp(params);
	}

	@Override
	public List<HashMap<String, String>> getMccPse(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMccPse(params);
	}

	@Override
	public HashMap<String, String> getMCCDtl(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCCDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getMCCopinion(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCCopinion(params);
	}

	@Override
	public int getMCCOpiCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCCOpiCnt(params);
	}

	@Override
	public void insertMCCOpinion(HashMap<String, String> params) throws Throwable {
		iCrmDao.insertMCCOpinion(params);
	}

	@Override
	public void deleteMCCOpinion(HashMap<String, String> params) throws Throwable {
		iCrmDao.deleteMCCOpinion(params);

	}

	@Override
	public int getMCOCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCOCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getMCOList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCOList(params);
	}

	@Override
	public int getMCContCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCContCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getMCContList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCContList(params);
	}

	@Override
	public HashMap<String, String> getMCODtl(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCODtl(params);
	}

	@Override
	public HashMap<String, String> getMCContDtl(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMCContDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getMMOList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMMOList(params);
	}

	@Override
	public int getMMOCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMMOCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getmngrSearchPopup(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getmngrSearchPopup(params);
	}

	@Override
	public List<HashMap<String, String>> getchanceSearchPopup(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getchanceSearchPopup(params);
	}

	@Override
	public HashMap<String, String> selectchance(HashMap<String, String> params) throws Throwable {
		return iCrmDao.selectchance(params);
	}

	@Override
	public void insertOffer(HashMap<String, String> params) throws Throwable {
		iCrmDao.insertOffer(params);
	}

	@Override
	public List<HashMap<String, String>> getcalMainList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getcalMainList(params);
	}

	@Override
	public List<HashMap<String, String>> getcalMainList2(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getcalMainList2(params);
	}

	@Override
	public List<HashMap<String, String>> reloadactivityType(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.reloadactivityType(params);
	}

	@Override
	public List<HashMap<String, String>> getChanceSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getChanceSearchPopup(params);
	}

	@Override
	public void MarkActivityWriteAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.MarkActivityWriteAjax(params);
	}

	@Override
	public int CRMMarkActivityCalListCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.CRMMarkActivityCalListCnt(params);
	}

	@Override
	public List<HashMap<String, String>> CRMMarkActivityCalList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.CRMMarkActivityCalList(params);
	}

	@Override
	public HashMap<String, String> getMACDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.getMACDtl(params);
	}

	@Override
	public void MarkActivityUpdateAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.MarkActivityUpdateAjax(params);
	}

	// 찐성훈

	@Override
	public List<HashMap<String, String>> CRMgetMngrList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetMngrList(params);
	}

	@Override
	public int CRMgetTestCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetTestCnt(params);
	}

	@Override
	public HashMap<String, String> CRMgetMngr(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetMngr(params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetMngrAtt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetMngrAtt(params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetMngropinion(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetMngropinion(params);
	}

	@Override
	public int CRMgetOpiCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetOpiCnt(params);
	}

	@Override
	public void CRMinsertOpinion(HashMap<String, String> params) throws Throwable {
		iCrmDao.CRMinsertOpinion(params);
	}

	@Override
	public void CRMdeleteOpinion(HashMap<String, String> params) throws Throwable {
		iCrmDao.CRMdeleteOpinion(params);
	}

	@Override
	public void updateGrade(HashMap<String, String> params) throws Throwable {
		iCrmDao.updateGrade(params);

	}

	@Override
	public int getCrmGradeCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getCrmGradeCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getCrmGrade(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getCrmGrade(params);
	}

	@Override
	public int ContWriteCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.ContWriteCnt(params);
	}

	@Override
	public List<HashMap<String, String>> ContWriteList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.ContWriteList(params);
	}

	@Override
	public List<HashMap<String, String>> getMMNList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMMNList(params);
	}

	@Override
	public int getMMNCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMMNCnt(params);
	}

	@Override
	public HashMap<String, String> getInsertContList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getInsertContList(params);
	}

	@Override
	public void writeCont(HashMap<String, String> params) throws Throwable {
		iCrmDao.writeCont(params);
	}

	@Override
	public HashMap<String, String> getMMNDtl(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMMNDtl(params);
	}

	@Override
	public HashMap<String, String> getUpdateContList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getUpdateContList(params);
	}

	@Override
	public void updateCont(HashMap<String, String> params) throws Throwable {
		iCrmDao.updateCont(params);
	}

	@Override
	public HashMap<String, String> CRMgetUpdateNegoList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetUpdateNegoList(params);
	}

	@Override
	public void CRMupdateNego(HashMap<String, String> params) throws Throwable {
		iCrmDao.CRMupdateNego(params);
	}

	@Override
	public int NegoWriteCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.NegoWriteCnt(params);
	}

	@Override
	public List<HashMap<String, String>> NegoWriteList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.NegoWriteList(params);
	}

	@Override
	public HashMap<String, String> getInsertNegoList(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getInsertNegoList(params);
	}

	@Override
	public void writeNego(HashMap<String, String> params) throws Throwable {
		iCrmDao.writeNego(params);
	}

	@Override
	public HashMap<String, String> getMngntOfferHit(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMngntOfferHit(params);
	}

	@Override
	public void updateMngntOffer(HashMap<String, String> params) throws Throwable {
		iCrmDao.updateMngntOffer(params);
	}

	@Override
	public void insertMngntOffer(HashMap<String, String> params) throws Throwable {
		iCrmDao.insertMngntOffer(params);

	}

	@Override
	public void updateMngntOfferAsk(HashMap<String, String> params) throws Throwable {
		iCrmDao.updateMngntOfferAsk(params);
	}

	@Override
	public HashMap<String, String> getMMODtl(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getMMODtl(params);
	}

	@Override
	public void CstmOpnionDelete(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.CstmOpnionDelete(params);
	}

	@Override
	public int CalMainListCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.CalMainListCnt(params);
	}

	@Override
	public void CRMupdatePseAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.CRMupdatePseAjax(params);
	}

	// ↓ 이 아래로 통계
	@Override
	public List<HashMap<String, String>> getStcCstmGrade(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcCstmGrade(params);
	}

	@Override
	public int getStcCstmCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcCstmCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getStcChanceCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcChanceCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getStcMarkChance(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcMarkChance(params);
	}

	@Override
	public List<HashMap<String, String>> getStcGradeGraph(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcGradeGraph(params);
	}

	@Override
	public List<HashMap<String, String>> getStcActGraph(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcActGraph(params);
	}

	@Override
	public List<HashMap<String, String>> getStcMarkGraph(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getStcMarkGraph(params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetCstmAtt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.CRMgetCstmAtt(params);
	}

	@Override
	public List<HashMap<String, String>> gethistList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return iCrmDao.gethistList(params);
	}

	public List<HashMap<String, String>> getGradeHist(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getGradeHist(params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetMarkAtt(HashMap<String, String> params) { 
		return iCrmDao.CRMgetMarkAtt(params);
	}

	@Override
	public void MarkActivityDeleteAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.MarkActivityDeleteAjax(params);
	}

	@Override
	public List<HashMap<String, String>> getCstmHist(HashMap<String, String> params) throws Throwable {
		return iCrmDao.getCstmHist(params);
	}

	@Override
	public void deleteAttFileAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.deleteAttFileAjax(params);
	}
	
	@Override
	public int CRMgetMarkChanceOpinionCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetMarkChanceOpinionCnt(params);
	}

	@Override
	public int CRMgetCstmOpinionCnt(HashMap<String, String> params) throws Throwable {
		return iCrmDao.CRMgetCstmOpinionCnt(params);
	}

	@Override
	public void deleteCstmAttFileAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.deleteCstmAttFileAjax(params);
	}

	@Override
	public void deleteMarkAttFileAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		iCrmDao.deleteMarkAttFileAjax(params);
	}

}
