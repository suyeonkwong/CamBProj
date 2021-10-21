package kr.or.ddit.common.inquiry.vo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.BaseVO.BaseVO;

public class InquiryVO extends BaseVO {

	private int rnum;
	private String memId;
	private String artcNum;
	private String title;
	private String content;
	private Date writeDate;
	private String answer;
	private Date modDate;
	private String fileGrNum;
	private List<MultipartFile> fileList;
	
	private String name;
	private String replyComment;
	private String replyAnswer;
	
	
	public String getCreateDateDisplay(){
		String createDateDisplay="";
		if(this.writeDate != null) {
			createDateDisplay = new SimpleDateFormat("yyyy-MM-dd").format(this.writeDate);
		}
		return createDateDisplay;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getArtcNum() {
		return artcNum;
	}

	public void setArtcNum(String artcNum) {
		this.artcNum = artcNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public Date getModDate() {
		return modDate;
	}

	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}

	public String getFileGrNum() {
		return fileGrNum;
	}

	public void setFileGrNum(String fileGrNum) {
		this.fileGrNum = fileGrNum;
	}
	
	public List<MultipartFile> getFileList() {
		return fileList;
	}

	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public String getReplyComment() {
		return replyComment;
	}

	public void setReplyComment(String replyComment) {
		this.replyComment = replyComment;
	}

	public String getReplyAnswer() {
		return replyAnswer;
	}

	public void setReplyAnswer(String replyAnswer) {
		this.replyAnswer = replyAnswer;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	@Override
	public String toString() {
		return "InquiryVO [memId=" + memId + ", artcNum=" + artcNum + ", title=" + title + ", content=" + content
				+ ", writeDate=" + writeDate + ", answer=" + answer + ", modDate=" + modDate + ", fileGrNum="
				+ fileGrNum + ", fileList=" + fileList + ", name=" + name + ", replyComment=" + replyComment
				+ ", replyAnswer=" + replyAnswer + "]";
	}	




}
