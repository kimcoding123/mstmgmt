package egovframework.cmm.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.srvcr.service.SrvcrService;
import egovframework.system.service.MenuMngService;
import egovframework.system.service.UserMngService;

@Controller
public class MainController {

	@Resource(name = "userMngService")
	private UserMngService userMngService;
	
	@Resource(name = "menuMngService")
	private MenuMngService menuMngService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	private final String LOGIN_PAGE_URL = "com/login.main";
	
	@RequestMapping(value="/openLogin.do")
	public String openLogin() throws Exception{
		return LOGIN_PAGE_URL;
	}
	@RequestMapping(value="/login.do")
	public String login(@RequestParam Map<String, String> param, HttpSession session,  HttpServletRequest request, ModelMap model) throws Exception{
		
		Map user = userMngService.login(param.get("loginId"), param.get("password"));
		if(user!=null) {
			session.setAttribute("loginVo", user);//VO로 답는것이 좋아보이나 MAP으로 처리함.	
		}else {
 			model.addAttribute("loginMessage", "사용자 정보가 없습니다.");
 			return LOGIN_PAGE_URL;
		}
		
		
		return "redirect:/index.do";
	}
	@RequestMapping(value="/logout.do")
	public String logout(@RequestParam Map<String, String> param, HttpSession session,  HttpServletRequest request, ModelMap model) throws Exception{
		session.invalidate();
		return LOGIN_PAGE_URL;
	}
	@RequestMapping(value="/index.do")
	public String index() throws Exception{
		
		String page = menuMngService.selectUserFirstMenu();
		
		//페이지가 없으면 
		if(StringUtils.isEmpty(page)) {
			return "com/empty.tiles";
		}
		return page.replaceAll("jsp", "tiles");
		//return "srvcr/SCR001M.tiles";
	}
	@RequestMapping(value="/cmm/openSCR001M.do")
	public String openSCR001M() throws Exception{
		//서비스기준관리 화면 호출
		return "srvcr/SCR001M.jsp";
	}
	@RequestMapping(value="/cmm/openSCR002M.do")
	public String openSCR002M() throws Exception{
		//서비스기준관리 화면 호출
		return "srvcr/SCR002M.jsp";
	}
	@RequestMapping(value="/cmm/openSCR010D.do")
	public String openSCR010D() throws Exception{
		//서비스기준관리 화면 호출
		return "srvcr/SCR010D.jsp";
	}
	
	@RequestMapping(value="/cmm/openSCR011D.do")
	public String openSCR011D() throws Exception{
		//테스트 화면 호출
		return "srvcr/SCR011D.jsp";
	}
	
	@RequestMapping(value="/cmm/openSCR012D.do")
	public String openSCR012D() throws Exception{
		// 화면 호출
		return "srvcr/SCR012D.jsp";
	}

	@RequestMapping(value="/cmm/openSCR013D.do")
	public String openSCR013D() throws Exception{
		// 화면 호출 
		return "srvcr/SCR013D.jsp";
	}

	@RequestMapping(value="/cmm/openSCR014D.do")
	public String openSCR014D() throws Exception{
		// 화면 호출
		return "srvcr/SCR014D.jsp";
	}	

	@RequestMapping(value="/cmm/openSCR015D.do")
	public String openSCR015D() throws Exception{
		// 화면 호출
		return "srvcr/SCR015D.jsp";
	}	

	@RequestMapping(value="/cmm/openSCR003P.do")
	public String openSCR003P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		//서비스기준관리 화면 호출
		return "srvcr/SCR003P.jsp";
	}
	@RequestMapping(value="/cmm/openSCR004P.do")
	public String openSCR004P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("srvcrId",(String)param.get("srvcrId"));
		model.put("srvcrId",(String)param.get("srvcrId"));
		//서비스기준관리 화면 호출
		return "srvcr/SCR004P.jsp";
	}
	@RequestMapping(value="/cmm/openSCR005P.do")
	public String openSCR005P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("srvcrId",(String)param.get("srvcrId"));
		model.addAttribute("critmId",(String)param.get("critmId"));
		//model.put("srvcrId",(String)param.get("srvcrId"));
		//서비스기준관리 화면 호출
		return "srvcr/SCR005P.jsp";
	}
	@RequestMapping(value="/cmm/openSCR006P.do")
	public String openSCR006P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("srvcrId",(String)param.get("srvcrId"));
		model.addAttribute("critmId",(String)param.get("critmId"));
		//model.put("srvcrId",(String)param.get("srvcrId"));
		//서비스기준관리 화면 호출
		return "srvcr/SCR006P.jsp";
	}
	@RequestMapping(value="/cmm/openSCR007P.do")
	public String openSCR007P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("critmNm",(String)param.get("critmNm"));
		model.addAttribute("cdvlTnm",(String)param.get("cdvlTnm"));
		model.addAttribute("dmnLgcNm",(String)param.get("dmnLgcNm"));
		model.addAttribute("dmnPhyNm",(String)param.get("dmnPhyNm"));
		//서비스기준관리 화면 호출
		return "srvcr/SCR007P.jsp";
	}
	@RequestMapping(value="/cmm/openSCR008P.do")
	public String openSCR008P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("srvcrId",(String)param.get("srvcrId"));
		return "srvcr/SCR008P.jsp";
	}
	
	@RequestMapping(value="/cmm/openSCR009P.do")
	public String openSCR009P(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("dmnLgcNm",(String)param.get("dmnLgcNm"));
		model.addAttribute("dmnPhyTblNm",(String)param.get("dmnPhyTblNm"));
		return "srvcr/SCR009P.jsp";
	}
	
	@RequestMapping(value="/cmm/openSCR009R.do")
	public String openSCR009R(@RequestParam Map<String, String> param, ModelMap model) throws Exception{
		model.addAttribute("dmnLgcNm",(String)param.get("dmnLgcNm"));
		model.addAttribute("dmnPhyTblNm",(String)param.get("dmnPhyTblNm"));
		return "srvcr/SCR009R.jsp";
	}
	public static void main(String[] args) {
		System.out.println("srvcr/SCR002M.jsp".replaceAll("jsp", "tiles"));
	}	
}
