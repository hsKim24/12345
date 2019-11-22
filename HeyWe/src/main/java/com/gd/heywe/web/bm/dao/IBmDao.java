package com.gd.heywe.web.bm.dao;

import java.util.HashMap;
import java.util.List;

public interface IBmDao {
	// 김영찬
	// 경영관리 메인
	// 캘린더 데이터 가져오기
	public List<HashMap<String, String>> getCal(HashMap<String, String> params) throws Throwable;
	// 일정 목록
	public List<HashMap<String, String>> getSchList(HashMap<String, String> params) throws Throwable;
	
	// 신용카드 관리
	// 카드 구분 리스트 가져오기
	public List<HashMap<String, String>> getCardDivList(HashMap<String, String> params) throws Throwable;
	// 카드사 리스트 가져오기
	public List<HashMap<String, String>> getCardCoList(HashMap<String, String> params) throws Throwable;
	// 신용카드 등록
	public void insertCrdtCard(HashMap<String, String> params) throws Throwable;
	// 신용카드 관리 리스트 카운트
	public int getCrdtCardMgntCnt(HashMap<String, String> params) throws Throwable;
	// 신용카드 관리 리스트 조회
	public List<HashMap<String, String>> getCrdtCardMgntList(HashMap<String, String> params) throws Throwable;
	// 사원 리스트 가져오기
	public List<HashMap<String, String>> getEmpSearchPopup(HashMap<String, String> params) throws Throwable;
	// 선택한 카드정보 조회 (수정 시)
	public HashMap<String, String> getCrdtCardInfo(HashMap<String, String> params) throws Throwable;
	// 신용카드 수정
	public void updateCrdtCard(HashMap<String, String> params) throws Throwable;
	// 신용카드 삭제
	public int delCrdtCard(HashMap<String, String> params) throws Throwable;
	
	// 계좌 관리
	// 계좌 구분 리스트 가져오기
	public List<HashMap<String, String>> getAcntDivList(HashMap<String, String> params) throws Throwable;
	// 은행 리스트 가져오기
	public List<HashMap<String, String>> getBankList(HashMap<String, String> params) throws Throwable;
	// 계좌 등록
	public void insertAcnt(HashMap<String, String> params) throws Throwable;
	// 계좌 관리 리스트 카운트
	public int getAcntMgntCnt(HashMap<String, String> params) throws Throwable;
	// 계좌 관리 리스트 조회
	public List<HashMap<String, String>> getAcntMgntList(HashMap<String, String> params) throws Throwable;
	// 선택한 계좌 정보 조회 (수정 시)
	public HashMap<String, String> getAcntInfo(HashMap<String, String> params) throws Throwable;
	// 계좌 수정
	public void updateAcnt(HashMap<String, String> params) throws Throwable;
	// 계좌 삭제
	public int delAcnt(HashMap<String, String> params) throws Throwable;
	
	// 급여 계산
	// 직위 리스트 가져오기
	public List<HashMap<String, String>> getPosiList(HashMap<String, String> params) throws Throwable;
	// 급여 계산 리스트 카운트
	public int getSalCalcCnt(HashMap<String, String> params) throws Throwable;
	// 급여 계산 리스트 조회
	public List<HashMap<String, String>> getSalCalcList(HashMap<String, String> params) throws Throwable;
	// 급여 계산 리스트 삽입
	public void insertSalCalcList() throws Throwable;
	// 급여 자동 계산
	public void insertSalAutoCalc(HashMap<String, String> params) throws Throwable;
	// 계산한 실급여 급여 계산 테이블에 업데이트
	public void updateSalAutoCalc(HashMap<String, String> params) throws Throwable;
	// 급여 명세 내역 (팝업)
	public HashMap<String, String> getSalBkdwnHist(HashMap<String, String> params) throws Throwable;
	// 급여 계산 결재권자 가져오기
	public List<HashMap<String, String>> getSalCalcApvAuther(HashMap<String, String> params) throws Throwable;
	// 급여 계산 결재리스트 가져오기
	public List<HashMap<String, String>> getSalCalcApvList(HashMap<String, String> params) throws Throwable;
	// 급여 계산 결재 상태 가져오기
	public String getSalCalcApvState(HashMap<String, String> params) throws Throwable;

