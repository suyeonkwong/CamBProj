package kr.or.ddit.professor.lecture.vo;

import java.util.List;

public class ConsultVO {
	//CONSULT_SCHEDULE
	private String profId;
	private String profName;
	private String consultAvlDate;
	private String startTime;
	private String endTime;
	private String consultSchdlNum;
	private String cap;
	private String capSeat;
	private String createDate;
	private String modDate;
//	/CONSULT
	private String stdId;
	private String stdName;
	private String fileGrNum;
	private String consultNum;
	private String applyDate;
	private String consultContent;
	private String consultResult;
	private String consultStf;
	private String unstfRsn;
	private String procStatCode;
	private String consultGoalCode;
	private String consultTypeCode;
	private String consultMotiveCode;
	private String consultOx;
	
	// 출결 입력,미입력별 검색을 위한 변수
	private String inputStatus;
	private String memId;
	private String pageNo; //현재 페이지번호
	private String startDate; //검색 시작일자
	private String endDate; //검색 종료일자
	private String rnum; //검색 종료일자
	
	
	private List<ConsultVO> consultVOList;
	private String univDeptNum;
	private String stdUnivDeptNum; //STD_UNIV_DEPT_NUM
	
	private String year;
	
	
	
	
	
	public String getStdUnivDeptNum() {
		return stdUnivDeptNum;
	}

	public void setStdUnivDeptNum(String stdUnivDeptNum) {
		this.stdUnivDeptNum = stdUnivDeptNum;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getProfName() {
		return profName;
	}

	public void setProfName(String profName) {
		this.profName = profName;
	}

	public String getUnivDeptNum() {
		return univDeptNum;
	}

	public void setUnivDeptNum(String univDeptNum) {
		this.univDeptNum = univDeptNum;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}


	public List<ConsultVO> getConsultVOList() {
		return consultVOList;
	}




	public void setConsultVOList(List<ConsultVO> consultVOList) {
		this.consultVOList = consultVOList;
	}




	public String getConsultOx() {
		return consultOx;
	}


	public void setConsultOx(String consultOx) {
		this.consultOx = consultOx;
	}


	public String getStdName() {
		return stdName;
	}


	public void setStdName(String stdName) {
		this.stdName = stdName;
	}


	public String getInputStatus() {
		return inputStatus;
	}
	public void setInputStatus(String inputStatus) {
		this.inputStatus = inputStatus;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPageNo() {
		return pageNo;
	}
	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
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
	public String getProfId() {
		return profId;
	}
	public void setProfId(String profId) {
		this.profId = profId;
	}
	public String getConsultAvlDate() {
		return consultAvlDate;
	}
	public void setConsultAvlDate(String consultAvlDate) {
		this.consultAvlDate = consultAvlDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getConsultSchdlNum() {
		return consultSchdlNum;
	}
	public void setConsultSchdlNum(String consultSchdlNum) {
		this.consultSchdlNum = consultSchdlNum;
	}
	public String getCap() {
		return cap;
	}
	public void setCap(String cap) {
		this.cap = cap;
	}
	public String getCapSeat() {
		return capSeat;
	}
	public void setCapSeat(String capSeat) {
		this.capSeat = capSeat;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	public String getStdId() {
		return stdId;
	}
	public void setStdId(String stdId) {
		this.stdId = stdId;
	}
	public String getFileGrNum() {
		return fileGrNum;
	}
	public void setFileGrNum(String fileGrNum) {
		this.fileGrNum = fileGrNum;
	}
	public String getConsultNum() {
		return consultNum;
	}
	public void setConsultNum(String consultNum) {
		this.consultNum = consultNum;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getConsultContent() {
		return consultContent;
	}
	public void setConsultContent(String consultContent) {
		this.consultContent = consultContent;
	}
	public String getConsultResult() {
		return consultResult;
	}
	public void setConsultResult(String consultResult) {
		this.consultResult = consultResult;
	}
	public String getConsultStf() {
		return consultStf;
	}
	public void setConsultStf(String consultStf) {
		this.consultStf = consultStf;
	}
	public String getUnstfRsn() {
		return unstfRsn;
	}
	public void setUnstfRsn(String unstfRsn) {
		this.unstfRsn = unstfRsn;
	}
	public String getProcStatCode() {
		return procStatCode;
	}
	public void setProcStatCode(String procStatCode) {
		this.procStatCode = procStatCode;
	}
	public String getConsultGoalCode() {
		return consultGoalCode;
	}
	public void setConsultGoalCode(String consultGoalCode) {
		this.consultGoalCode = consultGoalCode;
	}
	public String getConsultTypeCode() {
		return consultTypeCode;
	}
	public void setConsultTypeCode(String consultTypeCode) {
		this.consultTypeCode = consultTypeCode;
	}
	public String getConsultMotiveCode() {
		return consultMotiveCode;
	}
	public void setConsultMotiveCode(String consultMotiveCode) {
		this.consultMotiveCode = consultMotiveCode;
	}

	@Override
	public String toString() {
		return "ConsultVO [profId=" + profId + ", profName=" + profName + ", consultAvlDate=" + consultAvlDate
				+ ", startTime=" + startTime + ", endTime=" + endTime + ", consultSchdlNum=" + consultSchdlNum
				+ ", cap=" + cap + ", capSeat=" + capSeat + ", createDate=" + createDate + ", modDate=" + modDate
				+ ", stdId=" + stdId + ", stdName=" + stdName + ", fileGrNum=" + fileGrNum + ", consultNum="
				+ consultNum + ", applyDate=" + applyDate + ", consultContent=" + consultContent + ", consultResult="
				+ consultResult + ", consultStf=" + consultStf + ", unstfRsn=" + unstfRsn + ", procStatCode="
				+ procStatCode + ", consultGoalCode=" + consultGoalCode + ", consultTypeCode=" + consultTypeCode
				+ ", consultMotiveCode=" + consultMotiveCode + ", consultOx=" + consultOx + ", inputStatus="
				+ inputStatus + ", memId=" + memId + ", pageNo=" + pageNo + ", startDate=" + startDate + ", endDate="
				+ endDate + ", rnum=" + rnum + ", consultVOList=" + consultVOList + ", univDeptNum=" + univDeptNum
				+ ", year=" + year + "]";
	}
	
	
	
	
}
