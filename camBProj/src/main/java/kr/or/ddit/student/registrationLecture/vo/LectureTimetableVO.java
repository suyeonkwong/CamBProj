package kr.or.ddit.student.registrationLecture.vo;

import kr.or.ddit.util.BaseVO.BaseVO;

public class LectureTimetableVO extends BaseVO{
	
	private String lectOpenNum;     //강의 개설 번호
	private String[] lectOpenNumList; // 다중 검색을 위한 list
	private String lectName;	    //강의 이름
	private String dayCode;         //요일 코드
	private String dayCodename;     //요일 코드 이름
	private String period;          //교시
	
	private String name; // 담당 교수
	private String roomIdnName; // 강의실 이름

	public String getLectOpenNum() {
		return lectOpenNum;
	}
	public void setLectOpenNum(String lectOpenNum) {
		this.lectOpenNum = lectOpenNum;
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
	public String getDayCodename() {
		return dayCodename;
	}
	public void setDayCodename(String dayCodename) {
		this.dayCodename = dayCodename;
	}
	public String getLectName() {
		return lectName;
	}
	public void setLectName(String lectName) {
		this.lectName = lectName;
	}
	public String[] getLectOpenNumList() {
		return lectOpenNumList;
	}
	public void setLectOpenNumList(String[] lectOpenNumList) {
		this.lectOpenNumList = lectOpenNumList;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoomIdnName() {
		return roomIdnName;
	}
	public void setRoomIdnName(String roomIdnName) {
		this.roomIdnName = roomIdnName;
	}

}
