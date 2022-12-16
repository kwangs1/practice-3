package com.spring.community.Board.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.community.Board.DAO.BoardAttachDAO;
import com.spring.community.common.BoardAttachVO;

@Component
public class FileCheckTask {
	@Autowired
	private BoardAttachDAO boardAttach;
	
	private static Logger log = Logger.getLogger(FileCheckTask.class.getName());
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 3 * * *")
	public void checkFiles() throws Exception {

		log.info("File Check Task run.................");
		log.info("date():"+new Date());
		// 우선 DB에 저장된 이미지 파일 리스트를 조회할 객체 선언
		List<BoardAttachVO> fileList = boardAttach.getOldFiles();

		// 폴더에 저장된 이미지 파일 리스트, 
		List<Path> fileListPaths = fileList.stream()
				//.map을 통해 vo변수에 파일 경로 저장
				//.collect 요소들의 가공이 끝났다면 리턴해줄 결과를 collect를 통해 만들어준다.
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		
		//DB에 저장된 이미지 파일리스트를 확인합니다
		//filter를 통해 isFileType == true면 걸러내는 작업을 함
		//썸네일에 대한 이미지정보를 map에 담아서 반목문을 통해 폴더에 이미지를 추가 
		fileList.stream().filter(vo -> vo.isFileType() == true)
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
				.forEach(p -> fileListPaths.add(p));

		log.info("===========================================");

		fileListPaths.forEach(p -> log.info("p:"+p));

		//어제자 폴더에 저장된 이미지에 대한 값을 가져와서 targetDir에 대입
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		//listFiles메서드 사용해서 폴더의 파일목록을 file 배열로 반환 후 대상 문자열에 특정 문자열이 포함 되었는지 (경로에) 확인 == false
		//false 면 없는 파일이므로 없는 파일들을 찾아 목록에 추가
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

		log.info("-----------------------------------------");
		//file 변수에 removeFIles 값을 대입시켜서 삭제 시킨다. 즉 썸네일사진 기본사진 둘다 삭제를 시킨다는것
		for (File file : removeFiles) {

			log.info("file:" +file.getAbsolutePath());

			file.delete();

		}
	}
}
