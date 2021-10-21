package kr.or.ddit.admin.member.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.member.mapper.MemberMapper;
import kr.or.ddit.admin.member.service.MemberService;
import kr.or.ddit.admin.member.vo.AllMemberVO;
import kr.or.ddit.admin.member.vo.EmployeeVO;
import kr.or.ddit.admin.member.vo.MemberVO;
import kr.or.ddit.admin.member.vo.ProfessorVO;
import kr.or.ddit.admin.member.vo.StudentVO;
import kr.or.ddit.admin.member.vo.VCodeVO;
import kr.or.ddit.student.courseChange.vo.CourseRecodeVO;
import kr.or.ddit.util.code.vo.CodeVO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper memberMapper;

//	멤버 목록
	@Override
	public List<MemberVO> selectMemberList(MemberVO memberVo) throws Exception {
		return memberMapper.selectMemberList(memberVo);
	}
	
//	멤버 인원 수
	@Override
	public int totalMember(MemberVO memberVo) throws Exception {
		return memberMapper.totalMember(memberVo);
	}

//	학과목록
	@Override
	public List<VCodeVO> selectUnivDepList() throws Exception {
		return memberMapper.selectUnivDepList();
	}
	
//	지도교수 목록
	@Override
	public List<MemberVO> selectAdvProfList(String codeVal) throws Exception {
		return memberMapper.selectAdvProfList(codeVal);
	}
	
//	부서목록
	@Override
	public List<CodeVO> selectDeptCodeList() throws Exception {
		return memberMapper.selectDeptCodeList();
	}
	
//	직무목록
	@Override
	public List<CodeVO> selectJobCodeList() throws Exception {
		return memberMapper.selectJobCodeList();
	}
	
//	memId 생성
	@Override
	public String makeMemId(MemberVO memberVo) throws Exception{
		return memberMapper.makeMemId(memberVo);
	}
	
//	멤버 등록
	@Override
	public String insertMember(MemberVO memberVo) throws Exception {
		
		int affectedRowCnt = memberMapper.insertMember(memberVo);
		if(affectedRowCnt > 0) {	//insert 성공
			return memberVo.getMemId();	//회원 번호를 리턴
		}else {	//insert 실패 시 0 리턴
			return null;
		}
	}

//	학생 등록
	@Override
	public String insertStudent(StudentVO studentVo) throws Exception{
		
		int affectedRowCnt = memberMapper.insertStudent(studentVo);
		if(affectedRowCnt > 0) {	//insert 성공
			
			// 학생의 주전공을 courseRecode 테이블에 입력
			CourseRecodeVO courseRecodeVo = new CourseRecodeVO();
			courseRecodeVo.setStdId(studentVo.getStdId());
			courseRecodeVo.setUnivDeptNum(studentVo.getUnivDeptNum());
			memberMapper.courseRecodeInsertStudent(courseRecodeVo);
			
			return studentVo.getStdId();	//학생 번호를 리턴
			
		}else {	//insert 실패 시 0 리턴
			return null;
		}
		
	}
	
//	교수 등록
	@Override
	public String insertProfessor(ProfessorVO professorVo) throws Exception{
		
		int affectedRowCnt = memberMapper.insertProfessor(professorVo);
		if(affectedRowCnt > 0) {	//insert 성공
			return professorVo.getProfId();	//교수 번호를 리턴
		}else {	//insert 실패 시 0 리턴
			return null;
		}
		
	}
	
//	직원 등록
	@Override
	public String insertEmployee(EmployeeVO employeeVo) throws Exception{
		
		int affectedRowCnt = memberMapper.insertEmployee(employeeVo);
		if(affectedRowCnt > 0) {	//insert 성공
			return employeeVo.getEmpId();	//직원 번호를 리턴
		}else {	//insert 실패 시 0 리턴
			return null;
		}
	}
	
//	멤버기본정보
	@Override
	public MemberVO detailMemberBefore(String memId) throws Exception {
		return memberMapper.detailMemberBefore(memId);
	}
	
//	멤버 상세
	@Override
	public AllMemberVO detailMember(MemberVO memberVo) throws Exception {
		return memberMapper.detailMember(memberVo);
	}

//	멤버 수정
	@Override
	public int updateMember(MemberVO memberVo) throws Exception{
		return memberMapper.updateMember(memberVo);
	}
	
//	학생 수정
	@Override
	public int updateStudent(StudentVO studentVo) throws Exception {
		
		// 학과 코드가 잘못들어감 01 -> UNIV_DEPT1 로 보정
		String univDeptNum = studentVo.getUnivDeptNum();
		if('0' == univDeptNum.charAt(0)) {
			univDeptNum = univDeptNum.substring(1);
		}
		studentVo.setUnivDeptNum("UNIV_DEPT" + univDeptNum);
		
		// 학생 수정 시 주전공을 courseRecode 테이블에서도 수정
		CourseRecodeVO courseRecodeVo = new CourseRecodeVO();
		String courseRcdNum = memberMapper.courseRecodeNumSelect(studentVo.getStdId());
		courseRecodeVo.setCourseRcdNum(courseRcdNum);
		courseRecodeVo.setUnivDeptNum(studentVo.getUnivDeptNum());
		memberMapper.courseRecodeUpdateStudent(courseRecodeVo);
		
		return memberMapper.updateStudent(studentVo);
	}
	
//	교수 수정
	@Override
	public int updateProfessor(ProfessorVO professorVo) throws Exception {
		return memberMapper.updateProfessor(professorVo);
	}
	
//	직원 수정
	@Override
	public int updateEmployee(EmployeeVO employeeVo) throws Exception {
		return memberMapper.updateEmployee(employeeVo);
	}

//	멤버 삭제
	@Override
	public int deleteMember(MemberVO memberVo) throws Exception {
		
		// 학생일 경우 전공 포기 여부 Y로 수정 --? 왜  memTypeCode가 안 들어오는지?
		if("01".equals(memberVo.getMemTypeCode())) {
			CourseRecodeVO courseRecodeVo = new CourseRecodeVO();
			String courseRcdNum = memberMapper.courseRecodeNumSelect(memberVo.getMemId());
			courseRecodeVo.setCourseRcdNum(courseRcdNum);
			memberMapper.courseRecodeUpdateStudent(courseRecodeVo);
		}
		
		return memberMapper.deleteMember(memberVo);
	}









	
	
}
