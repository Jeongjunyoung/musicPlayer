<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- JavaSciprt File -->
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script type="text/javascript" src="/../resources/js/musicBox.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- CSS File -->
	<link href="/../resources/css/musicBox.css" type="text/css" rel="stylesheet">
</head>
<body>
	<c:choose>
		<c:when test="${session == true }">
			<p>${sessionScope.userSession.user_id}님 ㅎㅇ</p>
			<input type="hidden" value="${sessionScope.userSession.user_id}" id="login_id">
			<button type="button" id="logout_btn" class="btn btn-default">로그아웃</button>
		</c:when>
		<c:otherwise>
			<button type="button" id="login_btn" class="btn btn-default" data-toggle="modal" data-target="#login_paper">로그인</button>
		</c:otherwise>
	</c:choose>
	<div id="register">
		<button type="button" id="signUp_btn" class="btn btn-default" data-toggle="modal" data-target="#signUp_paper">회원가입</button>
		
	</div>
	<c:choose>
		<c:when test="${session == true }">
			<div id="player"></div>
		</c:when>
		<c:otherwise>
			<h1>로그인 하세요</h1>
		</c:otherwise>
	</c:choose>	
	<div id="btnBox" class="box">
		<img src="/../resources/images/play.png" onclick="playVideo()" id="playBtn">
		<img src="/../resources/images/pause.png" onclick="pauseVideo()" id="stopBtn">
		<img src="/../resources/images/shuffle.png" onclick="shufflePlay()" id="shuffleBtn">
	</div>
	<div id="list" class="box scrollBox">
		<c:forEach var="list" items="${list }">
			<ul id="playList" class="hoverList">
				<li value="${list.music_id }">${list.music_name }</li>
			</ul>
		</c:forEach>
	</div>
	<input id="searchKey" type="text"><button id="searchBtn" class="btn btn-default">검색</button><button class="btn btn-default" id="checkAdd">선택 추가</button>
	<div id="searchResult" class="box scrollBox"></div>
	<!-- 회원가입 양식 -->
	<div class="modal fade" id="signUp_paper" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times</span>
					</button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">
					<form action="sign_in" method="post" class="form-horizontal">
						<div class="col-sm-12">
							ID   <input type="text" class="form-control" name="user_id">
						</div>
						<div class="col-sm-12">
							PassWord   <input type="password" class="form-control" name="user_pw">
						</div>
						<div class="col-sm-12">
							E-Mail   <input type="text" class="form-control" name="user_email">
						</div>
						<button type="submit" id="signIn_btn" class="btn btn-default">가입</button>
					</form>
				</div>
				<div class="modal-footer">
					
				</div>
			</div> <!-- /modal-content -->
		</div> <!-- /modal-dialog -->
	</div> <!-- /modal -->
	
	<!-- 로그인 양식 -->
	<div class="modal fade" id="login_paper" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times</span>
					</button>
					<h4 class="modal-title">로그인</h4>
				</div>
				<div class="modal-body">
					<form action="login_form" method="post" class="form-horizontal">
						<div class="col-sm-12">
							ID   <input type="text" class="form-control" name="user_id">
						</div>
						<div class="col-sm-12">
							PassWord   <input type="password" class="form-control" name="user_pw">
						</div>
						<button type="submit" id="loginForm_btn" class="btn btn-default">로그인</button>
					</form>
				</div>
				<div class="modal-footer"></div>
			</div> <!-- /modal-content -->
		</div> <!-- /modal-dialog -->
	</div> <!-- /modal -->
</body>
</html>