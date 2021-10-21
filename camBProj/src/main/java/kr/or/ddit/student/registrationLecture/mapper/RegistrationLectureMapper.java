package kr.or.ddit.student.registrationLecture.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.admin.member.vo.StudentVO;
import kr.or.ddit.professor.lecture.vo.LectureEvalItemVO;
import kr.or.ddit.student.registrationLecture.vo.CartVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenAndSyllabusVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenVO;
import kr.or.ddit.student.registrationLecture.vo.LectureScoreVO;
import kr.or.ddit.student.registrationLecture.vo.LectureTimetableVO;
import kr.or.ddit.student.registrationLecture.vo.RegistrationLectureVO;
import kr.or.ddit.student.registrationLecture.vo.StdRegInfoVO;
import kr.or.ddit.student.tuitionPayment.vo.TuitionPaymentVO;

@Mapper("registrationLectureMapper")
public interface RegistrationLectureMapper {
	
	/** 강의 목록 **/
	
	// 수강 신청 가능 강의 중 조건에 맞는 강의 목록 가져오기
	public List<LectureOpenAndSyllabusVO> lectureOpenSelect(LectureOpenVO lectureOpenVo);
	
	// 조건에 해당하는 강의의 수
	public int lectureOpenCount(LectureOpenVO lectureOpenVo); 
	
	// 강의 시간표 가져오기
	public List<LectureTimetableVO> lectureTimetableSelect(LectureOpenVO lectureOpenVo);
	
	/** 장바구니 **/
	
	// 특정 학기에 장바구니에 담은 강의 lect_open_num 목록 가져오기 
	public String[] cartLectOpenNumSelect(LectureOpenVO lectureOpenVo);
	
	// 특정 학기에 장바구니에 담은 강의 수 가져오기
	public int cartCount(LectureOpenVO lectureOpenVo);
	
	// 장바구니에 넣기
	public int cartInsert(CartVO cartVo);
	
	// 장바구니에서 빼기
	public int cartDelete(CartVO cartVo);

	/** 수강 신청 **/

	// 특정 학기에 신청 완료한 강의 lect_open_num 목록 가져오기
	public String[] registrationLectureLectOpenNumSelect(LectureOpenVO lectureOpenVo);
	
	// 신청 완료한 강의 수, 학점
	public LectureOpenVO registrationLectureCountAndCredSum(LectureOpenVO lectureOpenVo);
	
	// 수강 신청하기
	public int registrationLectureInsert(RegistrationLectureVO registrationLectureVo);
	
	// 수강 신청 취소하기
	public int registrationLectureDelete(RegistrationLectureVO registrationLectureVo);
	
	// 성적 테이블에 입력하기
	public int lectureScoreInsert(RegistrationLectureVO registrationLectureVo);

	// 성적 테이블에서 삭제하기
	public int lectureScoreDelete(RegistrationLectureVO registrationLectureVo);
	
	// 학생 정보 가져오기
	public StudentVO stdSelect(String stdId);
	
	// 수업 신청 학생 수 구해서 업데이트하기
	public int stdCntUpdate(String lectOpenNum);
	
	
	/** 수업 목록 **/
	
	// 학생이 등록한 학기
	public List<TuitionPaymentVO> registrationSemSelect(String stdId);
	
	/** 성적 확인 **/
	
	// 학생의 성적과 성적 기준, 교수 정보 가져오기
	public List<LectureScoreVO> lectScoreSelect(LectureOpenVO lectureOpenVo);
	
	/** 강의 평가 **/
	
	// 강의 평가 항목 / 답안 한번에 가져오기 
	public List<LectureEvalItemVO> lectEvalItemSelect(LectureOpenVO lectureOpenVo);
	
	// 학기 별 강의 평가 요약 (강의 번호, 평가 일자, 평가한 강의 수) 
	public List<LectureEvalItemVO> lectureEvalInfo(LectureOpenVO lectureOpenVo);
	
	// 강의 평가 입력
	public int lectureEvalInsert(LectureEvalItemVO lectureEvalItemVo);
}
