<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta name="google-signin-scope" content="profile email">
<meta name="google-site-verification" content="60I7cWIaqvcVC_HneXrEvqvbUD99KqLcdRmOnNUhexA">
<meta name="google-signin-client_id" content="222457887868-9bofjnk09tuuc2v2cgedclv7nu6c868n.apps.googleusercontent.com">
	<link href="/../resources/css/bootstrap.min.css" rel="stylesheet">
	<!-- Theme CSS -->
	<link href="/../resources/css/mymy.css" type="text/css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/../resources/css/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="/../resources/css/mBox.css">
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css"	rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<!-- jQuery -->
	<script src="/../resources/js/jquery.min.js"></script>
	<!-- Theme js-->
	<script src="/../resources/js/mymy.js"></script>
	<script src="/../resources/js/sweetalert.min.js"></script>
	<!-- Plugin JavaScript -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<title>JSP</title>
</head>
<body>
	<div class="container" id="play-view">
		<div class="row">
			<div class="col-lg-12">
				<div class="intro-text" id="player"></div>
			</div>
		</div>
	</div>
	<div class="container div-box" id="menu_tab">
		<div class="row">
			<c:choose>
				<c:when test="${session == true }">
					<a class="Button" href="logout" onclick="signOut();"><span class="Button__textWrapper"><span class="Button__text">LOGOUT</span><span
						class="Button__icon login-icon" aria-hidden="true"></span></span></a>
				</c:when>
				<c:otherwise>
					<a class="Button" href="#loginModal" data-toggle="modal"><span class="Button__textWrapper"><span class="Button__text">LOGIN</span><span
						class="Button__icon login-icon" aria-hidden="true"></span></span></a>
				</c:otherwise>
			</c:choose>
			<a class="Button" href="#signUpModal" data-toggle="modal"><span class="Button__textWrapper"><span class="Button__text">SIGN UP</span><span
					class="Button__icon signup-icon" aria-hidden="true"></span></span></a>
			<a class="Button"  href="#searchModal" data-toggle="modal"><span class="Button__textWrapper"><span class="Button__text">SEARCH</span><span
					class="Button__icon search-icon" aria-hidden="true"></span></span></a>
		</div>
	</div>
	<div class="container div-box" id="now-playing">
		<div class="row">
			<div id="plaing-music-name"></div>
		</div>
	</div>
	<div class="container div-box" id="controll-box">
		<div class="row">
			<div class="col-lg-12 text-center">
				<button type="button" class="btn btn-lg" id="prevBtn" onclick="prevVideo()" title="뒤로">
					<span class="fa fa-backward"></span>
				</button>
				<button type="button" class="btn btn-lg" id="playBtn" onclick="playVideo()" title="재생">
					<span class="fa fa-play"></span>
				</button>
				<button type="button" class="btn btn-lg" id="stopBtn" onclick="pauseVideo()" title="정지">
					<span class="fa fa-pause"></span>
				</button>
				<button type="button" class="btn btn-lg" id="nextBtn" onclick="nextVideo()" title="다음곡">
					<span class="fa fa-forward"></span>
				</button>
				<button type="button" class="btn btn-lg" id="shuffleBtn" onclick="shufflePlay()" title="랜덤재생">
					<span class="fa fa-random"></span>
				</button>
				<button type="button" class="btn btn-lg" id="replayBtn" title="한곡반복">
					<span class="fa fa-repeat"></span>
				</button>
			</div>
		</div>
	</div>
	<div class="container div-box"id="playlist-box">
			<div class="row">
				<div class="col-md-12">
					<!-- Nav tabs -->
					<ul id="tab-list" class="nav nav-tabs" role="tablist">
						<li class="tab active"><a href="#tab1" role="tab" data-toggle="tab">TOP 100</a></li>
						<li><a href="#tab2" role="tab" data-toggle="tab" id="a-tab2">MY LIST</a></li>
						<c:forEach var="tabs" items="${tabs }">
							<li class="tab"><a href="#${tabs.tab_id }" role="tab" data-toggle="tab">${tabs.tab_name }
									<button style="display:none;" class="btn btn-xs delete-tab" type="button" title="Remove this page">×</button>
							</a></li>
						</c:forEach>
					</ul>
					<!-- Tab panes -->
					<div id="tab-content">
						<div class="tab-pane fade in active top100-list" id="tab1">
							<table class="table hoverList">
								<c:forEach var="top100" items="${top100 }" varStatus="status">
									<tr class="playList-td">
										<td class="top100-ranking">${status.count}</td>
										<td id="${top100.music_id }"
											class="clickList-td top100Index-${status.count}">${top100.music_name }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="tab-pane fade user-list" id="tab2">
							<table class="table hoverList tab-playList" id="playList">
								<c:forEach var="list" items="${list }" varStatus="status">
									<tr class="playList-td">
										<c:choose>
											<c:when test="${status.last }">
												<td class="top100-ranking last-index">${status.count}</td>
												<td id="${list.music_id }" 
													class="clickList-td  myIndex-${status.count}">${list.music_name }</td>
											</c:when>
											<c:otherwise>
												<td class="top100-ranking">${status.count}</td>
												<td id="${list.music_id }" 
													class="clickList-td  myIndex-${status.count}">${list.music_name }</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</table>
						</div>
						<c:forEach var="tabs" items="${tabs }">
							<div class="tab-pane fade in active user-list" id="${tabs.tab_id }">
								<table class="table hoverList tab-playList">
									<c:forEach var="tabMusic" items="${tabMusic }">
										<c:if test="${tabMusic.tab_id == tabs.tab_id}">
											<tr class="playList-td">
												<td class="top100-ranking">${status.count}</td>
												<td id="${tabMusic.tabs_music_id }"
													class="clickList-td">${tabMusic.tabs_music_name }</td>
											</tr>
										</c:if>
									</c:forEach>
								</table>
								<div class="col-lg-12 text-center">
									<button class="tabadd-btn tadAddMusic">ADD MUSIC</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="container div-box"id="edit-box">
			<div class="row">
				<div class="col-lg-12 text-center">
					<button class="tabadd-btn hideBtn" id="editBtn">EDIT</button>
					<button class="tabadd-btn hideBtn" id="btn-add-tab">ADD TAB</button>
				</div>
				<div class="col-lg-12 text-center">
					<button class="tabadd-btn delCancelBtn" id="delBtn">DELETE</button>
					<button class="tabadd-btn delCancelBtn" id="cancelBtn">CANCEL</button>
				</div>
			</div>
		</div>
	<!-- 회원가입 Modal -->
	<div class="modal fade" id="signUpModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<h2 class="text-center">SIGN UP</h2>
				<form action="sign_in" method="post" class="form-horizontal" id="frm">
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8 text-center">
							<input type="text" title="ID" class="form-control input_text" name="user_id" id="input_id" placeholder="ID">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8 text-center">
							<input type="password" title="PASSWORD"
								class="form-control input_text" name="user_pw" id="input_pw"
								placeholder="PASSWORD">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8 text-center">
							<input type="email" title="E-MAIL" class="form-control input_text" name="user_email"
								id="input_email" placeholder="E-MAIL">
						</div>
					</div>
					<input type="hidden" title="HIDDEN" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="form-group">
						<div class="col-sm-12 text-center">
							<button type="submit" id="signIn_btn" class="btn btn-default">SIGN UP</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 로그인 Modal -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<h2 class="text-center">LOGIN</h2>
				<form action="login_form" method="post" class="form-horizontal" name="loginForm" id="loginForm">
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8 text-center">
							<input type="text" class="form-control input_text" name="user_id" placeholder="ID" id="user_id">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8 text-center">
							<input type="password" class="form-control input_text" name="user_pw" placeholder="PASSWORD" id="user_pw">
							<input type="hidden" name="user_email" id="user_email" />
						</div>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="form-group">
						<div class="col-sm-12 text-center">
							<button type="submit" id="loginForm_btn" class="btn btn-default">LOGIN</button>
						</div>
					</div>
				</form>
				<div class="g-signin2" data-onsuccess="onSignIn"></div>
			</div>
		</div>
	</div>
	<!-- 탭추가 Modal -->
	<div class="modal fade" id="AddTabModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="container">
			<div class="row">
				<div id="tabForm">
					<h1 class="tabH1">ADD TAB</h1>
					<input placeholder="TAB NAME" type="input" required="" id="tabInput">
					<button class="tabadd-btn" id="tabAddBtn">ADD</button>
					<br>
					<br>
					<button class="tabadd-btn" id="tabCloseBtn">CLOSE</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 탭뮤직 추가 Modal -->
	<div class="portfolio-modal modal fade" id="AddTabMusicModal" tabindex="-1"	role="dialog" aria-hidden="true">
		<div class="modal-content">
			<div class="close-modal" data-dismiss="modal">
				<div class="lr">
					<div class="rl"></div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-center">
						<h1 class="tabH1">ADD MUSIC</h1>
						<div class="row">
							<div class="col-xs-6 text-center add-tab add-tab-list add-tab-list-none">
								<span class="add-tab-mylist" title="tabMusic-list">MY LIST</span>
							</div>
							<div class="col-xs-6 text-center add-tab add-tab-list">
								<span class="add-tab-100list" title="tabMusic-100list">TOP 100</span>
							</div>
						</div>
						<div class="col-lg-12 text-center add-tab-table" id="tabMusic-list">
							<table class="table hoverList" id="tabAllList">
								<c:forEach var="list" items="${list }">
									<tr>
										<td id="${list.music_id }" class="tab-click tab-list">${list.music_name }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="col-lg-12 text-center add-tab-table" id="tabMusic-100list">
							<table class="table hoverList" id="tab100AllList">
								<c:forEach var="top100" items="${top100 }" varStatus="status">
									<tr>
										<td class="top100-ranking">${status.count}</td>
										<td id="${top100.music_id }" class="tab-click tab-list-top100">${top100.music_name }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<button class="tabadd-btn" id="tabMusicAddBtn">ADD</button>
						<button class="tabadd-btn" id="tabMusicCloseBtn">CLOSE</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 검색 Modal 보류.... -->
	<!-- <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="container">
			<div class="row">
				<div id="searchForm">
					<h2 class="text-center">SEARCH</h2>
						<input type="text" class="form-control" placeholder="KEY WORD" id="searchKey">
						<button type="button" class="btn btn-lg btn-default" id="searchBtn">
							<span class="fa fa-search"></span>
						</button>
						<div class="control-group text-center result-Scroll" id="searchResult"></div>
				</div>
			</div>
		</div>
	</div> -->
	<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<h2 class="text-center">SEARCH</h2>
				<div id="searchForm">
					<div class="form-group">
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="KEY WORD" id="searchKey">
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-lg btn-default" id="searchBtn"><span class="fa fa-search"></span></button>
						</div>
						<div class="control-group text-center result-Scroll" id="searchResult"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>