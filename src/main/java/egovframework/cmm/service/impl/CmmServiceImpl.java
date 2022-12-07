/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.cmm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.cmm.service.CmmService;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * @Class Name : CmmCdServiceImpl.java
 * @Description : 공통코드서비스
 */
@SuppressWarnings({"unchecked","rawtypes"})
@Service("cmmService")
public class CmmServiceImpl extends EgovAbstractServiceImpl implements CmmService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmServiceImpl.class);

	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;

	/**
	 * 공통코드 상세 조회
	 * */
	@Override
	public List<?> selectCmmCdDtlList(CmmCdDtlVo cmmCdDtlVo) throws Exception {
		return cmmDAO.selectCmmCdDtlList(cmmCdDtlVo);
	}
	/**
	 * 이력용 시작일시, 종료일시 조회
	 * */
	@Override
	public Map selectBgngEndDt() throws Exception {
		return cmmDAO.selectBgngEndDt();
	}
	/*첨부파일id 채번*/
	@Override
	public String getAtcflId() throws Exception {
		return cmmDAO.selectAtcflId();
	}
	/**
	 * 통합업무테이블 조회
	 * */
	@Override
	public List selectTb(Map map) throws Exception {
		return cmmDAO.selectTb(map);
	}

	/**
	 * 작성중
	 * @param tblNm
	 * @param createList
	 * @param updateList
	 * @param deleteList
	 * @throws Exception
	 */
	@Override
	public void registTb(String tblNm, List<Map> createList, List<Map> updateList, List<Map> deleteList) throws Exception {
		Map param = new HashMap();
		param.put("tblNm",tblNm);
		//불필요 int cnt = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(param);
		
		//이력용 시작일시, 종료일시 조회
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		
		for(int i=0 ; i<createList.size() ; i++) {
			Map map = createList.get(i);
			
			map.putAll(mapBgngEndDt);
			// 동일 식별자 존재여부 확인 - DB UNIQUE 제약으로 에러 처리되도록 함
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//식별자가 추가되면 데이터 꼬이므로 
				throw new Exception("데이터가 존재합니다. 식별항목은 추가할수 없습니다.");
			}
			//1.등록하고
			cmmDAO.insertTb(map);
			
			//2.이력 테이블 찾아 이력도 등록 (기본 이력모델 사용하는 경우, 일단 하드코딩)
			if (map.tblNm == "TB0004") {
				map.tblNm = "TB0005"; // 이력
				cmmDAO.insertTb(map);
			}
			
		}
		
		for(int i=0 ; i<updateList.size() ; i++) {
			Map map = updateList.get(i);
			map.putAll(mapBgngEndDt);
			
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//식별자가 추가되면 데이터 꼬이므로 
				throw new Exception("데이터가 존재합니다. 식별항목은 변경할수 없습니다.");
			}
			//1.변경하고
			tBDAO.updateTb(map);
			//2.이력 테이블 찾아 이력도 등록 (기본 이력모델 사용하는 경우, 일단 하드코딩)
			if (map.tblNm == "TB0004") {
				map.tblNm = "TB0005"; // 이력
				cmmDAO.updateTb(map); // 변경전 최종이력 종료시키고
				cmmDAO.insertTb(map); // 최종이력 추가 
			}			
		}
		
		// 과거 이력 모두 삭제? 아니면 이력은 유지? 아니면 마지막이력 update만? -> 규칙 정의 필요
		for(int i=0 ; i<deleteList.size() ; i++) {
			Map map = deleteList.get(i);
			map.putAll(mapBgngEndDt);
			
			//1.삭제
			cmmDAO.deleteTb(map);
			//2.이력 테이블 찾아 이력도 삭제 (기본 이력모델 사용하는 경우, 일단 하드코딩)
			if (map.tblNm == "TB0004") {
				map.tblNm = "TB0005"; // 이력
				cmmDAO.deleteTb(map); // 
			}
		}
	} // end of method
} // end of class
