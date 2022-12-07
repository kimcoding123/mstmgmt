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
package egovframework.srvcr.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
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
public class SrvcrVo  {

	private static final long serialVersionUID = 1L;
	
	private String scrId; // 추가
	private String tags; // 추가
	private String srvcrDc;
	private String srvcrId;
	private String srvcrNm;
	private String srvcrViewNm;
	private String taskDivSclsCd;
	private String taskDivSclsNm;
	private String useBgngYmd;
	private String useEndYmd;

	// 추가
	public String getScrId() {
		return scrId;
	}
	// 추가
	public void setScrId(String scrId) {
		this.scrId = scrId;
	}
	
	// 추가
	public String getTags() {
		return tags;
	}
	// 추가
	public void setTags(String tags) {
		this.tags = tags;
	}
		
	
	public String getSrvcrDc() {
		return srvcrDc;
	}
	public void setSrvcrDc(String srvcrDc) {
		this.srvcrDc = srvcrDc;
	}
	public String getSrvcrId() {
		return srvcrId;
	}
	public void setSrvcrId(String srvcrId) {
		this.srvcrId = srvcrId;
	}
	public String getSrvcrNm() {
		return srvcrNm;
	}
	public void setSrvcrNm(String srvcrNm) {
		this.srvcrNm = srvcrNm;
	}
	public String getSrvcrViewNm() {
		return srvcrViewNm;
	}
	public void setSrvcrViewNm(String srvcrViewNm) {
		this.srvcrViewNm = srvcrViewNm;
	}
	public String getTaskDivSclsCd() {
		return taskDivSclsCd;
	}
	public void setTaskDivSclsCd(String taskDivSclsCd) {
		this.taskDivSclsCd = taskDivSclsCd;
	}
	public String getTaskDivSclsNm() {
		return taskDivSclsNm;
	}
	public void setTaskDivSclsNm(String taskDivSclsNm) {
		this.taskDivSclsNm = taskDivSclsNm;
	}
	public String getUseBgngYmd() {
		return useBgngYmd;
	}
	public void setUseBgngYmd(String useBgngYmd) {
		this.useBgngYmd = useBgngYmd;
	}
	public String getUseEndYmd() {
		return useEndYmd;
	}
	public void setUseEndYmd(String useEndYmd) {
		this.useEndYmd = useEndYmd;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
}
