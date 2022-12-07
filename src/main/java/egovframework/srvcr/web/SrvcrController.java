package egovframework.srvcr.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.node.ObjectNode;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.cmm.service.impl.CmmServiceImpl;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.ptl.mvc.bind.annotation.CommandMap;
import egovframework.srvcr.service.SrvcrService;

@Controller
public class SrvcrController {

	

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Resource(name = "srvcrService")
	private SrvcrService srvcrService;
	@Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
	/**서비스 기준 조회*/
	@RequestMapping(value = "/srvcr/saveSrvcr.ajax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public @ResponseBody  ModelAndView saveSrvcr(@RequestBody String param,  BindingResult bindingResult) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("isSuccess","Y");
		try {
			JsonParser jparser = new JsonParser();
			Gson gson = new Gson();
			//
			JsonElement el = jparser.parse(param);
			JsonObject obj = el.getAsJsonObject();
			JsonArray createdRows = obj.getAsJsonArray("createdRows");
			JsonArray updatedRows = obj.getAsJsonArray("updatedRows");
			JsonArray deletedRows = obj.getAsJsonArray("deletedRows");
			List <Map> createdData = gson.fromJson(createdRows, (new TypeToken<List<Map>>() {  }).getType());
			List <Map> updatedData = gson.fromJson(updatedRows, (new TypeToken<List<Map>>() {  }).getType());
			List <Map> deletedData = gson.fromJson(deletedRows, (new TypeToken<List<Map>>() {  }).getType());
			
			srvcrService.registSrvcr(createdData, updatedData, deletedData);
		}catch(Exception e) {
			mav.addObject("isSuccess","N");
			mav.addObject("errorMessage",e.getMessage());
		}
		//mav.addObject("cmmCdDtlList",list);
		return mav;
	}

