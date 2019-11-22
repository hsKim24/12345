package com.gd.heywe.web.crm.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gd.heywe.util.Utils;

@Repository
public class CrmDao implements ICrmDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getCRMMarkChanceCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getCRMMarkChanceCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getCRMMarkChanceList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCRMMarkChanceList", params);
		// xml에서 쿼리문 만드세요
	}

	@Override
	public int getCRMCstmCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getCRMCstmCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getCrmCstmList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCrmCstmList", params);
	}

	@Override
	public List<HashMap<String, String>> getDEPTList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getDEPTList", params);
	}

	@Override
	public List<HashMap<String, String>> getDept(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getDept", params);
	}

	@Override
	public List<HashMap<String, String>> getEmp(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getEmp", params);
	}

	@Override
	public HashMap<String, String> getCRMCstmDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getCRMCstmDtl", params);
	}

	@Override
	public List<HashMap<String, String>> getCstmOpnionList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCstmOpnionList", params);
	}

	@Override
	public HashMap<String, String> loginCheck(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.loginCheck", params);
	}

	@Override
	public void opinionInsert(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		sqlSession.insert("CRM.opinionInsert", params);
	}

	@Override
	public List<HashMap<String, String>> getCstmDiv(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCstmDiv", params);
	}

	@Override
	public List<HashMap<String, String>> getCstmGrade(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCstmGrade", params);
	}

	@Override
	public List<HashMap<String, String>> getProgressState(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getProgressState", params);
	}

	@Override
	public void getCstmWrite(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub

		int cstmNo = sqlSession.selectOne("CRM.getCstmNo");
		params.put("cstmNo", String.valueOf(cstmNo));

		if (params.get("att") != null && params.get("att") != "") {
			sqlSession.insert("CRM.getCstmWriteAtt", params);
		}

		sqlSession.insert("CRM.getCstmWrite", params);
	}

	@Override
	public void getCstmUpdate(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		sqlSession.update("CRM.getCstmUpdate", params);
	}

	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getEmpSearchPopup", params);
	}

	@Override
	public HashMap<String, String> selectemp(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.selectemp", params);
	}

	@Override
	public HashMap<String, String> getCRMMarkChanceDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getCRMMarkChanceDtl", params);
	}

	@Override
	public List<HashMap<String, String>> getMarkChanceOpnionList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getMarkChanceOpnionList", params);
	}

	@Override
	public void MarkopinionInsert(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.insert("CRM.MarkopinionInsert", params);
	}

	@Override
	public List<HashMap<String, String>> getcalList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return Utils.toLowerListMapKey(sqlSession.selectList("CRM.getcalList", params));
	}

	@Override
	public List<HashMap<String, String>> getBsnsType(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getBsnsType", params);
	}

	@Override
	public List<HashMap<String, String>> getSalesDiv(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getSalesDiv", params);
	}

	@Override
	public List<HashMap<String, String>> getRecogPath(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getRecogPath", params);
	}

	@Override
	public HashMap<String, String> selectcstm(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.selectcstm", params);
	}

	@Override
	public List<HashMap<String, String>> getCstmSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCstmSearchPopup", params);
	}

	@Override
	public HashMap<String, String> selectmngr(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.selectmngr", params);
	}

	@Override
	public List<HashMap<String, String>> getMngrSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getMngrSearchPopup", params);
	}

	@Override
	public int getCRMMarkMgntContCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getCRMMarkMgntContCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getCRMMarkMgntContList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCRMMarkMgntContList", params);
	}

	@Override
	public HashMap<String, String> getCRMMarkMgntContAsk(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getCRMMarkMgntContAsk", params);
	}

	@Override
	public List<HashMap<String, String>> getcalList2(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getcalList2", params);
	}

	@Override
	public void MarkOpnionDelete(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.delete("CRM.MarkOpnionDelete", params);
	}

	// 성훈이꺼

	@Override
	public List<HashMap<String, String>> getMngrList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMngrList", params);
	}

	@Override
	public int getTestCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getTestCnt", params);
	}

	@Override
	public HashMap<String, String> getMngr(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMngr", params);
	}

	@Override
	public List<HashMap<String, String>> getMngropinion(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMngropinion", params);
	}

	@Override
	public void insertOpinion(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("CRM.insertOpinion", params);
	}

	@Override
	public void deleteOpinion(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("CRM.deleteOpinion", params);
	}

	@Override
	public int getOpiCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getOpiCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getMngrAtt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMngrAtt", params);
	}

	@Override
	public HashMap<String, String> getUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getUpdate", params);
	}

	@Override
	public void updateMngr(HashMap<String, String> params) throws Throwable {
		sqlSession.update("CRM.updateMngr", params);
	}

	@Override
	public List<HashMap<String, String>> getcstmSearchPopup(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getcstmSearchPopup", params);
	}

	@Override
	public void insertMngr(HashMap<String, String> params) throws Throwable {
		// 관리번호 취득
		int mngrNo = sqlSession.selectOne("CRM.getMngrNo");
		params.put("mngrNo", String.valueOf(mngrNo));

		if (params.get("att") != null && params.get("att") != "") {
			sqlSession.insert("CRM.insertMngrAtt", params);
		}

		sqlSession.insert("CRM.insertMngr", params);
	}

	@Override
	public List<HashMap<String, String>> getMCCList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMCCList", params);
	}

	@Override
	public int getMCCCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCCCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getMccEmp(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMccEmp", params);
	}

	@Override
	public List<HashMap<String, String>> getMccDept(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMccDept", params);
	}

	@Override
	public List<HashMap<String, String>> getMccPse(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMccPse", params);
	}

	@Override
	public HashMap<String, String> getMCCDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCCDtl", params);
	}

	@Override
	public List<HashMap<String, String>> getMCCopinion(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMCCopinion", params);
	}

	@Override
	public int getMCCOpiCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCCOpiCnt", params);
	}

	@Override
	public void insertMCCOpinion(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("CRM.insertMCCOpinion", params);
	}

	@Override
	public void deleteMCCOpinion(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("CRM.deleteMCCOpinion", params);
	}

	@Override
	public int getMCOCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCOCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getMCOList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMCOList", params);
	}

	@Override
	public int getMCContCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCContCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getMCContList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMCContList", params);
	}

	@Override
	public HashMap<String, String> getMCODtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCODtl", params);
	}

	@Override
	public HashMap<String, String> getMCContDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMCContDtl", params);
	}

	@Override
	public List<HashMap<String, String>> getMMOList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMMOList", params);
	}

	@Override
	public int getMMOCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMMOCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getmngrSearchPopup(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getmngrSearchPopup", params);
	}

	@Override
	public List<HashMap<String, String>> getchanceSearchPopup(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getchanceSearchPopup", params);
	}

	@Override
	public HashMap<String, String> selectchance(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.selectchance", params);
	}

	@Override
	public void insertOffer(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("CRM.insertOffer", params);
		sqlSession.insert("CRM.insertOffer1", params);
	}

	@Override
	public List<HashMap<String, String>> getcalMainList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getcalMainList", params);
	}

	@Override
	public List<HashMap<String, String>> getcalMainList2(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getcalMainList2", params);
	}

	@Override
	public List<HashMap<String, String>> reloadactivityType(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.reloadactivityType", params);
	}

	@Override
	public List<HashMap<String, String>> getChanceSearchPopup(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getChanceSearchPopup2", params);
	}

	@Override
	public void MarkActivityWriteAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.insert("CRM.MarkActivityWriteAjax", params);
	}

	@Override
	public int CRMMarkActivityCalListCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.CRMMarkActivityCalListCnt", params);
	}

	@Override
	public List<HashMap<String, String>> CRMMarkActivityCalList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.CRMMarkActivityCalList", params);
	}

	@Override
	public HashMap<String, String> getMACDtl(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.getMACDtl", params);
	}

	@Override
	public void MarkActivityUpdateAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.update("CRM.MarkActivityUpdateAjax", params);
	}

	// 찐성훈
	@Override
	public List<HashMap<String, String>> CRMgetMngrList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.CRMgetMngrList", params);
	}

	@Override
	public int CRMgetTestCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.CRMgetTestCnt", params);
	}

	@Override
	public HashMap<String, String> CRMgetMngr(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.CRMgetMngr", params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetMngrAtt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.CRMgetMngrAtt", params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetMngropinion(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.CRMgetMngropinion", params);
	}

	@Override
	public int CRMgetOpiCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.CRMgetOpiCnt", params);
	}

	@Override
	public void CRMinsertOpinion(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("CRM.CRMinsertOpinion", params);
	}

	@Override
	public void CRMdeleteOpinion(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("CRM.CRMdeleteOpinion", params);
	}

	@Override
	public HashMap<String, String> CRMgetUpdateNegoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.CRMgetUpdateNegoList", params);
	}

	// 신

	@Override
	public int getCrmGradeCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getCrmGradeCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getCrmGrade(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getCrmGrade", params);
	}

	@Override
	public void updateGrade(HashMap<String, String> params) throws Throwable {

		sqlSession.update("CRM.updateGrade", params);

		String[] nos = params.get("blockCheck").split(",");

		for (int i = 0; i < nos.length; i++) {
			params.put("blockCheck", nos[i]);
			sqlSession.insert("CRM.updateConDate", params);
		}

	}

	@Override
	public List<HashMap<String, String>> ContWriteList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.ContWriteList", params);
	}

	@Override
	public int ContWriteCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.ContWriteCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getMMNList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getMMNList", params);
	}

	@Override
	public int getMMNCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMMNCnt", params);
	}

	@Override
	public HashMap<String, String> getInsertContList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getInsertContList", params);
	}

	@Override
	public HashMap<String, String> getMMNDtl(HashMap<String, String> params) throws Throwable {

		return sqlSession.selectOne("CRM.getMMNDtl", params);
	}

	@Override
	public HashMap<String, String> getUpdateContList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getUpdateContList", params);
	}

	@Override
	public int NegoWriteCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.NegoWriteCnt", params);
	}

	@Override
	public List<HashMap<String, String>> NegoWriteList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.NegoWriteList", params);
	}

	@Override
	public HashMap<String, String> getInsertNegoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getInsertNegoList", params);
	}

	@Override
	public HashMap<String, String> getMngntOfferHit(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMngntOfferHit", params);
	}

	@Override
	public void updateMngntOffer(HashMap<String, String> params) throws Throwable {
		
		if (params.get("att") != null && params.get("att") != "") {
			sqlSession.insert("CRM.getMarkAtt", params);
		}
		sqlSession.update("CRM.updateMngntOffer", params);
	}

	@Override
	public HashMap<String, String> getMMODtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getMMODtl", params);
	}

	@Override
	public void CstmOpnionDelete(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.delete("CRM.CstmOpnionDelete", params);
	}

	@Override
	public int CalMainListCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CRM.CalMainListCnt", params);
	}

	// 통계

	@Override
	public List<HashMap<String, String>> getStcCstmGrade(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getStcCstmGrade", params);
	}

	@Override
	public int getStcCstmCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.getStcCstmCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getStcChanceCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getStcChanceCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getStcMarkChance(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getStcMarkChance", params);
	}

	@Override
	public List<HashMap<String, String>> getStcGradeGraph(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getStcGradeGraph", params);
	}

	@Override
	public List<HashMap<String, String>> getStcActGraph(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getStcActGraph", params);
	}

	@Override
	public List<HashMap<String, String>> getStcMarkGraph(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getStcMarkGraph", params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetCstmAtt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.CRMgetCstmAtt", params);
	}

