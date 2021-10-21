package kr.or.ddit.professor.lecture.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.professor.lecture.vo.ConsultVO;
import kr.or.ddit.professor.lecture.vo.LectureEvalItemVO;
import kr.or.ddit.professor.lecture.vo.LectureOpenVO;
import kr.or.ddit.professor.lecture.vo.LectureRoomVO;
import kr.or.ddit.professor.lecture.vo.LectureTimeVO;
import kr.or.ddit.professor.lecture.vo.RegistrationLectureVO;
import kr.or.ddit.professor.lecture.vo.SubjectVO;
import kr.or.ddit.professor.lecture.vo.SyllabusVO;

public interface LectureService {

	public List<LectureOpenVO> selectLectureList(Map<String, Object> map);

	public int selectCount(Map<String, Object> map);

	public List<LectureRoomVO> searchLectRoom(LectureRoomVO lectureRoomVO);

	public LectureOpenVO detailLectureOpen(String lectOpenNum);

	public int updateLecture(LectureOpenVO lectureOpenVO);

	public int deleteLectureOpen(String lectOpenNum);

	public SyllabusVO detailSyllabus(String lectOpenNum);

	public int updateSyllabus(SyllabusVO syllabusVO);

	public LectureOpenVO searchDeptName(String memId);

	public List<SubjectVO> searchLectName(SubjectVO subjectVO);

	public int searchLectCount(SubjectVO subjectVO);

	public int lectureOpenInsert(LectureOpenVO lectureOpenVO);

	public int lectTimeInsert(List<LectureTimeVO> time);

	public List<LectureTimeVO> selectLectOpenNum(LectureOpenVO lectureOpenVO);

	public List<LectureOpenVO> lectureEvaluationList(LectureOpenVO lectureOpenVO);

	public int lectureEvaluationCount(LectureOpenVO lectureOpenVO);

	public LectureOpenVO lectureEvalListDetail(LectureOpenVO lectureOpenVO);

	public List<LectureEvalItemVO> searchEvalItem(LectureOpenVO lectureOpenVO);

	public List<LectureEvalItemVO> searchEvalDetail(LectureOpenVO lectureOpenVO);

	public List<LectureOpenVO> selectLectureListVO_ver(LectureOpenVO lectureOpenVO);

	public int lectureListVO_verCount(LectureOpenVO lectureOpenVO);

	public int attendCountZero(LectureOpenVO lectureOpenVO);

	public List<RegistrationLectureVO> detailAttendance(String lectOpenNum);

	public List<RegistrationLectureVO> attendanceList(RegistrationLectureVO registrationLectureVO);

	public RegistrationLectureVO searchAttendNum(RegistrationLectureVO registrationLectureVO);

	public int attendanceInsert(List<RegistrationLectureVO> registrationLectureVO);

	public List<LectureOpenVO> selectGradeList(LectureOpenVO lectureOpenVO);

	public int selectGradeListCount(LectureOpenVO lectureOpenVO);

	public int gradeCountZero(LectureOpenVO lectureOpenVO);

	public List<LectureOpenVO> detailGrade(String lectOpenNum);

	public int gradeUpdate(List<LectureOpenVO> lectureOpenVO);

	public List<ConsultVO> scheduleList(ConsultVO consultVO);

	public int scheduleListCount(ConsultVO consultVO);

	public int scheduleResultZeroCount(ConsultVO consultVO);

	public int consultTimeInsert(List<ConsultVO> consultVOList);

	public String searchConsultSchdlNum();

	public List<ConsultVO> consultTimeList(ConsultVO consultVO);

	public int consultTimeListCount(ConsultVO consultVO);

	public int consultTimeDelete(String consultSchdlNum);

	public ConsultVO detailConsult(ConsultVO consultVO);

	public int updateConsultResult(ConsultVO consultVO);

	public List<ConsultVO> consultChartInfo(ConsultVO consultVO);

	public List<ConsultVO> consultList();

	public int lectTimeDelete(String lectOpenNum);

	public int consultZeroCount(ConsultVO consultVO);

	public int lectTimeInsert2(List<LectureTimeVO> time);





}
