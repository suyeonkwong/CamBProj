package kr.or.ddit.student.graduate.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.common.main.vo.StdAcadInfoVO;
import kr.or.ddit.student.graduate.vo.ScoreVO;

@Mapper("graduateMapper")
public interface GraduateMapper {
	
	List<ScoreVO> scoreSelect(String stdId);
	
	StdAcadInfoVO volTimeSelect(String stdId);
	
	int stdGraduate(String stdId);
}
