package kr.or.ddit.common.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.common.main.mapper.MainMapper;
import kr.or.ddit.common.main.vo.JobCountVO;
import kr.or.ddit.common.main.vo.MemberInfoVO;
import kr.or.ddit.common.main.vo.NoticeVO;
import kr.or.ddit.common.main.vo.StdAcadInfoVO;
import kr.or.ddit.common.notice.service.NoticeService;
import kr.or.ddit.student.registrationLecture.controller.RegistrationLectureController;
import kr.or.ddit.student.registrationLecture.mapper.RegistrationLectureMapper;
import kr.or.ddit.student.registrationLecture.service.RegistrationLectureService;
import kr.or.ddit.student.registrationLecture.service.impl.RegistrationLectureServiceImpl;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenVO;
import kr.or.ddit.student.registrationLecture.vo.LectureTimetableVO;
import kr.or.ddit.student.tuitionPayment.vo.TuitionPaymentVO;
import kr.or.ddit.util.auth.service.AuthService;

@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	MainMapper mainMapper;
	@Autowired
	RegistrationLectureService registrationLectureService;  // 학생 - 시간표
	@Autowired
	RegistrationLectureMapper registrationLectureMapper;  
	@Autowired
	NoticeService noticeService; // 공통 - 공지사항
	@Autowired
	AuthService authService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MainServiceImpl.class);
	
	/**
	 * 회원 공통 : 상단에 띄워줄 회원정보 가져오기 
	 */
	@Override
	public MemberInfoVO memInfoSelect(String memId) {
		return mainMapper.memInfoSelect(memId);
	}
	
	/**
	 * 최근 등록 학기 가져오기 - 최근 등록학기가 없으면 빈값을 보냄 
	 * @param stdId
	 * @return Map의 키 - year : 년도(2021), sem : 학기(1) 
	 * @throws Exception 
	 */
	@Override
	public Map<String, String> getYearAndSem(String stdId) throws Exception {
		List<TuitionPaymentVO> yearAndSemList = registrationLectureService.registrationSemSelect(stdId);
		
		Map<String, String> yearSem = new HashMap<>();
		
		if(yearAndSemList.size() == 0) {
			yearSem.put("year", "");
			yearSem.put("sem", "");
			return yearSem;
		}
		
		yearSem.put("year", yearAndSemList.get(0).getYear());
		yearSem.put("sem", yearAndSemList.get(0).getSemCode());
		return yearSem;
	}
	
	/**
	 * 최근 학기 시간표 json 문자열을 가져오기
	 * @param stdId
	 * @return 최근 학기 시간표 json 문자열
	 * @throws Exception
	 */
	@Override
	public String lectureTimetableSelect(String stdId) throws Exception {
		LectureOpenVO lectureOpenVO = new LectureOpenVO();
		lectureOpenVO.setStdId(stdId);
		lectureOpenVO.setYear(getYearAndSem(stdId).get("year"));
		lectureOpenVO.setSemCode(getYearAndSem(stdId).get("sem"));
		return registrationLectureService.lectureTimetableSelect(lectureOpenVO);
	}
	
	/**
	 * 학생 이수 학점 정보 가져오기
	 */
	@Override
	public StdAcadInfoVO StdAcadInfo(String stdId) {
		
		// 이수한 학점 정보 (공집합일 경우 처리)
		StdAcadInfoVO stdAcadInfoVoSource = mainMapper.getCourseCredit(stdId);
		StdAcadInfoVO stdAcadInfoVoTarget = mainMapper.getGrdtnCred();
		
		// 이수해야 할 학점 정보를 더하기
		BeanUtils.copyProperties(stdAcadInfoVoSource, stdAcadInfoVoTarget, "ct1GrdtnCred", "ct2GrdtnCred", "ct3GrdtnCred", "ct4GrdtnCred");
		
		return stdAcadInfoVoTarget;
	}
	
	/**
	 * 학생 학사 정보 카운트 가져오기
	 */
	@Override
	public JobCountVO stdAcadInfoCount(String stdId) throws Exception{
		return mainMapper.stdAcadInfoCount(stdId);
	}
	
	/**
	 * 공지사항 리스트, 페이징 처리 객체 가져오기
	 * @return Map의 키 - noticeList : List<NoticeVO>공지사항 리스트, paginationInfo : 페이징처리 객체
	 */
	@Override
	public Map<String, Object> noticeList(NoticeVO noticeVo) throws Exception {
		
		Map<String, Object> noticeMap = new HashMap<>();

		// 페이징 처리
		PaginationInfo paginationInfo = getPaginationInfo(noticeVo);
		noticeVo.setFirstIndex(paginationInfo.getFirstRecordIndex()+1); 
		noticeVo.setLastIndex(paginationInfo.getLastRecordIndex());
		noticeMap.put("paginationInfo", paginationInfo);
		
		// 리스트 가져오기 
		noticeMap.put("noticeList", mainMapper.noticeSelect(noticeVo));
		
		return noticeMap;
	}
	
	/**
	 * 페이징 처리 객체 가져오기
	 * @param returnVo : pageNo가 저장된 ReturnVO
	 * @return PaginationInfo : 1. 뷰단에 보내고 2. 리스트 쿼리에 firstInext, lastIndex 정보를 줄 페이징 객체  
	 */
	public PaginationInfo getPaginationInfo(NoticeVO noticeVo) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(noticeVo.getPageNo());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(5);
		paginationInfo.setTotalRecordCount(noticeService.selectCnt(new HashMap<>()));
		return paginationInfo;
	}
	
	/**
	 * 교수 / 직원 : 필요한 업무 
	 */
	@Override
	public JobCountVO getJobInfo(MemberVO memberVo) throws Exception{
		
		JobCountVO target = new JobCountVO();
		JobCountVO source = new JobCountVO();
		
		if("02".equals(memberVo.getMemTypeCode())) { // 교수
			target = mainMapper.consultCount(memberVo.getMemId());
			source = mainMapper.authDocInfoCountForStep(memberVo.getMemId());
			BeanUtils.copyProperties(source, target, "consultCnt01", "consultCntAll");
			
		}else if("03".equals(memberVo.getMemTypeCode())) { // 직원
			target= mainMapper.authDocInfoCount(memberVo.getMemId());
			source = mainMapper.authDocInfoCountForStep(memberVo.getMemId());
			String qnaCnt = mainMapper.empQnaCnt();
			BeanUtils.copyProperties(source, target, "authDocCnt01", "authDocCnt02", "authDocCnt03", "authDocCnt04");
			target.setQnaCnt(qnaCnt);
		}
		
		return target;
	}
	
	/**
	 * 교수의 시간표 정보 가져오기 
	 * @throws JsonProcessingException 
	 */
	@Override
	public String profLectureTimetableSelect(String profId) throws JsonProcessingException {
		LectureOpenVO lectureOpenVo = new LectureOpenVO();

		// 날짜 기반 현재 학기 
		Map<String, String> yearSemCode = registrationLectureService.getYearSemCode();
		lectureOpenVo.setYear(yearSemCode.get("year"));
		lectureOpenVo.setSemCode(yearSemCode.get("semCode"));
		lectureOpenVo.setProfId(profId);
		
		String[] lectOpenNumList = mainMapper.profLectureSelect(lectureOpenVo);
    	lectureOpenVo.setLectOpenNumList(lectOpenNumList);
    	
    	if(lectOpenNumList.length  == 0) { // 강의가 없을 경우 빈 json 반환
    		return "[]";
    	}
    	
    	List<LectureTimetableVO> lectTimeTableList = registrationLectureMapper.lectureTimetableSelect(lectureOpenVo);
    	ObjectMapper mapper = new ObjectMapper(); 
    	return mapper.writeValueAsString(lectTimeTableList);
	}
	
	
}
