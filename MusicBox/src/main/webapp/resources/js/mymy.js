	var arr = [];
	var repeatArr = [];
	var editArr = [];
	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	var player;
	var replay = 'normal';
	var shuffle = true;
	var volume = true;
	var edit = false;
	//ajax 처리
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
	function onYouTubeIframeAPIReady() {
		player = new YT.Player('player', {
		   height: '200',
		   width: '340',
		   events: {
		     'onReady': onPlayerReady,
		     'onStateChange': onPlayerStateChange
		   }
		});
	}
	function changeListBlock(index){
		var getPlaylist = player.getPlaylist();
		$('.clickList-td').each(function(){
			if($(this).attr('id') == getPlaylist[index]){
				$(this).addClass('now-playing');
			}
		})
	}
	function onPlayerReady(event,index) {
		if(index == undefined){
			index = 0;
		}
		player.loadPlaylist(arr,index);
		player.setLoop(true);
		$('.clickList-td').each(function(){
			if($(this).attr('id') == arr[index]){
				$(this).addClass('now-playing');
			}
		})
	}	
	function onPlayerStateChange(event) {
		if(player.getPlayerState()==0){
			if(replay == 'true'){
				player.loadPlaylist(repeatArr,0);
				player.setLoop(true);
			}else if(replay == 'false'){
				var id = get_playing_id();
				var index=0;
				for(var i=0;i<arr.length;i++){
					if(arr[i] == id){
						index = i+1;
					}
				}
				$('.clickList-td').removeClass('now-playing');
				changeListBlock(index);
				onPlayerReady(event,index);
				replay = 'normal';
			}else if(replay == 'normal'){
				var index = player.getPlaylistIndex();
				$('.clickList-td').removeClass('now-playing');
				changeListBlock(index);
			}
		}
	}
	//로그인 NULL값 체크
	function checkFields(){
		var txtEle = $("#frm input").not(":input[type=hidden]");
		for(var i = 0; i < txtEle.length; i ++){
			if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
				var title = $(txtEle[i]).attr("title");
				swal("Login Failed...", title + "을(를) 입력하세요", "error");
				return false;
			}
		}
		return true;
	}
	//재생중인 노래 id 가져오기
	function get_playing_id(){
		var id='';
		$('.clickList-td').each(function(){
			if($(this).hasClass('now-playing')){
				id = $(this).attr('id');						
			}
		})
		return id;
	}
	//볼륨 컨트롤
	function audio_btn(){
		var src = '/../resources/images/audio';
		if(volume){
			player.mute();
			volume = false;
			$('#audioBtn').attr('src',src+'-off.png');
		}else{
			player.unMute();
			volume = true;
			$('#audioBtn').attr('src',src+'.png');
		}
	}
	//랜덤 재생
	function shufflePlay(){
		if(shuffle){
			player.setShuffle(shuffle);
			player.setLoop(true);
			shuffle = false;
			$('#shuffleBtn').addClass('videoBtn-click');
		}else{
			player.setShuffle(shuffle);
			player.setLoop(true);
			shuffle = true;
			$('#shuffleBtn').removeClass('videoBtn-click');
		}
	}
	function playVideo(){ //Play 버튼 클릭 이벤트
		player.playVideo();
		$('#playBtn').css('display','none');
		$('#stopBtn').css('display','inline');    	
	}
    function pauseVideo(){ //Pause 버튼 클릭 이벤트
    	player.pauseVideo();
    	$('#stopBtn').css('display','none');
    	$('#playBtn').css('display','inline');
    }
    function changeVideo(video_ID){ //음악 변경 이벤트
    	for(var i=0;i<arr.length;i++){
    		if(arr[i] == video_ID){
    			player.loadPlaylist(arr,i);
    			player.setLoop(true);
    		}
    	}
    }
    function errorHandle(data){
		swal("Add Failed...", "로그인 해주세요.", "error");
		$('.checkAdd').slideUp();
	}
	//재생목록 추가 ajax 처리
	function addPlayListHandle(data){
		swal("Add Success!!", "음악을 추가하였습니다.", "success");
		$('.checkAdd').slideUp();
		$.each(data, function(index,value){
			var td = '<tr class='+"playList-td"+' id='+"playList-add"+'><td id='+value.music_id+' class='+"clickList-td"+'>'+ value.music_name +'</td></tr>';
			$('#playList').append(td);
			arr.push(value.music_id);
		})
	}
	//로그인시  플레이리스트 arr배열에 노래 추가
	function getPlayListHandle(data){
		$.each(data, function(index, value){
			arr.push(value.music_id);
		})
	}
	function searchHandler(data){
	 	var id_arr = [];
	 	var title_arr = [];
	 	var html = '';
	 	$('#searchResult').empty();
		$.each(data.items,function(index, value, key){
			id_arr[index] = value.id.videoId;
			title_arr[index] = value.snippet.title;
		})
		for(var i=0;i<id_arr.length;i++){
			html += '<p id='+ id_arr[i] +' class='+ "searchList" +' name='+"title_name"+'>'+title_arr[i]+'</p>';
			html += '<button class='+"checkAdd"+'><span class='+"cheak-span"+'></span></button>';
		}
		$('#searchResult').html(html);
		$('.checkAdd').addClass('btn');
		$('.checkAdd').addClass('btn-sm');
		$('.checkAdd').addClass('btn-info');
		$('.cheak-span').addClass('fa');
		$('.cheak-span').addClass('fa-plus');
	}
	$(function(){
		//DEL 버튼
		$('#delBtn').click(function(){
			if(editArr.length == 0){
				swal("Delete Failed...", "삭제할 음악을 선택하세요.", "error");
			}else{
				var url = 'delPlayList?editArr='+editArr;
				swal({
					  title: "삭제하시겠습니까?",
					  text: "다시 한번 확인해주세요!",
					  type: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#DD6B55",
					  confirmButtonText: "Yes, delete it!",
					  closeOnConfirm: false,
					  html: false
					}, function(){
					  swal("삭제하였습니다!",
					  "음악들이 삭제되었습니다.",
					  "success");
					  $(location).attr('href',url);
				});
			}
		})
		
		//EDIT 버튼
		$('#editBtn').click(function(){
			edit = true;
			if($(this).css('display') != 'none'){
				$(this).hide();
				$('.delCancelBtn').show();
			}
		})
		//CANCEL 버튼
		$('#cancelBtn').click(function(){
			edit = false;
			$('.clickList-td').removeClass('edit-click');
			$('.delCancelBtn').hide();
			$('#editBtn').show();
		})
		//MYMY 기본
		var login = $('#loginFail').val();
		var user_id = $('#login_id').val();
		var url2 = 'getPlayList?user_id='+user_id;
		ajax_load("GET", url2, null,"json", getPlayListHandle);
		//로그인 실패시
		if(login == "true"){
			$('#loginModal').modal();
			swal("Login Failed...", "아이디와 비밀번호를 확인하세요.", "error");
		}
		//로그인  submit
		$('#frm').submit(function(){
			var result = checkFields();
			if(result == false){
				return false;
			}
		})
		//검색 이벤트들...
		$('#searchResult').on('click','p',function(){
			$('.searchList').removeClass('search-click');
			$('.checkAdd').slideUp();
			$(this).addClass('search-click');
			$(this).next().slideDown();
		})
		//리스트 클릭 이벤트
		$('#playList').on('click', 'td', function(){
				var video_ID = $(this).attr('id');
				var $this = $(this);
			if(edit){
				if($this.hasClass('edit-click')){
					$this.removeClass('edit-click');
					for(var i=0;i<editArr.length;i++){
						if(editArr[i] == video_ID){
							editArr.splice(i, 1)
						}
					}
				}else{
					$this.addClass('edit-click');
					editArr.push(video_ID);
				}
			}else{
				$('.clickList-td').removeClass('now-playing');
				$this.addClass('now-playing');
				changeVideo(video_ID);
			}
		})
		//검색 버튼 이벤트
		$('#searchKey').keydown(function(){
			var q = $(this).val();
			searchEvent(q);
		})
		$('#searchBtn').click(function(){
			var q = $('#searchKey').val();
			searchEvent(q);
		})
		function searchEvent(q){
			var url = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyAueMXgFyZOx_OFGSEca-S1FdCygGHR51k&maxResults=20";
			url += '&q='+q;
			ajax_load("GET", url, null, "json", searchHandler);
		}
		//체크 선택 추가 이벤트
		$('#searchResult').on('click', 'button',function(){
			console.log('click');
			var add_id = '';
			var encode_title = '';
			var url = "addPlayList?";
			$(".searchList").each(function() {
				if($(this).hasClass('search-click')){
					add_id = $(this).attr('id');
					encode_title = escape(encodeURIComponent($(this).text()));
				}
			})
			if(add_id == '' || add_id == null){
				swal("Add Failed...", "추가할 음악을 선택하세요.", "error");
			}else{
				ajax_load("GET", url+"music_id="+add_id+"&music_name="+encode_title, null, "json", addPlayListHandle, errorHandle);
				$('.searchList').removeClass('search-click');
			}
		})
		//버튼 마우스 HOVER
		$('.video-btn').hover(function(){
			var img = $(this).attr('name');
			var img_url_hover = '/../resources/images/hover/'+img+'-hover.png';
			$(this).attr('src',img_url_hover);
		},function(){
			var img = $(this).attr('name');
			var img_url = '/../resources/images/'+img+'.png';
			$(this).attr('src',img_url);
		})
		
		//한곡 반복 재생
		$('#replayBtn').click(function(){
			if(replay == 'false' || replay == 'normal'){
				$(this).addClass('videoBtn-click');
				repeatArr[0] = get_playing_id();
				replay = 'true';
			}else if(replay){
				$(this).removeClass('videoBtn-click');
				replay = 'false';
			}
		})
	})