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

    <title>Freelancer - Start Bootstrap Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="/../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Theme CSS -->
    <link href="/../resources/css/freelancer.min.css" rel="stylesheet">
    <link href="/../resources/css/musicBox.css" type="text/css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/../resources/css/font-awesome.min.css" rel="stylesheet" type="text/css">
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
                <c:choose>
					<c:when test="${session == true }">
						<a class="navbar-brand" href="#page-top">${sessionScope.userSession.user_id}'s MY MY</a>
						<input type="hidden" value="${sessionScope.userSession.user_id}" id="login_id">
						<!-- button type="button" id="logout_btn" class="btn btn-default">로그아웃</button> -->
					</c:when>
					<c:otherwise>
						<a class="navbar-brand" href="#page-top">MY MY</a>
						<!-- <button type="button" id="login_btn" class="btn btn-default" data-toggle="modal" data-target="#login_paper">로그인</button> -->
					</c:otherwise>
				</c:choose>                
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li class="page-scroll">
                        <a href="#portfolio">PLAYLIST</a>
                    </li>
                    <li class="page-scroll">
                        <a href="#about">SEARCH</a>
                    </li>                    
                    <li class="page-scroll">
	                    <c:choose>
	                    	<c:when test="${session == true }">
	                    		<a href="logout">LOGOUT</a>                    		
	                   		</c:when>
	                   		<c:otherwise>
	                   			<a href="#loginModal" data-toggle="modal">LOGIN</a>
	                   		</c:otherwise>
	                    </c:choose>
                    </li>
                    <li class="page-scroll">
                        <a href="#signUpModal" data-toggle="modal">SIGN UP</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <!-- Header -->
    <header>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                	<span class="skills">PLAYING NOW</span>
               		<hr class="star-light">
                    <div class="intro-text" id="player"></div>
                    <br><br><br>
                </div>
			</div>
			<div class="row">
                <div class="col-md-1 col-md-offset-4">
                	<img src="/../resources/images/play.png" class="img-responsive video-btn" onclick="playVideo()" id="playBtn" name="play">
                	<img src="/../resources/images/pause.png" class="img-responsive video-btn" onclick="pauseVideo()" id="stopBtn" name="pause">
                </div>
                <div class="col-md-1">
                	<img src="/../resources/images/shuffle.png" class="img-responsive video-btn" onclick="shufflePlay()" id="shuffleBtn" name="shuffle">
                </div>
                <div class="col-md-1">
                	<img src="/../resources/images/repeat-one.png" class="img-responsive video-btn" id="replayBtn" name="repeat-one">
                </div>
                <div class="col-md-1">
                	<img src="/../resources/images/audio.png" class="img-responsive" onclick="audio_btn()" id="audioBtn" name="audio">
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
                    <hr class="star-primary">
                </div>
            </div>
            <div id="playList_scroll" class="row">
            	<table class="table table-hover hoverList" id="playList">
            		<tr class="playList-th">
            			<td>TITLE</td>
            		</tr>
            		<c:forEach var="list" items="${list }">
	            		<tr class="playList-td">
	            			<td id="${list.music_id }" class="clickList-td">${list.music_name }</td>
	            		</tr>
	            	</c:forEach>
            	</table>
            </div>
        </div>
    </section>

    <!-- Search Section -->
    <section class="success" id="about">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>SEARCH</h2>
                    <hr class="star-light">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center">
                	<p>SEARCH LIST</p>
                </div>
                <div class="col-lg-8 col-lg-offset-2">
	                <div class="row control-group text-center">
						<div class="form-group col-xs-8 floating-label-form-group controls">
						    <label>searchKey</label>
						    <input type="text" class="form-control" placeholder="Word" id="searchKey">
						</div>
						<div class="form-group col-xs-2 controls">
							<button type="button" class="btn btn-xs btn-outline" id="searchBtn">SEARCH</button>
	                	</div>
						<div class="form-group col-xs-2 controls">
							<button type="button" class="btn btn-xs btn-outline" id="checkAdd">ADD</button>
	                	</div>
	                </div>
	                <div class="row control-group text-center result-Scroll" id="searchResult">
	                	
	                </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>Contact Me</h2>
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
                    <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
                    <form name="sentMessage" id="contactForm" novalidate>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>Name</label>
                                <input type="text" class="form-control" placeholder="Name" id="name" required data-validation-required-message="Please enter your name.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>Email Address</label>
                                <input type="email" class="form-control" placeholder="Email Address" id="email" required data-validation-required-message="Please enter your email address.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>Phone Number</label>
                                <input type="tel" class="form-control" placeholder="Phone Number" id="phone" required data-validation-required-message="Please enter your phone number.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>Message</label>
                                <textarea rows="5" class="form-control" placeholder="Message" id="message" required data-validation-required-message="Please enter a message."></textarea>
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <br>
                        <div id="success"></div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <button type="submit" class="btn btn-success btn-lg">Send</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="text-center">
        <div class="footer-above">
            <div class="container">
                <div class="row">
                    <div class="footer-col col-md-4">
                        <h3>Location</h3>
                        <p>3481 Melrose Place
                            <br>Beverly Hills, CA 90210</p>
                    </div>
                    <div class="footer-col col-md-4">
                        <h3>Around the Web</h3>
                        <ul class="list-inline">
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-facebook"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-google-plus"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-twitter"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-linkedin"></i></a>
                            </li>
                            <li>
                                <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-dribbble"></i></a>
                            </li>
                        </ul>
                    </div>
                    <div class="footer-col col-md-4">
                        <h3>About Freelancer</h3>
                        <p>Freelance is a free to use, open source Bootstrap theme created by <a href="http://startbootstrap.com">Start Bootstrap</a>.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-below">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        Copyright &copy; 2016, BokGyu All Rights Reserved.
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-top page-scroll hidden-sm hidden-xs hidden-lg hidden-md">
        <a class="btn btn-primary" href="#page-top">
            <i class="fa fa-chevron-up"></i>
        </a>
    </div>

    <!-- Portfolio Modals -->
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
                            <form action="sign_in" method="post" class="form-horizontal">
								<div class="form-group">
									<div class="col-sm-12">
										<input type="text" class="form-control input_text" name="user_id" id="input_id" placeholder="ID">
									</div>
								</div>
								<div class="form-group">									
									<div class="col-sm-12">
										<input type="password" class="form-control input_text" name="user_pw" id="input_pw" placeholder="PASSWORD">
									</div>
								</div>
								<div class="form-group">																
									<div class="col-sm-12">
										<input type="email" class="form-control input_text" name="user_email" id="input_email" placeholder="E-MAIL">
									</div>
								</div>
								<button type="submit" id="signIn_btn" class="btn btn-default">SIGN IN</button>
							</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                            <form action="login_form" method="post" class="form-horizontal">
                            	<div class="form-group">
									<div class="col-sm-12">
										<input type="text" class="form-control input_text" name="user_id" placeholder="ID">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input type="password" class="form-control input_text" name="user_pw" placeholder="PASSWORD">
									</div>
								</div>
								<button type="submit" id="loginForm_btn" class="btn btn-default">LOGIN</button>
							</form>
                        </div>
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

    <!-- Contact Form JavaScript -->
    <script src="/../resources/js/jqBootstrapValidation.js"></script>
    <script src="/../resources/js/musicBox.js"></script>
    <script src="/../resources/js/contact_me.js"></script>

    <!-- Theme JavaScript -->
    <script src="/../resources/js/freelancer.min.js"></script>

</body>

</html>
