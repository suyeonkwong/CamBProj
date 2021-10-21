package kr.or.ddit.professor.lecture.vo;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class LectureOpenVO {
	private String profId;			//교번
	private String subjNum;         //과목 번호 // 학수번호
	private String lectOpenNum;     //강의 개설 번호
	private String lectName;        //강의 이름
	private String semCode;         //학기 코드
	private String cred;            //학점
	private String roomIdnNum;      //강의실 식별 번호
	private String sylNum;          //강의 계획서 번호
	private String subjTypeCode;    //교과 구분 코드
	private String subjTypeName;    //교과 구분 코드
	private String year;            //년도
	private String univDeptNum;     //학과 번호
	private String univDeptName;     //학과 이름 [FN_GET_CODE_NAME('UNI_DEP',UNIV_DEPT_NUM) UNIV_DEPT_NUM]
	private String divideNum;       //분반 번호
	private int maxStdCnt;          //최대 수강 인원
	private int stdCnt;             //수강 인원
	private int evalCnt;             //각 수업별 강의평가 남긴 인원 체크
	private String closeYn;         //폐강 여부
	private String openYn;          //개설 여부
	private String applyDate;         //신청 일자
	private String procStatCode;    //처리 상태 코드
	private String disauthRsn;      //미승인 사유 disauthRsn     disaurhRsn
	private String authDocNum;      //결재 문서 번호
	private String roomNum;		//LECTURE_OPEN테이블  ROOM_IDN_NUM 컬럼 조인으로 얻어온 강의실 번호(BUILD_CODE+ROOM_NUM)
	private String buildName;
	private String roomName;
	private String buildCode;
	
	private String lectTime; 	//lectTime1, lectTime2 Concat한것
	private String lectTime1;
	private String lectTime2;
	
	private String profNm;	//교수 테이블에서 profId 통해 join 해서 가져옴
		
	private String pageNo; //현재 페이지번호
	private String selectYear; //년도 검색조건
	private String selectSemester; //학기 검색조건
	private String searchKeyword; //검색어 검색조건
	
	private String memId;	//Id세션 받기위한 변수
	
	//--------강의 시간 테이블----------//
//	private String lectOpenNum;
	private String dayCode1;
	private String dayCode2;
	private String period1;		//강의시간 1~6번
	private String period2;
	private String period3;
	private String period4;
	private String period5;
	private String period6;
	
	//xml의 foreach collection에 들어갈 변수
	private String dayCode;
	private String period;
	
	
	// 출결 입력여부를 위한 카운트
	private String attendCount;
	// 출결 입력,미입력별 검색을 위한 변수
	private String inputStatus;
	private String checkSemester;
	
	
	// 성적 입력이 되었나 안되었나 체크할 변수
	private String sumTotalScore;
	
	// 성적관리 VO
	private String stdId;
	private String stdName;
	private String midSc;
	private String finalSc;
	private String attendSc;
	private String assignSc;
	private String quizSc;
	private String debateSc;
	private String otherSc;
	private String rating;
	private String totalScore;
	private String score;
	
	
	//강의계획서 VO
	private int midReflectPer;             //중간고사 반영 비율
	private int finalReflectPer;           //기말고사 반영 비율
	private int attendReflectPer;          //출석 반영 비율
	private int assignRelectPer;           //과제 반영 비율
	private int quizReflectPer;            //퀴즈 반영 비율
	private int debateReflectPer;          //토론 반영 비율
	private int otherReflectPer;           //기타 반영 비율
	
	private List<LectureOpenVO> lectureOpenVOList;
	private String rnum;
	
	
	
	
	
	public String getBuildName() {
		return buildName;
	}
	public void setBuildName(String buildName) {
		this.buildName = buildName;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getBuildCode() {
		return buildCode;
	}
	public void setBuildCode(String buildCode) {
		this.buildCode = buildCode;
	}
	public String getSubjTypeName() {
		return subjTypeName;
	}
	public void setSubjTypeName(String subjTypeName) {
		this.subjTypeName = subjTypeName;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public List<LectureOpenVO> getLectureOpenVOList() {
		return lectureOpenVOList;
	}
	public void setLectureOpenVOList(List<LectureOpenVO> lectureOpenVOList) {
		this.lectureOpenVOList = lectureOpenVOList;
	}
	public int getMidReflectPer() {
		return midReflectPer;
	}
	public void setMidReflectPer(int midReflectPer) {
		this.midReflectPer = midReflectPer;
	}
	public int getFinalReflectPer() {
		return finalReflectPer;
	}
	public void setFinalReflectPer(int finalReflectPer) {
		this.finalReflectPer = finalReflectPer;
	}
	public int getAttendReflectPer() {
		return attendReflectPer;
	}
	public void setAttendReflectPer(int attendReflectPer) {
		this.attendReflectPer = attendReflectPer;
	}
	public int getAssignRelectPer() {
		return assignRelectPer;
	}
	public void setAssignRelectPer(int assignRelectPer) {
		this.assignRelectPer = assignRelectPer;
	}
	public int getQuizReflectPer() {
		return quizReflectPer;
	}
	public void setQuizReflectPer(int quizReflectPer) {
		this.quizReflectPer = quizReflectPer;
	}
	public int getDebateReflectPer() {
		return debateReflectPer;
	}
	public void setDebateReflectPer(int debateReflectPer) {
		this.debateReflectPer = debateReflectPer;
	}
	public int getOtherReflectPer() {
		return otherReflectPer;
	}
	public void setOtherReflectPer(int otherReflectPer) {
		this.otherReflectPer = otherReflectPer;
	}
	public String getStdName() {
		return stdName;
	}
	public void setStdName(String stdName) {
		this.stdName = stdName;
	}
	public String getCheckSemester() {
		return checkSemester;
	}
	public void setCheckSemester(String checkSemester) {
		this.checkSemester = checkSemester;
	}
	public String getStdId() {
		return stdId;
	}
	public void setStdId(String stdId) {
		this.stdId = stdId;
	}
	public String getMidSc() {
		return midSc;
	}
	public void setMidSc(String midSc) {
		this.midSc = midSc;
	}
	public String getFinalSc() {
		return finalSc;
	}
	public void setFinalSc(String finalSc) {
		this.finalSc = finalSc;
	}
	public String getAttendSc() {
		return attendSc;
	}
	public void setAttendSc(String attendSc) {
		this.attendSc = attendSc;
	}
	public String getAssignSc() {
		return assignSc;
	}
	public void setAssignSc(String assignSc) {
		this.assignSc = assignSc;
	}
	public String getQuizSc() {
		return quizSc;
	}
	public void setQuizSc(String quizSc) {
		this.quizSc = quizSc;
	}
	public String getDebateSc() {
		return debateSc;
	}
	public void setDebateSc(String debateSc) {
		this.debateSc = debateSc;
	}
	public String getOtherSc() {
		return otherSc;
	}
	public void setOtherSc(String otherSc) {
		this.otherSc = otherSc;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getSumTotalScore() {
		return sumTotalScore;
	}
	public void setSumTotalScore(String sumTotalScore) {
		this.sumTotalScore = sumTotalScore;
	}
	public String getInputStatus() {
		return inputStatus;
	}
	public void setInputStatus(String inputStatus) {
		this.inputStatus = inputStatus;
	}
	public String getAttendCount() {
		return attendCount;
	}
	public void setAttendCount(String attendCount) {
		this.attendCount = attendCount;
	}
	public int getEvalCnt() {
		return evalCnt;
	}
	public void setEvalCnt(int evalCnt) {
		this.evalCnt = evalCnt;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getSelectYear() {
		return selectYear;
	}
	public void setSelectYear(String selectYear) {
		this.selectYear = selectYear;
	}
	public String getSelectSemester() {
		return selectSemester;
	}
	public void setSelectSemester(String selectSemester) {
		this.selectSemester = selectSemester;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getDayCode() {
		return dayCode;
	}
	public void setDayCode(String dayCode) {
		this.dayCode = dayCode;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getDayCode1() {
		return dayCode1;
	}
	public void setDayCode1(String dayCode1) {
		this.dayCode1 = dayCode1;
	}
	public String getDayCode2() {
		return dayCode2;
	}
	public void setDayCode2(String dayCode2) {
		this.dayCode2 = dayCode2;
	}
	public String getPeriod1() {
		return period1;
	}
	public void setPeriod1(String period1) {
		this.period1 = period1;
	}
	public String getPeriod2() {
		return period2;
	}
	public void setPeriod2(String period2) {
		this.period2 = period2;
	}
	public String getPeriod3() {
		return period3;
	}
	public void setPeriod3(String period3) {
		this.period3 = period3;
	}
	public String getPeriod4() {
		return period4;
	}
	public void setPeriod4(String period4) {
		this.period4 = period4;
	}
	public String getPeriod5() {
		return period5;
	}
	public void setPeriod5(String period5) {
		this.period5 = period5;
	}
	public String getPeriod6() {
		return period6;
	}
	public void setPeriod6(String period6) {
		this.period6 = period6;
	}
	public String getPageNo() {
		return pageNo;
	}
	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}
	public String getUnivDeptName() {
		return univDeptName;
	}
	public void setUnivDeptName(String univDeptName) {
		this.univDeptName = univDeptName;
	}
	public String getProfNm() {
		return profNm;
	}
	public void setProfNm(String profNm) {
		this.profNm = profNm;
	}
	public String getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}
	public String getLectTime() {
		return lectTime;
	}
	public void setLectTime(String lectTime) {
//		String[] lectTimeAry = lectTime.split(", ");
//		for (int i = 0; i < lectTimeAry.length; i++) {
//				System.out.println("lectTime : " + lectTimeAry[i].substring(0,1)); 
//				
//			}
//		System.out.println("lectTimez : "+ lectTime);
//		System.out.println("lectTimezzzzzzzzzzzzzz" );
			
		this.lectTime = lectTime;
	}
	public String getLectTime1() {
		return lectTime1;
	}
	public void setLectTime1(String lectTime1) {
		this.lectTime1 = lectTime1;
	}
	public String getLectTime2() {
		return lectTime2;
	}
	public void setLectTime2(String lectTime2) {
		this.lectTime2 = lectTime2;
	}
	public String getProfId() {
		return profId;
	}
	public void setProfId(String profId) {
		this.profId = profId;
	}
	public String getSubjNum() {
		return subjNum;
	}
	public void setSubjNum(String subjNum) {
		this.subjNum = subjNum;
	}
	public String getLectOpenNum() {
		return lectOpenNum;
	}
	public void setLectOpenNum(String lectOpenNum) {
		this.lectOpenNum = lectOpenNum;
	}
	public String getLectName() {
		return lectName;
	}
	public void setLectName(String lectName) {
		this.lectName = lectName;
	}
	public String getSemCode() {
		return semCode;
	}
	public void setSemCode(String semCode) {
		this.semCode = semCode;
	}
	public String getCred() {
		return cred;
	}
	public void setCred(String cred) {
		this.cred = cred;
	}
	public String getRoomIdnNum() {
		return roomIdnNum;
	}
	public void setRoomIdnNum(String roomIdnNum) {
		this.roomIdnNum = roomIdnNum;
	}
	public String getSylNum() {
		return sylNum;
	}
	public void setSylNum(String sylNum) {
		this.sylNum = sylNum;
	}
	public String getSubjTypeCode() {
		return subjTypeCode;
	}
	public void setSubjTypeCode(String subjTypeCode) {
		this.subjTypeCode = subjTypeCode;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getUnivDeptNum() {
		return univDeptNum;
	}
	public void setUnivDeptNum(String univDeptNum) {
		this.univDeptNum = univDeptNum;
	}
	public String getDivideNum() {
		return divideNum;
	}
	public void setDivideNum(String divideNum) {
		this.divideNum = divideNum;
	}
	public int getMaxStdCnt() {
		return maxStdCnt;
	}
	public void setMaxStdCnt(int maxStdCnt) {
		this.maxStdCnt = maxStdCnt;
	}
	public int getStdCnt() {
		return stdCnt;
	}
	public void setStdCnt(int stdCnt) {
		this.stdCnt = stdCnt;
	}
	public String getCloseYn() {
		return closeYn;
	}
	public void setCloseYn(String closeYn) {
		this.closeYn = closeYn;
	}
	public String getOpenYn() {
		return openYn;
	}
	public void setOpenYn(String openYn) {
		this.openYn = openYn;
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
	public String getAuthDocNum() {
		return authDocNum;
	}
	public void setAuthDocNum(String authDocNum) {
		this.authDocNum = authDocNum;
	}
	@Override
	public String toString() {
		return "LectureOpenVO [profId=" + profId + ", subjNum=" + subjNum + ", lectOpenNum=" + lectOpenNum
				+ ", lectName=" + lectName + ", semCode=" + semCode + ", cred=" + cred + ", roomIdnNum=" + roomIdnNum
				+ ", sylNum=" + sylNum + ", subjTypeCode=" + subjTypeCode + ", year=" + year + ", univDeptNum="
				+ univDeptNum + ", univDeptName=" + univDeptName + ", divideNum=" + divideNum + ", maxStdCnt="
				+ maxStdCnt + ", stdCnt=" + stdCnt + ", evalCnt=" + evalCnt + ", closeYn=" + closeYn + ", openYn="
				+ openYn + ", applyDate=" + applyDate + ", procStatCode=" + procStatCode + ", disauthRsn=" + disauthRsn
				+ ", authDocNum=" + authDocNum + ", roomNum=" + roomNum + ", lectTime=" + lectTime + ", lectTime1="
				+ lectTime1 + ", lectTime2=" + lectTime2 + ", profNm=" + profNm + ", pageNo=" + pageNo + ", selectYear="
				+ selectYear + ", selectSemester=" + selectSemester + ", searchKeyword=" + searchKeyword + ", memId="
				+ memId + ", dayCode1=" + dayCode1 + ", dayCode2=" + dayCode2 + ", period1=" + period1 + ", period2="
				+ period2 + ", period3=" + period3 + ", period4=" + period4 + ", period5=" + period5 + ", period6="
				+ period6 + ", dayCode=" + dayCode + ", period=" + period + ", attendCount=" + attendCount
				+ ", inputStatus=" + inputStatus + ", checkSemester=" + checkSemester + ", sumTotalScore="
				+ sumTotalScore + ", stdId=" + stdId + ", stdName=" + stdName + ", midSc=" + midSc + ", finalSc="
				+ finalSc + ", attendSc=" + attendSc + ", assignSc=" + assignSc + ", quizSc=" + quizSc + ", debateSc="
				+ debateSc + ", otherSc=" + otherSc + ", rating=" + rating + ", totalScore=" + totalScore + ", score="
				+ score + ", midReflectPer=" + midReflectPer + ", finalReflectPer=" + finalReflectPer
				+ ", attendReflectPer=" + attendReflectPer + ", assignRelectPer=" + assignRelectPer
				+ ", quizReflectPer=" + quizReflectPer + ", debateReflectPer=" + debateReflectPer + ", otherReflectPer="
				+ otherReflectPer + ", lectureOpenVOList=" + lectureOpenVOList + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	


	
	
	
	
	
}
