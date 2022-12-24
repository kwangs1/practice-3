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
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
.row1 {
   margin:0px auto;
   width: 700px;
   height: 650px;
   font-family: 'Space Grotesk', sans-serif;
}
*{
  padding-top:20px;
  padding-right:15px;
  padding-bottom:10px;
  padding-left:15px;
}
h1 {
	text-align:center;
	font-family: 'Space Grotesk', sans-serif;
}
li{
   list-style:none;
   }
 a:link {text-decoration: none;}
 a:visited {text-decoration: none;}
 a:hover { color: black; text-decoration: none;}
</style>
<body>

   <div class="container">
   	 <h1>상세보기</h1>
     <div class="row row1">
      <table class="table">
        <tr>
         <th width=20% class="text-center warning">제목</th>
         <td width=30% class="text-center">${detail.title}</td>
         <th width=20% class="text-center warning">작성일</th>
         <td width=30% class="text-center">${detail.credate}</td>
        </tr>
        <tr>
         <th width=20% class="text-center warning">닉네임</th>
         <td width=30% class="text-center">${detail.nickname}</td>
         <th width=20% class="text-center warning">조회수</th>
         <td width=30% class="text-center">${detail.hit}</td>
        </tr>
        <tr>
          <td colspan="4" class="text-left" valign="top" height="200">
           <pre style="white-space: pre-wrap;border:none;background-color: white;">${detail.content}</pre>
          </td>
        </tr>
        <tr>
         <td class="uploadResult">
           	<ul></ul>
         </td>
        </tr>
        <tr>
          <td colspan="4" class="text-right">
			<a href='<c:url value='/board/lists?page=${scri.page}&perPageNum=${scri.perPageNum }&searchType=${scri.searchType}&keyword=${scri.keyword}'/>' 
					class="btn btn-xs btn-success">목록으로</a>
			<a href="${path}/board/modify?bno=${detail.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}" 
			class="btn btn-xs btn-info">수정</a>
  			&nbsp;<button type="submit" data-oper='remove' class="btn btn-xs btn-warning remove" style="width:40px;height:23.5px;">삭제</button>
          </td>
        </tr>
        <tr >
        	<td class="getLike">
				<a href="#" class="LikeBtn">
        			<i class="fa-regular fa-heart"></i>
				</a><br>&nbsp;&nbsp;&nbsp;&nbsp;<strong>${getLike}</strong>
        	</td>
        </tr>
      </table>
		<%@include file="../common/ReplyList.jsp"%>
     </div>
   </div>

   <form method='get' id='form'>
	  <input type='hidden' id='bno' name='bno' value='${detail.bno}'>
	  <input type='hidden' id='page' name='page' value='${scri.page}'>
	  <input type='hidden' id='perPageNum' name='perPageNum' value='${scri.perPageNum}'>
	  <input type='hidden' id='searchType' name='searchType' value='${scri.searchType}'>
	  <input type='hidden' id='keyword' name='keyword' value='${scri.keyword}'>
	</form>	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
$(document).ready(function(){
	var formObj = $('#form');
	 $('.remove').on("click", function(e){
		    
		    e.preventDefault(); 
		    
		    var operation = $(this).data("oper");
		    var delconfirm = confirm('삭제 하시겠습니까?');
		    
		    console.log(operation);
		    
		    if(operation === 'remove' && delconfirm){
		      alert('삭제 되었습니다.');
		      formObj.attr("action", "${path}/board/remove");		      
		    }else{
				alert('삭제 취소되었습니다.');
				return false;
			}
		    formObj.submit();
	 });    
  (function(){
  
    var bno = '<c:out value="${detail.bno}"/>';
    
    $.getJSON("${path}/board/getAttachList", {bno: bno}, function(arr){
        
       console.log(arr);     
       var str = "";
       
       $(arr).each(function(i, attach){
       
         //image type
         if(attach.fileType){
           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
           
           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
           str += "<img src='${path}/display?fileName="+fileCallPath+"'>";
           str += "</div>";
           str +"</li>";
         }else{
             
           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
           str += "<span> "+ attach.fileName+"</span><br/>";
           str += "<img src='${path}/resources/img/attach.png'></a>";
           str += "</div>";
           str +"</li>";
         }
       });
       
       $(".uploadResult").html(str);       
       
     });//end getjson
    
  })();//end function
  
});
</script>
<!-- 좋아요 스크립트 -->
<script type="text/javascript">
var LikeVal = ${findLike};

	let bno = ${detail.bno};
	let like_type = 1;
	
	if(LikeVal > 0){
		console.log("좋아요 눌렀어!.."+LikeVal);
		
		$('.LikeBtn').on('click',function(){
		$('.LikeBtn').html('<i class="fa-solid fa-heart"></i>');
			$.ajax({
				type : 'post',
				url : '${path}/Like/LikeDown',
				contentType : 'application/json',
				data : JSON.stringify({
					'bno' : bno,
					'like_type' : like_type
				}),
				dataType : 'json',
				success : function(){
					console.log("좋아요 취소!.."+LikeVal);
				},
				error : function(error){
					console.log(error);
				}
			})//end ajax;
		})//end function
 	}else{
		console.log("좋아요 누를꺼임!.."+LikeVal);
		$('.LikeBtn').on('click',function(){
			$.ajax({
				type : 'post',
				url : '${path}/Like/LikeUp',
				contentType : 'application/json',
				data : JSON.stringify({
					'bno' : bno,
					'like_type' : like_type
				}),
				success : function(){
					console.log("좋아요 눌렀어.."+LikeVal);
				},
				error : function(error){
					console.log(error);
				}
			})//end ajax
		})//end function
	}
</script>
</body>
</html>