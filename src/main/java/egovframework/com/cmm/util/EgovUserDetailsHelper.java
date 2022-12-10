package egovframework.com.cmm.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.com.cmm.service.EgovUserDetailsService;

/**
 * EgovUserDetails Helper 클래스
 *
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon         최초 생성
 *   2011.07.01	 서준식          interface 생성후 상세 로직의 분리
 * </pre>
 */

public class EgovUserDetailsHelper {

	

	/**
	 * 인증된 사용자객체를 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	public static Map<String, String> getAuthenticatedUser() {
		return (Map<String, String>)RequestContextHolder.getRequestAttributes().getAttribute("loginVo", RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * 인증된 사용자의 권한 정보를 가져온다.
	 *
	 * @return List - 사용자 권한정보 목록
	 */
	public static List<String> getAuthorities() {
		// 추후 필요시 세션에 담아놓고 꺼내서 사용하도록 함.
		return null;
	}

	/**
	 * 인증된 사용자 여부를 체크한다.
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
	 */
	public static Boolean isAuthenticated() {
		return RequestContextHolder.getRequestAttributes().getAttribute("loginVo", RequestAttributes.SCOPE_SESSION)!=null;
	}
	//사용자id
	public static String getUserId() {
		Map<String, String> loginVo = getAuthenticatedUser();
		return (String)loginVo.get("usrid");
	}
	//현재 접속한 메뉴id
	public static String getMnuId() {
		Map<String, String> loginVo = getAuthenticatedUser();
		return (String)loginVo.get("mnuId");
	}
	//프로그램id
	public static String getPgmId() {
		Map<String, String> loginVo = getAuthenticatedUser();
		return (String)loginVo.get("pgmId");
	}
	//CUD에서 사용하는 MAP
	public static Map<String, String> getDefaultMap() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("frstCrtUsrid", getUserId());
		map.put("frstCrtPgmId", getMnuId());
		map.put("lastChgUsrid", getUserId());
		map.put("lastChgPgmId", getMnuId());
		return map;
	}
	
}
