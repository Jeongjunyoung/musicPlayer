	var arr = [];
	var repeatArr = [];
	var tag = document.createElement('script');
	
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	
	var player;
	var replay = 'normal';
	var shuffle = true;
	var volume = true;
	
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
	//재생중인 노래 id 가져오기
	function get_playing_id(){
		var id='';
		$('.clickList-td').each(function(){
			if($(this).attr('class') == 'clickList-td now-playing'){
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
    /*var array = [];
	var title_array = [];*/
	$(function(){
		var logout = $('#logoutFail').val();
		if(logout == "true"){
			console.log('111');
			$('#loginModal').modal();
			alert('Login Fail');
		}
		
		var user_id = $('#login_id').val();
		var url2 = 'getPlayList?user_id='+user_id;
		$.ajax({
			type : "GET",
			url : url2,		
			dataType : "json",
			success : getPlayListHandle
		})
		//검색 이벤트들...
		$('#searchResult').on('click','p',function(){
			$('.searchList').removeClass('search-click');
			$(this).addClass('search-click');
		})
		$('#checkAdd').on('click', function(){ //체크 선택 추가 이벤트
			var add_id = '';
			var encode_title = '';
			var url = "addPlayList?";
			$(".searchList").each(function() {
				if($(this).attr('class') == 'searchList search-click'){
					add_id = $(this).attr('id');
					encode_title = escape(encodeURIComponent($(this).text()))
				}
			})
			$.ajax({
				type : "GET",
				url : url+"music_id="+add_id+"&music_name="+encode_title,
				dataType : "json",
				success : addPlayListHandle,
				error : errorHandle
			})
			$('.searchList').removeClass('search-click');
		})
		$('#playList').on('click', 'td', function(){ //리스트 클릭 이벤트
			var video_ID = $(this).attr('id');
			$('.clickList-td').removeClass('now-playing');
			$(this).addClass('now-playing');
			changeVideo(video_ID);
		})
		$('#searchBtn').click(function(){ //검색 버튼 이벤트
			console.log('aa');
			var url = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyAueMXgFyZOx_OFGSEca-S1FdCygGHR51k&maxResults=20";
			var q = $('#searchKey').val();
			url += '&q='+q;
			$.ajax({
					type : "GET",
					url : url,
					dataType : "json",
					success : successHandle
			})
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
	function errorHandle(data){
		alert('Sorry Server Error');
	}
	//재생목록 추가 ajax 처리
	function addPlayListHandle(data){
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
	function successHandle(data){
	 	var id_arr = [];
	 	var title_arr = [];
	 	var html = '';
	 	$('#searchResult').empty();
		$.each(data.items,function(index, value, key){
			id_arr[index] = value.id.videoId;
			title_arr[index] = value.snippet.title;
		})
		for(var i=0;i<id_arr.length;i++){
			//html += '<div class='+"searchList"+' id='+ id_arr[i] +'><p name='+"title_name"+'>'+title_arr[i]+'</p></div>';
			html += '<p id='+ id_arr[i] +' class='+ "searchList" +' name='+"title_name"+'>'+title_arr[i]+'</p>';
		}
		$('#searchResult').html(html);
	}