	// 급여 조회
	public HashMap<String, String> getSalAsk(HashMap<String, String> params) throws Throwable;

	
	// 최익섭
	
	// 매입채무 관리 리스트 카운트
	public int getPurcDebtMgntCnt(HashMap<String, String> params) throws Throwable;
	// 매입채무 관리 리스트 가져오기
	public List<HashMap<String, String>> getPurcDebtMgntList(HashMap<String, String> params) throws Throwable;
	// 매출채권 관리 리스트 카운트
	public int getSalesBondMgntCnt(HashMap<String, String> params) throws Throwable;
	// 매출채권 관리 리스트 가져오기
	public List<HashMap<String, String>> getSalesBondMgntList(HashMap<String, String> params) throws Throwable;
	// 적요명 구분 셀렉 리스트 가져오기
	public List<HashMap<String, String>> getCsptsNameDivList(HashMap<String, String> params) throws Throwable;
	// 거래처 구분 셀렉 리스트 가져오기
	public List<HashMap<String, String>> getCstmDivList(HashMap<String, String> params) throws Throwable;
	// 매입채무 등록하기
	public void insertPurcDebt(HashMap<String, String> params) throws Throwable;
	// 매출채권 등록하기
	public void insertSalesBond(HashMap<String, String> params) throws Throwable;
	// 선택된 매입채무 정보 가져오기
	public HashMap<String, String> getPurcDebtInfo(HashMap<String, String> params) throws Throwable;
	// 매입채무 수정
	public void updatePurcDebt(HashMap<String, String> params) throws Throwable;
	// 선택된 매출채권 정보 가져오기
	public HashMap<String, String> getSalesBondInfo(HashMap<String, String> params) throws Throwable;
	// 매출채권 수정
	public void updateSalesBond(HashMap<String, String> params) throws Throwable;
	// 매입채무 삭제
	public int delPurcDebt(HashMap<String, String> params) throws Throwable;
	// 매출채권 삭제
	public int delSalesBond(HashMap<String, String> params) throws Throwable;
	// 매입채무, 매출채권 상환
	public void rpayRtn(HashMap<String, String> params) throws Throwable;
	// 상세내역 가져오기
	public HashMap<String, String> getDtlHist(HashMap<String, String> params) throws Throwable;
	// 상환내역 가져오기
	public List<HashMap<String, String>> getRpayRtnHistList(HashMap<String, String> params) throws Throwable;
	// 선택된 계정과목 정보 가져오기
	public HashMap<String, String> getUnitSbjctInfo(HashMap<String, String> params) throws Throwable;
	// 계정과목 관리 리스트 카운트
	public int getUnitSbjctMgntCnt(HashMap<String, String> params) throws Throwable;
	// 계정과목 관리 리스트 가져오기
	public List<HashMap<String, String>> getUnitSbjctMgntList(HashMap<String, String> params) throws Throwable;
	// 계정과목 등록
	public void insertUnit(HashMap<String, String> params) throws Throwable;
	// 계정과목 수정
	public void updateUnitSbjct(HashMap<String, String> params) throws Throwable;
	// 계정과목 삭제
	public int delUnitSbjct(HashMap<String, String> params) throws Throwable;
	
	// 선택된 거래처 정보 가져오기
	public HashMap<String, String> getCstmInfo(HashMap<String, String> params) throws Throwable;
	// 거래처 관리 리스트 카운트
	public int getCstmMgntCnt(HashMap<String, String> params) throws Throwable;
	// 거래처 관리 리스트 가져오기
	public List<HashMap<String, String>> getCstmMgntList(HashMap<String, String> params) throws Throwable;
	// 거래처 등록
	public void insertCstm(HashMap<String, String> params) throws Throwable;
	// 거래처 수정
	public void updateCstm(HashMap<String, String> params) throws Throwable;
	// 거래처 삭제
	public int delCstm(HashMap<String, String> params) throws Throwable;
	
	
	// 위지훈
	
	/* 비용관리  */
	
