package egovframework.cmm.web;

import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.srvcr.service.SrvcrService;

@Controller
public class MainController {

	/** EgovSampleService */
	@Resource(name = "sampleService")
	private EgovSampleService sampleService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	
	@RequestMapping(value="/index.do")
	public String index() throws Exception{
		//서비스기준관리 화면 호출
		return "srvcr/SCR001M.tiles";
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
	
}
