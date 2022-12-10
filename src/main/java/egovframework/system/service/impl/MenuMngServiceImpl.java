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
package egovframework.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.cmm.service.CmmService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.system.service.MenuMngService;
import egovframework.system.service.UserMngService;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * @Class Name : CmmCdServiceImpl.java
 * @Description : 공통코드서비스
 */
@SuppressWarnings({"unchecked","rawtypes"})
@Service("menuMngService")
public class MenuMngServiceImpl extends EgovAbstractServiceImpl implements MenuMngService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MenuMngServiceImpl.class);

	@Resource(name = "menuDAO")
	private MenuDAO menuDAO;

	@Override
	public List selectUserMenuTree(Map param) throws Exception {

		return menuDAO.selectUserMenuTree(param);
	}

	@Override
	public String selectUserFirstMenu() throws Exception {
		Map param = new HashMap();
		param.put("usrId",EgovUserDetailsHelper.getUserId());
		
		List list = selectUserMenuTree(param);
		String retVal="";
		for(int i=0; i<list.size(); i++) {
			Map map = (Map)list.get(i);
			String pgmFlpth = (String)map.get("pgmFlpth");
			if(StringUtils.isNotEmpty(pgmFlpth)) {
				retVal = pgmFlpth;
				break;
			}
		}
		return retVal;
	}



	

}
