<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">

<script src="https://kit.fontawesome.com/aa33559cc0.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
.row1 {
   margin:0px auto;
   width: 700px;
   height: 650px;
   font-family: 'Space Grotesk', sans-serif;
}
h1 {
	text-align:center;
	font-family: 'Space Grotesk', sans-serif;
}
select {
width: 200px; 
padding: .8em .5em; 
border: 1px solid #999;
font-family: inherit;  
border-radius: 10px;
font-family: 'Space Grotesk', sans-serif;
}

select::-ms-expand {
    display: none;
}
</style>
<body>
<form method='post' id='modifyForm'>
	  <input type='hidden' id='bno' name='bno' value='${board.bno}'>
	
	<div class="container">
		<h1>수정</h1>
     <div class="row row1">
      <table class="table">
        <tr>
			<th width=30% class="text-center">
				<select class="option" name="category" id="category">
					<option value="" selected>말머리 선택해주세요</option>
					<option value="1">일반</option>
					<option value="2">질문</option>
					<option value="3">공략</option>
					<option value="4">자랑</option>
				</select>
			</th>
		</tr>
        <tr>
         <th width=20% class="text-center warning">제목</th>
         <td width=30% class="text-center">
         	<input type="text" name="title"  value="${board.title}">
         </td>
         	
         <th width=20% class="text-center warning">작성일</th>
         <td width=30% class="text-center">${board.credate}</td>
        </tr>
        <tr>
         <th width=20% class="text-center warning">닉네임</th>
         <td width=30% class="text-center">${board.nickname}</td>
        </tr>
        <tr>
          <td colspan="4" class="text-left" valign="top" height="200">
          	<textarea name="content"  style="width:100%; height:100%">${board.content}</textarea>
          </td>
        </tr>
         <tr>
           <td class="panel-heading">Files
           	<input type="file" name='uploadFile' multiple>
           </td>
           <td class="uploadResult">
           	<ul>
           		
           	</ul>
           </td>
        </tr>
        <tr>
          <td colspan="4" class="text-right">
          	<button type='submit' id="upd_chk" class="btn btn-xs btn-info">수정</button>
			<a href="${path}/board/lists" class="btn btn-xs btn-success">목록으로</a>
          </td>
        </tr>
      </table>
     </div>
   </div>

</form>		
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
$(document).ready(function(){
//수정 확인 및 취소 메시지창 띄우기
	$("#upd_chk").on('click',function(){
		var updform = $('#modfiyForm');
		var update = confirm("수정 하시겠습니까?");
			
		if(update){
			alert("수정 되었습니다");
			updform.attr('action','${path}/board/modify').submit();
		}else{
			alert("취소 되었습니다.");
			return false;
		}
	})
	
	
//select option 값 가져오기!
	let category = '${board.category}';		
	//option 객체에 접근을 하면 배열 형태로 프로퍼티를 가지고 있음
	//jquery의 each메서드 사용해서 option객체가 가지고 있는 모든 요소에 순차적으로 접근하도록 함. 
	$("option").each(function(i,obj){
		if(category === $(obj).val()){
			$(obj).attr("selected", "selected");
		}
	});		
});

</script>
<!-- 이미지 수정 관련 스크립트 -->
<script>
$(document).ready(function() {
	//attachlist에 수정된 이미지 및 삭제된 이미지를 담기 위해
	  var formObj = $("form");

	  $('button').on("click", function(e){
		  
	    	e.preventDefault();         
	       console.log("submit clicked");
	        
	        var str = "";
	        
	        $(".uploadResult ul li").each(function(i, obj){
	          
	          var jobj = $(obj);
	          
	          console.dir(jobj);
	          
	          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	          str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
	          
	        });
	        formObj.append(str).submit();
      
  
	    formObj.submit();
	  });
	//----등록된 이미지 불러오기
  (function(){
    
    var bno = '<c:out value="${board.bno}"/>';
    
    $.getJSON("${path}/board/getAttachList", {bno: bno}, function(arr){
    
      console.log(arr);
      
      var str = "";

      $(arr).each(function(i, attach){
          
          //image type
          if(attach.fileType){
            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
            
            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
            str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
            str += "<span> "+ attach.fileName+"</span>";
            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='${path}/display?fileName="+fileCallPath+"'>";
            str += "</div>";
            str +"</li>";
          }else{
              
            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
            str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
            str += "<span> "+ attach.fileName+"</span><br/>";
            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
            str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='${path}/resources/img/attach.png'></a>";
            str += "</div>";
            str +"</li>";
          }
       });

      
      $(".uploadResult ul").html(str);
      
    });//end getjson
  })();//end function
  
//-----등록된 이미지 삭제
  $(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    var targetFile = $(this).data("file");
    var type = $(this).data("type");
    
    var targetLi = $(this).closest("li");
    
    $.ajax({
      url: '/community/deleteFile',
      data: {fileName: targetFile, type:type},
      dataType:'text',
      type: 'POST',
        success: function(result){
           //alert(result);
           
           targetLi.remove();
         }
    }); //$.ajax
   });
//---------이미지 파일 종류 및 사이즈 설정 
  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  var maxSize = 5242880; //5MB
  
  function checkExtension(fileName, fileSize){
    
    if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
    }
    
    if(regex.test(fileName)){
      alert("해당 종류의 파일은 업로드할 수 없습니다.");
      return false;
    }
    return true;
  }
//-----사진 불러오기(업로드)
  $("input[type='file']").change(function(e){

	    var formData = new FormData();
	    
	    var inputFile = $("input[name='uploadFile']");
	    
	    var files = inputFile[0].files;
	    
	    for(var i = 0; i < files.length; i++){

	      if(!checkExtension(files[i].name, files[i].size) ){
	        return false;
	      }
	      formData.append("uploadFile", files[i]);
	      
	    }
	    
	    $.ajax({
	      url: '${path}/uploadAjaxAction',
	      processData: false, 
	      contentType: false,
	      data:formData,
	      type: 'POST',
	      dataType:'json',
	        success: function(result){
	          console.log(result); 
			  showUploadResult(result); //업로드 결과 처리 함수 

	      }
	    }); //$.ajax
	    
	  });    
//------사진 보여주기(업로드) 함수에서 성공시 보여주기 위한 함수 
  function showUploadResult(uploadResultArr){
	    
	    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	    
	    var uploadUL = $(".uploadResult ul");
	    
	    var str ="";
	    
	    $(uploadResultArr).each(function(i, obj){
			//image type
			
			if(obj.image){
				var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"'";
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str +" ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/community/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str +"</li>";
			}else{
				var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			      
				str += "<li "
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str +"</li>";
			}

	    });
	    
	    uploadUL.append(str);
	  }
	  
	});
</script>
</body>
</html>