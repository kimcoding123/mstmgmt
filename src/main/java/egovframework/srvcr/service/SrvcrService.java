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
package egovframework.srvcr.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.FileVO;

/**
 * 
 *서비스기준  
 */
public interface SrvcrService {


	/**
	 * 서비스기준 등록
	 */
	public void registSrvcr(List<Map> createList,List<Map> updateList,List<Map> deleteList) throws Exception;
	public List selectHtmlTags(Map map) throws Exception; // 추가
	public List selectSrvcr(Map map) throws Exception;
	public List selectSrvcrHist(Map map) throws Exception;
	public List selectSrvcrItmDtls(Map map) throws Exception;
	public List selectSrvcrItmDtlsNew(Map map) throws Exception;
	public void registSrvcrItmDtls(String srvcrId, List<Map> createList,List<Map> updateList,List<Map> deleteList) throws Exception;
	public List selectSrvcrDtls(Map map) throws Exception;
	public List selectSrvcrValDtls(Map map) throws Exception; // 추가
	public void registSrvcrDtls(List<HashMap> createList,List<HashMap> updateList,List<HashMap> deleteList) throws Exception;
	public void registSrvcrDtlsXlsx(String srvcrId, List<FileVO> list) throws Exception;
	public List selectCritmDmnLstIqiemDtls(Map mpa)throws Exception;
	public List selectCritmRefDtls(Map map)throws Exception;  // 추가
	public List selectcritmDmnData(Map map)throws Exception;
	
}
