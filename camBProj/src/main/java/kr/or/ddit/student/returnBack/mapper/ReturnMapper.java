package kr.or.ddit.student.returnBack.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.student.returnBack.vo.ReturnVO;
import kr.or.ddit.student.takeOff.vo.StudentVO;

@Mapper("returnMapper")
public interface ReturnMapper {
	
	List<ReturnVO> returnApplyList(ReturnVO returnVo);
	
	int applyCheck(ReturnVO returnVo);
	
	ReturnVO returnApplyCount(ReturnVO returnVo);
	
	ReturnVO returnApplyDetail(String returnApplyNum);
	
	int returnApplyInsert(ReturnVO returnVo);
	
	int returnApplyUpdate(ReturnVO returnVo);
	
	int returnApplyDelete(String returnApplyNum);
	
	StudentVO getStdInfo(String stdId); 
}
