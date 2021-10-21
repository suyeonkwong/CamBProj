package kr.or.ddit.common.inquiry.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.inquiry.mapper.InquiryMapper;
import kr.or.ddit.common.inquiry.service.InquiryService;
import kr.or.ddit.common.inquiry.vo.InquiryVO;
import kr.or.ddit.common.inquiry.vo.ReplyVO;

@Service
public class InquiryServiceImpl implements InquiryService {
	@Autowired
	private InquiryMapper inquiryMapper;

	@Override
	public List<InquiryVO> inquiryList(InquiryVO iqVo) throws Exception {
		return this.inquiryMapper.inquiryList(iqVo);
	}

	@Override
	public int inquiryInsert(InquiryVO iqVo) {
		return this.inquiryMapper.inquiryInsert(iqVo);
	}

	@Override
	public int totalMember(InquiryVO iqVo) throws Exception {
		return this.inquiryMapper.totalMember(iqVo);
	}

	@Override
	public InquiryVO inquDetail(String artcNum) {
		return this.inquiryMapper.inquDetail(artcNum);
	}

	@Override
	public int inquiryDelete(String artcNum) {
		return this.inquiryMapper.inquiryDelete(artcNum);
	}

	@Override
	public int inquiryUpdate(InquiryVO inquiryVo) {
		return this.inquiryMapper.inquiryUpdate(inquiryVo);
	}

	@Override
	public List<ReplyVO> replyList(Map<String, Object> map) {
		return this.inquiryMapper.replyList(map);
	}

	@Override
	public int replyInsert(Map<String, Object> map) throws Exception{
		return this.inquiryMapper.replyInsert(map);
	}

	@Override
	public int replyDelete(Map<String, Object> map) {
		return this.inquiryMapper.replyDelete(map);
	}


}
