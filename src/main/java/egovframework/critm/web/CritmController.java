package egovframework.critm.web;

import java.util.ArrayList;
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
import egovframework.critm.service.CritmService;
import egovframework.rte.ptl.mvc.bind.annotation.CommandMap;
import egovframework.srvcr.service.SrvcrService;

@Controller
public class CritmController {

	

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Resource(name = "critmService")
	private CritmService critmService;
	
	/**
	 * 기준항목 조회
	 * */
	@RequestMapping(value = "/critm/selectCritm.ajax", method = RequestMethod.POST)
	public  ModelAndView selectCritm(@RequestParam Map<String, String> param, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("list",critmService.selectCritm(param));
		return mav;
	}
	
	
	
}
