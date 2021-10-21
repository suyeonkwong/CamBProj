package kr.or.ddit.common.deptNotice.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class DeptNoticeVO {
	
	private String empId;
	private int rnum;
	private String artcNum;
	private String title;
	private String content;
	private Date writeDate;
	private String fileGrNum;
	private String uniDepCode;
	private Date modDate;
	private List<MultipartFile> fileList;
	private String name;
	
	public String getEmpId() {
		return empId;

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
	public String getFileGrNum() {
		return fileGrNum;
	}
	public void setFileGrNum(String fileGrNum) {
		this.fileGrNum = fileGrNum;
	}
	public String getUniDepCode() {
		return uniDepCode;
	}
	public void setUniDepCode(String uniDepCode) {
		this.uniDepCode = uniDepCode;
	}
	public Date getModDate() {
		return modDate;
	}
	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
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
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	@Override
	public String toString() {
		return "DeptNoticeVO [empId=" + empId + ", artcNum=" + artcNum + ", title=" + title + ", content=" + content
				+ ", writeDate=" + writeDate + ", fileGrNum=" + fileGrNum + ", uniDepCode=" + uniDepCode + ", modDate="
				+ modDate + ", fileList=" + fileList + ", name=" + name + "]";
	}
	
	

}
