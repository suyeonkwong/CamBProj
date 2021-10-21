package kr.or.ddit.student.dorm.service.serviceImpl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.student.dorm.controller.DormController;
import kr.or.ddit.student.dorm.mapper.DormMapper;
import kr.or.ddit.student.dorm.service.DormService;
import kr.or.ddit.student.dorm.vo.DormRoomVO;
import kr.or.ddit.student.dorm.vo.DormVO;
import kr.or.ddit.student.dorm.vo.SleepOutVO;

@Service
public class DormServiceImpl implements DormService{
	
	Logger logger = LoggerFactory.getLogger(DormController.class);
	
	@Autowired
	private DormMapper dormMapper;
	
	//생활관room 고를때 방 정보 select
	@Override
	public List<DormRoomVO>  selectDormRoom(String buildCode) {
		return this.dormMapper.selectDormRoom(buildCode);
	}
	//건물코드만 가져오기
	@Override
	public List<DormRoomVO> selectBuildCode(){
		return this.dormMapper.selectBuildCode();
	}
	//기숙사 신청하기
	@Override
	public int DromApply(DormVO dormVO) {
		return this.dormMapper.DromApply(dormVO);
	}
	//재신청 방지
	@Override
	public int reapplyPrevention(Map<String, Object> map) {
		return this.dormMapper.reapplyPrevention(map);
	}
	//합격자 조회
	@Override
	public DormVO selectAcptYn(Map<String, Object> map) {
		return this.dormMapper.selectAcptYn(map);
	}
	//생활관 사생인지 아닌지 조회
	@Override
	public DormVO SelectBoarderYN(Map<String, Object> map) {
		return this.dormMapper.SelectBoarderYN(map);
	}
	//외박신청
	@Override
	public int sleepOutApply(SleepOutVO sleepOutVO) {
		return this.dormMapper.sleepOutApply(sleepOutVO);
	}
	//외박신청 리스트
	@Override
	public	List<SleepOutVO> selectSleepOutApplyList(Map<String, Object> map){
		return this.dormMapper.selectSleepOutApplyList(map);
	}
	//외박상세내역
	@Override
	public SleepOutVO selectSleepOutDetailList(Map<String, Object> map) {
		return this.dormMapper.selectSleepOutDetailList(map);
	}
	//외박신청취소
	@Override
	public int sleepOutCancel(Map<String, Object> map) {
		return this.dormMapper.sleepOutCancel(map);
	}
	//외박신청내역 수정
	@Override
	public int sleepOutUpdate(SleepOutVO sleepOutVo) {
		return this.dormMapper.sleepOutUpdate(sleepOutVo);
	}
	//외박신청여부(하루에 한번만 신청 가능)
//	@Override
//	public int selectSleepOutApplyYN(Map<String, Object> map) {
//		return this.dormMapper.selectSleepOutApplyYN(map);
//	}
}
