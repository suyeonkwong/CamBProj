package kr.or.ddit.common.inquiry.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.inquiry.vo.InquiryVO;
import kr.or.ddit.common.inquiry.vo.ReplyVO;
public interface InquiryService {

	List<InquiryVO> inquiryList(InquiryVO iqVo) throws Exception;

	int inquiryInsert(InquiryVO iqVo);
	
	int totalMember(InquiryVO iqVo)throws Exception;

	InquiryVO inquDetail(String artcNum);

	int inquiryDelete(String artcNum);

	int inquiryUpdate(InquiryVO inquiryVo);
	//댓글 리스트
	List<ReplyVO> replyList(Map<String, Object> map);
	//댓글 등록
	int replyInsert(Map<String, Object> map) throws Exception;

	int replyDelete(Map<String, Object> map);

}
