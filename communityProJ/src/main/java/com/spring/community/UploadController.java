package com.spring.community;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.community.common.AttachFileDTO;

import net.coobird.thumbnailator.Thumbnailator;


@Controller
public class UploadController {
	private static Logger log = Logger.getLogger(UploadController.class.getName());
	
	//년/월/일 폴더 생성
	private String getFolder() {
		//SimpleDateFormat 클래스 객체를 선언(yyyy-MM-dd)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//sdf 객체를 담을 date객체 선언
		Date date = new Date();
		//str 변수 선언 후 지정한 포맷으로 변환
		String str = sdf.format(date);
		// str에 들어간 파일들의 구분자 '-' 사용
		return str.replace("-", File.separator);
	}
	
	//특정한 파일이 이미지 타입인지를 검사하는 메서드
	private boolean checkImageType(File file) {

		try {
			//Files.probeContentType 메서드는 실제 파일의 내용이 아니라 파일의 확장자를 이용하여 MimeType을 판단함
			//확장자가 없는 파일은 null 반환 , 실제 파일이 존재 하지 않아도 MimeType을 반환
			//file.toPath를 집어 넣어서 파일을 경로로 변환 합니다.
			String contentType = Files.probeContentType(file.toPath());
			//string 관련 함수 startsWith 함수를 사용하여 파일의 경로에 있는 것이 image인지 확인
			//맞으면 true반환 ,아닐 시 false반환
			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
	
	//업로드되는 파일을 저장하는 메서드
	//MediaType.APPLICATION_JSON_UTF8_VALUE 는 브라우저가 매개변수 없이 utf-8 특수문자를 올바르게 해석하게 하기 위해서
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	//list<attachfileDTO>를 응답데이터로 선언
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("uploadAjaxAction Post..........");
		
		//이미지에 대한 정보를 담을 arraylist객체 선언
		List<AttachFileDTO> list = new ArrayList<>();
		//저장될 경로 선언
		String uploadFolder = "C:\\upload";
		//getfolder메서드를 uploadFolderPath에 주입
		String uploadFolderPath = getFolder();
		// 폴더 생성(경로에 년,월,일 로 생성하게 함) --------
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		//.exists함수를 사용 하여 만약 경로에 파일이 존재하지 않는다면
		//.mkdirs 함수를 사용 하여 폴더 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		//uploadFile 배열을 multipartFile변수에 담아서 출력
		for (MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------");
			log.info("Upload File Name:" + multipartFile.getOriginalFilename());
			log.info("Upload File size:" + multipartFile.getSize());
			//이미지 관련DTO 객체 선언(new연산자를 통해)
			AttachFileDTO attachDTO = new AttachFileDTO();
			//getOriginalFilename 메서드를 사용해서 파일 이름을 가져와서 uploadFileName 에 집어넣는다.
			String uploadFileName = multipartFile.getOriginalFilename();

			// 업로드된 파일 이름을 찾기위해 substring함수를 사용해서 원하는 위치에서 자르기위해 선언
			//lastIndexOf를 사용해서 뒤에서 부터 찾기 시작, \\ 이후에 문자열을 uploadFileName에 집어넣는다.
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			//uploadFileName문자열을 attachDTO.setFileName에 셋팅시켜줌
			attachDTO.setFileName(uploadFileName);
			
			//uuid클래스(유일한 식별자를 생성할 수 있어서 사용)
			UUID uuid = UUID.randomUUID();
			//파일이름 과 uuid를 구분하기위해 사이에 '_'를 추가
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				//파일의 경로 및 이름을 saveFile객체에 저장
				File saveFile = new File(uploadPath, uploadFileName);
				//파일을 복사해서 savefile에 전송
				multipartFile.transferTo(saveFile);
				
				//전송 시 들어온 uuid,경로 값 셋팅(attachDTO에)
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				//만약 check image type메서드에 saveFile의 값이 있다면?
				if (checkImageType(saveFile)) {
					//이미지 셋팅값은 true
					attachDTO.setImage(true);
					//썸네일이라는 객체를 fileoutputstream을 통해 출력( 기존 파일 저장이름에서 's_'를 붙여 썸네일 이미지 저장
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					//썸네일 이미지 생성(위 썸네일 객체에 맞게 저장, 및 사이즈는 100,100)
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					//이후 스트림 닫아준다
					thumbnail.close();
				}

				// 이후 이미지의 정보를 담은 list에 추가 시켜준다
				list.add(attachDTO);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
				//ResponseEntity<>(t body , HttpStatus status)
				//리턴 값을 responseentity<list , httpstatus.ok> list의 값과 status code 값을 응답
	}
	
	//썸네일 이미지 보여주기
	@GetMapping("/display")
	@ResponseBody
	//byte[] 배열 값을 응답데이터로 선언
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);
		//파일 경로 + 파일 이름의 값을 file객체에 저장
		File file = new File("c:\\upload\\" + fileName);

		log.info("file: " + file);
		//응답 데이터(byte[] 배열값) = null 선언
		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			//이후 headers 값에 content-type 값을 파일경로 값으로
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			//응답 데이터 값에 file의 내용을 byte에 담아 보내고 , 헤더에 컨텐트타입 , statuscode 값을 응답
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	//첨부파일 다운로드 메서드
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		//FileSystemResource 클래스를 사용해서 파일을 새로 만듬
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		//resource 객체의 경로에 파일 및 폴더가 존재하지 않으면 404 statuscode 출력
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		//변수를 선언하여 지정된 경로에 파일 이름 반환
		String resourceName = resource.getFilename();

		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();
		try {
			//userAgent는 http요청을 보내는 디바이스와 브라우저 등 사용자 소프트웨어의 식별정보를 담고 있는 request header의 한종류
			//userAgent정보를 파악, 값이 'MSIE' , 'Trident'인 경우 다른 방식으로 처리하도록 함(IE 브라우저의 엔진 이름 - IE11처리)
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			String downloadName = null;

			if (checkIE) {
				//replaceAll함수 사용으로 대상 문자열을 원하는 문자 값으로 반환
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replaceAll("\\+", " ");
			} else {
				//resourceOriginalName 의 문자열 값을 바이트 배열로 변환 후 , 해당 바이트 배열을 가지고 다시 'ISO-8859-1' 의 문자열로 생성하는 과정
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	//파일 삭제 메서드
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);

		File file;

		try {
			//파일 객체 선언(경로 + (filename, utf-8)을 decode 해줌 => 문자열이 깨져보이는 현상이 있을 수 있어서 사용)
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			if (type.equals("image")) {
				//getAbsolutePath => File에 입력된 절대 경로 리턴하는 함수
				//'s_' 와 '' 아무것도 없는 것들의 값을 largeFileName에 저장
				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName: " + largeFileName);
				//file 객체에 경로 리턴한 값을 넣고 .delete()를 사용해서 삭제
				file = new File(largeFileName);

				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			//만약 값이 없는데 삭제?를 하려하면 404에러 뜨게 응답
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}
}
