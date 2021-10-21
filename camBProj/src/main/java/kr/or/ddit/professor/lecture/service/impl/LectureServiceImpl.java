package kr.or.ddit.professor.lecture.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.professor.lecture.controller.LectureController;
import kr.or.ddit.professor.lecture.mapper.LectureMapper;
import kr.or.ddit.professor.lecture.service.LectureService;
import kr.or.ddit.professor.lecture.vo.ConsultVO;
import kr.or.ddit.professor.lecture.vo.LectureEvalItemVO;
import kr.or.ddit.professor.lecture.vo.LectureOpenVO;
import kr.or.ddit.professor.lecture.vo.LectureRoomVO;
import kr.or.ddit.professor.lecture.vo.LectureTimeVO;
import kr.or.ddit.professor.lecture.vo.RegistrationLectureVO;
import kr.or.ddit.professor.lecture.vo.SubjectVO;
import kr.or.ddit.professor.lecture.vo.SyllabusVO;

@Service
public class LectureServiceImpl implements LectureService{

	private static Logger logger = LoggerFactory.getLogger(LectureServiceImpl.class);
	
	@Autowired
	LectureMapper lectureMapper;
	
	@Override
	public List<LectureOpenVO> selectLectureList(Map<String, Object> map){
		
		return this.lectureMapper.selectLectureList(map);
	}
	
	@Override
	public int selectCount(Map<String, Object> map) {
		return this.lectureMapper.selectCount(map);
	}
	
	@Override
	public List<LectureRoomVO> searchLectRoom(LectureRoomVO lectureRoomVO){
		return this.lectureMapper.searchLectRoom(lectureRoomVO);
	}
	
	@Override
	public LectureOpenVO detailLectureOpen(String lectOpenNum) {
		return this.lectureMapper.detailLectureOpen(lectOpenNum);
	}
	
	//학과 번호로 해당 학과에 해당하는 강의명 출력
	@Override
	public List<SubjectVO> searchLectName(SubjectVO subjectVO) {
		return this.lectureMapper.searchLectName(subjectVO);
	}
	
	@Override
	public LectureOpenVO searchDeptName(String memId) {
		return this.lectureMapper.searchDeptName(memId);
	}
	
	@Override
	public int updateLecture(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.updateLecture(lectureOpenVO);
	}
	
	@Override
	public int deleteLectureOpen(String lectOpenNum) {
		return this.lectureMapper.deleteLectureOpen(lectOpenNum);
	}
	
	@Override
	public SyllabusVO detailSyllabus(String lectOpenNum) {
		return this.lectureMapper.detailSyllabus(lectOpenNum);
	}
	
	//강의 계획서 수정 및 입력
	@Override
	public int updateSyllabus(SyllabusVO syllabusVO) {
		return this.lectureMapper.updateSyllabus(syllabusVO);
	}
	
	@Override
	public int searchLectCount(SubjectVO subjectVO) {
		return this.lectureMapper.searchLectCount(subjectVO);
	}
	
	@Override
	public int lectureOpenInsert(LectureOpenVO lectureOpenVO) {
		
		int resultSyl = this.lectureMapper.syllabusInsert();	//강의 계획서에 기본키max Num으로 번호 인설트
		int resultOpen =0;
		if(resultSyl >0) {
			resultOpen = this.lectureMapper.lectureOpenInsert(lectureOpenVO);			
		}
		
		
		return resultOpen;
	}
	
	
	@Override
	public int lectTimeInsert(List<LectureTimeVO> time) {
		return lectureMapper.lectTimeInsert(time);
	}
	@Override
	public int lectTimeInsert2(List<LectureTimeVO> time) {
		return lectureMapper.lectTimeInsert2(time);
	}
	@Override
	public int lectTimeDelete(String lectOpenNum) {
		return this.lectureMapper.lectTimeDelete(lectOpenNum);
	}
	
	
	@Override
	public List<LectureTimeVO> selectLectOpenNum(LectureOpenVO lectureOpenVO){
		List<LectureOpenVO> lectOpenNumList = this.lectureMapper.selectLectOpenNum(lectureOpenVO) ;
		logger.info("IMPL lectOpenNumList : " + lectOpenNumList);
		if(lectOpenNumList.size() ==0) {
//			regiLectureVOList.add(registrationLectureVO.getRegistrationLectureVO().get(i));
			logger.info("빈사이지 lectOpenNumList : " + lectOpenNumList);
			LectureOpenVO temp = new LectureOpenVO();
			temp.setLectOpenNum(" ");
			lectOpenNumList.add(temp);
		}
		List<LectureTimeVO> lectureTimeList = this.lectureMapper.selectScheduleList(lectOpenNumList) ;
		
		return lectureTimeList;
	}
	
	
	// 강의평가 페이지에서 강의리스트
	@Override
	public List<LectureOpenVO> lectureEvaluationList(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.lectureEvaluationList(lectureOpenVO);
	}
	//lectureEvaluationCount
	@Override
	public int lectureEvaluationCount(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.lectureEvaluationCount(lectureOpenVO);
	}
	
