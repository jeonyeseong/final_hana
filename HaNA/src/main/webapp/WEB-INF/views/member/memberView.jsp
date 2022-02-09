<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="마이페이지" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberView.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-- 우측 공간확보 -->
<section class="body-section" style="width:200px;height:100%;float:right;display:block;">
<span style="float:right;">ㅁㄴ이랸멍리ㅑㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴ어랴ㅣㅁㄴㅇㄹ</span>
</section>
<section>
 <script src="https://kit.fontawesome.com/0748f32490.js"
	crossorigin="anonymous">
</script>
<sec:authentication property="principal" var="loginMember"/>
 
<c:if test="${not empty msg}">
	<script>
	alert("${msg}");
	</script>
</c:if>
 
<div class="container mt-2">
    <div class="row" id="myInfo">   	
    	<!-- 프로필이미지 영역 -->
        <div class="col-sm-5 d-flex justify-content-center align-items-center flex-column" id="profileImg">
        	<div class="profileImg d-flex">
        		<!-- 이미지를 넣으세요 -->
        		<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${member.picture}" alt=""/>
        	</div>
        	<div class="profileBtn">
    		 	<c:if test="${loginMember.id.equals(member.id) }">
        		<div class="extraSet">
        		<!-- (+)버튼을 -->
        		<form:form name="profileUpdateFrm" action="${pageContext.request.contextPath }/member/profileUpdate?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
	        		<label class="input-file-button" for="input-file">
	        			<img src="${pageContext.request.contextPath }/resources/images/icons/plusIcon.png" alt="" />
	        		</label>
	        		<input type="file" name="upFile" id="input-file" style="display:none;"/>
        		</form:form>
        		</div>
        		</c:if>
        	</div>
        </div>
        <!-- 프로필 세부정보 영역 -->
        <div class="col-sm-7" id="profileStatus">
		<br><br><br>
        	<span class="followTitle">팔로잉&nbsp;&nbsp; </span>
        	 <c:choose>
    		<c:when test="${member.publicProfile == 2  && loginMember.id != member.id && isFriend != 1}">
    		<span style="font-weight:bold">비공개</span>
    		 </c:when>
    		 <c:otherwise>
        	 <button  type="button" class="btn btn-secondary" id="btn-following-list">${followerCount}명</button>
        	 </c:otherwise>
        	 </c:choose>
        	&nbsp;&nbsp;&nbsp;&nbsp; 
        	<span class="followTitle">팔로워&nbsp;&nbsp; </span>
        	 <c:choose>
    		<c:when test="${member.publicProfile == 2  && loginMember.id != member.id && isFriend != 1}">
    		<span style="font-weight:bold">비공개</span>
    		 </c:when>
    		 <c:otherwise>
        	 <button  type="button" class="btn btn-secondary" id="btn-follower-list">${followingCount}명</button>
        	  </c:otherwise>
        	 </c:choose> 
	

        	<!-- 설정버튼 : 본인계정일땐 설정, 아닐땐 친구추가 버튼 --> 
			<c:if test="${loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="goSetting();">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/setting.png" alt="" />
        	</button>
        	</c:if>
        	<c:if test="${!loginMember.id.equals(member.id) }">
        	<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="addFollowing()">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/man.png" alt="" />
        	</button>
        	</c:if>
        	 <c:choose>
    		<c:when test="${member.publicProfile == 2  && loginMember.id != member.id && isFriend != 1}">
    		<button type="button" class="btn btn-outline-dark" id="settingBtn" onclick="requestFollowing1()">
        		<img src="${pageContext.request.contextPath }/resources/images/icons/man.png" alt="" />
        	</button>
        	</c:when>
        	</c:choose>
        	<form:form name="addFollowingFrm" action="${pageContext.request.contextPath}/member/addFollowing" method = "POST">
        		<input type="hidden" name ="friendId" value="${member.id}" />
        		<input type="hidden" name ="myId" value="${loginMember.id}" />
        	</form:form>
        	
        	 <form:form name="requestFollowingFrm" action="${pageContext.request.contextPath}/member/requestFollowing" method = "POST">
        		<input type="hidden" name ="friendId" value="${member.id}" />
        		<input type="hidden" name ="myId" value="${loginMember.id}" />
        		<input type="hidden" name ="status" value="요청" />
        	</form:form>
 

            <br /><br/>
            
            <div class="profileTableArea">
				<table id="profileTable">
					<tbody>
						<tr>
							<td><span class="tableKey">아이디</span></td>
							<td class="tableValue">${member.id}</td>
						</tr>
					 
						<tr>
							<td><span class="tableKey">지역</span></td>
							<td class="tableValue">${member.addressAll}</td>
						</tr>
						<tr>
							<td rowspan=2><span class="tableKey">소개</span></td>
							<td class="tableValue" rowspan=1>
								 ${member.introduce} 
							</td>
						</tr>
					</tbody>
				</table>
			</div>
    <c:if test="${loginMember.id.equals(member.id) }">
        	<button id="btn-add" style="float:right; margin-top:80px"><i style="font-size: 30px;" class="fas fa-pencil-alt"></i></button>
	</c:if>
	    <c:if test="${request > 0}">
    	<button type="button" class="btn btn-secondary" id="requestButton">친구요청이 있습니다.</button>
    </c:if>
		</div>
   </div>
   
