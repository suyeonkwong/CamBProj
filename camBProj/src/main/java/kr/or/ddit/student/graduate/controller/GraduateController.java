package kr.or.ddit.student.graduate.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.common.main.service.impl.MainService;
import kr.or.ddit.student.graduate.service.GraduateService;

@Controller
public class GraduateController {
	
	@Autowired
	GraduateService graduateService;
	@Autowired
	MainService mainService; // 메인에 구현된 학생 정보 열람 기능 사용 
	
	@RequestMapping("/tempTest")
	String tempTest(Model model) {
		return "student/graduate/volunteerListtest";
	}
	
	/**
	 * 졸업 사정용 성적 일람표 띄우기
	 * @param session
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping("/student/graduate/gradEvaluationDetail")
	public String gradEvaluationDetail(HttpSession session, Model model) throws JsonProcessingException {
		
		MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
		ObjectMapper mapper = new ObjectMapper();
		
		// 학생 정보
		model.addAttribute("memInfo", mainService.memInfoSelect(memberVo.getMemId()));
		model.addAttribute("stdAcadInfo", mainService.StdAcadInfo(memberVo.getMemId()));
		
		// 성적 정보
		Map<String, Object> map = graduateService.gradEvaluationDetail(memberVo.getMemId());
		model.addAttribute("scoreList", map.get("scoreList"));
		model.addAttribute("jsonScoreList", mapper.writeValueAsString(map.get("scoreList")));
		model.addAttribute("volTime", map.get("volTime"));
		
		return "student/graduate/gradEvaluationDetail";
	}
	
	/**
	 * 졸업 처리
	 * @throws Exception 
	 */
	@RequestMapping("/student/graduate/stdGraduate")
	public String stdGraduate(String stdId) throws Exception {
		graduateService.stdGraduate(stdId);
		return "forward:/student/graduate/gradEvaluationDetail";
	}
	
}
