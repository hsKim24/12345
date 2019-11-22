package com.gd.heywe.web.bm.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gd.heywe.util.Utils;

@Repository
public class bmDao implements IBmDao {
	@Autowired
	public SqlSession sqlSession;
	// 김영찬
	// 경영관리 메인
	// 캘린더 데이터 가져오기
	@Override
	public List<HashMap<String, String>> getCal(HashMap<String, String> params) throws Throwable {
		return Utils.toLowerListMapKey(sqlSession.selectList("bm.getCal", params));
	}
	// 일정 목록
	@Override
	public List<HashMap<String, String>> getSchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getSchList", params);
	}
	
	// 신용카드 관리
	// 카드 구분 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getCardDivList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCardDivList", params);
	}
	// 카드사 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getCardCoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCardCoList", params);
	}
	// 신용카드 등록
	@Override
	public void insertCrdtCard(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertCrdtCard", params);
	}
	// 신용카드 관리 리스트 카운트
	@Override
	public int getCrdtCardMgntCnt(HashMap<String, String> params) throws Throwable {
		return  sqlSession.selectOne("bm.getCrdtCardMgntCnt", params);
	}
	// 신용카드 관리 리스트 조회
	@Override
	public List<HashMap<String, String>> getCrdtCardMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCrdtCardMgntList", params);
	}
	// 사원 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getEmpSearchPopup", params);
	}
	// 선택한 카드 정보 조회 (수정 시)
	@Override
	public HashMap<String, String> getCrdtCardInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getCrdtCardInfo", params);
	}
	// 신용카드 수정
	@Override
	public void updateCrdtCard(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateCrdtCard", params);
	}
	// 신용카드 삭제
	@Override
	public int delCrdtCard(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("bm.delCrdtCard", params);
	}
	
	// 계좌 관리
	// 계좌 구분 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getAcntDivList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getAcntDivList", params);
	}
	// 은행 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getBankList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getBankList", params);
	}
	// 계좌 등록
	@Override
	public void insertAcnt(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertAcnt", params);
	}
	// 계좌 관리 리스트 카운트
	@Override
	public int getAcntMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getAcntMgntCnt", params);
	}
	// 계좌 관리 리스트 조회
	@Override
	public List<HashMap<String, String>> getAcntMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getAcntMgntList", params);
	}
	// 선택한 계좌 정보 조회 (수정 시)
	@Override
	public HashMap<String, String> getAcntInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getAcntInfo", params);
	}
	// 계좌 수정
	@Override
	public void updateAcnt(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateAcnt", params);
	}
	// 계좌 삭제
	@Override
	public int delAcnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("bm.delAcnt", params);
	}
	
	// 급여 계산
	// 직위 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getPosiList", params);
	}
	// 급여 계산 리스트 카운트
	@Override
	public int getSalCalcCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalCalcCnt", params);
	}
	// 급여 계산 리스트 조회
	@Override
	public List<HashMap<String, String>> getSalCalcList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getSalCalcList", params);
	}
	// 급여 계산 리스트 삽입
	@Override
	public void insertSalCalcList() throws Throwable {
		sqlSession.insert("bm.insertSalCalcList");
	}
	// 급여 자동 계산
	@Override
	public void insertSalAutoCalc(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertSalAutoCalc", params);
	}
	// 계산한 실급여 급여 계산 테이블에 업데이트
	@Override
	public void updateSalAutoCalc(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateSalAutoCalc", params);
	}
	// 급여 명세 내역 (팝업)
	@Override
	public HashMap<String, String> getSalBkdwnHist(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalBkdwnHist", params);
	}
	// 급여 계산 결재권자 가져오기
	@Override
	public List<HashMap<String, String>> getSalCalcApvAuther(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getSalCalcApvAuther", params);
	}
	// 급여 계산 결재리스트 가져오기
	@Override
	public List<HashMap<String, String>> getSalCalcApvList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getSalCalcApvList", params);
	}
	// 급여 계산 결재 상태 가져오기
	@Override
	public String getSalCalcApvState(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalCalcApvState", params);
	}
	
	// 급여 조회
	@Override
	public HashMap<String, String> getSalAsk(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalAsk", params);
	}
	
	
	// 최익섭
	// 매입채무 관리 리스트 카운트
	@Override
	public int getPurcDebtMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getPurcDebtMgntCnt", params);
	}

	// 최익섭

	// 매입채무 관리 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getPurcDebtMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getPurcDebtMgntList", params);
	}
	
	// 매출채권 관리 리스트 카운트
	@Override
	public int getSalesBondMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalesBondMgntCnt", params);
	}
	
	// 매출채권 관리 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getSalesBondMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getSalesBondMgntList", params);
	}
	
	
	// 적요명 구분 셀렉 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getCsptsNameDivList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCsptsNameDivList", params);
	}
	
	// 거래처 구분 셀렉 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getCstmDivList(HashMap<String, String> params) {
		return sqlSession.selectList("bm.getCstmDivList", params);
	}
	
	// 매입채무 등록하기
	@Override
	public void insertPurcDebt(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertPurcDebt", params);
	}
	
	// 매출채권 등록하기
	@Override
	public void insertSalesBond(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertSalesBond", params);
		
	}
	
	// 대출유형 구분 셀렉 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getLoanTypeDivList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getLoanTypeDivList", params);
	}

	// 선택된 매입채무 정보 가져오기
	@Override
	public HashMap<String, String> getPurcDebtInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getPurcDebtInfo", params);
	}
	
	// 매입채무 수정
	@Override
	public void updatePurcDebt(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updatePurcDebt", params);
	}
	
	// 선택된 매출채권 정보 가져오기
	@Override
	public HashMap<String, String> getSalesBondInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalesBondInfo", params);
	}
	
	// 매출채권 수정
	@Override
	public void updateSalesBond(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateSalesBond", params);
		
	}
	
	// 매입채무 삭제
	@Override
	public int delPurcDebt(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("bm.delPurcDebt", params);
	}
	
	// 매출채권 삭제
	@Override
	public int delSalesBond(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("bm.delSalesBond", params);
	}
	
	
	// 매입채무, 매출채권 상환
	@Override
	public void rpayRtn(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.rpayRtn", params);
	}
	
	// 상세내역 가져오기
	@Override
	public HashMap<String, String> getDtlHist(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getDtlHist", params);
	}
	
	// 상환내역 가져오기
	@Override
	public List<HashMap<String, String>> getRpayRtnHistList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getRpayRtnHistList", params);
	}
	
	// 계정과목 삭제
	@Override
	public int delUnitSbjct(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("bm.delUnitSbjct", params);
	}
	// 선택된 계정과목 정보 가져오기
	@Override
	public HashMap<String, String> getUnitSbjctInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getUnitSbjctInfo", params);
	}
	// 계정과목 등록
	@Override
	public void insertUnit(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertUnit", params);
		
	}
	// 계정과목 관리 리스트 카운트
	@Override
	public int getUnitSbjctMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getUnitSbjctMgntCnt", params);
	}
	// 계정과목 관리 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getUnitSbjctMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getUnitSbjctMgntList", params);
	}
	// 계정과목 수정
	@Override
	public void updateUnitSbjct(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateUnitSbjct", params);
	}
	
	// 거래처 삭제
	@Override
	public int delCstm(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("bm.delCstm", params);
	}
	// 선택된 거래처 정보 가져오기
	@Override
	public HashMap<String, String> getCstmInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getCstmInfo", params);
	}
	// 거래처 등록
	@Override
	public void insertCstm(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertCstm", params);
		
	}
	// 거래처 관리 리스트 카운트
	@Override
	public int getCstmMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getCstmMgntCnt", params);
	}
	// 거래처 관리 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getCstmMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCstmMgntList", params);
	}
	// 거래처 수정
	@Override
	public void updateCstm(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateCstm", params);
	}
	
	// 위지훈
	/* 비용관리 */
	
	// 비용관리 페이지 수
	@Override
	public int getCostMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getCostMgntCnt", params);
	}
	// 비용관리 조회화면 리스트
	@Override
	public List<HashMap<String, String>> getCostMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCostMgntList", params);
	}
	// 비용관리 계정과목 리스트
	@Override
	public List<HashMap<String, String>> getUnitSbjList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getUnitSbjList", params);
	}
	// 비용관리 지출유형 리스트
	@Override
	public List<HashMap<String, String>> getExpsTypeList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getExpsTypeList", params);
	}
	// 비용관리 분류 리스트
	@Override
	public List<HashMap<String, String>> getTypeList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getTypeList", params);
	}
	// 비용관리 이름 리스트
	@Override
	public List<HashMap<String, String>> getEmpNameList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getEmpNameList", params);
	}
	// 비용관리 신규등록
	@Override
	public void insertCostMgnt(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertCostMgnt", params);
	}
	// 비용관리 체크정보 가져오기
	@Override
	public HashMap<String, String> getCostMgntInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getCostMgntInfo", params);
	}
	// 비용관리 수정
	@Override
	public void updateCostMgnt(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateCostMgnt", params);
	}
	// 비용관리 삭제
	@Override
	public int delCostMgnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("bm.delCostMgnt", params);
	}
	
	/* 매출액관리 */
	
	// 매출액관리 페이징 수
	@Override
	public int getSalesAmtMgntCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalesAmtMgntCnt", params);
	}
	// 매출액관리 조회화면 리스트
	@Override
	public List<HashMap<String, String>> getSalesAmtMgntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getSalesAmtMgntList", params); 
	}
	// 매출액관리 고객사 리스트
	@Override
	public List<HashMap<String, String>> getCstmList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCstmList", params);
	}
	// 매출액관리 적요명 리스트
	@Override
	public List<HashMap<String, String>> getCsptsList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getCsptsList", params);
	}
	// 매출액관리 지급방법 리스트
	@Override
	public List<HashMap<String, String>> getPayProvList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getPayProvList", params);
	}
	// 매출액관리 부서 리스트
	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getDeptList", params);
	}
	// 매출액관리 신규등록
	@Override
	public void insertSalesAmtMgnt(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("bm.insertSalesAmtMgnt", params);
	}
	// 매출액관리 삭제(수정)
	@Override
	public Object deleteSalesAmtMgnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("bm.deleteSalesAmtMgnt", params);
	}
	
	
	//체크된 정보 가져오기
	@Override
	public HashMap<String, String> getSalesInfo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("bm.getSalesInfo", params);
	}
	
	// 통계 
	// 통계 비용 년도 가져오기
	@Override
	public List<HashMap<String, String>> getStsCostYearList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsCostYearList", params);
	}
	// 통계 비용 월 가져오기
	@Override
	public List<HashMap<String, String>> getStsCostMonthList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsCostMonthList", params);
	}
	// 통계 비용 적요명 가져오기
	@Override
	public List<HashMap<String, String>> getStsUnitSbjList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsUnitSbjList", params);
	}
	// 통계 비용 적요명 내용가져오기
	@Override
	public List<HashMap<String, String>> getStsUnitSbjConList(HashMap<String, String> params) throws Throwable {
		System.out.println(params);
		return sqlSession.selectList("bm.getStsUnitSbjConList", params);
	}
	// 통계 매출액관리 적요명 가져오기
	@Override
	public List<HashMap<String, String>> getStsSalesTypeList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsSalesTypeList", params);
	}
	// 통계 매출액 월 가져오기
	@Override
	public List<HashMap<String, String>> getStsSalesMonthList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsSalesMonthList", params);
	}
	// 통계 매출액 년 가져오기
	@Override
	public List<HashMap<String, String>> getStsSalesYearList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsSalesYearList", params);
	}
	@Override
	public List<HashMap<String, String>> getStsSalesTypeConList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.getStsSalesTypeConList", params);
	}
	@Override
	public void updateSalesAcnt(HashMap<String, String> params) throws Throwable {
		sqlSession.update("bm.updateSalesAcnt", params);
		
	}
	@Override
	public List<HashMap<String, String>> AcntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("bm.AcntList", params);
	}




	
	
	
}