</div> 
<br>

<div class="container mt-2">       
    <div class="row">   
    </div>

	<!-- 게시물목록 -->        
 	<c:choose>
    		<c:when test="${member.publicProfile == 2  && loginMember.id != member.id && isFriend != 1}">
    	 	<p style="font-weight: bold" class="private">비공개계정입니다.</p>
    	 	<p class="private">사진을 보려면 팔로우하세요.</p>
    	 	</c:when>
    	 	<c:otherwise>
       <div class="row">    
         <c:forEach items="${boardList}" var="board" varStatus="vs">
	        <div class="thumbnail col-sm-4" >     
	       	 	<input type="hidden" value="${board.no}" id="boardNo" name="no"/>
	        	<img class="board-main-image" style="width:100%; height:100%; margin-bottom: 10%"
						src="${pageContext.request.contextPath}/resources/upload/member/board/${board.picture[0]}"
						alt=""  />
		      </div>
	      </c:forEach>
	   </div>
	    </c:otherwise>
 	</c:choose> 
	</div>
<script>
$("#requestButton").on( "click", function() {
    $("#requestModal").modal();
});
$("#btn-following-list").on( "click", function() {
    $("#test_modal").modal();
});

$("#btn-follower-list").on( "click", function() {
    $("#test_modal1").modal();
});
</script>
 <!-- 팔로잉요청!! 모달창 -->
       <div class="modal fade" id="requestModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
						<tr>
							<th>팔로잉 요청</th>
						</tr>
					</thead>
					<tbody id="RequestModalTbody">
					
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
 <!-- 팔로잉리스트 모달창 -->
       <div class="modal fade" id="test_modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
						<tr>
							<th>팔로잉</th>
						</tr>
					</thead>
					<tbody id="modalTbody">
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 팔로워리스트 모달창 -->
       <div class="modal fade" id="test_modal1" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<table class="table" style="text-align: center;" name="modalTable">
					<thead class="table-light">
						<tr>
							<th>팔로워</th>
						</tr>
					</thead>
					<tbody id="modalTbody1">
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
			<!-- <button type="button" class="btn btn-primary">Save changes</button> -->	
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
let boardDetail;
let newContent;
let isLiked;
 