	/**
	 * HTML Tags 조회
	 * */
	@RequestMapping(value = "/srvcr/selectHtmlTags.ajax", method = RequestMethod.POST)
	public  ModelAndView selectHtmlTags(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectHtmlTags(param));
		return mav;
	}

	
	/**
	 * 서비스기준 조회
	 * */
	@RequestMapping(value = "/srvcr/selectSrvcr.ajax", method = RequestMethod.POST)
	public  ModelAndView selectSrvcr(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectSrvcr(param));
		return mav;
	}
	/**
	 * 서비스기준이력 조회
	 * */
	@RequestMapping(value = "/srvcr/selectSrvcrHist.ajax", method = RequestMethod.POST)
	public  ModelAndView selectSrvcrHist(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectSrvcrHist(param));
		return mav;
	}
	/**
	 * 서비스기준항목 조회
	 * */
	@RequestMapping(value = "/srvcr/selectSrvcrItmDtls.ajax", method = RequestMethod.POST)
	public  ModelAndView selectSrvcrItm(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectSrvcrItmDtls(param));
		return mav;
	}
	
	/**
	 * 서비스기준항목 조회 New
	 * */
	@RequestMapping(value = "/srvcr/selectSrvcrItmDtlsNew.ajax", method = RequestMethod.POST)
	public  ModelAndView selectSrvcrItmNew(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectSrvcrItmDtlsNew(param));
		return mav;
	}
		
	/**서비스 기준 항목 저장*/
	@RequestMapping(value = "/srvcr/saveSrvcrItmDtls.ajax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public @ResponseBody  ModelAndView saveSrvcrItmDtls(@RequestBody String param,  BindingResult bindingResult) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("isSuccess","Y");
		try {
			JsonParser jparser = new JsonParser();
			Gson gson = new Gson();
			//
			JsonElement el = jparser.parse(param);
			JsonObject obj = el.getAsJsonObject();
			String srvcrId = obj.get("srvcrId").getAsString();
			
			JsonArray createdRows = obj.getAsJsonArray("createdRows");
			JsonArray updatedRows = obj.getAsJsonArray("updatedRows");
			JsonArray deletedRows = obj.getAsJsonArray("deletedRows");
			List <Map> createdData = gson.fromJson(createdRows, (new TypeToken<List<Map>>() {  }).getType());
			List <Map> updatedData = gson.fromJson(updatedRows, (new TypeToken<List<Map>>() {  }).getType());
			List <Map> deletedData = gson.fromJson(deletedRows, (new TypeToken<List<Map>>() {  }).getType());
			
			srvcrService.registSrvcrItmDtls(srvcrId, createdData, updatedData, deletedData);
		}catch(Exception e) {
			mav.addObject("isSuccess","N");
			mav.addObject("errorMessage",e.getMessage());
		}
		//mav.addObject("cmmCdDtlList",list);
		return mav;
	}

	
	/**
	 * 서비스기준내역 조회
	 * */
	@RequestMapping(value = "/srvcr/selectSrvcrDtls.ajax", method = RequestMethod.POST)
	public  ModelAndView selectSrvcrDtls(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectSrvcrDtls(param));
		return mav;
	}

	/**
	 * 서비스기준내역 조회 : 로우 형태
	 * */
	@RequestMapping(value = "/srvcr/selectSrvcrValDtls.ajax", method = RequestMethod.POST)
	public  ModelAndView selectSrvcrValDtls(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectSrvcrValDtls(param));
		return mav;
	}
	
	
	
	/**
	 * 서비스기준내역 저장
	 * */
	@RequestMapping(value = "/srvcr/saveSrvcrDtls.ajax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public  ModelAndView saveSrvcrDtls(@RequestBody String param,  BindingResult bindingResult) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("isSuccess","Y");
		try {
			JsonParser jparser = new JsonParser();
			Gson gson = new Gson();
			//
			JsonElement el = jparser.parse(param);
			JsonObject obj = el.getAsJsonObject();
			JsonArray createdRows = obj.getAsJsonArray("createdRows");
			JsonArray updatedRows = obj.getAsJsonArray("updatedRows");
			JsonArray deletedRows = obj.getAsJsonArray("deletedRows");
			List <HashMap> createdData = gson.fromJson(createdRows, (new TypeToken<List<HashMap>>() {  }).getType());
			List <HashMap> updatedData = gson.fromJson(updatedRows, (new TypeToken<List<HashMap>>() {  }).getType());
			List <HashMap> deletedData = gson.fromJson(deletedRows, (new TypeToken<List<HashMap>>() {  }).getType());
			
			srvcrService.registSrvcrDtls(createdData, updatedData, deletedData);
		}catch(Exception e) {
			mav.addObject("isSuccess","N");
			mav.addObject("errorMessage",e.getMessage());
		}
		//mav.addObject("cmmCdDtlList",list);
		return mav;
	}
	/**
	 * 서비스기준내역 저장
	 * */
	@RequestMapping(value = "/srvcr/uploadSrvcrDtlsExcel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public  ModelAndView uploadSrvcrDtlsExcel( MultipartHttpServletRequest  multiRequest,@RequestParam Map<String, String> param) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("isSuccess","Y");
		try {
			List<MultipartFile> files = multiRequest.getFiles("fileUpload");
		    if (files.isEmpty()) {
		    	throw new Exception("upload된 엑셀 파일이 없습니다.");
		    }
		    List<FileVO> list = fileUtil.parseFileInf(files, "SRVCR_DTLS_", 0, "", "");
		    srvcrService.registSrvcrDtlsXlsx(param.get("srvcrId"),list);
		}catch(Exception e) {
			mav.addObject("isSuccess","N");
			mav.addObject("errorMessage",e.getMessage());
			e.printStackTrace();
		}
		//mav.addObject("cmmCdDtlList",list);
		return mav;
	}
	
	/**
	 * 기준항ㅁ목도메인목록조회항목내역 조회
	 * */
	@RequestMapping(value = "/srvcr/selectCritmDmnLstIqiemDtls.ajax", method = RequestMethod.POST)
	public  ModelAndView selectCritmDmnLstIqiemDtls(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectCritmDmnLstIqiemDtls(param));
		return mav;
	}
	
	/**
	 * 기준항목참조상세 내역 조회
	 * */
	@RequestMapping(value = "/srvcr/selectCritmRefDtls.ajax", method = RequestMethod.POST)
	public  ModelAndView selectCritmRefDtls(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectCritmRefDtls(param));
		return mav;
	}
	
	
	@RequestMapping(value = "/srvcr/selectcritmDmnData.ajax", method = RequestMethod.POST)
	public  ModelAndView selectcritmDmnData(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",srvcrService.selectcritmDmnData(param));
		return mav;
	}
	
}
