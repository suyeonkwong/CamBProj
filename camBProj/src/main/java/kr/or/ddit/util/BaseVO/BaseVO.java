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
package kr.or.ddit.util.BaseVO;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;

import egovframework.example.sample.service.SampleDefaultVO;

/**
 * @Class Name : SampleDefaultVO.java
 * @Description : SampleDefaultVO Class
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
public class BaseVO implements Serializable {

	/**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = -858838578081269359L;

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";

	/** 검색사용여부 */
	private String searchUseYn = "";

	/** (수정 pageIndex->pageNo)현재페이지 */
	protected int pageNo = 1;

	/** 페이지갯수 */
	private int pageUnit = 5;

	/** 페이지사이즈 */
	private int pageSize = 5;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage 한 페이지에 보여지는 행의 수*/
	private int recordCountPerPage = 10;
	
	/**
	 * (추가) 페이징 처리에 사용할  rnum
	 */
	private int rnum;
	
	/**
	 * (추가) 중복 등록 방지용 토큰
	 */
	protected String saveToken;
	
	/**
	 * 파일이 있는지 확인
	 * 파일이 없을 경우 null 이 들어온다
	 */
	private String fileCheck; 
	
	
	/**
	 * OSY : 뭔지 잘 모르겠음
	 * @param baseVO 
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	public void copyVoCondition(BaseVO baseVO, String VoName) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		Map<String, String> describeMap= BeanUtils.describe(baseVO); // vo의 값을 map에 넣기
		Iterator<String> describeIterator= describeMap.keySet().iterator(); // map 반복 준비
		while(describeIterator.hasNext()){
			String key = describeIterator.next(); // searchVo, formVo가 있으면
			if(key.startsWith(VoName)){
				System.out.println("BaseVo : this : " + this.toString());
				BeanUtils.copyProperty(this, key, describeMap.get(key)); // BaseVO의 필드를 BaseVO.searchVo, BaseVO.formVo에 복사하기 
			}
		}
	}

	public String getFileCheck() {
		return fileCheck;
	}

	public void setFileCheck(String fileCheck) {
		this.fileCheck = fileCheck;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getSaveToken() {
		return saveToken;
	}

	public void setSaveToken(String saveToken) {
		this.saveToken = saveToken;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
