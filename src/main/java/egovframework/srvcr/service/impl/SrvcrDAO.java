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
package egovframework.srvcr.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : CmmCdDAO.java
 * @Description : CmmCdDAO DAO Class

 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Repository("srvcrDAO")
public class SrvcrDAO extends EgovAbstractDAO {


	/**
	 * 서비스 기준 등록
	 */
	public String insertSrvcr(Map map) throws Exception {
		return (String)insert("srvcr.insertSrvcr", map);
	}
	/**
	 * 서비스 기준 조회
	 */
	public List selectSrvcr(Map map) throws Exception {
		return list("srvcr.selectSrvcr", map);
	}
	/**
	 * 서비스 기준 조회
	 */
	public String selectSrvcrId() throws Exception {
		return (String)select("srvcr.selectSrvcrId");
	}
	
	/**
	 * 서비스 기준 변경
	 */
	public void updateSrvcr(Map map) throws Exception {
		update("srvcr.updateSrvcr", map);
	}
	/*서비스기준 뷰명 검증하기 위한 건수 조회*/
	public int selectSrvcrViewNmCnt(Map map) throws Exception {
		return (int)select("srvcr.selectSrvcrViewNmCnt", map);
	}
	
}
