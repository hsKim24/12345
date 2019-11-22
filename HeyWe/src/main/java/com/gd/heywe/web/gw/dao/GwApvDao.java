package com.gd.heywe.web.gw.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class GwApvDao implements IGwApvDao{
	@Autowired
	SqlSession sqlSession;

	@Override
	public int getApvDocCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("apv.getApvDocCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getApvDocList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getApvDocList",params);
	}

	@Override
	public List<HashMap<String, String>> getApvTypeDivList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getApvTypeDivList",params);
	}

	@Override
	public List<HashMap<String, String>> getApvDocTypeList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getApvDocTypeList",params);
	}

	@Override
	public HashMap<String, String> getApvDocType(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("apv.getApvDocType",params);
	}

	@Override
	public List<HashMap<String, String>> getDeptList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getDeptList",params);
	}

	@Override
	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getEmpList",params);
	}

	@Override
	public List<HashMap<String, String>> getSApvLineNames(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getSApvLineNames",params);
	}

	@Override
	public List<HashMap<String, String>> getSApvLineList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getSApvLineList",params);
	}
	
	@Transactional
	@Override
	public void saveNewApvLine(HashMap<String, String> params) throws Throwable {
		//저장결재라인번호 취득
		int saveApvLineNo = sqlSession.selectOne("apv.getSaveApvLineNo", params);
		params.put("saveApvLineNo", Integer.toString(saveApvLineNo));
		
		//결재라인명으로 결재라인 저장
		sqlSession.insert("apv.insertNewApvLine", params);
		
		//결재자 결재라인에 추가
		String[] apverArr = params.get("exceptEmpNo").split(",");
		for(int i = 0; i < apverArr.length; i++) {
			params.put("apverEmpNo", apverArr[i]);
			sqlSession.insert("apv.addApverToSave", params);
		}
	}

	@Override
	public int delApvLine(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("apv.delApvLine",params);
	}
	
	@Override
	public HashMap<String, String> getApvDocDtl(HashMap<String, String> params) throws Throwable {
		HashMap<String, String> data = sqlSession.selectOne("apv.getApvDocDtl", params);
		
		System.out.println(data);
		return data;
	}

	@Override
	public List<HashMap<String, String>> getApvDocDtlMenList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getApvDocDtlMenList", params);
	}


	@Override
	public List<HashMap<String, String>> getApverList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getApverList",params);
	}
	
	@Transactional
	// 일반결재 and 외부결재 공통 메소드
	@Override
	public void reportApv(HashMap<String, String> params) throws Throwable {
		// 외부결재 시 넘겨주어야할 데이터들  
		// 시행일 	:	#{impDate}
		// 제목 	:	#{title}  
		// 내용	:	#{con} 
		// 확장내용:	#{expCon} 
		// 전결 가능 여부 :	#{allApvWhether}
		// 외부결재유형번호 : #{outApvTypeNo} 
		// 연결번호 : 	#{connectNo}			ex) 인사발령의 경우 인사발령번호를 넣어주면 됨. 
		// 결재자 : 	#{apverNos}				ex) 20190001,20180002,20190003  <- 이런 형식
		
		//결재번호 취득
		int apvNo = sqlSession.selectOne("apv.getApvNo", params);
		params.put("apvNo", Integer.toString(apvNo));
		
		//상신
		if(!params.containsKey("outApvTypeNo") || params.get("outApvTypeNo") == null) {
			params.put("outApvTypeNo", "");
		}
		if(!params.containsKey("connectNo") || params.get("connectNo") == null) {
			params.put("connectNo", "");
		}
		sqlSession.insert("apv.insertApv", params);
		
		//첨부파일 저장
		if(params.get("attList") != null && params.get("attList") != "") {
			String[] attFileArr = params.get("attList").split("/");
			for(int i = 0; i < attFileArr.length; i++) {
				params.put("attFileName", attFileArr[i]);
				sqlSession.insert("apv.addAttFile", params);
			}
		}
		
		//결재자 결재라인에 추가
		String[] apverArr = params.get("apverNos").split(",");
		for(int i = 0; i < apverArr.length; i++) {
			params.put("apverEmpNo", apverArr[i]);
			sqlSession.insert("apv.addApverToLine", params);
		}
	}
	
	//코멘트가져오기
	@Override
	public HashMap<String, String> getOpinion(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("apv.getOpinion", params);
	}

	@Override
	public void deleteApvDoc(HashMap<String, String> params) throws Throwable {
		sqlSession.update("apv.deleteApvDoc", params);
	}
	
	//해당 결재에 첨부파일 리스트 가져오기
	@Override
	public List<HashMap<String, String>> getAttFileList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getAttFileList", params);
	}

	@Override
	public HashMap<String, String> getApvState(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("apv.getApvState", params);
	}

	@Override
	public void doApv(HashMap<String, String> params) throws Throwable {
		sqlSession.update("apv.doApv", params);
	}

	@Override
	public int updateApv(HashMap<String, String> params) throws Throwable {
		
		//첨부파일 업데이트
		sqlSession.delete("apv.delAttFile", params);
		
		if(params.get("attList") != null && params.get("attList") != "") {
			String[] attFileArr = params.get("attList").split("/");
			for(int i = 0; i < attFileArr.length; i++) {
				params.put("attFileName", attFileArr[i]);
				sqlSession.insert("apv.addAttFile", params);
			}
		}
		
		//결재자 수정
		sqlSession.delete("apv.delApver", params);
	
		String[] apverArr = params.get("apverNos").split(",");
		for(int i = 0; i < apverArr.length; i++) {
			params.put("apverEmpNo", apverArr[i]);
			sqlSession.insert("apv.addApverToLine", params);
		}
		
		//결재문서 수정
		return sqlSession.update("apv.updateApv", params);
	}

	@Override
	public List<HashMap<String, String>> getApvComplete(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("apv.getApvComplete", params);
	}

	@Override
	public int getSavedApvLineCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("apv.getSavedApvLineCnt", params);
	}
}
