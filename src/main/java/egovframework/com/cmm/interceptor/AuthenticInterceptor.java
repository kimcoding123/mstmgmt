package egovframework.com.cmm.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.system.service.PgmMngService;
import egovframework.system.service.UserMngService;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  2017.08.31  장동한          인증된 사용자 체크로직 변경 및 관리자 권한 체크 로직 추가 
 *  </pre>
 */

@SuppressWarnings({ "rawtypes", "unchecked" })
public class AuthenticInterceptor extends HandlerInterceptorAdapter {

	
	@Resource(name = "pgmMngService")
	private PgmMngService pgmMngService;
	
	/** 관리자 접근 권한 패턴 목록 */
	private List<String> loginPageUrl;
	

	
	public List<String> getLoginPageUrl() {
		return loginPageUrl;
	}
	public void setLoginPageUrl(List<String> loginPageUrl) {
		this.loginPageUrl = loginPageUrl;
	}
	
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticInterceptor.class);
	/**
	 * 인증된 사용자 여부로 인증 여부를 체크한다.
	 * 관리자 권한에 따라 접근 페이지 권한을 체크한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession(false);
		
		String servletPath = request.getServletPath();
		//session 에 로그인한 사용자 정보를 어떻게 담아놔야할까나.
		//if(session==null || session.getAttribute("loginVo")==null) {
		if(EgovUserDetailsHelper.isAuthenticated()==false) {
			//로그인안했는데 로그인page 호출이면 통과하도록
			if(loginPageUrl.get(0).contentEquals(servletPath)) {
				return true;
			}else{
				if (isAjaxRequest(request)) {
					response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
					return false;
		        } 
				   
				//로그인페이지로 이동하도록
				ModelAndView modelAndView = new ModelAndView("redirect:/openLogin.do");
				throw new ModelAndViewDefiningException(modelAndView);	
			}
		}
		
		//로그인했는데 로그인page를 호출하면 index페이지로 이동하도록함.
		if("/openLogin.do".contentEquals(request.getServletPath())){
			ModelAndView modelAndView = new ModelAndView("redirect:/index.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		if(StringUtils.isNotEmpty(request.getParameter("menuId"))){
			Map loginVo = (Map)session.getAttribute("loginVo");
			loginVo.put("mnuId", request.getParameter("menuId"));//session 현재 메뉴ID 셋팅	
		}
		
		/*
		 * //인증된사용자 여부 boolean isAuthenticated =
		 * EgovUserDetailsHelper.isAuthenticated(); //미민증사용자 체크 if(!isAuthenticated) {
		 * ModelAndView modelAndView = new ModelAndView("redirect:/login.main"); throw
		 * new ModelAndViewDefiningException(modelAndView); } //인증된 권한 목록 List<String>
		 * authList = (List<String>)EgovUserDetailsHelper.getAuthorities(); //관리자인증여부
		 * boolean adminAuthUrlPatternMatcher = false; //AntPathRequestMatcher 
		 * AntPathRequestMatcher antPathRequestMatcher = null; //관리자가 아닐때 체크함 for(String
		 * adminAuthPattern : adminAuthPatternList){ antPathRequestMatcher = new
		 * AntPathRequestMatcher(adminAuthPattern);
		 * if(antPathRequestMatcher.matches(request)){ adminAuthUrlPatternMatcher =
		 * true; } } //관리자 권한 체크 if(adminAuthUrlPatternMatcher &&
		 * !authList.contains("ADMIN")){ ModelAndView modelAndView = new
		 * ModelAndView("redirect:/uat/uia/egovLoginUsr.do?auth_error=1"); throw new
		 * ModelAndViewDefiningException(modelAndView); }
		 */
		return true;
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {

        return req.getHeader("AJAX") != null && req.getHeader("AJAX").equals(Boolean.TRUE.toString());
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	
		String viewName = modelAndView.getViewName();
		
		if("jsonView".equals(viewName)) return;//json으로 데이터만 받는거면 DB CALL을 하지 않도록 하기 위함.
		
		Map<String, String> param = new HashMap<String, String>();
		param.put("pgmFlpth",viewName);
		List list = pgmMngService.selectPgm(param);
		
		if(ObjectUtils.isEmpty(list)==false) {
			Map map = (Map)list.get(0);
			String pgmId = (String)map.get("pgmId");
			//HttpSession session = request.getSession(false);
			//Map loginVo = (Map)session.getAttribute("loginVo");
			//loginVo.put("pgmId", pgmId);//session 현재 pgmID 셋팅
			modelAndView.getModel().put("acctlPgmId",pgmId);//화면컴포넌트 접근제어 하기 위한 프로그램ID를 담음.
			
		}
		
	}

}
