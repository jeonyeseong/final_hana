<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="설정화면" name="memberSetting/"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>

<c:if test=" ${not empty msg}">
<script>
$(() => {
alert("${msg}");
</script>
</c:if>


<div class="row">
  <div class="col-2">
    <div class="list-group" id="list-tab" role="tablist">
      <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href='${pageContext.request.contextPath}/member/memberUpdate' role="tab" aria-controls="profile">프로필편집</a>
      <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="password">비밀번호 변경</a>
      <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="public">계정 공개 설정</a>
      <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="information">내 정보 공개</a>
            <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="reservation">예약내역</a>
    </div>
  </div>
</div>
<div id="enroll-container" class="mx-auto text-center">
	<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate" method="POST">
		<table class="mx-auto">
		 <input type="hidden" name="id" value="${loginMember.id}" />
			<tr>
				<th>이름</th>
				<td>
					<div id="memberId-container">
						<input type="text" class="form-control" name="name" id="name" value="${loginMember.name}" required >
					 				
					</div>
				</td>
			</tr>
		
			<tr>
				<th>소개</th>
				<td>
					<input type="text" class="form-control" name="introduce" id="introduce" value="${loginMember.introduce}" required>
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>	
					<input type="text" class="form-control" id="" name="addressFirst" value="${loginMember.addressFirst}" required>
				</td>
			</tr>  
			<tr>
				<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressSecond" value="${loginMember.addressSecond}" required>
				</td>
			</tr>  
			<tr>
				<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressThird" value="${loginMember.addressThird}" required>
				</td>
			</tr>  
			<tr>
			<th></th>
				<td>	
					<input type="text" class="form-control" id="" name="addressFull" value="${loginMember.addressFull}" required>
				</td>
			</tr>
			<tr>
				<th>내 성격</th>
				<td>	
					<select name="personality" id="personality" class="custom-select" required>
					  <option selected>선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
					  <option value="차분한" ${loginMember.personality  eq '차분한'? 'selected' : ''}>차분한</option>
					  <option value="활발한" ${loginMember.personality  eq '활발한'? 'selected' : ''}>활발한</option>
					  <option value="내향적인" ${loginMember.personality  eq '내향적인'? 'selected' : ''}>내향적인</option>
					  <option value="외향적인" ${loginMember.personality  eq '외향적인'? 'selected' : ''}>외향적인</option>
					  <option value="열정적인" ${loginMember.personality  eq '열정적인'? 'selected' : ''}>열정적인</option>
					  <option value="느긋한" ${loginMember.personality  eq '느긋한'? 'selected' : ''}>느긋한</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>내 관심사</th>
				<td>	
				<select name="interest" class="custom-select" required>
				  <option selected>선택</option>
				  <option value="스포츠" ${loginMember.interest  eq '스포츠'? 'selected' : ''}>스포츠</option>
				  <option value="영화" ${loginMember.interest  eq '영화'? 'selected' : ''}>영화</option>
				  <option value="술" ${loginMember.interest  eq '술'? 'selected' : ''}>술</option>
				  <option value="책" ${loginMember.interest  eq '책'? 'selected' : ''}>책</option>
				</select>
				</td>
			</tr> 
		 
		</table>
		<input type="submit" value="완료" >
		<input type="reset" value="취소">
	</form:form>
</div>

 