package kr.or.ddit.student.readingRoom.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.student.readingRoom.service.ReadingRoomService;
import kr.or.ddit.student.readingRoom.vo.ReadingRoomSeatVO;
import kr.or.ddit.student.readingRoom.vo.ReadingRoomVO;
import kr.or.ddit.student.readingRoom.vo.SeatReservationVO;

@Controller
@RequestMapping(value="/student/readingRoom/*")
public class ReadingRoomController {
	
	Logger logger = LoggerFactory.getLogger(ReadingRoomController.class);
	
	@Autowired
	private ReadingRoomService readingRoomService;
	
	//열람실 정보 조회
	@RequestMapping(value="/readingRoomLookup")
	public String readingRoomLookup(Model model) {
		
		List<ReadingRoomVO> roomVo = this.readingRoomService.selectReadingRoom();
		logger.info("roomVo >>> " + roomVo);
		
		model.addAttribute("roomVo", roomVo);
		
		//열람실 별 잔여석 , 사용석 조회
		List<ReadingRoomSeatVO> roomSeatCntVo = this.readingRoomService.selectRemainSeat();
		logger.info("roomSeatCntVo >>> " + roomSeatCntVo);
		model.addAttribute("roomSeatCntVo", roomSeatCntVo);
		
		return "student/readingRoom/readingRoomLookUp";
	}
	
	//열람실별 좌석 페이지로 이동하기
	@RequestMapping(value="/readingRoomDetailLookUp")
	public String readingRoomOne(@RequestParam String roomIdnNum
								, Model model){
		
		logger.info("roomIdnNum : " + roomIdnNum);
		
		if(roomIdnNum.equals("1")) {
			//한개의 열람실 정보
			ReadingRoomVO roomVo = this.readingRoomService.selectReadingRoomDetail(roomIdnNum);
			logger.info("roomVo >>> " + roomVo);
			model.addAttribute("roomVo", roomVo);
			
			//열람실 좌석 정보
			List<ReadingRoomSeatVO> seatVo = this.readingRoomService.selectReadingRoomSeat(roomIdnNum);
			logger.info("seatVo >>> " + seatVo);
			model.addAttribute("seatVo", seatVo);
			
			return "student/readingRoom/readingRoomOne";
		}else if(roomIdnNum.equals("2")){
			//한개의 열람실 정보
			ReadingRoomVO roomVo = this.readingRoomService.selectReadingRoomDetail(roomIdnNum);
			logger.info("roomVo >>> " + roomVo);
			model.addAttribute("roomVo", roomVo);
			
			//열람실 좌석 정보
			List<ReadingRoomSeatVO> seatVo = this.readingRoomService.selectReadingRoomSeat(roomIdnNum);
			logger.info("seatVo >>> " + seatVo);
			model.addAttribute("seatVo", seatVo);
			return "student/readingRoom/readingRoomNormalUniversity";
		}else {
			return null;
		}
	}
	
	//좌석 예약
	@RequestMapping(value="/seatReservation")
	public String seatReservation(@ModelAttribute SeatReservationVO seatReservationVo) {
		
		logger.info("seatReservationVo >>> " + seatReservationVo);
		
		int result = this.readingRoomService.seatReservation(seatReservationVo);
		
		//좌석 예약되면 좌석이용여부 컬럼 N으로 변경하기
		if(result > 0) {	
			String seatIdnNum = seatReservationVo.getSeatIdnNum();
			this.readingRoomService.seatAvlYn(seatIdnNum);
		}
		
		return "redirect:/student/readingRoom/readingRoomLookup";
	}
	
	//현재 예약한사람은 두번째 예약 못하게 하기
	@RequestMapping(value="/ReservationSelect")
	@ResponseBody
	public SeatReservationVO ReservationSelect(@RequestBody Map<String, Object> map) {
	
		logger.info("예약정보 map >>> " + map);
		SeatReservationVO reservation = this.readingRoomService.reservationSelect(map);
		return reservation;
	}
	
	//학생개인의 예약 정보
	@RequestMapping(value="/ReservationInform")
	@ResponseBody
	public Map<String, Object> ReservationInform(@RequestBody Map<String, Object> map) {
		
		logger.info("예약정보  map >>> " + map);
		Map<String, Object> Map = this.readingRoomService.reservationInform(map);
		return Map;
	}
	
	//좌석 예약 취소
	@RequestMapping(value="/reservationCancel")
	public String seatReservationCancel(@RequestParam String seatReservNum,
										@RequestParam String seatIdnNum) {
		
		logger.info("seatReservNum >>> " + seatReservNum);
		logger.info("seatIdnNum >>> " + seatIdnNum);
		
		int result = this.readingRoomService.seatReservationCancel(seatReservNum);
		
		if(result > 0) {
			this.readingRoomService.seatAvlyN(seatIdnNum);
		}
		
		return "redirect:/student/readingRoom/readingRoomLookup";
	}
	

	
}
