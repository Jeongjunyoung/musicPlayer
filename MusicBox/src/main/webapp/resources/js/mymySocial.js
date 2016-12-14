function ajax_load(type,url,data,dataType,success,error){
		$.ajax({
			type : type,
			url : url,
			data : data,
			dataType : dataType,
			success : success,
			error : error
		})
	}
//구글 로그인
function onSignIn(googleUser){
	var profile = googleUser.getBasicProfile();
	var googleArr = [];
	var encodeName = escape(encodeURIComponent(profile.getName()));
	var id_token = googleUser.getAuthResponse().id_token;
	var google_user = $('#google_user').val();
	googleArr.push(id_token);
	googleArr.push(encodeName);
	googleArr.push(profile.getEmail());
	$('#user_id').val(encodeName);
	$('#user_pw').val(id_token);
	$('#user_email').val(profile.getEmail());
	var url = 'googleLogin?googleArr='+googleArr;
	var queryString = $('#loginForm').serialize();
	if(google_user != 'trueS'){
		ajax_load('post', 'googleLogin', queryString, 'json', googleHandler);
	}
}
function googleHandler(){
	$(location).attr('href','googleSet');
}
//구글 로그아웃
function signOut(){
	var google_user = $('#google_user').val();
	if(google_user == 'trueS'){
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function () {
			$(location).attr('href','logout');
		});
	}
}