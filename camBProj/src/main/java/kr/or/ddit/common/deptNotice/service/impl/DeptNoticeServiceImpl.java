package kr.or.ddit.common.deptNotice.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.deptNotice.mapper.DeptNoticeMapper;
import kr.or.ddit.common.deptNotice.service.DeptNoticeService;
import kr.or.ddit.common.deptNotice.vo.DeptNoticeVO;
@Service
public class DeptNoticeServiceImpl implements DeptNoticeService {
	
	@Autowired
	private DeptNoticeMapper deptNoticeMapper; 
	
	@Override
	public List<DeptNoticeVO> deptNoticeList(Map<String, Object> map) {
		return this.deptNoticeMapper.deptNoticeList(map);
	}
	@Override
	public int selectCount(Map<String, Object> map) {
		return this.deptNoticeMapper.selectCount(map);
	}
	@Override
	public int deptNoticeInsert(DeptNoticeVO deptNoticeVo) {
		return this.deptNoticeMapper.deptNoticeInsert(deptNoticeVo);
	}
	@Override
	public DeptNoticeVO deptNoticeDetail(String artcNum) {
		return this.deptNoticeMapper.deptNoticeDetail(artcNum);
	}
	@Override
	public int deptNoticeDelete(String artcNum) {
		return this.deptNoticeMapper.deptNoticeDelete(artcNum);
	}
	@Override
	public int deptNoticeUpdate(DeptNoticeVO deptNoticeVo) {
		return this.deptNoticeMapper.deptNoticeUpdate(deptNoticeVo);
	}

}
