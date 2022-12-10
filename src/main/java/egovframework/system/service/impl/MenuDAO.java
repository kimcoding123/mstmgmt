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

import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import org.springframework.stereotype.Repository;

/**
 * 공통 DAO
 */
@SuppressWarnings({"unchecked","rawtypes"})
@Repository("menuDAO")
public class MenuDAO extends EgovAbstractDAO {


	/**
	 * 사용자 메뉴 트리
	 */
	public List selectUserMenuTree(Map param) throws Exception {
		return list("mnu.selectUserMenuTree", param);
	}
	
}
