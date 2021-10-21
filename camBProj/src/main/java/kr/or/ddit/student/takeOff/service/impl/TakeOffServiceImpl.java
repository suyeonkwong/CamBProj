package kr.or.ddit.student.takeOff.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.student.takeOff.mapper.TakeOffMapper;
import kr.or.ddit.student.takeOff.service.TakeOffService;
import kr.or.ddit.student.takeOff.vo.StudentVO;
import kr.or.ddit.student.takeOff.vo.TakeOffVO;

@Service
public class TakeOffServiceImpl implements TakeOffService{

	@Autowired
	TakeOffMapper takeOffMapper;
	
	@Override
	public List<TakeOffVO> takeOffApplyList (TakeOffVO takeOffVo) {
		 List<TakeOffVO> list = takeOffMapper.takeOffApplyList(takeOffVo);
		 List<TakeOffVO> resultList = new ArrayList<>();
		for(TakeOffVO vo : list) {
			vo = getEndYearSem(vo);
			resultList.add(vo);
		}
		
		return resultList;
	}
	
	/**
	 * 이미 신청 진행 중인 (접수 상태) 신청 내역이 있는지 확인
	 * @return 접수 가능하면 True, 불가능하면 False
	 */
	@Override
	public String applyCheck(TakeOffVO takeOffVo) {
		int rowCnt = takeOffMapper.applyCheck(takeOffVo);
		if(rowCnt > 0) {
			return "False";
		}
		return "True";
	}
	
	
	/**
	 * TakeOffVO를 받아 휴학 학기 수로 휴학 종료 예정 학기를 계산하기 ("2021-1학기" 형식)
	 */
	@Override
	public TakeOffVO getEndYearSem(TakeOffVO takeOffVo) {
		int semCnt = takeOffVo.getSemCnt();
		String sem = takeOffVo.getSemCode();
		int year = Integer.parseInt(takeOffVo.getYear());
		for(int i=0; i<semCnt; i++) {
			if(sem == "1학기") {
				sem = "2학기";
			}else {
				year += 1;
				sem = "1학기";
			}
		}
		String endYearSem = year + "-" +sem;
		takeOffVo.setEndYearSem(endYearSem);
		return takeOffVo;
	}
	
	/**
	 * 3개 값을 받아 휴학 학기 수로 휴학 종료 예정 학기를 계산하기
	 * @param year : 기준 년도
	 * @param sem : 기준 학기
	 * @param semCnt : 휴학 학기 수
	 * @return 휴학 종료 예정 학기 ("2021-1학기" 형식)
	 */
	@Override
	public String getEndYearSem(int year, String sem, int semCnt) {
		for(int i=0; i<semCnt; i++) {
			if(sem == "1학기") {
				sem = "2학기";
			}else {
				year += 1;
				sem = "1학기";
			}
		}
		String endYearSem = year + "-" +sem;
		return endYearSem;
	}

	@Override
	public TakeOffVO takeOffApplyCount(TakeOffVO takeOffVo) {
		return takeOffMapper.takeOffApplyCount(takeOffVo);
	}

	@Override
	public TakeOffVO takeOffApplyDetail(String takeOffApplyNum) {
		return takeOffMapper.takeOffApplyDetail(takeOffApplyNum);
	}

	@Override
	public int takeOffApply(TakeOffVO takeOffVo) {
		int affectedRows = takeOffMapper.takeOffApply(takeOffVo);
		if(affectedRows > 0) {
			return 1; // 성공 시 
		}else {
			return 0; // 실패 시
		}
	}

	@Override
	public int takeOffApplyUpdate(TakeOffVO takeOffVo) {
		int affectedRows = takeOffMapper.takeOffApplyUpdate(takeOffVo);
		if(affectedRows > 0) {
			return 1; // 성공 시 
		}else {
			return 0; // 실패 시
		}
	}
	
	
	// 삭제 시에는 결재 기안에 올라간 것도 삭제해야 함
	@Override
	public int takeOffApplyDelete(String takeOffApplyNum) {
		int affectedRows = takeOffMapper.takeOffApplyDelete(takeOffApplyNum);
		if(affectedRows > 0) {
			return 1; // 성공 시 
		}else {
			return 0; // 실패 시
		}
	}
	
	/**
	 * 신청 폼에 보낼 학생 정보 가져오기
	 */
	@Override
	public StudentVO getStdInfo(String stdId) {
		return takeOffMapper.getStdInfo(stdId);
	}
	
	
	
	/**
	 * 신청 폼에 보낼 학생 정보 중 휴학 가능한 학기 기간 가져오기
	 * 휴학 신청 가능한 6개 학기에서 '일반휴학'과 '창업휴학'학한 '일반휴학'과 '창업휴학'학기 수를 뺀다. 
	 */
	@Override
	public int getAvailableSemCnt(String stdId) {
		return 6 - takeOffMapper.getUsedSemCnt(stdId);
	}
	

	
}
