<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>



	<!-- Bootstrap Core CSS -->
    <link href="/../resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <!-- Theme CSS -->
    
    <link href="/../resources/css/freelancer.min.css" rel="stylesheet">
    <link href="/../resources/css/mymy.css" type="text/css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/../resources/css/sweetalert.css">
	
    <!-- Custom Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
	<link href="http://fonts.googleapis.com/css?family=Architects+Daughter" rel="stylesheet">
	
<style type="text/css">

body {
  font-family: 'Architects Daughter', sans-serif;
}

#paper-back {
  width: 100%;
  height: 100vh;
  background-color: #243040;
  position: fixed;
  top: 0;
  left: 0;
  font-size: 33px;
}
#paper-back nav {
  padding: 120px 34px;
}
#paper-back nav a {
  display: block;
  margin-bottom: 25px;
  text-decoration: none;
  color: rgba(255, 255, 255, 0.7);
}

#paper-window {
  height: 100vh;
  width: 100vw;
  position: relative;
  overflow-x: hidden;
  overflow-y: scroll;
  z-index: 2;
}
#paper-window.tilt {
  overflow: hidden;
  pointer-events: none;
}
#paper-window.tilt #paper-front {
  -webkit-transform: rotate(10deg) translateZ(0);
          transform: rotate(10deg) translateZ(0);
}

#paper-front {
  pointer-events: auto;
  position: relative;
  z-index: 3;
  background-color: white;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.7);
  -webkit-transform-origin: center 70%;
          transform-origin: center 70%;
  -webkit-transition: all 0.3s ease;
  transition: all 0.3s ease;
}

#container section {
  height: 600px;
  text-align: center;
}
#container section:first-of-type {
  padding-top: 10vh;
}
#container section:first-of-type h1 {
  font-size: 45px;
}
#container section:first-of-type p {
  font-size: 25px;
}
@media (max-width: 600px) {
  #container section:first-of-type {
    padding-top: 15vh;
  }
  #container section:first-of-type h1 {
    font-size: 30px;
  }
  #container section:first-of-type p {
    font-size: 18px;
  }
}
#container section:nth-of-type(2n) {
  background-color: #edf1f5;
}

.hamburger {
  position: fixed;
  z-index: 4;
  top: 30px;
  left: 30px;
  width: 45px;
  height: 34px;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
}
.hamburger span {
  position: relative;
}
.hamburger span, .hamburger span:before, .hamburger span:after {
  display: block;
  width: 45px;
  height: 6px;
  background-color: #243040;
  border-radius: 2px;
}
.hamburger span:before, .hamburger span:after {
  content: '';
  position: absolute;
}
.hamburger span:before {
  bottom: -14px;
}
.hamburger span:after {
  bottom: -28px;
}

.close {
  position: fixed;
  top: 30px;
  left: 30px;
  width: 45px;
  height: 34px;
  cursor: pointer;
}
.close:before, .close:after {
  content: '';
  position: absolute;
  display: block;
  width: 45px;
  height: 6px;
  top: 50%;
  background-color: white;
  border-radius: 2px;
}
.close:before {
  -webkit-transform: translateY(-50%) rotate(45deg);
          transform: translateY(-50%) rotate(45deg);
}
.close:after {
  -webkit-transform: translateY(-50%) rotate(-45deg);
          transform: translateY(-50%) rotate(-45deg);
}
</style>
</head>
<body>
<div id="paper-back">
	<nav>
		<div class="close"></div>
		<a href="#home-section" id="home-a" class="paper-menu">Home</a>
		<a href="#playList-section" id="playlist-a" class="paper-menu">Play List</a>
		<a href="#search-section" id="search-a" class="paper-menu">Search</a>
		<a href="#loginModal" data-toggle="modal" id="loginBtn">LOGIN</a>
		<a href="#signUpModal" data-toggle="modal">SIGN UP</a>
	</nav>
