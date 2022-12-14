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

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.cmm.service.CmmService;
import egovframework.cmm.service.impl.CmmDAO;
import egovframework.com.cmm.service.FileVO;

import egovframework.com.cmm.util.EgovUserDetailsHelper;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.srvcr.service.SrvcrService;
import egovframework.util.DateUtil;

import javax.annotation.Resource;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.ibatis.sqlmap.client.SqlMapClient;

import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFCell; 
import org.apache.poi.xssf.usermodel.XSSFRow; 
import org.apache.poi.xssf.usermodel.XSSFSheet; 
import org.apache.poi.xssf.usermodel.XSSFWorkbook;



/**
 * @Class Name : CmmCdServiceImpl.java
 * @Description : ?????????????????????
 */

@Service("srvcrService")
@SuppressWarnings({"unchecked","rawtypes"})
public class SrvcrServiceImpl extends EgovAbstractServiceImpl implements SrvcrService {

	private static final Logger LOGGER = LoggerFactory.getLogger(SrvcrServiceImpl.class);

	@Resource(name = "cmmService")
	private CmmService cmmService;
	
	@Resource(name = "srvcrHistDAO")
	private SrvcrHistDAO srvcrHistDAO;
	
	@Resource(name = "srvcrItmDtlsDAO")
	private SrvcrItmDtlsDAO srvcrItmDtlsDAO;
	
	@Resource(name = "srvcrItmDtlsHistDAO")
	private SrvcrItmDtlsHistDAO srvcrItmDtlsHistDAO;
	
	@Resource(name = "srvcrGenItmValDtlsDAO")
	private SrvcrGenItmValDtlsDAO srvcrGenItmValDtlsDAO;
	
	@Resource(name = "srvcrIdnfItmValDtlsDAO")
	private SrvcrIdnfItmValDtlsDAO srvcrIdnfItmValDtlsDAO;
	
	@Resource(name = "critmDmnLstIqiemDtlsDAO")
	private CritmDmnLstIqiemDtlsDAO critmDmnLstIqiemDtlsDAO;
	
	@Resource(name = "critmDmnDAO")
	private CritmDmnDAO critmDmnDAO;
	
	@Resource(name = "srvcrDAO")
	private SrvcrDAO srvcrDAO;
	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	
	@Resource(name = "htmlTagsDAO")
	private HtmlTagsDAO htmlTagsDAO;
	

	@Override
	public void registSrvcr(List<Map> createList, List<Map> updateList, List<Map> deleteList) throws Exception {
		Map defaultMap = EgovUserDetailsHelper.getDefaultMap();
		//????????? ????????????, ???????????? ??????
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		for(int i=0;i<createList.size();i++) {
			Map map = createList.get(i);
			map.putAll(defaultMap);
			//????????? ?????? ????????????
			validSrvcrViewNm(map);
			
			map.putAll(mapBgngEndDt);
			String srvcrId = srvcrDAO.selectSrvcrId();
			map.put("srvcrId", srvcrId);
			//1.????????????
			srvcrDAO.insertSrvcr(map);
			//2.????????????
			map.put("srvcrId", srvcrId);
			srvcrHistDAO.insertSrvcrHist(map);
			
			//??????????????????/???????????? ????????????
			//insertSrvcrItmDtlsVldBgngEndDt(map);
		}
		for(int i=0;i<updateList.size();i++) {
			Map map = updateList.get(i);
			map.putAll(mapBgngEndDt);
			map.putAll(defaultMap);
			
			validSrvcrViewNm(map);
			//1.????????????
			srvcrDAO.updateSrvcr(map);
			//2.???????????? ???????????? ????????????
			srvcrHistDAO.updateSrvcrHist(map);
			//3.????????????
			srvcrHistDAO.insertSrvcrHist(map);
		}
	}
	@Override
	public List selectHtmlTags(Map map) throws Exception {
		return htmlTagsDAO.selectHtmlTags(map);
	}

	@Override
	public List selectSrvcr(Map map) throws Exception {
		return srvcrDAO.selectSrvcr(map);
	}

	@Override
	public List selectSrvcrHist(Map map) throws Exception {
		return srvcrHistDAO.selectSrvcrHist(map);
	}

