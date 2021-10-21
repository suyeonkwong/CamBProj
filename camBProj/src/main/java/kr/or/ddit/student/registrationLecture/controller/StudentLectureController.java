package kr.or.ddit.student.registrationLecture.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.professor.lecture.vo.LectureEvalItemVO;
import kr.or.ddit.student.registrationLecture.service.RegistrationLectureService;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenAndSyllabusVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenFormVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenVO;
import kr.or.ddit.student.registrationLecture.vo.LectureScoreVO;
import kr.or.ddit.student.tuitionPayment.vo.TuitionPaymentVO;
import kr.or.ddit.util.code.service.CodeService;
import kr.or.ddit.util.code.vo.CodeVO;
import kr.or.ddit.util.saveToken.service.SaveTokenService;

/**
 * @author PC-08
 *
 */
@Controller
public class StudentLectureController {
	
	@Autowired
	RegistrationLectureService registrationLectureService;
	@Autowired
	CodeService codeService; // 공통 코드 처리 용
	@Autowired
	SaveTokenService saveTokenService; // 중복 입력 방지 처리 용
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RegistrationLectureController.class);
	
	/**
	 * 특정 학기에 수강한 강의 출력 
	 * @throws Exception 
	 */
	@RequestMapping("/student/lecture/lectureList")
	public String lectureList(LectureOpenFormVO lectureOpenFormVO
								, HttpSession session
								, Model model) throws Exception {
		
		
		// 사용자 정보 (신청한 학점 / 신청 가능한 학점)
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		
		// 학생의 학기 정보 (셀렉트 박스)
		// 등록한 학기가 1개 이상 존재하지 않으면 빈값을 보냄
		List<TuitionPaymentVO> yearAndSemList = registrationLectureService.registrationSemSelect(memberVo.getMemId());
		if(yearAndSemList.size() == 0) {
			return "student/lecture/lectureList";
		}
		model.addAttribute("yearAndSemList", yearAndSemList);
		
		// year semCode값이 비어있다면 최근 학기로 변경 (pay_date DESC로 정렬해서 첫번째 인덱스가 최근 학기임)
		if(lectureOpenFormVO.getSearchLectureOpenVO().getYear() == null) {
			lectureOpenFormVO.getSearchLectureOpenVO().setYear(yearAndSemList.get(0).getYear());
			lectureOpenFormVO.getSearchLectureOpenVO().setSemCode(yearAndSemList.get(0).getSemCode());
		}
		
		// 학점 정보
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		LectureOpenVO lectCountCredSum = registrationLectureService.registrationLectureCountAndCredSum(lectureOpenFormVO.getSearchLectureOpenVO());
		if(lectCountCredSum == null) {
			lectCountCredSum = new LectureOpenVO();
			lectCountCredSum.setCredSum(0);
		}
		model.addAttribute("credSum", lectCountCredSum.getCredSum());
		
		// 신청 완료한 강의 목록 
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		lectureOpenFormVO.getSearchLectureOpenVO().setNotPaging(true);
		Map<String, Object> listAndCount = registrationLectureService.registrationLectureLectOpenNumSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("registrationLectureCount", listAndCount.get("count"));
		model.addAttribute("registrationLectureList", listAndCount.get("list"));
		model.addAttribute("jsonRegistrationLectureList", listAndCount.get("jsonList"));
		
		// 시간표 정보 가져오기
		String jsonLectTimeTableList = registrationLectureService.lectureTimetableSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("jsonLectTimeTableList", jsonLectTimeTableList);
		
		model.addAttribute("lectureOpenFormVO", lectureOpenFormVO);
		
		return "student/lecture/lectureList";
	}
	
	/**
	 * 특정 학기 강의 평가 목록 출력
	 * @throws Exception 
	 */
	@RequestMapping("/student/lecture/lectureEval")
	public String lectureEvalList(LectureOpenFormVO lectureOpenFormVO
								, HttpSession session
								, Model model) throws Exception {
		
		// 중복 입력 방지 토큰 (세션과 뷰에 저장)
		lectureOpenFormVO.getLectureOpenVO().setSaveToken(saveTokenService.getToken(session));
		
		// 사용자 정보 (신청한 학점 / 신청 가능한 학점)
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		
		// 학생의 학기 정보 (셀렉트 박스)
		// 등록한 학기가 1개 이상 존재하지 않으면 빈값을 보냄
		List<TuitionPaymentVO> yearAndSemList = registrationLectureService.registrationSemSelect(memberVo.getMemId());
		if(yearAndSemList.size() == 0) {
			return "student/lecture/lectureList";
		}
		model.addAttribute("yearAndSemList", yearAndSemList);
		
		// year semCode값이 비어있다면 최근 학기로 변경 (pay_date DESC로 정렬해서 첫번째 인덱스가 최근 학기임)
		if(lectureOpenFormVO.getSearchLectureOpenVO().getYear() == null) {
			lectureOpenFormVO.getSearchLectureOpenVO().setYear(yearAndSemList.get(0).getYear());
			lectureOpenFormVO.getSearchLectureOpenVO().setSemCode(yearAndSemList.get(0).getSemCode());
		}
		
		// 학점 정보
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		LectureOpenVO lectCountCredSum = registrationLectureService.registrationLectureCountAndCredSum(lectureOpenFormVO.getSearchLectureOpenVO());
		if(lectCountCredSum == null) {
			lectCountCredSum = new LectureOpenVO();
			lectCountCredSum.setCredSum(0);
		}
		model.addAttribute("credSum", lectCountCredSum.getCredSum());
		
		// 신청 완료한 강의 목록 
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		lectureOpenFormVO.getSearchLectureOpenVO().setNotPaging(true);
		Map<String, Object> listAndCount = registrationLectureService.registrationLectureLectOpenNumSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("registrationLectureCount", listAndCount.get("count"));
		model.addAttribute("registrationLectureList", listAndCount.get("list"));
		model.addAttribute("jsonRegistrationLectureList", listAndCount.get("jsonList"));
		
		// 강의 평가 요약 (강의 번호, 평가 일자, 평가한 강의 수, 학점)
		ObjectMapper mapper = new ObjectMapper(); 
		model.addAttribute("lectureEvalInfoList", mapper.writeValueAsString(registrationLectureService.lectureEvalInfo(lectureOpenFormVO.getSearchLectureOpenVO())));
		
		model.addAttribute("lectureOpenFormVO", lectureOpenFormVO);
		
		return "student/lecture/lectureEval";
	}
	
	/**
	 * ajax : 강의 평가 항목 / 답안 보내기 (json)
	 */
	@ResponseBody
	@RequestMapping(value = "/student/lecture/getLectureEvalForm", produces = "application/json; charset=utf8")
	public String getLectureEval(@RequestBody LectureOpenVO lectureOpenVO) throws Exception {
		ObjectMapper mapper = new ObjectMapper(); 
		return mapper.writeValueAsString(registrationLectureService.lectEvalItemSelect(lectureOpenVO));
	}
	
	/**
	 * 강의 평가 입력하기 /student/lecture/lectureEvalInsert
	 */
	@ResponseBody
	@RequestMapping(value = "/student/lecture/lectureEvalInsert", produces = "application/json; charset=utf8")
	public String lectureEvalInsert(@RequestBody List<LectureEvalItemVO> lectureEvalItemList) throws Exception {
		registrationLectureService.lectureEvalInsert(lectureEvalItemList);
		return "success";
	}
	
	/**
	 * 특정 학기 성적 확인
	 */
	@RequestMapping("/student/lecture/lectureScore")
	public String lectureScoreList(LectureOpenFormVO lectureOpenFormVO
								, HttpSession session
								, Model model) throws Exception {
		
		// 사용자 정보 (신청한 학점 / 신청 가능한 학점)
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		
		// 학생의 학기 정보 (셀렉트 박스)
		// 등록한 학기가 1개 이상 존재하지 않으면 빈값을 보냄
		List<TuitionPaymentVO> yearAndSemList = registrationLectureService.registrationSemSelect(memberVo.getMemId());
		if(yearAndSemList.size() == 0) {
			return "student/lecture/lectureList";
		}
		model.addAttribute("yearAndSemList", yearAndSemList);
		
		// year semCode값이 비어있다면 최근 학기로 변경 (pay_date DESC로 정렬해서 첫번째 인덱스가 최근 학기임)
		if(lectureOpenFormVO.getSearchLectureOpenVO().getYear() == null) {
			lectureOpenFormVO.getSearchLectureOpenVO().setYear(yearAndSemList.get(0).getYear());
			lectureOpenFormVO.getSearchLectureOpenVO().setSemCode(yearAndSemList.get(0).getSemCode());
		}
		
		// 학점 정보
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		LectureOpenVO lectCountCredSum = registrationLectureService.registrationLectureCountAndCredSum(lectureOpenFormVO.getSearchLectureOpenVO());
		if(lectCountCredSum == null) {
			lectCountCredSum = new LectureOpenVO();
			lectCountCredSum.setCredSum(0);
		}
		model.addAttribute("credSum", lectCountCredSum.getCredSum());
		
		// 강의 목록, 항목 수 (stdId, sem code, year)
		Map<String, Object> listAndCount = registrationLectureService.registrationLectureLectOpenNumSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("registrationLectureCount", listAndCount.get("count"));
		model.addAttribute("registrationLectureList", listAndCount.get("list"));
		model.addAttribute("jsonRegistrationLectureList", listAndCount.get("jsonList"));
		
		// 강의의 성적 기준과 학생의 성적을 한 번에 가지고 오기 
		ObjectMapper mapper = new ObjectMapper(); 
		List<LectureScoreVO> lectureScoreList = registrationLectureService.lectScoreSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("lectureScoreList", lectureScoreList);
		model.addAttribute("jsonLectureScoreList", mapper.writeValueAsString(lectureScoreList));
		
		model.addAttribute("lectureOpenFormVO", lectureOpenFormVO);
		
		return "student/lecture/lectureScore";
		
	}
	
	/**
	 * 성적 이의 신청하기
	 */
	
	
	
}
