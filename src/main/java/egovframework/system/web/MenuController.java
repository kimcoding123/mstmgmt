package egovframework.system.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.srvcr.service.SrvcrService;
import egovframework.system.service.MenuMngService;
import egovframework.system.service.UserMngService;

@Controller
public class MenuController {

	/** EgovSampleService */
	@Resource(name = "menuMngService")
	private MenuMngService menuMngService;

	
	@RequestMapping(value="/mnu/selectUserMenuTree.ajax")
	public ModelAndView selectUserMenuTree(@RequestParam Map<String, String> param,  HttpSession session, ModelMap model) throws Exception{
		
		
		List list = menuMngService.selectUserMenuTree(param);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		mav.addObject("userMenuTree",list);
		
		return mav;
	}
}
