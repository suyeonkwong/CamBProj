package kr.or.ddit.util.auth.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.util.auth.vo.AuthDetailInfoVO;
import kr.or.ddit.util.auth.vo.AuthDocFormVO;
import kr.or.ddit.util.auth.vo.AuthDocVO;
import kr.or.ddit.util.auth.vo.AuthLineStepVO;
import kr.or.ddit.util.auth.vo.AuthStepVO;
import kr.or.ddit.util.auth.vo.LectureOpenVO;
import kr.or.ddit.util.auth.vo.TakeOffAndStudentVO;
import kr.or.ddit.util.auth.vo.VolunteerVO;

public interface AuthService {
	
	/**
	 *  AuthLine 결재 라인  
	 */
	public List<AuthLineStepVO> authLineList(AuthLineStepVO authLineStepVo);
	
	public int authLineTotalCount(AuthLineStepVO authLineStepVo);
	
	public List<AuthStepVO> authStepSearch(AuthStepVO authStepVo);
	
	public int authStepCount(AuthStepVO authStepVo);
	
	public int authLineStepInsert(AuthLineStepVO authLineStepVo);
	
	public String seachAdvProf(String stdId); 
	
	public AuthLineStepVO insertAdvProfAuthLineVo(String advProf);
	
	public AuthLineStepVO getAdvProfAuthLineVo(String advProf);
	
	public AuthLineStepVO authLineDetail(String authLineNum);
	
	public List<AuthStepVO> authStepList(String authLineNum);
	
	public int authLineUpdate(AuthLineStepVO authLineStepVo);
	
	public int authLineDelete(String authLineNum);
	
	public int authStepDelete(String authLineNum);
	
	/**
	 *  AuthDocForm 결재 문서 양식  
	 */
	public AuthDocFormVO authDocFormDetail(String authDocFormNum);
	

	/**
	 *  AuthDoc 결재 문서
	 */
	public String authDocInsert(String authDocFormNum);
	
	public List<AuthDocVO> authDocList(AuthDocVO authDocVo);
	
	public List<AuthDocVO> authDocListForSteps(AuthDocVO authDocVo);
	
	public int authDocTotalCount(AuthDocVO authDocVo);
	
	public int authDocTotalCountForSteps(AuthDocVO authDocVo);
	
	public AuthDocVO authDocDetail(String authDocNum);

	public AuthDocVO authDocDetailForSteps(AuthDocVO authDocVo);
	
	public int authDocUpdateAndAuthDetailInfoInsert(AuthDocVO authDocVo);
	
	public int authDetailInfoInsert(List<AuthDetailInfoVO> authDetailInfoVoList);
	
	public int authDocUpdateForSteps(AuthDetailInfoVO authDetailInfoVo);
	
	public int authDocComplete(String authDocNum);
	
	public void authDocCompleteByApplyTypes(AuthDetailInfoVO authDetailInfoVo); 
	
	public List<AuthDetailInfoVO> authDetailInfoList(String authDocNum);
	
	public AuthDetailInfoVO authDetailInfoDetail(AuthDetailInfoVO authDetailInfoVo);
	
	public int authDetailInfoMaxSeq(String authDocNum);
	
	public int authDocDelete(String authDocNum);
	
	/**
	 * 결재 기안 / 결재 문서 count 정보
	 */
	public Map<String, Object> authDocInfoCount(String memId);
	
	/**
	 * AuthDoc 결재 문서에 필요한 신청 정보 가져오는 쿼리
	 */

	public Map<String, Object> getApplyDetail(AuthDocVO authDocVo);

}
