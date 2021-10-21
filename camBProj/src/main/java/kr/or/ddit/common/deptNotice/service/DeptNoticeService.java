package kr.or.ddit.common.deptNotice.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.deptNotice.vo.DeptNoticeVO;

public interface DeptNoticeService {

	List<DeptNoticeVO> deptNoticeList(Map<String, Object> map);

	int selectCount(Map<String, Object> map);

	int deptNoticeInsert(DeptNoticeVO deptNoticeVo);

	DeptNoticeVO deptNoticeDetail(String artcNum);

	int deptNoticeDelete(String artcNum);

	int deptNoticeUpdate(DeptNoticeVO deptNoticeVo);

}