// 성훈스 히스토리

	@Override
	public void CRMupdatePseAjax(HashMap<String, String> params) {
		sqlSession.update("CRM.CRMupdatePseAjax", params);
		sqlSession.insert("CRM.CRMupdatePseAjax2", params);
	}

	@Override
	public List<HashMap<String, String>> gethistList(HashMap<String, String> params) {
		return sqlSession.selectList("CRM.gethistList", params);
	}

	@Override
	public void getMarkChanceWrite(HashMap<String, String> params) {
		// TODO Auto-generated method stub

		int markNo = sqlSession.selectOne("CRM.getMarkNo");
		params.put("markNo", String.valueOf(markNo));

		if (params.get("att") != null && params.get("att") != "") {
			sqlSession.insert("CRM.getMarkAtt", params);
		}
		sqlSession.insert("CRM.getMarkChanceWrite", params);
		sqlSession.insert("CRM.getMarkChanceWrite2", params);
		sqlSession.insert("CRM.getMarkChanceWrite3", params);

	}

	@Override
	public void getChanceUpdate(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.update("CRM.getChanceUpdate", params);
	}

	@Override
	public void insertMngntOffer(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("CRM.insertMngntOffer", params);
		sqlSession.insert("CRM.insertMngntOffer2", params);
	}

	@Override
	public void updateMngntOfferAsk(HashMap<String, String> params) throws Throwable {
		sqlSession.update("CRM.updateMngntOfferAsk", params);
		sqlSession.update("CRM.updateMngntOfferAsk2", params);
	}

	@Override
	public void writeNego(HashMap<String, String> params) throws Throwable {

		if (params.get("att") != null && params.get("att") != "") {
			sqlSession.insert("CRM.getMarkAtt", params);
		}

		sqlSession.update("CRM.writeNegoMark", params);
		sqlSession.insert("CRM.writeNego", params);
		sqlSession.insert("CRM.writeNego2", params);
	}

	@Override
	public void CRMupdateNego(HashMap<String, String> params) throws Throwable {
		sqlSession.update("CRM.updateNego", params);
		sqlSession.update("CRM.updateNego2", params);
		sqlSession.update("CRM.updateNegoMark", params);
	}

	@Override
	public void writeCont(HashMap<String, String> params) {
		if (params.get("att") != null && params.get("att") != "") {
			sqlSession.insert("CRM.getMarkAtt", params);
		}
		sqlSession.update("CRM.writeContMark", params);
		sqlSession.insert("CRM.writeCont", params);
		sqlSession.insert("CRM.writeCont2", params);
	}

	@Override
	public void updateCont(HashMap<String, String> params) throws Throwable {
		sqlSession.update("CRM.updateCont", params);
		sqlSession.update("CRM.updateCont2", params);
		sqlSession.update("CRM.updateContMark", params);
	}

	@Override
	public List<HashMap<String, String>> getGradeHist(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("CRM.getGradeHist", params);
	}

	@Override
	public List<HashMap<String, String>> CRMgetMarkAtt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.CRMgetMarkAtt", params);
	}

	@Override
	public void MarkActivityDeleteAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.delete("CRM.MarkActivityDeleteAjax", params);
	}

	@Override
	public List<HashMap<String, String>> getCstmHist(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CRM.getCstmHist", params);
	}

	@Override
	public void deleteAttFileAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.delete("CRM.deleteAttFileAjax", params);
	}
	@Override
	public int CRMgetMarkChanceOpinionCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.CRMgetMarkChanceOpinionCnt", params);
	}

	@Override
	public int CRMgetCstmOpinionCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("CRM.CRMgetCstmOpinionCnt",params);
	}

	@Override
	public void deleteCstmAttFileAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.delete("CRM.deleteCstmAttFileAjax", params);
	}

	@Override
	public void deleteMarkAttFileAjax(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.delete("CRM.deleteMarkAttFileAjax", params);
	}
	
}
