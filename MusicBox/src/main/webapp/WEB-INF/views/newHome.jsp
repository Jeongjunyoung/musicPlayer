<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="/../resources/css/bootstrap.min.css" rel="stylesheet">
	<!-- Theme CSS -->

	<link rel="stylesheet" type="text/css" href="/../resources/css/sweetalert.css">

	<!-- jQuery -->
	<script src="/../resources/js/jquery.min.js"></script>
	<!-- Theme -->
	<script src="/../resources/js/sweetalert.min.js"></script>
	
<style type="text/css">
*,
*:after,
*:before {
  box-sizing: border-box;
}
a {
  text-decoration: none;
}

.Button__textWrapper, .Button__text, .Button__icon {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
}

.Button__text, .Button__icon {
  -webkit-transition: top 500ms;
  transition: top 500ms;
}

.Button {
  display: inline-block;
  position: relative;
  background-color: #0CBABA;
  color: black;
  font-size: 1.4rem;
  border-radius: 1000px;
  width: 200px;
  height: 60px;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.7), inset 0 1px rgba(255, 255, 255, 0.3);
  text-align: center;
  -webkit-transition: background-color 500ms, -webkit-transform 100ms;
  transition: background-color 500ms, -webkit-transform 100ms;
  transition: background-color 500ms, transform 100ms;
  transition: background-color 500ms, transform 100ms, -webkit-transform 100ms;
}
.Button__textWrapper {
  overflow: hidden;
}
.Button__text {
  line-height: 60px;
  top: 0;
}
.login-icon {
  top: 100%;
  background: url("/../resources/images/tab/login.png") no-repeat center center;
}
.search-icon {
  top: 100%;
  background: url("/../resources/images/tab/search.png") no-repeat center center;
}
.Button::before {
  content: attr(data-tooltip);
  width: 140px;
  height: 60px;
  background-color: #EEB868;
  font-size: 1rem;
  border-radius: .25em;
  line-height: 60px;
  bottom: 90px;
  left: calc(50% - 70px);
}
.Button::after {
  content: '';
  width: 0;
  height: 0;
  border: 10px solid transparent;
  border-top-color: #EEB868;
  left: calc(50% - 10px);
  bottom: 70px;
}
.Button::before, .Button::after {
  position: absolute;
  opacity: 0;
  -webkit-transition: all 500ms;
  transition: all 500ms;
  visibility: hidden;
}
.Button:hover {
  background-color: #01BAEF;
}
.Button:hover .Button__text {
  top: -100%;
}
.Button:hover .Button__icon {
  top: 0;
}
.Button:hover::before, .Button:hover::after {
  opacity: 1;
  visibility: visible;
}
.Button:hover::after {
  bottom: 60px;
}
.Button:hover::before {
  bottom: 80px;
}
.Button:active {
  -webkit-transform: translate(2px, 2px);
          transform: translate(2px, 2px);
}
</style>
<script type="text/javascript">
$(function(){
	$('.Button').click(function(){
		var case_str = $(this).find('.Button__text').html();
		swal(str, "Click", "success");
	})
})
</script>
<title>JSP</title>
</head>
<body>
	<a class="Button"><span class="Button__textWrapper"><span class="Button__text">LOGIN</span><span
			class="Button__icon login-icon" aria-hidden="true"></span></span></a>
	<a class="Button"><span class="Button__textWrapper"><span class="Button__text">SEARCH</span><span
			class="Button__icon search-icon" aria-hidden="true"></span></span></a>
	
</body>
</html>