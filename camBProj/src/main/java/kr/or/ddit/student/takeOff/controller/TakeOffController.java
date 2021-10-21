package kr.or.ddit.student.takeOff.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.student.takeOff.service.TakeOffService;
import kr.or.ddit.student.takeOff.vo.StudentVO;
import kr.or.ddit.student.takeOff.vo.TakeOffVO;
import kr.or.ddit.util.auth.controller.AuthDocController;
import kr.or.ddit.util.code.service.CodeService;
import kr.or.ddit.util.code.vo.CodeVO;
import kr.or.ddit.util.file.controller.FileController;
import kr.or.ddit.util.file.vo.AttachFileVO;
import kr.or.ddit.util.format.service.FormatUtil;
import kr.or.ddit.util.saveToken.service.SaveTokenService;

/**
 * 20210917 추후 구현할 기능
 * - 상단의 휴학 기간은 학사 일정을 기반으로 출력할 수도 있음
 * - 신청 자격
 *  1. 재학생  
 *  2. 2학기 이상 등록 
 *  3. 신청은 한 번만 
 * @author PC-08
 *
 */

@Controller
@RequestMapping("/student/takeOff/*")
public class TakeOffController {

	@Autowired
	FileController fileController; // 파일 처리 용 
	@Autowired
	CodeService codeService; // 공통 코드 처리 용
	@Autowired
	SaveTokenService saveTokenService; // 중복 입력 방지 처리 용
	@Autowired
	AuthDocController authController; // 결재 처리 용
	@Autowired
	FormatUtil formatUtil; // 전화번호 형식 처리 용
	@Autowired
	TakeOffService takeOffService;
	
	Logger logger = LoggerFactory.getLogger(TakeOffController.class);
	
	@RequestMapping("/test/image")
	public String test() {
		return "student/takeOff/test";
	}
	
	// ** 신청 폼 
	@RequestMapping(value = "/takeOffApply", method = RequestMethod.GET)
	public String insert(HttpSession session
						,@RequestParam(defaultValue = "1") String pageNo
						, Model model) {
		
		// (! 작업 중이던 페이지로 돌아가기 위해 PageNo를 저장하고 있다가, 제출 시 포워드할 때 함께 보내야 함)
		model.addAttribute("pageNo", pageNo);
		
		// 학생 정보 보내기
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		String phNum = formatUtil.phone(memberVo.getPhNum());
		model.addAttribute("phNum", phNum); // 형식에 맞게 전화번호 보내기
		
		String stdId = memberVo.getMemId();
		StudentVO studentVo = takeOffService.getStdInfo(stdId);
		studentVo.setAvailableSemCnt(takeOffService.getAvailableSemCnt(stdId));
		model.addAttribute("studentVo", studentVo);
		
		// 중복 입력 방지 토큰 (세션과 뷰에 저장)
		String saveToken = saveTokenService.getToken(session);
		model.addAttribute("saveToken", saveToken);
		
		List<CodeVO> codeList = codeService.codeList("TAK_OFF");
		model.addAttribute("codeList", codeList);
		return "student/takeOff/takeOffApply";
	}
	
	// ** 신청 폼 제출
	@RequestMapping(value = "/takeOffApply", method = RequestMethod.POST)
	public String insertPost(@ModelAttribute TakeOffVO takeOffVo
							,@RequestParam(defaultValue = "1") String pageNo
							,@RequestParam(value="fileCheck", required=false) String fileCheck
							,@RequestParam(value = "saveToken", required = false) String saveToken
							,HttpSession session) {
		
		// 중복 입력 방지 
		Boolean isDuplicate = saveTokenService.isDuplicate(session, saveToken);
		System.out.println("isDuplicate : " + isDuplicate);
		if(isDuplicate) {
			return "forward:/student/takeOff/takeOffApplyList"; // 중복이라면 insert하지 않음
		}
		
		// 파일이 들어 있을 때만 실행
		String fileGrNum = "";
		if(fileCheck!=null) {
			fileGrNum = fileController.fileUpload(takeOffVo.getFileList());
			takeOffVo.setFileGrNum(fileGrNum);
		}
		
		// 신청 시 결재 문서 테이블에 insert 후 결재 문서 번호 받아 입력하기
		// 필요한 파라미터 : 각 신청을 구분하는 번호 (봉사 : 06, 강의개설 : 07)
		String authDocNum = authController.authDocInsert("01");
		takeOffVo.setAuthDocNum(authDocNum);
		
		takeOffService.takeOffApply(takeOffVo);
		
		return "forward:/student/takeOff/takeOffApplyList"; // 포워딩으로 변경
	}

