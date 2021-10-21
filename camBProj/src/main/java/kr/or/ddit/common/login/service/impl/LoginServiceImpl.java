package kr.or.ddit.common.login.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.login.mapper.LoginMapper;
import kr.or.ddit.common.login.service.LoginService;
import kr.or.ddit.common.login.vo.MemberVO;

//주석입니다....

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginMapper loginMapper;

//	정상로그인
	@Override
	public MemberVO login(MemberVO memberVo) throws Exception {

		MemberVO memberVo2 = loginMapper.login(memberVo);
		return memberVo2;
	}
	
//	비밀번호만 오류인건지 확인
	@Override
	public MemberVO checkPwdMiss(String memId) throws Exception {
		MemberVO memberVo = loginMapper.checkPwdMiss(memId);
		return memberVo;
	}	
	
//	비번에러 1 증가
	@Override
	public int plusErrCnt(MemberVO memberVo) throws Exception {
		return loginMapper.plusErrCnt(memberVo);
	}

//	비번에러 0으로 초기화
	@Override
	public int resetErrCnt(MemberVO memberVo) throws Exception {
		return loginMapper.resetErrCnt(memberVo);
	}

//	초기비번컬럼 초기화
	@Override
	public int resetFirstInsert(MemberVO memberVo) throws Exception {
		return loginMapper.resetFirstInsert(memberVo);
	}

//	PWD컬럼 값 입력
	@Override
	public int setPwd(MemberVO memberVo) throws Exception {
		return loginMapper.setPwd(memberVo);
	}

//  오류횟수 숫자세기
	@Override
	public int selectCnt(MemberVO memberVo) throws Exception {
		return loginMapper.selectCnt(memberVo);
	}

}
