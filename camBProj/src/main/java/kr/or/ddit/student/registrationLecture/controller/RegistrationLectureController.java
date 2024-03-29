package kr.or.ddit.student.registrationLecture.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.student.registrationLecture.service.RegistrationLectureService;
import kr.or.ddit.student.registrationLecture.vo.CartVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenAndSyllabusVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenFormVO;
import kr.or.ddit.student.registrationLecture.vo.LectureOpenVO;
import kr.or.ddit.util.code.service.CodeService;
import kr.or.ddit.util.code.vo.CodeVO;
import kr.or.ddit.util.saveToken.service.SaveTokenService;

/**
 * - 수강 신청 메뉴 기능
 * 
 * 09/29 
 * - 학생 성적에 따라 신청 가능한 학점 상향, 하향해야 함 
 * @author PC-08
 */
@Controller
public class RegistrationLectureController {
	
	@Autowired
	RegistrationLectureService registrationLectureService;
	@Autowired
	CodeService codeService; // 공통 코드 처리 용
	@Autowired
	SaveTokenService saveTokenService; // 중복 입력 방지 처리 용
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RegistrationLectureController.class);
	
	/**
	 * 수강 신청 할 수 있는 강의 목록
	 * - 장바구니, 신청 완료 강의 목록도 약식으로 보여줌 (페이징 처리 X)
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLectureL/lectureOpenList")
	public String lectureOpenList(LectureOpenFormVO lectureOpenFormVO
								, HttpSession session
								, Model model) throws Exception {
		
		// 중복 입력 방지 토큰 (세션과 뷰에 저장)
		lectureOpenFormVO.getLectureOpenVO().setSaveToken(saveTokenService.getToken(session));
		
		// 사용자 정보 (신청한 학점 / 신청 가능한 학점)
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		lectureOpenFormVO.getLectureOpenVO().setStdId(memberVo.getMemId());
		LectureOpenVO lectCountCredSum = registrationLectureService.registrationLectureCountAndCredSum(lectureOpenFormVO.getLectureOpenVO());
		if(lectCountCredSum == null) {
			lectCountCredSum = new LectureOpenVO();
			lectCountCredSum.setCredSum(0);
		}
		int credAvail = 21; // 학생의 성적에 따라 상향, 하향할 수 있는 메서드 만들기
		model.addAttribute("credSum", lectCountCredSum.getCredSum());
		model.addAttribute("credAvail", credAvail);
		
		// 강의 목록 & 항목 수 & 페이징 객체
		Map<String, Object> listAndCount = registrationLectureService.lectureOpenSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("lectureOpenListCount", listAndCount.get("count"));
		model.addAttribute("lectureOpenList", listAndCount.get("list"));
		model.addAttribute("jsonLectureOpenList", listAndCount.get("jsonList"));
		model.addAttribute("paginationInfo", registrationLectureService.getPaginationInfo(lectureOpenFormVO.getSearchLectureOpenVO(), 1));

		// json 객체 보내기
		ObjectMapper mapper = new ObjectMapper();
		String jsonLectureOpenList = mapper.writeValueAsString(listAndCount.get("list"));
		LOGGER.info(jsonLectureOpenList);
		model.addAttribute("jsonLectureOpenList", jsonLectureOpenList);
		
		
		// 약식 장바구니 & 신청 완료 강의 목록 (페이징 처리 X) & 각 항목 수 (stdId, notPaging 값만 있어야 됨)
		LectureOpenVO paramLectureOpenVO = new LectureOpenVO();
		paramLectureOpenVO.setStdId(memberVo.getMemId());
		paramLectureOpenVO.setNotPaging(true);
		listAndCount = registrationLectureService.cartLectOpenNumSelect(paramLectureOpenVO);
		model.addAttribute("cartCount", listAndCount.get("count"));
		model.addAttribute("cartList", listAndCount.get("list"));
		model.addAttribute("jsonCartList", listAndCount.get("jsonList"));
		
		listAndCount = registrationLectureService.registrationLectureLectOpenNumSelect(paramLectureOpenVO);
		model.addAttribute("registrationLectureCount", listAndCount.get("count"));
		model.addAttribute("registrationLectureList", listAndCount.get("list"));
		model.addAttribute("jsonRegistrationLectureList", listAndCount.get("jsonList"));
		
		// 교과 구분 코드 SUBJ_TYPE_CODE
		List<CodeVO> codeList = codeService.codeList("SUB_TYP");
		model.addAttribute("codeList", codeList);
		return "student/registrationLecture/lectureOpenList";
	}
	
	/**
	 * ajax : 모달 창에 뿌릴 강의 계획서 데이터 주기 (교수의 이메일, 연락처 추가)
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "/student/registrationLecture/getSyllabus", produces = "application/json; charset=utf8")
	public LectureOpenAndSyllabusVO getSyllabus(@RequestBody LectureOpenVO lectureOpenVO) throws Exception {
		Map<String, Object> listAndCount = registrationLectureService.lectureOpenSelect(lectureOpenVO);
		List<LectureOpenAndSyllabusVO> list = (List<LectureOpenAndSyllabusVO>) listAndCount.get("list");
		return list.get(0);
	}

	
	/**
	 * 장바구니에 담은 강의 목록
	 * 페이징 없음
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLectureC/cartList")
	public String cartList(LectureOpenFormVO lectureOpenFormVO, HttpSession session, Model model) throws Exception {
		
		// 사용자 정보 (신청한 학점 / 신청 가능한 학점)
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		lectureOpenFormVO.getLectureOpenVO().setStdId(memberVo.getMemId());
		LectureOpenVO lectCountCredSum = registrationLectureService.registrationLectureCountAndCredSum(lectureOpenFormVO.getLectureOpenVO());
		int credAvail = 21; // 학생의 성적에 따라 상향, 하향할 수 있는 메서드 만들기
		model.addAttribute("credSum", lectCountCredSum.getCredSum());
		model.addAttribute("credAvail", credAvail);

		// 중복 입력 방지 토큰 (세션과 뷰에 저장)
		lectureOpenFormVO.getLectureOpenVO().setSaveToken(saveTokenService.getToken(session));
		
		// 장바구니
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		lectureOpenFormVO.getSearchLectureOpenVO().setNotPaging(true);
		Map<String, Object> cartListAndCount = registrationLectureService.cartLectOpenNumSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("cartCount", cartListAndCount.get("count"));
		model.addAttribute("cartList", cartListAndCount.get("list"));
		model.addAttribute("jsonCartList", cartListAndCount.get("jsonList"));
		model.addAttribute("paginationInfo", registrationLectureService.getPaginationInfo(lectureOpenFormVO.getSearchLectureOpenVO(), 2));
		
		// 수강 완료 정보
		Map<String, Object> regiListAndCount = registrationLectureService.registrationLectureLectOpenNumSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("registrationLectureCount", regiListAndCount.get("count"));
		model.addAttribute("jsonRegistrationLectureList", regiListAndCount.get("jsonList"));
		
		return "student/registrationLecture/cartList";
	}
	
	/**
	 * 장바구니, 수강신청 시 각 페이지에 따라 forward 되는 페이지가 달라야 함
	 * @param lectureOpenFormVO
	 * @return forward 되는 페이지 주소
	 */
	private String getViewStr(LectureOpenFormVO lectureOpenFormVO) {
		String view = "";
		//<!-- LECT-수강신청 / CART-장바구니 / REGI-신청완료  -->
		if("LECT".equals(lectureOpenFormVO.getSearchLectureOpenVO().getSearchCondition())) {
			view = "forward:/student/registrationLectureL/lectureOpenList";
		}else if("CART".equals(lectureOpenFormVO.getSearchLectureOpenVO().getSearchCondition())) {
			view = "forward:/student/registrationLectureC/cartList";
		}else if("REGI".equals(lectureOpenFormVO.getSearchLectureOpenVO().getSearchCondition())) {
			view = "forward:/student/registrationLectureR/registrationLectureList";
		}
		return view;
	}
	
	/**
	 * 장바구니 담기 (saveTocken)
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLecture/cartInsert") 
	public String cartInsert(LectureOpenFormVO lectureOpenFormVO, HttpSession session) throws Exception {
		
		String view = getViewStr(lectureOpenFormVO);
		
		// 중복 입력 방지 
		Boolean isDuplicate = saveTokenService.isDuplicate(session, lectureOpenFormVO.getLectureOpenVO().getSaveToken());
		if(isDuplicate) {
			return view;
		}
		
		CartVO cartVo = new CartVO();
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		cartVo.setStdId(memberVo.getMemId());
		cartVo.setLectOpenNum(lectureOpenFormVO.getLectureOpenVO().getLectOpenNum()); // formVo의 값을 가져온다.
		registrationLectureService.cartInsert(cartVo);
		
		return view;
	}
	
	/**
	 * 장바구니에서 삭제하기 
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLecture/cartDelete")
	public String cartDelete(LectureOpenFormVO lectureOpenFormVO, HttpSession session) throws Exception {
		
		String view = getViewStr(lectureOpenFormVO);
		
		// 중복 입력 방지 
		Boolean isDuplicate = saveTokenService.isDuplicate(session, lectureOpenFormVO.getLectureOpenVO().getSaveToken());
		if(isDuplicate) {
			return view;
		}
		
		CartVO cartVo = new CartVO();
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		cartVo.setStdId(memberVo.getMemId());
		cartVo.setLectOpenNum(lectureOpenFormVO.getLectureOpenVO().getLectOpenNum()); // formVo의 값을 가져온다.
		registrationLectureService.cartDelete(cartVo);
		
		return view;
	}
	
	/**
	 * ajax : 장바구니 일괄 수강신청
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "/student/registrationLecture/registrationLectureInsertAll", produces = "application/json; charset=utf8")
	public String registrationLectureInsertAll(@RequestBody LectureOpenVO lectureOpenVo, HttpSession session) throws Exception {

		String result = registrationLectureService.registrationLectureInsert(lectureOpenVo, session);
		
		return result;
	}

	/**
	 * ajax : 장바구니 일괄 삭제
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "/student/registrationLecture/registrationLectureDeleteAll", produces = "application/json; charset=utf8")
	public int registrationLectureDeleteAll(@RequestBody LectureOpenVO lectureOpenVo, HttpSession session) throws Exception {
		
		int result = 0; 
		LOGGER.info(lectureOpenVo.toString());
		for(String lectOpenNum : lectureOpenVo.getLectOpenNumList()) {
			CartVO cartVo = new CartVO();
			MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
			cartVo.setStdId(memberVo.getMemId());
			cartVo.setLectOpenNum(lectOpenNum); // formVo의 값을 가져온다.
			result += registrationLectureService.cartDelete(cartVo);
		}
		
		return result;
	}
	
	/**
	 * 수강 신청하기
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLecture/registrationLectureInsert")
	public String registrationLectureInsert(LectureOpenFormVO lectureOpenFormVO, HttpSession session, Model model) throws Exception {
		
		String view = getViewStr(lectureOpenFormVO);
		
		// 중복 입력 방지 
		Boolean isDuplicate = saveTokenService.isDuplicate(session, lectureOpenFormVO.getLectureOpenVO().getSaveToken());
		if(isDuplicate) {
			return view;
		}
		String result = registrationLectureService.registrationLectureInsert(lectureOpenFormVO.getLectureOpenVO(), session);
		model.addAttribute("result", result);
		
		return view;
	}
	
	/**
	 * 수강 삭제하기
	 * lectureOpenVo에는 검색용 searchVo와 폼 제출용 formVo가 들어있음 : 여기에선 formVo 사용
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLecture/registrationLectureDelete")
	public String registrationLectureDelete(LectureOpenFormVO lectureOpenFormVO, HttpSession session) throws Exception {
		
		String view = getViewStr(lectureOpenFormVO);
		
		// 중복 입력 방지 
		Boolean isDuplicate = saveTokenService.isDuplicate(session, lectureOpenFormVO.getLectureOpenVO().getSaveToken());
		if(isDuplicate) {
			return view;
		}
		
		registrationLectureService.registrationLectureDelete(lectureOpenFormVO.getLectureOpenVO(), session);
		return view;
	}
	
	
	/**
	 * 신청 완료한 강의 목록 (페이징 처리 없음)
	 * @throws Exception 
	 */
	@RequestMapping("/student/registrationLectureR/registrationLectureList")
	public String registrationLectureList(LectureOpenFormVO lectureOpenFormVO, HttpSession session, Model model) throws Exception {
		// 사용자 정보 (신청한 학점 / 신청 가능한 학점)
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		lectureOpenFormVO.getLectureOpenVO().setStdId(memberVo.getMemId());
		LectureOpenVO lectCountCredSum = registrationLectureService.registrationLectureCountAndCredSum(lectureOpenFormVO.getLectureOpenVO());
		int credAvail = 21; // 학생의 성적에 따라 상향, 하향할 수 있는 메서드 만들기
		model.addAttribute("credSum", lectCountCredSum.getCredSum());
		model.addAttribute("credAvail", credAvail);

		// 중복 입력 방지 토큰 (세션과 뷰에 저장)
		lectureOpenFormVO.getLectureOpenVO().setSaveToken(saveTokenService.getToken(session));
		
		// 신청 완료한 강의 목록 
		lectureOpenFormVO.getSearchLectureOpenVO().setStdId(memberVo.getMemId());
		lectureOpenFormVO.getSearchLectureOpenVO().setNotPaging(true);
		Map<String, Object> listAndCount = registrationLectureService.registrationLectureLectOpenNumSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("registrationLectureCount", listAndCount.get("count"));
		model.addAttribute("registrationLectureList", listAndCount.get("list"));
		model.addAttribute("jsonRegistrationLectureList", listAndCount.get("jsonList"));
		
		// 시간표 정보 가져오기
		String jsonLectTimeTableList = registrationLectureService.lectureTimetableSelect(lectureOpenFormVO.getSearchLectureOpenVO());
		model.addAttribute("jsonLectTimeTableList", jsonLectTimeTableList);
		
		return "student/registrationLecture/registrationLectureList";
	}
	
	
}
