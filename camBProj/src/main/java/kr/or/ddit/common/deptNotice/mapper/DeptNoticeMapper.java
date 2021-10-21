package kr.or.ddit.common.deptNotice.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.common.deptNotice.vo.DeptNoticeVO;

@Mapper("deptNoticeMapper")
public interface DeptNoticeMapper {
		//전체리스트
		List<DeptNoticeVO> deptNoticeList(Map<String, Object> map);
		//등록
		int deptNoticeInsert(DeptNoticeVO deptNoticeVo);
		//상세
		DeptNoticeVO deptNoticeDetail(String artcNum);
		//삭제
		int deptNoticeDelete (String artcNum);
		//페이지 갯수
		int selectCount(Map<String, Object> map);
		
		int deptNoticeUpdate(DeptNoticeVO deptNoticeVo);
}

