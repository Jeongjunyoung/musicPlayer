<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-site-verification" content="60I7cWIaqvcVC_HneXrEvqvbUD99KqLcdRmOnNUhexA">
<meta name="google-signin-client_id" content="222457887868-9bofjnk09tuuc2v2cgedclv7nu6c868n.apps.googleusercontent.com">
<title>Google Login..</title>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript">
function onSignIn(googleUser){
	var profile = googleUser.getBasicProfile();
	$('#id').html(profile.getId());
	$('#name').html(profile.getName());
	$('#email').html(profile.getEmail());
	$('#image_url').html(profile.getImageUrl());
}
function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function () {
		alert('User signed out.');
	});
}
</script>
</head>
<body>
<div class="g-signin2" data-onsuccess="onSignIn"></div>
<a href="#" onclick="signOut();">Sign out</a>
<br/>
id : <span id="id"></span><br/>
name : <span id="name"></span><br/>
email : <span id="email"></span><br/>
<img id="image_url" src="#">
</body>
</html>