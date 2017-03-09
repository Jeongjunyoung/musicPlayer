<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta name="google-signin-scope" content="profile email">
<meta name="google-site-verification"
	content="60I7cWIaqvcVC_HneXrEvqvbUD99KqLcdRmOnNUhexA">
<meta name="google-signin-client_id"
	content="222457887868-9bofjnk09tuuc2v2cgedclv7nu6c868n.apps.googleusercontent.com">

<title>MYMY</title>
<!-- Bootstrap Core CSS -->
<link href="/../resources/css/bootstrap.min.css" rel="stylesheet">
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- Theme CSS -->

<link href="/../resources/css/freelancer.min.css" rel="stylesheet">
<link href="/../resources/css/mymy.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/../resources/css/sweetalert.css">

<!-- Custom Fonts -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body id="page-top" class="index">

	<!-- Navigation -->
	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top navbar-custom">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header page-scroll">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
			</button>
			<input type="hidden" id="google_user" value="${google_user}">
			<a class="navbar-brand" id="plaing-music-name"></a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li class="hidden"><a href="#page-top"></a></li>
				<li class="page-scroll"><a href="#portfolio">PLAYLIST</a></li>
				<li class="page-scroll"><a href="#searchModal" data-toggle="modal">SEARCH</a></li>
				<li class="page-scroll"><c:choose>
						<c:when test="${session == true }">
							<a href="logout" onclick="signOut();">LOGOUT</a>
						</c:when>
						<c:otherwise>
							<a href="#loginModal" data-toggle="modal" id="loginBtn">LOGIN</a>
						</c:otherwise>
					</c:choose></li>
				<li class="page-scroll"><a href="#signUpModal" data-toggle="modal">SIGN UP</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<!-- Header -->
	<header>
	<div class="container" id="play-view">
		<div class="row">
			<div class="col-lg-12">
				<hr class="star-light">
				<div class="intro-text" id="player"></div>
				<br><br><br>
			</div>
		</div>
		
	</div>
	</header>
	<!-- PLAY LIST Grid Section -->
	<section id="portfolio">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h2>PLAY LIST</h2>
			</div>
			<div class="col-lg-12 text-center">
				<button type="button" class="btn btn-lg" id="prevBtn"
					onclick="prevVideo()">
					<span class="fa fa-backward"></span>
				</button>
				<button type="button" class="btn btn-lg" id="playBtn"
					onclick="playVideo()">
					<span class="fa fa-play"></span>
				</button>
				<button type="button" class="btn btn-lg" id="stopBtn"
					onclick="pauseVideo()">
					<span class="fa fa-pause"></span>
				</button>
				<button type="button" class="btn btn-lg" id="nextBtn"
					onclick="nextVideo()">
					<span class="fa fa-forward"></span>
				</button>
				<button type="button" class="btn btn-lg" id="shuffleBtn"
					onclick="shufflePlay()">
					<span class="fa fa-random"></span>
				</button>
				<button type="button" class="btn btn-lg" id="replayBtn">
					<span class="fa fa-repeat"></span>
				</button>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<!-- Nav tabs -->
					<ul id="tab-list" class="nav nav-tabs" role="tablist">
						<li class="tab active"><a href="#tab1" role="tab" data-toggle="tab">TOP 100</a></li>
						<li><a href="#tab2" role="tab" data-toggle="tab" id="a-tab2">MY LIST</a></li>
						<c:forEach var="tabs" items="${tabs }">
							<li class="tab"><a href="#${tabs.tab_id }" role="tab" data-toggle="tab">${tabs.tab_name }
									<button class="btn btn-xs delete-tab" type="button" title="Remove this page">×</button>
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
								<c:forEach var="list" items="${list }">
									<tr class="playList-td" id="playList-add">
										<td id="${list.music_id }" class="clickList-td">${list.music_name }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<c:forEach var="tabs" items="${tabs }">
							<div class="tab-pane fade in active user-list"
								id="${tabs.tab_id }">
								<table class="table hoverList tab-playList">
									<c:forEach var="tabMusic" items="${tabMusic }">
										<c:if test="${tabMusic.tab_id == tabs.tab_id}">
											<tr class="playList-td">
												<td id="${tabMusic.tabs_music_id }" class="clickList-td">${tabMusic.tabs_music_name }</td>
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
		<div class="row">
			<br><br><br>
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
	</section>
	<!-- Search Section -->
	<!-- <section class="success" id="about">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h2>SEARCH</h2>
				<hr class="star-light">
			</div>
		</div>
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<div class="row control-group text-center">
					<div class="form-group col-xs-9 controls">
						<input type="text" class="form-control" placeholder="KEY WORD" id="searchKey">
					</div>
					<div class="col-xs-2">
						<button type="button" class="btn btn-lg btn-default" id="searchBtn">
							<span class="fa fa-search">
						</button>
					</div>
				</div>
				<div class="col-lg-12 text-center">
					<div class="row control-group text-center result-Scroll" id="searchResult"></div>
				</div>
			</div>
		</div>
	</div>
	</section> -->
	<!-- Footer -->
	<footer class="text-center">
	<div class="footer-below">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">Copyright &copy; 2016, BokGyu All Rights Reserved.</div>
			</div>
		</div>
	</div>
	</footer>

	<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
	<div
		class="scroll-top page-scroll hidden-sm hidden-xs hidden-lg hidden-md">
		<a class="btn btn-primary" href="#page-top"> <i class="fa fa-chevron-up"></i>
		</a>
	</div>

	<!-- 회원가입 Modal -->
	<div class="portfolio-modal modal fade" id="signUpModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-content">
			<div class="close-modal" data-dismiss="modal">
				<div class="lr">
					<div class="rl"></div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-lg-offset-2">
						<div class="modal-body">
							<h2>SIGN UP</h2>
							<hr class="star-primary">
							<form action="sign_in" method="post" class="form-horizontal" id="frm">
								<div class="form-group">
									<div class="col-sm-12">
										<input type="text" title="ID" class="form-control input_text" name="user_id" id="input_id" placeholder="ID">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input type="password" title="PASSWORD"
											class="form-control input_text" name="user_pw" id="input_pw"
											placeholder="PASSWORD">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input type="email" title="E-MAIL" class="form-control input_text" name="user_email"
											id="input_email" placeholder="E-MAIL">
									</div>
								</div>
								<input type="hidden" title="HIDDEN" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<button type="submit" id="signIn_btn" class="btn btn-default">SIGN UP</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 로그인 Modal -->
	<div class="portfolio-modal modal fade" id="loginModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-content">
			<div class="close-modal" data-dismiss="modal">
				<div class="lr">
					<div class="rl"></div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-lg-offset-2">
						<div class="modal-body">
							<h2>LOGIN</h2>
							<hr class="star-primary">
							<form action="login_form" method="post" class="form-horizontal"
								name="loginForm" id="loginForm">
								<div class="form-group">
									<div class="col-sm-12">
										<input type="text" class="form-control input_text"
											name="user_id" placeholder="ID" id="user_id">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input type="password" class="form-control input_text"
											name="user_pw" placeholder="PASSWORD" id="user_pw"> <input
											type="hidden" name="user_email" id="user_email" />
									</div>
								</div>
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<button type="submit" id="loginForm_btn" class="btn btn-default">LOGIN</button>
							</form>
							<div class="g-signin2" data-onsuccess="onSignIn"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="AddTabModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="container">
			<div class="row">
				<div id="tabForm">
					<h1 class="tabH1">ADD TAB</h1>
					<input placeholder="TAB NAME" type="input" required=""
						id="tabInput">
					<button class="tabadd-btn" id="tabAddBtn">ADD</button>
					<br>
					<br>
					<button class="tabadd-btn" id="tabCloseBtn">CLOSE</button>
				</div>
			</div>
		</div>
	</div>
	<%-- <div class="modal fade" id="AddTabMusicModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div id="AddtabForm">
						<h1 class="tabH1">ADD MUSIC</h1>
						<div class="col-lg-12 text-center" id="tabMusic-list">
							<table class="table hoverList" id="tabAllList">
								<c:forEach var="list" items="${list }">
									<tr>
										<td id="${list.music_id }" class="tab-list">${list.music_name }</td>
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
	</div>--%>
	<div class="portfolio-modal modal fade" id="AddTabMusicModal" tabindex="-1"
		role="dialog" aria-hidden="true">
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
	<div class="portfolio-modal modal fade" id="searchModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-content">
			<div class="close-modal" data-dismiss="modal">
				<div class="lr">
					<div class="rl"></div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-center">
						<h2>SEARCH</h2>
						<hr class="star-primary">
					</div>
				</div>
				<div class="row">
					<div class="col-lg-8 col-lg-offset-2">
						<div class="row control-group text-center">
							<div class="form-group col-xs-9 controls">
								<input type="text" class="form-control" placeholder="KEY WORD"
									id="searchKey">
							</div>
							<div class="col-xs-2">
								<button type="button" class="btn btn-lg btn-default"
									id="searchBtn">
									<span class="fa fa-search">
								</button>
							</div>
						</div>
						<div class="col-lg-12 text-center">
							<div class="row control-group text-center result-Scroll"
								id="searchResult"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- jQuery -->
	<script src="/../resources/js/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<!-- <script src="/../resources/js/bootstrap.min.js"></script> -->
	
	<!-- Plugin JavaScript -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	
	<!-- Theme JavaScript -->
	<script src="/../resources/js/mymy.js"></script>
	<script src="/../resources/js/mymySocial.js"></script>
	<script src="/../resources/js/freelancer.min.js"></script>
	<script src="/../resources/js/sweetalert.min.js"></script>
	
	<!-- Google API -->
	<script src="https://apis.google.com/js/platform.js" async defer></script>
</body>
</html>