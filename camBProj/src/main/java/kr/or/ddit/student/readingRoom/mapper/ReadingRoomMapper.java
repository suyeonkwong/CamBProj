package kr.or.ddit.student.readingRoom.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.student.readingRoom.vo.ReadingRoomSeatVO;
import kr.or.ddit.student.readingRoom.vo.ReadingRoomVO;
import kr.or.ddit.student.readingRoom.vo.SeatReservationVO;

@Mapper("readingRoomMapper")
public interface ReadingRoomMapper {
	
	//열람실전체 테이블 조회
	List<ReadingRoomVO> selectReadingRoom();
	//열람실 한개의 정보 조회
	ReadingRoomVO selectReadingRoomDetail(String roomIdnNum);
	//열람실별 좌석 조회
	List<ReadingRoomSeatVO> selectReadingRoomSeat(String roomIdnNum);
	//좌석예약
	int seatReservation(SeatReservationVO seatReservationVo);
	//좌석예약시 좌석사용여부 변경
	int seatAvlYn(String seatIdnNum);
	//열람실 별 잔여석 , 사용석 조회
	List<ReadingRoomSeatVO> selectRemainSeat();
	//현재 예약한사람은 두번째 예약 못하게 하기
	SeatReservationVO reservationSelect(Map<String, Object> map);
	//학생개인의 예약 정보
	Map<String, Object> reservationInform(Map<String, Object> map);
	//열람실예약 취소
	int seatReservationCancel(String seatReservNum);
	//좌석취소시 좌석사용여부 변경
	int seatAvlyN(String seatIdnNum);
	//예약시간을 선택하기 위한 예약 정보 조회
	List<SeatReservationVO> selectUseDate(Map<String, Object> map);
	
}
