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

@Repository("srvcrHistDAO")
public class SrvcrHistDAO extends EgovAbstractDAO {


	/**
	 * 서비스 기준 이력 등록
	 */
	public void insertSrvcrHist(Map map) throws Exception {
		insert("srvcrHist.insertSrvcrHist", map);
	}
	/**
	 * 서비스 기준 이력 등록
	 */
	public void updateSrvcrHist(Map map) throws Exception {
		insert("srvcrHist.updateSrvcrHist", map);
	}
	/**
	 * 서비스 기준 이력 조회
	 */
	public List selectSrvcrHist(Map map) throws Exception {
		return list("srvcrHist.selectSrvcrHist", map);
	}
	
	
	
}
