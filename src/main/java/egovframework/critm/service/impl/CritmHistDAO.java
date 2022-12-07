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
package egovframework.critm.service.impl;

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

@Repository("critmHistDAO")
public class CritmHistDAO extends EgovAbstractDAO {


	
	/**
	 * 기준항목 조회
	 */
	public List selectCritmHist(Map map) throws Exception {
		return list("critm.selectCritmHist", map);
	}

	/**
	 * 기준항목 등록
	 */
	public void insertCritmHist(Map map) throws Exception{
		insert("critm.insertCritmHist", map);
	}
	/**
	 * 기준항목 변경
	 */
	public void updateCritmHist(Map map) throws Exception{
		insert("critm.updateCritmHist", map);
	}
	/**
	 * 기준항목 삭제
	 */
	public void deleteCritmHist(Map map) throws Exception{
		insert("critm.deleteCritmHist", map);
	}
	
	
	
}