	// ** 리스트
	@RequestMapping(value = "/takeOffApplyList")
	public String list(HttpSession session
					  ,@ModelAttribute TakeOffVO takeOffVo
					  ,Model model) {
		
		// 세션에서 아이디 가져오기
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		takeOffVo.setStdId(memberVo.getMemId());
		
		// 학생 정보 가져오기
		StudentVO studentVo = takeOffService.getStdInfo(memberVo.getMemId());
		model.addAttribute("studentVo", studentVo);
		
		// count 정보 보내기
		model.addAttribute("takeOffApplyCount", takeOffService.takeOffApplyCount(takeOffVo));
		
		// 신청 정보 보내기 (접수 중인 복학 신청이 있으면 신청 불가능 - 한 번에 한 번만 신청하도록)
		String applyCheck = takeOffService.applyCheck(takeOffVo);
		model.addAttribute("applyCheck", applyCheck);

		//페이징 처리
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(takeOffVo.getPageNo());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(5);
		paginationInfo.setTotalRecordCount(takeOffService.takeOffApplyCount(takeOffVo).getTotalCnt());
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 리스트 가져오기
		takeOffVo.setFirstIndex(paginationInfo.getFirstRecordIndex()+1);  // 쿼리 쪽 페이징 처리
		takeOffVo.setLastIndex(paginationInfo.getLastRecordIndex());	// 쿼리 쪽 페이징 처리
		List<TakeOffVO> takeOffList = takeOffService.takeOffApplyList(takeOffVo);
		model.addAttribute("takeOffList", takeOffList);

		return "student/takeOff/takeOffApplyList";
	}
	
	// ** 수정 폼
	@RequestMapping(value = "/takeOffApplyUpdate", method = RequestMethod.POST)
	public String update(@RequestParam String takeOffApplyNum
						,@RequestParam(defaultValue = "1") String pageNo
						,HttpSession session
						,Model model) {

		MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
		memberVo.setPhNum(formatUtil.phone(memberVo.getPhNum()));
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("stdVo", takeOffService.getStdInfo(memberVo.getMemId()));
		
		// (! 작업 중이던 페이지로 돌아가기 위해 PageNo를 저장하고 있다가, 제출 시 포워드할 때 함께 보내야 함)
		model.addAttribute("pageNo", pageNo);
		
		// 중복 입력 방지 토큰 (세션과 뷰에 저장)
		String saveToken = saveTokenService.getToken(session);
		System.out.println("saveToken : " + saveToken);
		model.addAttribute("saveToken", saveToken);
		
		// 휴학 종류 코드 보내기
		List<CodeVO> codeList = codeService.codeList("TAK_OFF");
		model.addAttribute("codeList", codeList);
		
		TakeOffVO takeOffVo = takeOffService.takeOffApplyDetail(takeOffApplyNum);
		model.addAttribute("takeOffVo", takeOffVo);
		
		if(takeOffVo.getFileGrNum() != null) { // 파일이 들어 있을 경우
			List<AttachFileVO> fileList = fileController.fileList(takeOffVo.getFileGrNum());
			model.addAttribute("fileList", fileList);
		}
		
		return "student/takeOff/takeOffApplyUpdate";
	}
	
	// ** 수정 폼 제출
	@RequestMapping(value = "/takeOffApplyUpdateSubmit", method = RequestMethod.POST)
	public String updateSubmit(@ModelAttribute TakeOffVO takeOffVo
							  ,@RequestParam(defaultValue = "1") String pageNo
							  ,@RequestParam(value="fileCheck", required=false) String fileCheck
							  ,@RequestParam(value = "saveToken", required = false) String saveToken
							  ,HttpSession session) {
		
		// 중복 입력 방지 
		Boolean isDuplicate = saveTokenService.isDuplicate(session, saveToken);
		System.out.println("isDuplicate : " + isDuplicate);
		if(isDuplicate) {
			return "forward:/student/takeOff/takeOffApplyList"; // 중복이라면 update하지 않음
		}
		
		// 파일이 들어 있을 때만 파일 업로드 재실행 : 파일이 없는데 fileGrNum이 들어가는 결함이 있음. 
		if(fileCheck!=null) {
			String fileGrNum = fileController.fileUpload(takeOffVo.getFileList());
			takeOffVo.setFileGrNum(fileGrNum);
		}

		takeOffService.takeOffApplyUpdate(takeOffVo);
		return "forward:/student/takeOff/takeOffApplyList";
	}
	
	//** 삭제
	@RequestMapping(value = "takeOffApplyDelete", method = RequestMethod.POST)
	public String delete(@ModelAttribute TakeOffVO takeOffVo) {
		
		// 결재 기안 삭제
		takeOffVo = takeOffService.takeOffApplyDetail(takeOffVo.getTakeOffApplyNum());
		authController.authDocDelete(takeOffVo.getAuthDocNum());
		
		// proc_stat_code를 04(취소)로 update해도 되지만, 취소 내역을 복원하지도 않을 테니 그냥 지워도 될 것 같음.
		takeOffService.takeOffApplyDelete(takeOffVo.getTakeOffApplyNum());
		return "redirect:/student/takeOff/takeOffApplyList";
		
	}

}
