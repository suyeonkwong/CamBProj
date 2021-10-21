package kr.or.ddit.professor.lecture.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.professor.lecture.vo.ConsultVO;
import kr.or.ddit.professor.lecture.vo.LectureEvalItemVO;
import kr.or.ddit.professor.lecture.vo.LectureOpenVO;
import kr.or.ddit.professor.lecture.vo.LectureRoomVO;
import kr.or.ddit.professor.lecture.vo.LectureTimeVO;
import kr.or.ddit.professor.lecture.vo.RegistrationLectureVO;
import kr.or.ddit.professor.lecture.vo.SubjectVO;
import kr.or.ddit.professor.lecture.vo.SyllabusVO;

@Mapper("lectureMapper")
public interface LectureMapper {

	List<LectureOpenVO> selectLectureList(Map<String, Object> map);

	int selectCount(Map<String, Object> map);

	List<LectureRoomVO> searchLectRoom(LectureRoomVO lectureRoomVO);
	
	LectureOpenVO detailLectureOpen(String lectOpenNum);

	int updateLecture(LectureOpenVO lectureOpenVO);

	int deleteLectureOpen(String lectOpenNum);

	SyllabusVO detailSyllabus(String lectOpenNum);

	int updateSyllabus(SyllabusVO syllabusVO);

	LectureOpenVO searchDeptName(String memId);

	List<SubjectVO> searchLectName(SubjectVO subjectVO);

	int searchLectCount(SubjectVO subjectVO);

	int lectureOpenInsert(LectureOpenVO lectureOpenVO);

	int syllabusInsert();

	int lectTimeInsert(List<LectureTimeVO> time);

	List<LectureOpenVO> selectLectOpenNum(LectureOpenVO lectureOpenVO);

	List<LectureTimeVO> selectScheduleList(List<LectureOpenVO> lectOpenNumList);

	List<LectureOpenVO> lectureEvaluationList(LectureOpenVO lectureOpenVO);

	int lectureEvaluationCount(LectureOpenVO lectureOpenVO);

	LectureOpenVO lectureEvalListDetail(LectureOpenVO lectureOpenVO);

	List<LectureEvalItemVO> searchEvalItem(LectureOpenVO lectureOpenVO);

	List<LectureEvalItemVO> searchEvalDetail(LectureOpenVO lectureOpenVO);

	List<LectureOpenVO> selectLectureListVO_ver(LectureOpenVO lectureOpenVO);

	int lectureListVO_verCount(LectureOpenVO lectureOpenVO);

	int attendCountZero(LectureOpenVO lectureOpenVO);

	List<RegistrationLectureVO> detailAttendance(String lectOpenNum);

	List<RegistrationLectureVO> attendanceList(RegistrationLectureVO registrationLectureVO);

	RegistrationLectureVO searchAttendNum(RegistrationLectureVO registrationLectureVO);

	int attendanceInsert(List<RegistrationLectureVO> registrationLectureVO);

	List<LectureOpenVO> selectGradeList(LectureOpenVO lectureOpenVO);

	int selectGradeListCount(LectureOpenVO lectureOpenVO);

	int gradeCountZero(LectureOpenVO lectureOpenVO);

	List<LectureOpenVO> detailGrade(String lectOpenNum);

	int gradeUpdate(List<LectureOpenVO> lectureOpenVO);

	List<ConsultVO> scheduleList(ConsultVO consultVO);

	int scheduleListCount(ConsultVO consultVO);

	int scheduleResultZeroCount(ConsultVO consultVO);

	int consultTimeInsert(List<ConsultVO> consultVOList);

	String searchConsultSchdlNum();

	List<ConsultVO> consultTimeList(ConsultVO consultVO);

	int consultTimeListCount(ConsultVO consultVO);

	int consultTimeDelete(String consultSchdlNum);

	ConsultVO detailConsult(ConsultVO consultVO);

	int updateConsultResult(ConsultVO consultVO);

	List<ConsultVO> consultChartInfo(ConsultVO consultVO);

	List<ConsultVO> consultList();

	int lectTimeDelete(String lectOpenNum);

	int consultZeroCount(ConsultVO consultVO);

	int lectTimeInsert2(List<LectureTimeVO> time);


}
