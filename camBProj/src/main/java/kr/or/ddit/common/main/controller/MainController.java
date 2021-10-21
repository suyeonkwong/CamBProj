package kr.or.ddit.common.main.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.common.main.service.impl.MainService;
import kr.or.ddit.common.main.vo.JobCountVO;
import kr.or.ddit.common.main.vo.NoticeVO;
import kr.or.ddit.common.main.vo.StdAcadInfoVO;
import kr.or.ddit.student.volunteer.service.VolunteerService;
import kr.or.ddit.student.volunteer.vo.VolunteerVO;

@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	@Autowired
	VolunteerService volunteerService; // 봉사 시간 처리
	
	/**
	 * 회원 유형에 맞는 메인 화면을 호출 
	 * @param session
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/common/main")
	public String main(HttpSession session, Model model) throws Exception {
		
		// 세션 - 학생/교수/직원 메인 보여주는 메서드 호출
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		String memType = memberVo.getMemTypeCode();
		
		if("01".equals(memType)) {
			return studentMain(memberVo, model);
		}else if("02".equals(memType)) {
			return professorMain(memberVo, model);
		}else if("03".equals(memType)) {
			return employeeMain(memberVo, model);
		}else {
			return studentMain(memberVo, model);
		}
	}
	
	/**
	 * 학생 메인 화면 jsp 연결
	 * @param memberVo
	 * @return
	 * @throws Exception 
	 */
	public String studentMain(MemberVO memberVo, Model model) throws Exception {
		
		// 회원 정보 (학과, 학년, 재학 여부 / 학과 / 부서, 직무 / + 사진 경로) 
		model.addAttribute("MemberInfoVO", mainService.memInfoSelect(memberVo.getMemId()));

		// 공지 사항
		model.addAttribute("paginationInfo", mainService.noticeList(new NoticeVO()).get("paginationInfo")); 
		model.addAttribute("noticeList", mainService.noticeList(new NoticeVO()).get("noticeList")); 

		// 학사 정보 (이수 학점)
		StdAcadInfoVO stdAcadInfo = mainService.StdAcadInfo(memberVo.getMemId());
		model.addAttribute("stdAcadInfo", stdAcadInfo);
		model.addAttribute("jsonStdAcadInfo", new ObjectMapper().writeValueAsString(stdAcadInfo));
		
		// 봉사 시간
		VolunteerVO volunteerVo = volunteerService.volRecogTimeAndGraduation(memberVo.getMemId());
		model.addAttribute("volunteerVo", volunteerVo);
		
		// 학적 변동 정보
		JobCountVO jobCountVo = mainService.stdAcadInfoCount(memberVo.getMemId());
		model.addAttribute("jobCountVo", jobCountVo);
		
		// 최근 등록 학기, 시간표 정보 보내기 (없으면 빈 값을 보내서 화면단에서 처리)
		model.addAttribute("yearAndSem", mainService.getYearAndSem(memberVo.getMemId()));
		model.addAttribute("jsonLectTimeTableList", mainService.lectureTimetableSelect(memberVo.getMemId()));
		return "common/main/studentMain";
	}
	
	/**
	 * 교수 메인 화면 jsp 연결
	 * @param memberVo
	 * @return
	 * @throws Exception 
	 */
	public String professorMain(MemberVO memberVo, Model model) throws Exception {
		
		// 회원 정보 (학과, 학년, 재학 여부 / 학과 / 부서, 직무 / + 사진 경로) 
		model.addAttribute("MemberInfoVO", mainService.memInfoSelect(memberVo.getMemId()));
		
		// 공지 사항
		model.addAttribute("paginationInfo", mainService.noticeList(new NoticeVO()).get("paginationInfo")); 
		model.addAttribute("noticeList", mainService.noticeList(new NoticeVO()).get("noticeList"));
		
		// 이번 학기 강의 시간표 (없으면 빈 값을 보내서 화면단에서 처리)
		model.addAttribute("jsonLectTimeTableList", mainService.profLectureTimetableSelect(memberVo.getMemId()));
		
		// 업무 정보 (상담 & 결재 - 미완료 / 완료 건수)
		model.addAttribute("getJobInfo", mainService.getJobInfo(memberVo));
		
		return "common/main/professorMain";
	}
	
	/**
	 * 직원 메인 화면 jsp 연결
	 * @param memberVo
	 * @return
	 * @throws Exception 
	 */
	public String employeeMain(MemberVO memberVo, Model model) throws Exception {
		
		// 회원 정보 (학과, 학년, 재학 여부 / 학과 / 부서, 직무 / + 사진 경로) 
		model.addAttribute("MemberInfoVO", mainService.memInfoSelect(memberVo.getMemId()));
		
		// 공지 사항
		model.addAttribute("paginationInfo", mainService.noticeList(new NoticeVO()).get("paginationInfo")); 
		model.addAttribute("noticeList", mainService.noticeList(new NoticeVO()).get("noticeList"));
		
		// 업무 정보 (상담 & 결재 - 미완료 / 완료 건수)
		model.addAttribute("getJobInfo", mainService.getJobInfo(memberVo));
		
		return "common/main/employeeMain";
	}
	
	/**
	 * ajax : 공지사항 페이지 이동
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "/common/main/noticeList", produces = "application/json; charset=utf8")
	public Map<String, Object>ajaxNoticeList(@RequestBody NoticeVO noticeVo) throws Exception {
		return mainService.noticeList(noticeVo); 
	}
}
