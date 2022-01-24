<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
 	<jsp:param value="프로필 설정" name="title"/>
</jsp:include>

<sec:authentication property="principal" var="loginMember"/>

<h1>shop프로필설정</h1>
<div class="container">
    <div class="row">
    	<!-- 메뉴 영역 -->
        <div class="col-sm-4">
        	<ul class="list-group">
			  <li class="list-group-item active" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/personal'">개인정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/shopInfo'">업체정보 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/password'">비밀번호 변경</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/hashtag'">해시태그 설정</li>
			  <li class="list-group-item" onclick="location.href='${pageContext.request.contextPath}/member/shopSetting/reservationSetting'">예약 관리</li>
			</ul>
        </div>
        
        <div class="col-sm-8">
        	<label for="username">이름</label><input type="text" name="username" id="username" />
        	<br />
        	<label for="profile">프로필사진</label><input type="file" name="profile" id="profile" />
        	<br />
        	<label for="introduce">소개</label>
        	<br />
        	<input type="text" name="introduce" />
        	<br />
        	<label for="address">주소</label>
        	<br />
        	<input type="text" name="addressAll" style="width:300px;"/>
        	<input type="button" value="검색" onclick="execDaumPostcode();" />
        	<br />
        	<label for="addressDetail">상세주소</label>
        	<br />
        	<input type="text" name="addressDetail" required/>
        	<input type="hidden" name="locationX" />
        	<input type="hidden" name="locationY" />
        	<input type="hidden" name="id" />
        </div>
        
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>