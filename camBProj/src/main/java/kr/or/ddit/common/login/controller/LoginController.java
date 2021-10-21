package kr.or.ddit.common.login.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.common.login.vo.MemberVO;
import kr.or.ddit.util.CryptoUtil.CryptoUtil;
import kr.or.ddit.common.login.service.LoginService;
import lombok.extern.slf4j.Slf4j;

@Slf4j

@Controller
public class LoginController {

//	주석입니다.
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private LoginService loginService;

//	단순 로그인화면 호출
	@RequestMapping(value = "/common/login", method = RequestMethod.GET)
	public String login() {

		return "common/login";
	}

//	로그인 점검 및 로직 수행 : 직접입력시
	@RequestMapping(value = "/common/login", method = RequestMethod.POST)
	public String loginPost(@ModelAttribute MemberVO memberVo, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		logger.info("memberVo는 입력 받은 아이디와 비번만 있는 VO : " + memberVo.toString());
		
		String InputId = memberVo.getMemId();
		logger.info("입력받은 아이디 >> : " + InputId);
		String InputPass = memberVo.getPwd();
		logger.info("입력받은 비번 >> : " + InputPass);

//		-------------비밀번호 암호화 가공 세팅------------
		
		logger.info("로그인 준비 시작");
		
		String InputPassCrypto = CryptoUtil.sha512(InputPass);
		logger.info("DB와 비교하기위해 가공된 비번 >> : " + InputPassCrypto);
		
//		입력받은 memberVo의 비번을 암호화된 비번으로 세팅
		memberVo.setPwd(InputPassCrypto);
		logger.info("비번이 가공된 memberVo : " + memberVo.toString());
		
//		-------------비밀번호 암호화 가공 세팅 끝------------
		
//		-------------0단계 검증 시작------------
		MemberVO checkLoginVo = loginService.login(memberVo);
		
		if(checkLoginVo==null) { //무조건 로그인이 안되는 상황. (사용불가 아이디 / 비번입력오류)
//			비번오류일 경우인지 확인. 아이디는 사용가능한지 확인
			MemberVO checkLoginPwdVo = loginService.checkPwdMiss(InputId);
			if(checkLoginPwdVo == null) { // => 회원정보가 없습니다.
				request.setAttribute("msg", "delete");
				return "common/login";
				
			}else { // 비밀번호만 틀린 상황. 아이디만 검색했을때 나옴
//				비밀번호 오류횟수 확인
				int checkErrCnt = checkLoginPwdVo.getPwdErrCnt();
					if(checkErrCnt > 5) { // 오류횟수 초과로 로그인 불가
					request.setAttribute("msg", "errCnt");
					return "common/login";
					
					} else { // 에러카운트 여유있음. 비번오류횟수 1증가 
						int plusResult = loginService.plusErrCnt(memberVo);
						if(plusResult > 0) {
							logger.info("pwdErrCnt +1 완료");
						}else {
							logger.info("!!!!!!!!!!!!pwdErrCnt +1 실패");
						}
						
						//전체오류횟수 카운트해서 알려주기
						int selectCnt = loginService.selectCnt(memberVo);
						model.addAttribute("cnt", selectCnt);
						logger.info("오류 숫자 수" + selectCnt);
						request.setAttribute("msg", "fail");
						return "common/login";
					}
			}
			
//		-------------0단계 검증 끝------------
//		-------------1단계 검증 시작------------

			
		}else { // 로그인 통과가 됨
			logger.info("로그인 통과 된 checkLoginVo >> : " + checkLoginVo.toString());
			
//			1. 에러카운트 0으로 초기화 하기
			int resetResult = loginService.resetErrCnt(memberVo);
			if(resetResult > 0) {
				logger.info("pwdErrCnt 초기화 완료");
			}else {
				logger.info("!!!!!!!!!!!!pwdErrCnt 초기화 실패");
			}
			
//			2. loginType을 확인한다.
			String realLoginType =  checkLoginVo.getLoginType();
			
			if(realLoginType.equalsIgnoreCase("first")) { //최초로그인자
//				1)세션에 로그인 값을 넣어준다
				realLogin(checkLoginVo, session);
//				2)초기비번컬럼 초기화
				int resetFirstInsert = loginService.resetFirstInsert(memberVo);
				if(resetFirstInsert > 0) {
					logger.info("초기비번컬럼 초기화 완료");
				}else {
					logger.info("!!!!!!!!!!!!초기비번컬럼 초기화 실패");
				}
//				3)비번변경화면으로 이동
				return "common/myPage/myPageUpdatePwd";
				
			} else { //기로그인자
//				1)세션에 로그인 값을 넣어준다
				realLogin(checkLoginVo, session);
//				2)메인으로 이동
				return "redirect:/common/main";
			}
		}
	}
	
//	로그인 점검 및 로직 수행 : 셀렉박스 선택시
	@RequestMapping(value = "/quickLogin", method = RequestMethod.POST)
	public String quickLogin(@ModelAttribute MemberVO memberVo, HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
//		입력받은 VO로 로그인Vo 전체 값 풀세팅
		MemberVO quickLoginVo = loginService.login(memberVo);
		
//		세션입력
		realLogin(quickLoginVo, session);
		
//		리다이렉트
		return "redirect:/common/main";
	}
	
//	로그인하기
	public void realLogin(MemberVO allPassVo, HttpSession session) throws Exception {
		
		if(allPassVo != null) {
			String memTypeCode = allPassVo.getMemTypeCode();

			if (memTypeCode.equals("01")) {
				session.setAttribute("student", allPassVo.getMemTypeCode());
			}
			if (memTypeCode.equals("02")) {
				session.setAttribute("professor", allPassVo.getMemTypeCode());
			}
			if (memTypeCode.equals("03")) {
				session.setAttribute("admin", allPassVo.getMemTypeCode());
			}
			
			session.setAttribute("memberVo", allPassVo);
			logger.info("로그인 세선 적용 성공");
		}else {
			logger.info("로그인 실패");
		}
	}
	
//	아이디 입력받은 후 비밀번호 조회해오기
	@ResponseBody
	@RequestMapping(value = "/searchPwd")
	public MemberVO searchPwd(Model model, @RequestParam Map<String, String> selectedId) throws Exception {

		MemberVO loginVo = loginService.checkPwdMiss(selectedId.get("selectedId"));
		model.addAttribute("loginVo", loginVo);
		
		return loginVo;
	}
	
		
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpSession session) {

		session.invalidate();
		ModelAndView mav = new ModelAndView("redirect:/common/login");

		return mav;
	}

}