	// 강의평가 페이지에서 강의리스트 상세 (해당 강의개설번호의 학수번호, 강의명, 담당교수, 평가인원, 수업인원)
	@Override
	public LectureOpenVO lectureEvalListDetail(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.lectureEvalListDetail(lectureOpenVO);
	}
	
	
	// 교과 구분 코드 별 강의평가 문항 조회  
	@Override
	public List<LectureEvalItemVO> searchEvalItem(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.searchEvalItem(lectureOpenVO);
	}
	// 강의평가 문항별 각 번호 개수 구하기   
	@Override
	public List<LectureEvalItemVO> searchEvalDetail(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.searchEvalDetail(lectureOpenVO);
	}
	
	// 출결관리 리스트
	@Override
	public List<LectureOpenVO> selectLectureListVO_ver(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.selectLectureListVO_ver(lectureOpenVO);
	}
	@Override
	public int lectureListVO_verCount(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.lectureListVO_verCount(lectureOpenVO);
	}
	@Override
	public int attendCountZero(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.attendCountZero(lectureOpenVO);
	}
	
	// 출결상세
	@Override
	public List<RegistrationLectureVO> detailAttendance(String lectOpenNum) {
		return this.lectureMapper.detailAttendance(lectOpenNum);
	}
	
	//과목,날짜별 강의 출결 현황
	@Override
	public List<RegistrationLectureVO> attendanceList(RegistrationLectureVO registrationLectureVO) {
		return this.lectureMapper.attendanceList(registrationLectureVO);
	}
	
	
	@Override
	public RegistrationLectureVO searchAttendNum(RegistrationLectureVO registrationLectureVO) {
		return this.lectureMapper.searchAttendNum(registrationLectureVO);
	}
	
	// merge, foreach 써서 출결 입력
	@Override
	public int attendanceInsert(List<RegistrationLectureVO> registrationLectureVO) {
		return lectureMapper.attendanceInsert(registrationLectureVO);
	}
	
	
	// 성적관리 리스트화면
	@Override
	public List<LectureOpenVO> selectGradeList(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.selectGradeList(lectureOpenVO);
	}
	
	// 성적관리 리스트화면 페이징
	@Override
	public int selectGradeListCount(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.selectGradeListCount(lectureOpenVO);
	}
	
	// 성적 입력이 안된 강의 개수 
	@Override
	public int gradeCountZero(LectureOpenVO lectureOpenVO) {
		return this.lectureMapper.gradeCountZero(lectureOpenVO);
	}
	
	//성적 상세페이지
	@Override
	public List<LectureOpenVO> detailGrade(String lectOpenNum) {
		return this.lectureMapper.detailGrade(lectOpenNum);
	}
	
	@Override
	public int gradeUpdate(List<LectureOpenVO> lectureOpenVO) {
		return lectureMapper.gradeUpdate(lectureOpenVO);
	}
	
	
	@Override
	public List<ConsultVO> scheduleList(ConsultVO consultVO){
		return this.lectureMapper.scheduleList(consultVO);
	}
	
	
	@Override
	public int scheduleListCount(ConsultVO consultVO) {
		return this.lectureMapper.scheduleListCount(consultVO);
	}
	@Override
	public int scheduleResultZeroCount(ConsultVO consultVO) {
		return this.lectureMapper.scheduleResultZeroCount(consultVO);
	}
	
	@Override
	public int consultTimeInsert(List<ConsultVO> consultVOList) {
		return lectureMapper.consultTimeInsert(consultVOList);
	}
	
	@Override
	public String searchConsultSchdlNum() {
		return lectureMapper.searchConsultSchdlNum();
	}
	
	@Override
	public List<ConsultVO> consultTimeList(ConsultVO consultVO){
		return this.lectureMapper.consultTimeList(consultVO);
	}
	@Override
	public int consultZeroCount(ConsultVO consultVO) {
		return this.lectureMapper.consultZeroCount(consultVO);
	}
	
	@Override
	public List<ConsultVO> consultList(){
		return this.lectureMapper.consultList();
	}
	@Override
	public int consultTimeListCount(ConsultVO consultVO) {
		return this.lectureMapper.consultTimeListCount(consultVO);
	}
	
	@Override
	public int consultTimeDelete(String consultSchdlNum) {
		return this.lectureMapper.consultTimeDelete(consultSchdlNum);
	}
	
	@Override
	public ConsultVO detailConsult(ConsultVO consultVO) {
		return this.lectureMapper.detailConsult(consultVO);
	}
	
	
	@Override
	public int updateConsultResult(ConsultVO consultVO) {
		return this.lectureMapper.updateConsultResult(consultVO);
	}
	
	
	@Override
	public List<ConsultVO> consultChartInfo(ConsultVO consultVO){
		return this.lectureMapper.consultChartInfo(consultVO);
	}
	
}
