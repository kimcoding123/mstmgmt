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

import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import org.springframework.stereotype.Repository;

/**
 * 공통 DAO
 */
@SuppressWarnings({"unchecked","rawtypes"})
@Repository("cmmDAO")
public class CmmDAO extends EgovAbstractDAO {


	/**
	 * 공통코드 상세 조회
	 */
	public List<?> selectCmmCdDtlList(CmmCdDtlVo cmmCdDtlVo) throws Exception {
		return list("cmm.selectCmmCdDtlList", cmmCdDtlVo);
	}
	/**
	 * 이력용 시작일시, 종료일시 조회
	 * */
	
	public Map<String, String> selectBgngEndDt() throws Exception {
		return (Map<String, String>)select("cmm.selectBgngEndDt");
	}
	
	public String selectAtcflId()throws Exception {
		return (String)select("cmm.selectAtcflId");
	}
	/**
	 * 통합업무테이블 조회
	 */
	public List selectTb(Map map) throws Exception {
		return list("cmm.selectTb", map);
	}
	/**
	 * 통합업무테이블 등록
	 */
	public void insertTb(Map map) throws Exception{
		insert("cmm.insertTb", map);
	}
	/**
	 * 통합업무테이블 변경
	 */
	public void updateTb(Map map) throws Exception{
		insert("cmm.updateTb", map);
	}
	/**
	 * 통합업무테이블 삭제
	 */
	public void deleteTb(Map map) throws Exception{
		insert("cmm.deleteTb", map);
	}
	/**
	 * 접근제어컴포넌트id 목록 (12.10 추가)
	 */
	public List<?> selectAcctlCmpntId(Map param) throws Exception {
		return list("scrnCmpntAcctl.selectAcctlCmpntId", param);
	}

}
