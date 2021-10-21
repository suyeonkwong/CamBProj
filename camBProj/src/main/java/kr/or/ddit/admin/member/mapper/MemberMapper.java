package kr.or.ddit.admin.member.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.admin.member.vo.AllMemberVO;
import kr.or.ddit.admin.member.vo.EmployeeVO;
import kr.or.ddit.admin.member.vo.MemberVO;
import kr.or.ddit.admin.member.vo.ProfessorVO;
import kr.or.ddit.admin.member.vo.StudentVO;
import kr.or.ddit.admin.member.vo.VCodeVO;
import kr.or.ddit.student.courseChange.vo.CourseRecodeVO;
import kr.or.ddit.util.code.vo.CodeVO;

@Mapper("memberMapper")
public interface MemberMapper {

//	멤버목록	
	List<MemberVO> selectMemberList(MemberVO memberVo);
	
//	멤버인원수 
	int totalMember(MemberVO memberVo);
	
//	학과목록
	List<VCodeVO> selectUnivDepList();
	
//	지도교수 목록
	List<MemberVO> selectAdvProfList(String codeVal);
	
//	부서 목록
	List<CodeVO> selectDeptCodeList();
	
//	직무 목록
	List<CodeVO> selectJobCodeList();
	
//	memId생성	
	String makeMemId(MemberVO memberVo);
	
//	멤버등록
	int insertMember(MemberVO memberVo);
	
//	학생등록
	int insertStudent(StudentVO studentVo);

//  OSY : 학생 등록 시 주전공을 courseRecode 테이블에 입력	
	int courseRecodeInsertStudent(CourseRecodeVO courseRecodeVo);
//  OSY : 학생 주전공 course recode 테이블에서도 수정/삭제 위해 PK 셀렉트	
	String courseRecodeNumSelect(String stdId);
//  OSY : 학생 수정/삭제 시 주전공을 courseRecode 테이블에서도 수정
	int courseRecodeUpdateStudent(CourseRecodeVO courseRecodeVo);
	
//	교수등록
	int insertProfessor(ProfessorVO professorVo);
	
//	직원등록
	int insertEmployee(EmployeeVO employeeVo);
	
//	멤버기본정보
	MemberVO detailMemberBefore(String memId);
	
//	멤버상세
	AllMemberVO detailMember(MemberVO memberVo);
	
//	멤버수정
	int updateMember(MemberVO memberVo);
	
//	학생수정
	int updateStudent(StudentVO studentVo);
	
//	교수수정
	int updateProfessor(ProfessorVO professorVo);
	
//	직원수정
	int updateEmployee(EmployeeVO employeeVo);
	
//	멤버삭제
	int deleteMember(MemberVO memberVo);
}