</div>
<div id="paper-window">
	<div id="paper-front">
		<div class="hamburger"><span></span></div>
		<div id="container">
			<section id="home-section">
				<div class="container">
					<div class="row">
						<c:choose>
							<c:when test="${session == true }">
								<div class="col-lg-12">
									<span class="skills section-title">PLAYING NOW</span>
									<div class="intro-text" id="player"></div>
									<br><br><br>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-lg-12">
									<span class="skills section-title">PLAYING NOW</span><br>
									<span class="skills" id="login-plz">LOGIN PLEASE..</span>
									<input type="hidden" value="${loginFail }" id="loginFail"> <br>
									<br><br>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="row">
						<div class="col-xs-1 col-md-offset-4">
							<img src="/../resources/images/play.png"
								class="img-responsive video-btn" onclick="playVideo()"
								id="playBtn" name="play"> <img
								src="/../resources/images/pause.png"
								class="img-responsive video-btn" onclick="pauseVideo()"
								id="stopBtn" name="pause">
						</div>
						<div class="col-xs-1">
							<img src="/../resources/images/shuffle.png"
								class="img-responsive video-btn" onclick="shufflePlay()"
								id="shuffleBtn" name="shuffle">
						</div>
						<div class="col-xs-1">
							<img src="/../resources/images/repeat-one.png"
								class="img-responsive video-btn" id="replayBtn"
								name="repeat-one">
						</div>
						<div class="col-xs-1">
							<img src="/../resources/images/audio.png" class="img-responsive"
								onclick="audio_btn()" id="audioBtn" name="audio">
						</div>
					</div>
				</div>
				</section>
			<section id="playList-section">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-center">
							<span class="skills section-title">PLAY LIST</span>
						</div>
						<div class="col-lg-12 text-center">
							<button class="btn btn-lg btn-info hideBtn" id="editBtn">EDIT</button>
							<button class="btn btn-lg btn-info hideBtn" id="btn-add-tab">ADD TAB</button>
						</div>
						<div class="col-lg-12 text-center">
							<button class="btn btn-lg btn-danger delCancelBtn" id="delBtn">DELETE</button>
							<button class="btn btn-lg btn-info delCancelBtn" id="cancelBtn">CANCEL</button>
						</div>
					</div>
					<div class="container">
						<div class="row">
							<div class="col-md-12">
								<!-- Nav tabs -->
								<ul id="tab-list" class="nav nav-tabs" role="tablist">
									<li><a href="#tab1" role="tab" data-toggle="tab">TOP
											100</a></li>
									<li class="tab active"><a href="#tab2" role="tab"
										data-toggle="tab" id="a-tab2">MY LIST</a></li>
									<c:forEach var="tabs" items="${tabs }">
										<li class="tab"><a href="#${tabs.tab_id }" role="tab"
											data-toggle="tab">${tabs.tab_name }<button
													class="close delete-tab" type="button"
													title="Remove this page">×</button></a></li>
									</c:forEach>
								</ul>
								<!-- Tab panes -->
								<div id="tab-content">
									<div class="tab-pane fade top100-list" id="tab1">
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
									<div class="tab-pane fade in active user-list" id="tab2">
										<table class="table hoverList" id="playList">
											<c:forEach var="list" items="${list }">
												<tr class="playList-td" id="playList-add">
													<td id="${list.music_id }" class="clickList-td">${list.music_name }</td>
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
															<td id="${tabMusic.tabs_music_id }" class="clickList-td">${tabMusic.tabs_music_name }</td>
														</tr>
													</c:if>
												</c:forEach>
											</table>
											<div class="col-lg-12 text-center">
												<button class="btn btn-lg btn-info tadAddMusic">ADD MUSIC</button>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
				</section>
			<section id="search-section">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-center">
							<span class="skills section-title">SEARCH</span>
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
				</section>
		</div>
	</div>
</div>
    <!-- 회원가입 Modal -->
    <div class="portfolio-modal modal fade" id="signUpModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
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
										<input type="password" title="PASSWORD" class="form-control input_text" name="user_pw" id="input_pw" placeholder="PASSWORD">
									</div>
								</div>
								<div class="form-group">																
									<div class="col-sm-12">
										<input type="email" title="E-MAIL" class="form-control input_text" name="user_email" id="input_email" placeholder="E-MAIL">
									</div>
								</div>
								<input type="hidden" title="HIDDEN" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" id="signIn_btn" class="btn btn-default">SIGN UP</button>
							</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 로그인 Modal -->
    <div class="portfolio-modal modal fade" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <h2>LOGIN</h2>
                            <hr class="star-primary">
                            <form action="login_form" method="post" class="form-horizontal" name="loginForm" id="loginForm">
                            	<div class="form-group">
									<div class="col-sm-12">
										<input type="text" class="form-control input_text" name="user_id" placeholder="ID" id="user_id">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input type="password" class="form-control input_text" name="user_pw" placeholder="PASSWORD" id="user_pw">
										<input type="hidden" name="user_email" id="user_email"/>
									</div>
								</div>
								<input type="hidden"   name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" id="loginForm_btn" class="btn btn-default">LOGIN</button>
							</form>
							<div class="g-signin2" data-onsuccess="onSignIn"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<div class="modal fade" id="AddTabModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="container">
			<div class="row">
				<div id="tabForm">
					<h1 class="tabH1">ADD TAB</h1>
					<input placeholder="TAB NAME" type="input" required="" id="tabInput">
					<button class="tabadd-btn" id="tabAddBtn">ADD</button><br><br>
					<button class="tabadd-btn" id="tabCloseBtn">CLOSE</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="AddTabMusicModal" tabindex="-1" role="dialog" aria-hidden="true">
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
	</div>
	<!-- jQuery -->
    <script src="/../resources/js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/../resources/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script	src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	
    <!-- Contact Form JavaScript -->
    <script src="/../resources/js/mymy.js"></script>
    <script src="/../resources/js/mymySocial.js"></script>
    <script src="/../resources/js/testPage.js"></script>

    <!-- Theme JavaScript -->
    <script src="/../resources/js/freelancer.min.js"></script>
	<script src="/../resources/js/sweetalert.min.js"></script>
	<script src="/../resources/js/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	
	<!-- Google API -->
	<script src="https://apis.google.com/js/platform.js" async defer></script>
</body>
</html>