package kr.or.ddit.util.auth.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.BaseVO.BaseVO;

public class VolunteerVO extends BaseVO{
	
	// 결재에 쓰려고 name 추가한 vo 
	// 헷갈릴까봐 따로 만듦
	
	private String volNum; //봉사번호
	private String insName; //기관이름
	private String volRecogTime; //봉사인정시간
	private String startDate; //시작일자
	private String endDate; //종료일자
	private String volActContenT; //봉사 활동 내용
	private String volActCode; //봉사 활동 코드
	private String stdId; //학번
	private String name; 
	private String semCode; // 학기 코드
	private String applyDate; // 신청일자
	private String procStatCode; //처리 상태 코드
	private String disauthRsn; //미승인 사유
	private String fileGrNum; //파일 그룹 번호
	private String year; //년도
	private String authDocNum; //결재 문서 번호
	
	private int rnum; //순번
	private List<MultipartFile> fileList;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVolNum() {
		return volNum;
	}
	public void setVolNum(String volNum) {
		this.volNum = volNum;
	}
	public String getInsName() {
		return insName;
	}
	public void setInsName(String insName) {
		this.insName = insName;
	}
	public String getVolRecogTime() {
		return volRecogTime;
	}
	public void setVolRecogTime(String volRecogTime) {
		this.volRecogTime = volRecogTime;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getVolActContenT() {
		return volActContenT;
	}
	public void setVolActContenT(String volActContenT) {
		this.volActContenT = volActContenT;
	}
	public String getVolActCode() {
		return volActCode;
	}
	public void setVolActCode(String volActCode) {
		this.volActCode = volActCode;
	}
	public String getStdId() {
		return stdId;
	}
	public void setStdId(String stdId) {
		this.stdId = stdId;
	}
	public String getSemCode() {
		return semCode;
	}
	public void setSemCode(String semCode) {
		this.semCode = semCode;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getProcStatCode() {
		return procStatCode;
	}
	public void setProcStatCode(String procStatCode) {
		this.procStatCode = procStatCode;
	}
	public String getDisauthRsn() {
		return disauthRsn;
	}
	public void setDisauthRsn(String disauthRsn) {
		this.disauthRsn = disauthRsn;
	}
	public String getFileGrNum() {
		return fileGrNum;
	}
	public void setFileGrNum(String fileGrNum) {
		this.fileGrNum = fileGrNum;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getAuthDocNum() {
		return authDocNum;
	}
	public void setAuthDocNum(String authDocNum) {
		this.authDocNum = authDocNum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public List<MultipartFile> getFileList() {
		return fileList;
	}
	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}
	
	@Override
	public String toString() {
		return "VolunteerVO [volNum=" + volNum + ", insName=" + insName + ", volRecogTime=" + volRecogTime
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", volActContenT=" + volActContenT
				+ ", volActCode=" + volActCode + ", stdId=" + stdId + ", semCode=" + semCode + ", applyDate="
				+ applyDate + ", procStatCode=" + procStatCode + ", disauthRsn=" + disauthRsn + ", fileGrNum="
				+ fileGrNum + ", year=" + year + ", authDocNum=" + authDocNum + ", rnum=" + rnum + ", fileList="
				+ fileList + "]";
	}
	
}
