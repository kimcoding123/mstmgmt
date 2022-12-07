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
 *서비스기준식별항목값내역 DAO
 */
@Repository("srvcrIdnfItmValDtlsDAO")
@SuppressWarnings({"unchecked","rawtypes"})
public class SrvcrIdnfItmValDtlsDAO extends EgovAbstractDAO {

	//서비스기준식별항몪값내역 삭제
	public void deleteSrvcrIdnfItmValDtls(Map map) throws Exception {
		delete("srvcrIdnfItmValDtls.deleteSrvcrIdnfItmValDtls",map);
	}
	//서비스기준내역 조회
	public List selectSrvcrDtls(Map map) throws Exception {
		return list("srvcrIdnfItmValDtls.selectSrvcrDtls",map);
	}
	//서비스기준내역 조회2 추가 (로우)
	public List selectSrvcrValDtls(Map map) throws Exception {
		return list("srvcrIdnfItmValDtls.selectSrvcrValDtls",map);
	}
	public void updateSrvcrIdnfItmValDtls(Map map) throws Exception {
		update("srvcrIdnfItmValDtls.updateSrvcrIdnfItmValDtls", map);
	}
	//서비스기준식별항목값내역 조회
	public List selectsrvcrIdnfItmValDtls(Map map) throws Exception {
		return list("srvcrIdnfItmValDtls.selectSrvcrIdnfItmValDtls", map);
	}
	//서비스기준식별항목값내역 등록
	public void inertSrvcrIdnfItmValDtls(List list) throws Exception{
		insert("srvcrIdnfItmValDtls.inertSrvcrIdnfItmValDtls",list);
	}
	public int selectMaxIndfItmValDtlsSn(Map map) throws Exception{
		return (int) select("srvcrIdnfItmValDtls.selectMaxIndfItmValDtlsSn",map);
	}
	
	
}
