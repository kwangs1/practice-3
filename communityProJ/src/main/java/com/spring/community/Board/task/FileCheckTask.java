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
		// file list in database
		List<BoardAttachVO> fileList = boardAttach.getOldFiles();

		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());

		// image file has thumnail file
		fileList.stream().filter(vo -> vo.isFileType() == true)
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
				.forEach(p -> fileListPaths.add(p));

		log.info("===========================================");

		fileListPaths.forEach(p -> log.info("p:"+p));

		// files in yesterday directory
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();

		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

		log.info("-----------------------------------------");
		for (File file : removeFiles) {

			log.info("file:" +file.getAbsolutePath());

			file.delete();

		}
	}
}
