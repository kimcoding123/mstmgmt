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
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.system.service.PgmMngService;
import egovframework.system.service.UserMngService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * @Class Name : CmmCdServiceImpl.java
 * @Description : 공통코드서비스
 */
@SuppressWarnings({"unchecked","rawtypes"})
@Service("pgmMngService")
public class PgmMngServiceImpl extends EgovAbstractServiceImpl implements PgmMngService {

	private static final Logger LOGGER = LoggerFactory.getLogger(PgmMngServiceImpl.class);

	@Resource(name = "pgmDAO")
	private PgmDAO pgmDAO;

	@Override
	public List selectPgm(Map param) throws Exception {

		return pgmDAO.selectPgm(param);
	}




	

}