//요청팔로잉리스트
$("#requestButton").click((e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/member/requestFollowingList",
		data : {"myId": "${loginMember.id}"},
		success(resp){
			console.log("결과 :", resp);
			$("#RequestModalTbody").empty();
			
			//const {reqId} = resp;
			$.each(resp, (i, e) => {
				console.log("eeeeeee",e);
				console.log("iiiiii",i)
				console.log("요청아이디!!!!!!",resp[i].reqId);	
				 
				let tr= `
				<tr>
					<td>
					\${resp[i].reqId}  				
					</td>
				</tr>
				<tr>
					<td>
					 <form:form name="followingApplyFrm" action="${pageContext.request.contextPath}/member/applyFollowing">
	                     <input type="hidden" name="myId" value="\${resp[i].memberId}"/>
	                     <input type="hidden" name="reqId" value="\${resp[i].reqId}"/>
	                     <input type="hidden" name="status" value="\${resp[i].status}"/>
                 	</form:form>
                 <button type="button" onclick="followingApplyFunc();"
                     class="btn btn-default btn-sm btn-success"
                     style="margin-right: 1%;" value="수락">수락</button>
					 <form:form name="followingRefuseFrm" action="${pageContext.request.contextPath}/member/refuseFollowing">
	                     <input type="hidden" name="myId" value="\${resp[i].memberId}"/>
	                     <input type="hidden" name="reqId" value="\${resp[i].reqId}"/>
	                     <input type="hidden" name="status" value="거절"/>
             	</form:form>
                 <button type="button" onclick="followingRefuseFunc();" class="btn btn-default btn-sm btn-danger" value="거절">거절</button>
					</td>
				</tr>
			`;
			console.log(tr);
			$("#RequestModalTbody").append(tr);
		})
	},
	error: console.log
	})
});
//팔로잉 리스트 가져오기
$("#btn-following-list").click((e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/member/followingList",
		data : {"friendId":"${member.id}"},
		success(resp){
			console.log("결과 :", resp);
			

			$("#modalTbody").empty();
			
			const {memberId} = resp;
			$.each(resp, (i, e) => {
				console.log(e.followers[0].memberId);
				console.log(e.picture);
				let tr= `
				<tr>
					<td>
						<img style="width:50px; height:50px; border-radius:50%" src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.picture}" alt=""/>
						<a id = "a" href="${pageContext.request.contextPath}/member/memberView/\${e.followers[0].memberId}">\${e.followers[0].memberId}</a>
					</td>
				</tr>
			`;
			console.log(tr);
			$("#modalTbody").append(tr);
		})
	},
	error: console.log
	})
});
//팔로워 리스트 가져오기 
$("#btn-follower-list").click((e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/member/followerList",
		data :  {"friendId":"${member.id}"},
		success(resp){
			console.log(resp);
			
			$("#modalTbody1").empty();
			
			const {followingId} = resp;
			$.each(resp, (i, e) => {
				console.log(e.followingId);
				let tr= `
					<tr>
					<td>
						<img style="width:50px; height:50px; border-radius:50%" src="${pageContext.request.contextPath}/resources/upload/member/profile/\${e.picture}" alt=""/>
						<a id = "a" href="${pageContext.request.contextPath}/member/memberView/\${e.followingId}">\${e.followingId}</a>
					</td>
				</tr>
			`;
			$("#modalTbody1").append(tr);
			
		})
	},
	error: console.log
	})
});
//요청 팔로잉 거절하기
function followingRefuseFunc(){
	$(document.followingRefuseFrm).submit();	
}
//요청 팔로잉 수락하기
function followingApplyFunc(){
	$(document.followingApplyFrm).submit();	
}
//비공개계정에 친구 추가 클릭
function requestFollowing1(){
	$(document.requestFollowingFrm).submit();	
}
//친구추가하기
function addFollowing(){
	if(confirm("친구추가를 하시겠습니까?")){
		$(document.addFollowingFrm).submit();
	}
}
//게시물 목록
$('.board-main-image').click((e)=>{
	let boardNo = $(e.target).siblings("#boardNo").val();
	console.log("boardNo1",boardNo);
	getPageDetail(boardNo);
	
	$('#pageDetail').modal("show");
});

//계정페이지로 이동
function goMemberView(memberId){
	location.href=`${pageContext.request.contextPath}/member/memberView/\${memberId}`;
}
//설정페이지로 이동
function goSetting(){
	location.href = "${pageContext.request.contextPath}/member/memberSetting/memberSetting";
}
/* profile 사진 업데이트 */
$(".input-file-button").click((e) => {
	if(!confirm("파일을 등록하시겠습니까?")){
		return false;
	};
});
$("#input-file").change((e) => {
	console.log("파일등록");
	$(document.profileUpdateFrm).submit();
});
</script>
<style>
.private{
    margin-left: 450px;
    margin-top: 30px;
    margin-bottom: -13;
}
</style>
<!-- 게시글 작성 모달 -->
<jsp:include page="/WEB-INF/views/member/boardModal/boardEnrollForm.jsp"/> 
<!-- 게시글상세보기 모달 -->
<jsp:include page="/WEB-INF/views/member/boardModal/boardDetail.jsp"/>
<a href="/" class="badge badge-dark">Dark</a>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>