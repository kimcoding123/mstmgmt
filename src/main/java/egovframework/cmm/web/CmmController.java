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
package egovframework.cmm.web;

import java.util.List;
import java.util.Map;

import egovframework.cmm.service.CmmCdDtlVo;
import egovframework.cmm.service.CmmService;
import egovframework.cmm.service.impl.CmmServiceImpl;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class CmmController {

	@Resource(name = "cmmService")
	private CmmService cmmService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 공통코드상세를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/cmm/selectCmmCdDtlList.ajax")
	public ModelAndView selectCmmCdDtlList(@ModelAttribute("cmmCdDtlVo") CmmCdDtlVo cmmCdDtlVo, ModelMap model) throws Exception {

		List<?> list = cmmService.selectCmmCdDtlList(cmmCdDtlVo);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("cmmCdDtlList",list);
		return mav;

	}

	@RequestMapping(value = "/cmm/selectTb.ajax", method = RequestMethod.POST)
	public  ModelAndView selectTb(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		//mav.addObject("list",cmm.selectTb(param));
		mav.addObject("list",cmmService.selectTb(param));
		return mav;
	}
	
	/** 통합테이블 저장*/
	@RequestMapping(value = "/cmm/saveTb.ajax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public @ResponseBody  ModelAndView saveTb(@RequestBody String param,  BindingResult bindingResult) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("isSuccess","Y");
		try {
			JsonParser jparser = new JsonParser();
			Gson gson = new Gson();
			//
			JsonElement el = jparser.parse(param);
			JsonObject obj = el.getAsJsonObject();
			String tblNm = obj.get("tblNm").getAsString();
			
			JsonArray createdRows = obj.getAsJsonArray("createdRows");
			JsonArray updatedRows = obj.getAsJsonArray("updatedRows");
			JsonArray deletedRows = obj.getAsJsonArray("deletedRows");
			List <Map> createdData = gson.fromJson(createdRows, (new TypeToken<List<Map>>() {  }).getType());
			List <Map> updatedData = gson.fromJson(updatedRows, (new TypeToken<List<Map>>() {  }).getType());
			List <Map> deletedData = gson.fromJson(deletedRows, (new TypeToken<List<Map>>() {  }).getType());
			
			cmmService.registTb(tblNm, createdData, updatedData, deletedData);
		}catch(Exception e) {
			mav.addObject("isSuccess","N");
			mav.addObject("errorMessage",e.getMessage());
		}
		//mav.addObject("cmmCdDtlList",list);
		return mav;
	}	


}
