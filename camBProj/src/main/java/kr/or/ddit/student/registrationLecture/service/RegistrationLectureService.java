package kr.or.ddit.student.registrationLecture.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.or.ddit.professor.lecture.vo.LectureEvalItemVO;
import kr.or.ddit.student.registrationLecture.vo.CartVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenVO;
import kr.or.ddit.student.registrationLecture.vo.LectureScoreVO;
import kr.or.ddit.student.tuitionPayment.vo.TuitionPaymentVO;

public interface RegistrationLectureService {

	/**
	 * 현재 수강 신청한 강의 수, 학점 합계
	 */
	LectureOpenVO registrationLectureCountAndCredSum(LectureOpenVO lectureOpenVo) throws Exception;
	
	/**
	 * pageNo가 저장된 returnVo를 페이징 처리 객체 가져오기
	 * flag : 1(강의), 2(장바구니), 3(신청 완료)
	 */
	PaginationInfo getPaginationInfo(LectureOpenVO lectureOpenVo, int flag) throws Exception;

	/**
	 * 장바구니에 담긴 강의 목록을 페이징 처리해 가져온다.
	 * @param cartVo : stdId, year, semCode 
	 * @return Map<String, Object> listAndCount : List<LectureOpenAndSyllabusVO> 장바구니에 담긴 강의 목록 & int 강의 수
	 */
	Map<String, Object> cartLectOpenNumSelect(LectureOpenVO lectureOpenVo) throws Exception;

	/**
	 * 수강신청 완료한 강의 목록을 페이징 처리해 가져온다.
	 * @param registrationLectureVo : stdId, year, semCode 
	 * @return Map<String, Object> listAndCount : List<LectureOpenAndSyllabusVO> 수강신청 완료한 강의 목록 & int 강의 수
	 */
	Map<String, Object> registrationLectureLectOpenNumSelect(LectureOpenVO lectureOpenVo)
			throws Exception;

	/**
	 * 조건에 맞는 강의 수와, 조건에 맞는 강의 목록을 페이징 처리해 가져온다. 
	 * (수강신청 가능 강의 / 장바구니에 담은 강의 / 수강 신청 완료 강의)
	 * @param lectureOpenVo
	 * @param paginationInfo
	 * @return Map<String, Object> listAndCount : List<LectureOpenAndSyllabusVO> 조건에 맞는 강의 목록 & int 강의 수
	 */
	Map<String, Object> lectureOpenSelect(LectureOpenVO lectureOpenVo)
			throws Exception;

	/**
	 * 장바구니에 넣기
	 */
	void cartInsert(CartVO cartVo) throws Exception;

	/**
	 * 장바구니에서 삭제하기
	 * @return 
	 */
	int cartDelete(CartVO cartVo) throws Exception;

	/**
	 * 수강 신청 완료 목록에 넣기
	 * std_id lect_open_num std_rgst_sem std_grade lect_univ_dept_num lect_grdtn_requ_yn
	 * @return 
	 */
	String registrationLectureInsert(LectureOpenVO lectureOpenVo, HttpSession session) throws Exception;

	/**
	 * 수강 신청 완료 목록에서 삭제하기
	 */
	void registrationLectureDelete(LectureOpenVO lectureOpenVo, HttpSession session) throws Exception;

	/**
	 * 시간표 가져오기
	 * std_id, sem_code, year 정보 받아 
	 * 1. registrationLectureLectOpenNumSelect로 강의 목록 가져오고, 
	 * 2. 1을 파라미터로 넣어서 lectureTimetableSelect 실행
	 * json 형태로 준다
	 * @throws JsonProcessingException 
	 */
	String lectureTimetableSelect(LectureOpenVO lectureOpenVo) throws JsonProcessingException;

	/**
	 * 학생이 등록한 학기 정보 
	 */
	List<TuitionPaymentVO> registrationSemSelect(String stdId) throws Exception;

	/**
	 * 학생의 성적과 성적 기준, 교수 정보 가져오기
	 */
	List<LectureScoreVO> lectScoreSelect(LectureOpenVO lectureOpenVo) throws Exception;

	/**
	 * 강의 평가 항목 / 답안 한번에 가져오기 
	 */
	List<LectureEvalItemVO> lectEvalItemSelect(LectureOpenVO lectureOpenVo) throws Exception;

	/**
	 * 강의 평가 입력하기
	 */
	void lectureEvalInsert(List<LectureEvalItemVO> lectureEvalItemList) throws Exception;

	/**
	 * 강의 평가 요약 (강의 번호, 평가 일자, 평가한 강의 수) 
	 * - count_answer : 평가한 강의 수로 사용했다
	 */
	List<LectureEvalItemVO> lectureEvalInfo(LectureOpenVO lectureOpenVo) throws Exception;

	/**
	 * 날짜를 기반으로 year, semcode 구하기
	 */
	Map<String, String> getYearSemCode();

	
	

}
