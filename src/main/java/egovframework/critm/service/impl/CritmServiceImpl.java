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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.cmm.service.CmmService;
import egovframework.cmm.service.impl.CmmDAO;
import egovframework.critm.service.CritmService;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.srvcr.service.SrvcrService;
import egovframework.srvcr.service.impl.SrvcrDAO;
import egovframework.srvcr.service.impl.SrvcrHistDAO;
import egovframework.srvcr.service.impl.SrvcrItmDtlsDAO;
import egovframework.srvcr.service.impl.SrvcrItmDtlsHistDAO;
import egovframework.util.DateUtil;

import javax.annotation.Resource;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * @Class Name : CmmCdServiceImpl.java
 * @Description : 공통코드서비스
 */

@Service("critmService")
@SuppressWarnings({"unchecked","rawtypes"})
public class CritmServiceImpl extends EgovAbstractServiceImpl implements CritmService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CritmServiceImpl.class);

	@Resource(name = "cmmService")
	private CmmService cmmService;
	
	@Resource(name = "critmDAO")
	private CritmDAO critmDAO;
	

	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	

	
	@Override
	public List selectCritm(Map map) throws Exception {
		return critmDAO.selectCritm(map);
	}

	@Override
	public void registCritm(String tblNm, List<Map> createList, List<Map> updateList, List<Map> deleteList) throws Exception {
		Map param = new HashMap();
		param.put("tblNm",tblNm);
		// 불필요 int cnt = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(param);
		
		//이력용 시작일시, 종료일시 조회
		Map mapBgngEndDt = cmmService.selectBgngEndDt();

		for(int i = 0 ; i < createList.size() ; i++) {
			Map map = createList.get(i);			
			map.putAll(mapBgngEndDt); // map 합치기
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//식별자가 추가되면 데이터 꼬이므로 
				throw new Exception("데이터가 존재합니다. 식별항목은 추가할수 없습니다.");
			}
			//1.등록하고
			critmDAO.insertCritm(map);			
			//2.이력쌓고
			critmHistDAO.insertCritmHist(map);
		}
		for(int i = 0 ; i < updateList.size() ; i++) {		
			Map map = updateList.get(i);	
			map.putAll(mapBgngEndDt);
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//식별자가 추가되면 데이터 꼬이므로 
				throw new Exception("데이터가 존재합니다. 식별항목은 변경할수 없습니다.");
			}
			//1.변경하고
			critmDAO.updateCritm(map);
			//2.기존이력 종료일시 변경하고
			critmHistDAO.updateCritmHist(map);
			//3.이력쌓고
			critmHistDAO.insertCritmHist(map);
		}
		for(int i = 0 ; i < deleteList.size() ; i++) {
			Map map = deleteList.get(i);
			map.putAll(mapBgngEndDt);
			//일반항목값삭제
			srvcrIdnfItmValDtlsDAO.deleteSrvcrIdnfItmValDtls(map);
			//식별항목값삭제
			srvcrGenItmValDtlsDAO.deleteSrvcrGenItmValDtls(map);
			//서비스기준항목내역이력삭제
			srvcrItmDtlsHistDAO.deleteSrvcrItmDtlsHist(map);
			//서비스기준항목내역삭제
			srvcrItmDtlsDAO.deleteSrvcrItmDtls(map);
			
			
		}
	} // end of registTb		

}