	// 비용관리 페이지 수
	public int getCostMgntCnt(HashMap<String, String> params) throws Throwable;
	// 비용관리 조회화면 리스트
	public List<HashMap<String, String>> getCostMgntList(HashMap<String, String> params) throws Throwable;
	// 비용관리 계정과목 리스트
	public List<HashMap<String, String>> getUnitSbjList(HashMap<String, String> params) throws Throwable;
	// 비용관리 지출유형 리스트
	public List<HashMap<String, String>> getExpsTypeList(HashMap<String, String> params) throws Throwable;
	// 비용관리 분류 리스트
	public List<HashMap<String, String>> getTypeList(HashMap<String, String> params) throws Throwable;
	// 비용관리 이름 리스트
	public List<HashMap<String, String>> getEmpNameList(HashMap<String, String> params) throws Throwable;
	// 비용관리 신규등록
	public void insertCostMgnt(HashMap<String, String> params) throws Throwable;
	// 비용관리 체크정보 가져오기
	public HashMap<String, String> getCostMgntInfo(HashMap<String, String> params) throws Throwable;
	// 비용관리 수정
	public void updateCostMgnt(HashMap<String, String> params) throws Throwable;
	// 비용관리 삭제
	public int delCostMgnt(HashMap<String, String> params) throws Throwable;
	
	/* 매출액관리  */
	
	// 매출액관리 페이지 수
	public int getSalesAmtMgntCnt(HashMap<String, String> params) throws Throwable;
	// 매출액관리 조회화면 리스트
	public List<HashMap<String, String>> getSalesAmtMgntList(HashMap<String, String> params) throws Throwable;
	// 매출액관리 고객사 리스트
	public List<HashMap<String, String>> getCstmList(HashMap<String, String> params) throws Throwable;
	// 매출액관리 적요명 리스트
	public List<HashMap<String, String>> getCsptsList(HashMap<String, String> params) throws Throwable;
	// 매출액관리 지급방법 리스트
	public List<HashMap<String, String>> getPayProvList(HashMap<String, String> params) throws Throwable;
	// 매출액관리 부서 리스트
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable;
	// 매출액관리 신규등록
	public void insertSalesAmtMgnt(HashMap<String, String> params) throws Throwable;
	// 매출액관리 삭제(수정)
	public Object deleteSalesAmtMgnt(HashMap<String, String> params) throws Throwable;
	// 대출유형 구분 셀렉 리스트 가져오기
	public List<HashMap<String, String>> getLoanTypeDivList(HashMap<String, String> params) throws Throwable;
	// 체크된 정보 가져오기
	public HashMap<String, String> getSalesInfo(HashMap<String, String> params) throws Throwable;
	
	//통계
	//통계 비용 년도 가져오기
	public List<HashMap<String, String>> getStsCostYearList(HashMap<String, String> params) throws Throwable;
	//통계 비용 월 가져오기
	public List<HashMap<String, String>> getStsCostMonthList(HashMap<String, String> params) throws Throwable;
	//통계 비용 적요명 가져오기
	public List<HashMap<String, String>> getStsUnitSbjList(HashMap<String, String> params) throws Throwable;
	//통계 비용 적요명 내용 가져오기
	public List<HashMap<String, String>> getStsUnitSbjConList(HashMap<String, String> params) throws Throwable;
	//통계 매출액관리 년가져오기
	public List<HashMap<String, String>> getStsSalesTypeList(HashMap<String, String> params) throws Throwable;
	//통계 매출액관리 월 가져오기
	public List<HashMap<String, String>> getStsSalesMonthList(HashMap<String, String> params) throws Throwable;
	//통계 매출액관리 적요명 가져오기
	public List<HashMap<String, String>> getStsSalesYearList(HashMap<String, String> params) throws Throwable;
	//통계 매출액관리 적요명 내용 가져오기
	public List<HashMap<String, String>> getStsSalesTypeConList(HashMap<String, String> params) throws Throwable;
	// 계좌연동
	public void updateSalesAcnt(HashMap<String, String> params) throws Throwable;
	public List<HashMap<String, String>> AcntList(HashMap<String, String> params) throws Throwable;
}