	@Override
	public List selectSrvcrItmDtls(Map map) throws Exception {
		return srvcrItmDtlsDAO.selectSrvcrItmDtls(map);
	}

	// New ?????? : ??????ID ?????? ???????
	@Override
	public List selectSrvcrItmDtlsNew(Map map) throws Exception {
		return srvcrItmDtlsDAO.selectSrvcrItmDtlsNew(map);
	}
	
	@Override
	public void registSrvcrItmDtls(String srvcrId, List<Map> createList, List<Map> updateList, List<Map> deleteList) throws Exception {
		Map defaultMap = EgovUserDetailsHelper.getDefaultMap();
		Map param = new HashMap();
		param.put("srvcrId",srvcrId);
		int cnt = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(param);
		/*/if(cnt>0) {
			throw new Exception("???????????? ???????????????. ????????? ????????? ?????? ???????????????.");
		}*/
		
		//????????? ????????????, ???????????? ??????
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		for(int i=0;i<createList.size();i++) {
			Map map = createList.get(i);
			
			
			map.putAll(defaultMap);
			map.putAll(mapBgngEndDt);
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//???????????? ???????????? ????????? ???????????? 
				throw new Exception("???????????? ???????????????. ??????????????? ???????????? ????????????.");
			}
			//1.????????????
			srvcrItmDtlsDAO.insertSrvcrItmDtls(map);
			//2.????????????
			srvcrItmDtlsHistDAO.insertSrvcrItmDtlsHist(map);
			
			//??????????????????/???????????? ????????????
			//insertSrvcrItmDtlsVldBgngEndDt(map);
		}
		for(int i=0;i<updateList.size();i++) {
			Map map = updateList.get(i);
			map.putAll(mapBgngEndDt);
			map.putAll(defaultMap);
			
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//???????????? ???????????? ????????? ???????????? 
				throw new Exception("???????????? ???????????????. ??????????????? ???????????? ????????????.");
			}
			//1.????????????
			srvcrItmDtlsDAO.updateSrvcrItmDtls(map);
			//2.???????????? ???????????? ????????????
			srvcrItmDtlsHistDAO.updateSrvcrItmDtlsHist(map);
			//3.????????????
			srvcrItmDtlsHistDAO.insertSrvcrItmDtlsHist(map);
		}
		for(int i=0;i<deleteList.size();i++) {
			Map map = deleteList.get(i);
			map.putAll(mapBgngEndDt);
			//?????????????????????
			srvcrIdnfItmValDtlsDAO.deleteSrvcrIdnfItmValDtls(map);
			//?????????????????????
			srvcrGenItmValDtlsDAO.deleteSrvcrGenItmValDtls(map);
			//???????????????????????????????????????
			srvcrItmDtlsHistDAO.deleteSrvcrItmDtlsHist(map);
			//?????????????????????????????????
			srvcrItmDtlsDAO.deleteSrvcrItmDtls(map);
			
			
		}
		//?????? ???????????????????????
	}	

	public void validSrvcrViewNm(Map map) throws Exception {
		int cnt = selectSrvcrViewNmCnt(map);
		if(cnt!=0) {
			throw new Exception(map.get("srvcrViewNm")+" ?????? ?????? ???????????????.");
		}
	}
	public int selectSrvcrViewNmCnt(Map map) throws Exception {
		return srvcrDAO.selectSrvcrViewNmCnt(map);
		
	}
	
	
	/*
	 * ????????????????????? ?????? : ?????? ????????? ??????
	 * */
	@Override
	public List selectSrvcrValDtls(Map map) throws Exception {
		return srvcrIdnfItmValDtlsDAO.selectSrvcrValDtls(map);		
	}
	
	
	/*
	 * ????????????????????? ??????
	 * 1) map??? ??????????????????, N ??????
	 * 2) list??? srvcrItmDtlsDAO.selectSrvcrItmDtls(map) ?????? ??????
	 * 3) (?????????)list??? ????????? ???????????? itm??? ??????
	 * 4) (?????????)itm?????? critmId????????? sql????????? ", critmId??? varchar" ????????? ????????????
	 * 5) (?????????)columns???????????? ",critmId???" ????????? ????????????
	 * 6) map??? ?????? sql ??????, columns??????
	 * 7) srvcrIdnfItmValDtlsDAO.selectSrvcrDtls(map) ?????? ??????
	 * 8) ?????????, sql????????? ????????? crosstab??? ????????? ?????? ??????
	 * */
	@Override
	public List selectSrvcrDtls(Map map) throws Exception {
		map.put("idnfItmYn","N");
		List list = srvcrItmDtlsDAO.selectSrvcrItmDtls(map);
		StringBuffer columns = new StringBuffer();
		StringBuffer sql = new StringBuffer();
		for(int i=0; i<list.size();i++) {
			Map itm = (Map)list.get(i);
			sql.append(",").append(itm.get("critmId")).append(" varchar ");
			columns.append(",").append(itm.get("critmId"));
		}
		map.put("sql",sql.toString());
		map.put("columns", columns.toString());
		return srvcrIdnfItmValDtlsDAO.selectSrvcrDtls(map);		
	}

	
	/*
	 * ????????????????????? ?????? New
	 * */
	@Override
	public List selectSrvcrDtlsNew(Map map) throws Exception {
		map.put("idnfItmYn","N");
		List list = srvcrItmDtlsDAO.selectSrvcrItmDtlsNew(map);
		StringBuffer columns = new StringBuffer();
		StringBuffer sql = new StringBuffer();
		for(int i=0; i<list.size();i++) {
			Map itm = (Map)list.get(i);
			sql.append(",").append(itm.get("critmId")).append(" varchar ");
			columns.append(",").append(itm.get("critmId"));
		}
		map.put("sql",sql.toString());
		map.put("columns", columns.toString());
		return srvcrIdnfItmValDtlsDAO.selectSrvcrDtlsNew(map);		
	}
	
	
	@Override
	public void registSrvcrDtls(List<HashMap> createList, List<HashMap> updateList, List<HashMap> deleteList) throws Exception {
		//????????? ????????????, ???????????? ??????
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		Map defaultMap = EgovUserDetailsHelper.getDefaultMap();
		
		if(createList.size()>0) {
			List listSrvcrGenItmValDtls = new ArrayList();
			int idnfItmValDtlsSn = 0;
			for(int i=0;i<createList.size();i++) {
				
				HashMap map = (HashMap)createList.get(i);
				Map param = new HashMap();
				param.putAll(map);
				map.putAll(defaultMap);
				
				//??????????????? ????????? ????????? ????????????.
				param.remove("vldEndDt");
				List list = srvcrIdnfItmValDtlsDAO.selectsrvcrIdnfItmValDtls(param);
				if(list!=null && list.size()>0) {
					StringBuffer keys = new StringBuffer();
					for(int j=1; j<=10; j++) {
						if(StringUtils.isEmpty(param.get("idnfItmVal"+j))==false){
							keys.append(","+param.get("idnfItmVal"+j));
						}
					}
					throw new Exception("????????? ????????? ?????? ???????????? ???????????????.["+keys.toString().substring(1)+"]");
				}
				
				if(i==0) {
					idnfItmValDtlsSn = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(map);		
				}
				map.putAll(mapBgngEndDt);//insert ?????? ????????????/???????????? ??????
				map.put("vldEndDt","99991231235959");//???????????? ??????
				map.put("idnfItmValDtlsSn",idnfItmValDtlsSn+i+1);//???????????????????????????????????? ?????????..?????? ???????????? ?????? ????????? ????????? ???????????? ?????????.
				
				List tempList = getMapKey(map);
				if(tempList.size()>0) {
					listSrvcrGenItmValDtls.addAll(tempList);
				}
			}//end of for
			//??????????????? List??? ??????(??????)-->????????? ???????????? ?????? ???????????????id??? ???????????? ???????????? ???????????? ???????????????.  
			//????????? ???????????? ?????? ???????????????ID??? ???????????? ??????????????? ??? for??? ????????? ????????????. DB CALL??? ???????????? ?????????.
			int limit = 2000;//2000?????? ????????? insert--> ??? ????????? ????????? ?????????.
		    for(int i = 0; i < createList.size(); i += limit){
		    	srvcrIdnfItmValDtlsDAO.inertSrvcrIdnfItmValDtls(createList.subList(i, Math.min(i + limit, createList.size())));
		    }

			if(listSrvcrGenItmValDtls.size()>0) {
			    for(int i = 0; i < listSrvcrGenItmValDtls.size(); i += limit){
			        srvcrGenItmValDtlsDAO.insertSrvcrGenItmValDtls(listSrvcrGenItmValDtls.subList(i, Math.min(i + limit, listSrvcrGenItmValDtls.size())));
			    }
			}
		}
		if(updateList.size()>0) {
			List listSrvcrGenItmValDtls = new ArrayList();
			int idnfItmValDtlsSn = 0;
			for(int i=0;i<updateList.size();i++) {
				HashMap map = (HashMap)updateList.get(i);
				map.put("delYn", "N");//???????????? ????????????...
				map.putAll(defaultMap);
				
				if(i==0) {
					idnfItmValDtlsSn = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(map);		
				}
				map.putAll(mapBgngEndDt);
				srvcrIdnfItmValDtlsDAO.updateSrvcrIdnfItmValDtls(map);
				
				map.putAll(mapBgngEndDt);//insert ?????? ????????????/???????????? ??????
				
				map.put("idnfItmValDtlsSn",idnfItmValDtlsSn+i+1);//???????????????????????????????????? ?????????..?????? ???????????? ?????? ????????? ????????? ???????????? ?????????.
				map.put("vldEndDt","99991231235959");//???????????? ??????
				List tempList = getMapKey(map);
				if(tempList.size()>0) {
					listSrvcrGenItmValDtls.addAll(tempList);
				}
			}//end of for
			
			srvcrIdnfItmValDtlsDAO.inertSrvcrIdnfItmValDtls(updateList);
			if(listSrvcrGenItmValDtls.size()>0) {
				srvcrGenItmValDtlsDAO.insertSrvcrGenItmValDtls(listSrvcrGenItmValDtls);
			}
		}
		//??????. ???????????? , ???????????? ??????
		for(int i=0;i<deleteList.size();i++) {
			Map map = deleteList.get(i);
			//map.put("delYn", "Y");//????????????
			//map.putAll(mapBgngEndDt);
			//srvcrIdnfItmValDtlsDAO.updateSrvcrIdnfItmValDtls(map);
			srvcrGenItmValDtlsDAO.deleteSrvcrGenItmValDtls(map);//??????????????????
			srvcrIdnfItmValDtlsDAO.deleteSrvcrIdnfItmValDtls(map);//??????????????????
			
		}
	}
	private List getMapKey(HashMap<String, String> map) {
		Map defaultMap = EgovUserDetailsHelper.getDefaultMap();
		List list = new ArrayList();
		
		for(Entry<String,String> entry : map.entrySet()) {
			String key = entry.getKey();
			if(!key.equals("srvcrId") &&  !key.equals("idnfItmValDtlsSn") && !key.startsWith("idnfItmVal") && !key.equals("vldBgngDt") && !key.equals("vldEndDt") && !key.equals("delYn")
					 && !key.equals("frstCrtUsrid") && !key.equals("frstCrtPgmId") && !key.equals("lastChgUsrid") && !key.equals("lastChgPgmId")) {//???????????????+????????????/??????????????? ??????
				Map keyMap = new HashMap();
				keyMap.put("srvcrId",map.get("srvcrId"));
				keyMap.put("idnfItmValDtlsSn",map.get("idnfItmValDtlsSn"));
				keyMap.put("critmId",key.toUpperCase());
				keyMap.put("critmVal",entry.getValue());
				keyMap.putAll(defaultMap);
				list.add(keyMap);
			}

        }
		/*if(keyMap.size()>2) {
			list.add(keyMap);
		}*/
		return list;

	}
	@Override
	public void registSrvcrDtlsXlsx(String srvcrId, List<FileVO> list) throws Exception {
		//??????????????????????????? ??????
		Map map  = new HashMap();
		map.put("srvcrId",srvcrId);
		List listSrvcrItmDtls = selectSrvcrItmDtls(map);
		
		
		//?????? ??????
		FileVO fileVo = list.get(0);
		// ????????? ?????? ????????? ??? 
		FileInputStream file = new FileInputStream(fileVo.getFileStreCours()+File.separator+fileVo.getStreFileNm()); 
		XSSFWorkbook workbook = new XSSFWorkbook(file);
		
		XSSFSheet sheet = workbook.getSheetAt(0); // 0 ?????? ????????? ????????????
		//validate
		validSrvcrDtlsXlsx(sheet, listSrvcrItmDtls);
		/*???????????? ??????*/
		
		//????????????????????????????????? ??????
		int idnfItmValDtlsSn = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(map);
		
		int rows = sheet.getPhysicalNumberOfRows();
		
		List listSrvcrIdnfItmValDtls = new ArrayList();//????????????????????????????????? insert ?????? ?????? list
		List listSrvcrGenItmValDtls = new ArrayList();//????????????????????????????????? insert ?????? ?????? list
		Map defaultMap = EgovUserDetailsHelper.getDefaultMap();

		int cells = sheet.getRow(0).getPhysicalNumberOfCells(); // title ????????? ????????? 
		
		for(int i=1;i<rows; i++) {//title ????????????
			Map mapSrvcrIdnfItmValDtls = new HashMap();
			Map mapSrvcrGenItmValDtls = new HashMap();
			idnfItmValDtlsSn++;//????????????????????????????????? ??????
			mapSrvcrIdnfItmValDtls.put("srvcrId", srvcrId);
			mapSrvcrIdnfItmValDtls.put("idnfItmValDtlsSn", idnfItmValDtlsSn);
			
			
			mapSrvcrIdnfItmValDtls.putAll(defaultMap);
			XSSFRow row = sheet.getRow(i);
			int cells = row.getLastCellNum(); // ?????? Row??? ???????????? ????????? ?????? ?????? ????????????  // 12.10 ????????? ??????????????? ?????????

			//System.out.println("??????: " + cells);

			//cells = 12; 
			
			for(int cellIndex = 0; cellIndex < cells; cellIndex++){
				mapSrvcrGenItmValDtls= new HashMap();
				mapSrvcrGenItmValDtls.put("srvcrId", srvcrId);
				mapSrvcrGenItmValDtls.put("idnfItmValDtlsSn", idnfItmValDtlsSn);
				mapSrvcrGenItmValDtls.putAll(defaultMap);
				XSSFCell cell = row.getCell(cellIndex); // ?????? ?????? ???????????? 
				String cellValue = getCellValue(cell);
				/*
				System.out.println("??????: " + cellValue);
				if (cellValue.isEmpty()) {
					cellValue="??????";
				}
				System.out.println("??????: " + cellValue);	
				*/			
				Map mapSrvcrItmDtls = (Map)listSrvcrItmDtls.get(cellIndex);
				String idnfItmYn = (String)mapSrvcrItmDtls.get("idnfItmYn");
				String critmId = (String)mapSrvcrItmDtls.get("critmId");
				if("ST00002".equals(critmId)){//??????????????????
					mapSrvcrIdnfItmValDtls.put("vldEndDt",cellValue);
				}else if("ST00003".equals(critmId)){//??????????????????
					mapSrvcrIdnfItmValDtls.put("vldBgngDt",cellValue);
				}else if("Y".equals(idnfItmYn)){
					mapSrvcrIdnfItmValDtls.put("idnfItmVal"+(cellIndex+1),cellValue);
				}else {
					if(StringUtils.isEmpty(cellValue)==false) {
						mapSrvcrGenItmValDtls.put("critmId",critmId);
						mapSrvcrGenItmValDtls.put("critmVal",cellValue);
						listSrvcrGenItmValDtls.add(mapSrvcrGenItmValDtls);
					}
				}
			}//end of for cell
			listSrvcrIdnfItmValDtls.add(mapSrvcrIdnfItmValDtls);
		}//end of for row
//		srvcrIdnfItmValDtlsDAO.inertSrvcrIdnfItmValDtls(listSrvcrIdnfItmValDtls);
	//	srvcrGenItmValDtlsDAO.insertSrvcrGenItmValDtls(listSrvcrGenItmValDtls);

		int limit = 1000;//2000?????? ????????? insert--> ??? ????????? ????????? ?????????.
		for(int i = 0; i < listSrvcrIdnfItmValDtls.size(); i += limit){
	    	srvcrIdnfItmValDtlsDAO.inertSrvcrIdnfItmValDtls(listSrvcrIdnfItmValDtls.subList(i, Math.min(i + limit, listSrvcrIdnfItmValDtls.size())));
	    }

		if(listSrvcrGenItmValDtls.size()>0) {
		    for(int i = 0; i < listSrvcrGenItmValDtls.size(); i += limit){
		        srvcrGenItmValDtlsDAO.insertSrvcrGenItmValDtls(listSrvcrGenItmValDtls.subList(i, Math.min(i + limit, listSrvcrGenItmValDtls.size())));
		    }
		}
		
		
	}
	//????????????????????? ?????? validate
	private void validSrvcrDtlsXlsx(XSSFSheet sheet, List listSrvcrItmDtls) throws Exception{
		int rows = sheet.getPhysicalNumberOfRows();

		if(rows==0) {
			throw new Exception("??????????????? ???????????? ????????????.");
		}
		validXlsxTitle(sheet, listSrvcrItmDtls);
	}
	//title??? ??????????????? validate
	private void validXlsxTitle(XSSFSheet sheet, List listSrvcrItmDtls) throws Exception{
		//????????? ?????????.
				XSSFRow row = sheet.getRow(0); 
				if(row == null){
					throw new Exception("??????????????? TITLE ????????????.");
				}
				int cells = row.getPhysicalNumberOfCells(); // ?????? Row??? ???????????? ????????? ?????? ?????? ????????????
				if(cells!= listSrvcrItmDtls.size()) {
					throw new Exception("????????? ???????????? ?????????????????????????????? ?????? ???????????? ????????????.");
				}
				for(int cellIndex = 0; cellIndex < cells; cellIndex++){ 
					XSSFCell cell = row.getCell(cellIndex); // ?????? ?????? ???????????? 
					String cellValue = getCellValue(cell);
					Map map = (Map)listSrvcrItmDtls.get(cellIndex);
					String critmNm = (String)map.get("critmNm");
					if(org.apache.commons.lang3.StringUtils.equals(critmNm, cellValue)==false) {
						throw new Exception((cellIndex+1)+"??? ???????????? ???????????? ????????????.["+cellValue+" - "+critmNm+"]");
					}
					
				}//end of for
	}
	//????????? cell ??? ??????
	private String getCellValue(XSSFCell cell)throws Exception{
		String value = "";
		DataFormatter dataFormatter = new DataFormatter();
	    value = dataFormatter.formatCellValue(cell);
		
		return value;
	}
	
	@Override	
	public List selectCritmDmnLstIqiemDtls(Map map)throws Exception{
		return critmDmnLstIqiemDtlsDAO.selectCritmDmnLstIqiemDtls(map);
	}
	
	@Override	
	public List selectCritmRefDtls(Map map)throws Exception{
		return critmRefDtlsDAO.selectCritmRefDtls(map);
	}
		
	
	/**
	 * ????????????????????? ?????? sql ???????????? ????????? ????????????
	 * */
	public List selectcritmDmnData(Map map)throws Exception{
		List listCritmDmnListIqiemDtls = selectCritmDmnLstIqiemDtls(map);
		Map mapCritmDmn = (Map)critmDmnDAO.selectCritmDmn(map).get(0);
		
		String tableNm = (String)map.get("dmnPhyTblNm");
		map.remove("dmnLgcNm");
		map.remove("dmnPhyTblNm");
		
		StringBuffer select = new StringBuffer();
		select.append("select 1");
		listCritmDmnListIqiemDtls.forEach(item->{
			select.append(", "+((Map)item).get("critmPhyNm"));
		});
		
		StringBuffer where = new StringBuffer();
		where.append("where 1=1 ");
		
		map.forEach((key,value)->{
			if(StringUtils.isEmpty(value)==false) {
				where.append(" and "+key+" = '"+value+"'");	
			}
		});
		if(StringUtils.isEmpty(mapCritmDmn.get("inqCndCn"))==false) {
			where.append(" and " + mapCritmDmn.get("inqCndCn"));
		}
		String orderBy = " ";
		if(StringUtils.isEmpty(mapCritmDmn.get("arrgCndCn"))==false) {
			where.append(" order by " + mapCritmDmn.get("arrgCndCn"));
		}
		String sql = select+" from "+tableNm+" "+where +" "+orderBy;
		
		return critmDmnLstIqiemDtlsDAO.selectcritmDmnData(sql);
	}
}
