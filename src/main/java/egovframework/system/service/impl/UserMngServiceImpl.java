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
@Service("userMngService")
public class UserMngServiceImpl extends EgovAbstractServiceImpl implements UserMngService {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserMngServiceImpl.class);

	@Resource(name = "userDAO")
	private UserDAO userDAO;

	@Override
	public Map selectUserByLoginId(String loginId) throws Exception {
		Map<String, String> param = new HashMap();
		param.put("loginId",  loginId);
		
		return userDAO.selectUser(param);
	}
	
	public Map login(String loginId, String password)throws Exception{
		
		Map<String, String> user = selectUserByLoginId(loginId);
		if(user != null) {
			String pwd = user.get("pwd");
			if(password.equals(pwd)) {
				return user;
			}
		}
		return null;
	}



	

}
