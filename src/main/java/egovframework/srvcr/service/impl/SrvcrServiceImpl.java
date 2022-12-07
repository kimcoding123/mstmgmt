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
 * @Description : 공통코드서비스
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
		//이력용 시작일시, 종료일시 조회
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		for(int i=0;i<createList.size();i++) {
			Map map = createList.get(i);
			
			//뷰명에 대한 중복검사
			validSrvcrViewNm(map);
			
			map.putAll(mapBgngEndDt);
			String srvcrId = srvcrDAO.selectSrvcrId();
			map.put("srvcrId", srvcrId);
			//1.등록하고
			srvcrDAO.insertSrvcr(map);
			//2.이력쌓고
			map.put("srvcrId", srvcrId);
			srvcrHistDAO.insertSrvcrHist(map);
			
			//유효시작일시/종료일시 항목추가
			//insertSrvcrItmDtlsVldBgngEndDt(map);
		}
		for(int i=0;i<updateList.size();i++) {
			Map map = updateList.get(i);
			map.putAll(mapBgngEndDt);
			
			validSrvcrViewNm(map);
			//1.변경하고
			srvcrDAO.updateSrvcr(map);
			//2.기존이력 종료일시 변경하고
			srvcrHistDAO.updateSrvcrHist(map);
			//3.이력쌓고
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

	// New 추가 : 참조ID 컬럼 추가?
	@Override
	public List selectSrvcrItmDtlsNew(Map map) throws Exception {
		return srvcrItmDtlsDAO.selectSrvcrItmDtlsNew(map);
	}
	
	@Override
	public void registSrvcrItmDtls(String srvcrId, List<Map> createList, List<Map> updateList, List<Map> deleteList) throws Exception {
		Map param = new HashMap();
		param.put("srvcrId",srvcrId);
		int cnt = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(param);
		/*/if(cnt>0) {
			throw new Exception("데이터가 존재합니다. 데이터 삭제후 처리 가능합니다.");
		}*/
		
		//이력용 시작일시, 종료일시 조회
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		for(int i=0;i<createList.size();i++) {
			Map map = createList.get(i);
			
			
			map.putAll(mapBgngEndDt);
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//식별자가 추가되면 데이터 꼬이므로 
				throw new Exception("데이터가 존재합니다. 식별항목은 추가할수 없습니다.");
			}
			//1.등록하고
			srvcrItmDtlsDAO.insertSrvcrItmDtls(map);
			//2.이력쌓고
			srvcrItmDtlsHistDAO.insertSrvcrItmDtlsHist(map);
			
			//유효시작일시/종료일시 항목추가
			//insertSrvcrItmDtlsVldBgngEndDt(map);
		}
		for(int i=0;i<updateList.size();i++) {
			Map map = updateList.get(i);
			map.putAll(mapBgngEndDt);
			
			if(cnt>0 && "Y".equals(map.get("idnfItmYn"))){//식별자가 추가되면 데이터 꼬이므로 
				throw new Exception("데이터가 존재합니다. 식별항목은 변경할수 없습니다.");
			}
			//1.변경하고
			srvcrItmDtlsDAO.updateSrvcrItmDtls(map);
			//2.기존이력 종료일시 변경하고
			srvcrItmDtlsHistDAO.updateSrvcrItmDtlsHist(map);
			//3.이력쌓고
			srvcrItmDtlsHistDAO.insertSrvcrItmDtlsHist(map);
		}
		for(int i=0;i<deleteList.size();i++) {
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
		//뷰는 어느시점에????????
	}	

	public void validSrvcrViewNm(Map map) throws Exception {
		int cnt = selectSrvcrViewNmCnt(map);
		if(cnt!=0) {
			throw new Exception(map.get("srvcrViewNm")+" 뷰는 이미 존재합니다.");
		}
	}
	public int selectSrvcrViewNmCnt(Map map) throws Exception {
		return srvcrDAO.selectSrvcrViewNmCnt(map);
		
	}
	
	
	/*
	 * 서비스기준내역 조회 : 로우 형태로 리턴
	 * */
	@Override
	public List selectSrvcrValDtls(Map map) throws Exception {
		return srvcrIdnfItmValDtlsDAO.selectSrvcrValDtls(map);		
	}
	
	
	/*
	 * 서비스기준내역 조회
	 * 1) map에 식별항목여부, N 추가
	 * 2) list에 srvcrItmDtlsDAO.selectSrvcrItmDtls(map) 결과 저장
	 * 3) (반복문)list를 하나씩 읽으면서 itm에 저장
	 * 4) (반복문)itm에서 critmId값으로 sql변수에 ", critmId값 varchar" 형태로 문자추가
	 * 5) (반복문)columns변수에는 ",critmId값" 형태로 문자추가
	 * 6) map에 다시 sql 추가, columns추가
	 * 7) srvcrIdnfItmValDtlsDAO.selectSrvcrDtls(map) 결과 리턴
	 * 8) 참고로, sql변수값 내용은 crosstab문 구성을 위해 필요
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
	 * 서비스기준내역 조회 New
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
		//이력용 시작일시, 종료일시 조회
		Map mapBgngEndDt = cmmService.selectBgngEndDt();
		
		if(createList.size()>0) {
			List listSrvcrGenItmValDtls = new ArrayList();
			int idnfItmValDtlsSn = 0;
			for(int i=0;i<createList.size();i++) {
				
				HashMap map = (HashMap)createList.get(i);
				Map param = new HashMap();
				param.putAll(map);
				
				//동일키값을 가지고 있는지 중복검사.
				param.remove("vldEndDt");
				List list = srvcrIdnfItmValDtlsDAO.selectsrvcrIdnfItmValDtls(param);
				if(list!=null && list.size()>0) {
					StringBuffer keys = new StringBuffer();
					for(int j=1; j<=10; j++) {
						if(StringUtils.isEmpty(param.get("idnfItmVal"+j))==false){
							keys.append(","+param.get("idnfItmVal"+j));
						}
					}
					throw new Exception("동일한 키값을 가진 데이터가 존재합니다.["+keys.toString().substring(1)+"]");
				}
				
				if(i==0) {
					idnfItmValDtlsSn = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(map);		
				}
				map.putAll(mapBgngEndDt);//insert 위한 유효시작/종료일시 셋팅
				map.put("vldEndDt","99991231235959");//종료일시 셋팅
				map.put("idnfItmValDtlsSn",idnfItmValDtlsSn+i+1);//식별항목값내역일련번호를 채번함..여러 사용자가 동시 등록이 없다는 가정하에 하는것.
				
				List tempList = getMapKey(map);
				if(tempList.size()>0) {
					listSrvcrGenItmValDtls.addAll(tempList);
				}
			}//end of for
			//식별항목값 List로 등록(성능)-->동시에 여러명이 같은 서비스기준id를 등록하지 않는다는 가정하에 개발한것임.  
			//동시에 여러명이 같은 서비스기준ID의 데이터를 등록한다면 위 for문 안으로 넣어야함. DB CALL이 건수만큼 발생함.
			int limit = 2000;//2000건씩 끊어서 insert--> 넘 많으면 오류가 발생함.
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
				map.put("delYn", "N");//삭제된건 아니지만...
				
				if(i==0) {
					idnfItmValDtlsSn = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(map);		
				}
				map.putAll(mapBgngEndDt);
				srvcrIdnfItmValDtlsDAO.updateSrvcrIdnfItmValDtls(map);
				
				map.putAll(mapBgngEndDt);//insert 위한 유효시작/종료일시 셋팅
				
				map.put("idnfItmValDtlsSn",idnfItmValDtlsSn+i+1);//식별항목값내역일련번호를 채번함..여러 사용자가 동시 등록이 없다는 가정하에 하는것.
				map.put("vldEndDt","99991231235959");//종료일시 셋팅
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
		//삭제. 종료일시 , 삭제여부 변경
		for(int i=0;i<deleteList.size();i++) {
			Map map = deleteList.get(i);
			//map.put("delYn", "Y");//삭제처리
			//map.putAll(mapBgngEndDt);
			//srvcrIdnfItmValDtlsDAO.updateSrvcrIdnfItmValDtls(map);
			srvcrGenItmValDtlsDAO.deleteSrvcrGenItmValDtls(map);//일반항목삭제
			srvcrIdnfItmValDtlsDAO.deleteSrvcrIdnfItmValDtls(map);//식별항목삭제
			
		}
	}
	private List getMapKey(HashMap<String, String> map) {
		List list = new ArrayList();
		
		for(Entry<String,String> entry : map.entrySet()) {
			String key = entry.getKey();
			if(!key.equals("srvcrId") &&  !key.equals("idnfItmValDtlsSn") && !key.startsWith("idnfItmVal") && !key.equals("vldBgngDt") && !key.equals("vldEndDt")&& !key.equals("delYn")) {//식별항목값+유효시작/종료일시는 제외
				Map keyMap = new HashMap();
				keyMap.put("srvcrId",map.get("srvcrId"));
				keyMap.put("idnfItmValDtlsSn",map.get("idnfItmValDtlsSn"));
				keyMap.put("critmId",key.toUpperCase());
				keyMap.put("critmVal",entry.getValue());
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
		//서비스기준항목내역 조회
		Map map  = new HashMap();
		map.put("srvcrId",srvcrId);
		List listSrvcrItmDtls = selectSrvcrItmDtls(map);
		
		
		//파일 열기
		FileVO fileVo = list.get(0);
		// 경로에 있는 파일을 읽 
		FileInputStream file = new FileInputStream(fileVo.getFileStreCours()+File.separator+fileVo.getStreFileNm()); 
		XSSFWorkbook workbook = new XSSFWorkbook(file);
		
		XSSFSheet sheet = workbook.getSheetAt(0); // 0 번째 시트를 가져온다
		//validate
		validSrvcrDtlsXlsx(sheet, listSrvcrItmDtls);
		/*등록작업 시작*/
		
		//식별항목값내역일련번호 조회
		int idnfItmValDtlsSn = srvcrIdnfItmValDtlsDAO.selectMaxIndfItmValDtlsSn(map);
		
		int rows = sheet.getPhysicalNumberOfRows();
		
		List listSrvcrIdnfItmValDtls = new ArrayList();//서비스기준식별항목값을 insert 하기 위한 list
		List listSrvcrGenItmValDtls = new ArrayList();//서비스기준일반항목값을 insert 하기 위한 list

		int cells = sheet.getRow(0).getPhysicalNumberOfCells(); // title 로우의 셀갯수 
		
		for(int i=1;i<rows; i++) {//title 건너뛰고
			Map mapSrvcrIdnfItmValDtls = new HashMap();
			Map mapSrvcrGenItmValDtls = new HashMap();
			idnfItmValDtlsSn++;//식별항목값내역일련번호 채번
			mapSrvcrIdnfItmValDtls.put("srvcrId", srvcrId);
			mapSrvcrIdnfItmValDtls.put("idnfItmValDtlsSn", idnfItmValDtlsSn);
			
			
			XSSFRow row = sheet.getRow(i);
			// int cells = row.getPhysicalNumberOfCells(); // 해당 Row에 사용자가 입력한 셀의 수를 가져온다

			//System.out.println("셀수: " + cells);

			//cells = 12; 
			
			for(int cellIndex = 0; cellIndex < cells; cellIndex++){
				mapSrvcrGenItmValDtls= new HashMap();
				mapSrvcrGenItmValDtls.put("srvcrId", srvcrId);
				mapSrvcrGenItmValDtls.put("idnfItmValDtlsSn", idnfItmValDtlsSn);
				XSSFCell cell = row.getCell(cellIndex); // 셀의 값을 가져온다 
				String cellValue = getCellValue(cell);
				/*
				System.out.println("셀값: " + cellValue);
				if (cellValue.isEmpty()) {
					cellValue="빈값";
				}
				System.out.println("셀값: " + cellValue);	
				*/			
				Map mapSrvcrItmDtls = (Map)listSrvcrItmDtls.get(cellIndex);
				String idnfItmYn = (String)mapSrvcrItmDtls.get("idnfItmYn");
				String critmId = (String)mapSrvcrItmDtls.get("critmId");
				if("ST00002".equals(critmId)){//유효종료일자
					mapSrvcrIdnfItmValDtls.put("vldEndDt",cellValue);
				}else if("ST00003".equals(critmId)){//유효시작일자
					mapSrvcrIdnfItmValDtls.put("vldBgngDt",cellValue);
				}else if("Y".equals(idnfItmYn)){
					mapSrvcrIdnfItmValDtls.put("idnfItmVal"+(cellIndex+1),cellValue);
				}else {
					mapSrvcrGenItmValDtls.put("critmId",critmId);
					mapSrvcrGenItmValDtls.put("critmVal",cellValue);
					listSrvcrGenItmValDtls.add(mapSrvcrGenItmValDtls);
				}
			}//end of for cell
			listSrvcrIdnfItmValDtls.add(mapSrvcrIdnfItmValDtls);
		}//end of for row
//		srvcrIdnfItmValDtlsDAO.inertSrvcrIdnfItmValDtls(listSrvcrIdnfItmValDtls);
	//	srvcrGenItmValDtlsDAO.insertSrvcrGenItmValDtls(listSrvcrGenItmValDtls);

		int limit = 1000;//2000건씩 끊어서 insert--> 넘 많으면 오류가 발생함.
		for(int i = 0; i < listSrvcrIdnfItmValDtls.size(); i += limit){
	    	srvcrIdnfItmValDtlsDAO.inertSrvcrIdnfItmValDtls(listSrvcrIdnfItmValDtls.subList(i, Math.min(i + limit, listSrvcrIdnfItmValDtls.size())));
	    }

		if(listSrvcrGenItmValDtls.size()>0) {
		    for(int i = 0; i < listSrvcrGenItmValDtls.size(); i += limit){
		        srvcrGenItmValDtlsDAO.insertSrvcrGenItmValDtls(listSrvcrGenItmValDtls.subList(i, Math.min(i + limit, listSrvcrGenItmValDtls.size())));
		    }
		}
		
		
	}
	//서비스기준내역 엑셀 validate
	private void validSrvcrDtlsXlsx(XSSFSheet sheet, List listSrvcrItmDtls) throws Exception{
		int rows = sheet.getPhysicalNumberOfRows();

		if(rows==0) {
			throw new Exception("엑셀파일에 데이터가 없습니다.");
		}
		validXlsxTitle(sheet, listSrvcrItmDtls);
	}
	//title이 일치하는지 validate
	private void validXlsxTitle(XSSFSheet sheet, List listSrvcrItmDtls) throws Exception{
		//컬럼을 가져옴.
				XSSFRow row = sheet.getRow(0); 
				if(row == null){
					throw new Exception("엑셀파일에 TITLE 없습니다.");
				}
				int cells = row.getPhysicalNumberOfCells(); // 해당 Row에 사용자가 입력한 셀의 수를 가져온다
				if(cells!= listSrvcrItmDtls.size()) {
					throw new Exception("엑셀의 컬럼수와 서비스기준항목내역의 수가 일치하지 않습니다.");
				}
				for(int cellIndex = 0; cellIndex < cells; cellIndex++){ 
					XSSFCell cell = row.getCell(cellIndex); // 셀의 값을 가져온다 
					String cellValue = getCellValue(cell);
					Map map = (Map)listSrvcrItmDtls.get(cellIndex);
					String critmNm = (String)map.get("critmNm");
					if(org.apache.commons.lang3.StringUtils.equals(critmNm, cellValue)==false) {
						throw new Exception((cellIndex+1)+"의 컬럼명이 일치하지 않습니다.["+cellValue+" - "+critmNm+"]");
					}
					
				}//end of for
	}
	//엑셀의 cell 값 추출
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
	 * 기준항목도메인 으로 sql 생성해서 데이터 조회하기
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
