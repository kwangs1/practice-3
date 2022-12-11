<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">

<script src="https://kit.fontawesome.com/aa33559cc0.js" crossorigin="anonymous"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
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
</style>
<body>
<form action="${path}/board/register" method="post" id="frm" role="form">

<div class="container">
   	<h1>작성 페이지</h1>
     <div class="row row1">
      <table class="table">
      	<tr>
			<th width=30% class="text-center">
				<select class="option" name="category" id="category">
					<option value="" selected>말머리 선택해주세요</option>
					<option value="1">자유</option>
					<option value="2">질문</option>
					<option value="3">공략</option>
					<option value="4">자랑</option>
				</select>
			</th>
		</tr>
		
        <tr>
         <th width=20% class="text-center warning">제목</th>
         <td width=30% class="text-center">
         	<textarea name="title"  id="title" style="width:100%; height:100%" class="title"></textarea>
         </td>
        </tr>
        <tr>
         <th width=20% class="text-center warning">닉네임</th>
         <td width=30% class="text-center">
         	<textarea name="nickname" id="nickname" style="width:100%; height:100%" class="nickname"></textarea>
         </td>
        </tr>
        <tr>
          <td colspan="4" class="text-left" valign="top" height="200">
           <textarea name="content" id="content" style="width:100%; height:100%" class="content"></textarea>
          </td>
        </tr>
         <tr>
           <td class="panel-heading">File Attach
           	<input type="file" name='uploadFile' multiple>
           </td>
           <td class="uploadResult">
           	<ul>
           		
           	</ul>
           </td>
        </tr>
        <tr>
          <td colspan="4" class="text-right">
			<a href="${path}/board/lists" class="btn btn-xs btn-success">목록으로</a>
			 <button type="submit" class="btn btn-xs btn-info">등록</button>
          </td>
        </tr>
      </table>
     </div>
   </div>
   
</form>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(e){

  var formObj = $("form[role='form']");
  
  $("button[type='submit']").on("click", function(e){
		var category = $(".option").val();
		var title = $(".title").val();
		var nickname = $(".nickname").val();
		var content = $(".content").val();
		
		if(category == 0){
			alert("말머리 선택해주세요.");
			document.getElementById("category").focus();
			return false;
		}else if(title == ""){
			alert("제목을 적어주세요.");
			document.getElementById("title").focus();
			return false;
		}else if(nickname == ""){
			alert("닉네임 적어주세요.");
			document.getElementById("nickname").focus();
			return false;
		}else if(content == ""){
			alert("내용을 적어주세요.");
			document.getElementById("content").focus();
			return false;
		}
	    
	    e.preventDefault();
	    
	    console.log("submit clicked");
    var str = "";
    
    $(".uploadResult ul li").each(function(i, obj){
      
      var jobj = $(obj);
      
      console.dir(jobj);
      console.log("-------------------------");
      console.log(jobj.data("filename"));
      
      
      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
      
    });
    
    console.log(str);
    
    formObj.append(str).submit();
    
  });

  
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
      url: '/community/uploadAjaxAction',
      processData: false, 
      contentType: false,
      data: formData,
      type: 'POST',
      dataType:'json',
        success: function(result){
          console.log(result); 
		  showUploadResult(result); //업로드 결과 처리 함수 

      }
    }); //$.ajax
    
  });  
  
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
});
</script>
</body>
</html>