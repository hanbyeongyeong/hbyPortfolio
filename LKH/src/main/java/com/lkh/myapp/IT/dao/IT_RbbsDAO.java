package com.lkh.myapp.IT.dao;

import java.util.List;

import com.lkh.myapp.IT.dto.IT_RbbsDTO;

public interface IT_RbbsDAO {

	// 댓글 등록
	int write(IT_RbbsDTO it_rbbsDTO) throws Exception;

	// 댓글 목록
	List<IT_RbbsDTO> list(String num) throws Exception;

	List<IT_RbbsDTO> list(String num, int startRec, int endRec) throws Exception;

	// 댓글 수정
	int modify(IT_RbbsDTO it_rbbsDTO) throws Exception;

	// 댓글 삭제
	int delete(String rnum) throws Exception;

	// 대댓글 등록
	int reply(IT_RbbsDTO it_rbbsDTO) throws Exception;

	// 댓글 통계
	int replyTotalRec(String num) throws Exception;

}
