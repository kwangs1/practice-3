package com.spring.community.Board.DAO;

import java.util.List;

import com.spring.community.common.BoardAttachVO;

public interface BoardAttachDAO {

	List<BoardAttachVO> getAttachList(int bno);

	void deleteImg(int bno);

	void board_image(BoardAttachVO vo);

	List<BoardAttachVO> getOldFiles();

}
