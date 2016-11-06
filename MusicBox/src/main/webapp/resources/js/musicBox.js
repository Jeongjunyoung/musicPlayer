	var arr = [];
	var tag = document.createElement('script');
	
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	
	var player;
	var shuffle = true;
	function onYouTubeIframeAPIReady() {
		player = new YT.Player('player', {
		   height: '390',
		   width: '640',
		   events: {
		     'onReady': onPlayerReady,
		     'onStateChange': onPlayerStateChange
		   }
		});
	}	
	function onPlayerReady(event) {
		player.loadPlaylist(arr,0);
	}
	function onPlayerStateChange(event) {
		
	}
	//랜덤 재생
	function shufflePlay(){
		if(shuffle){
			player.setShuffle(true);
			shuffle = false;
			$('#shuffleBtn').addClass('shuffleClick');
		}else{
			player.setShuffle(false);
			shuffle = true;
			$('#shuffleBtn').removeClass('shuffleClick');
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
    		}
    	}
    }
	$(function(){
		var user_id = $('#login_id').val();
		var url2 = 'getPlayList?user_id='+user_id;
		$.ajax({
			type : "GET",
			url : url2,		
			dataType : "json",
			success : getPlayListHandle
		})		
		$('#checkAdd').on('click', function(){ //체크 선택 추가 이벤트
			var array = [];
			var title_array = [];
			var encode_title = '';
			var url = "addPlayList?";
			$("input[name=video_id]:checked").each(function() {
				array.push($(this).val());				
				encode_title = escape(encodeURIComponent($(this).parent().next().find('p').text()));
				title_array.push(encode_title);
			})
			$(location).attr('href',url+"music_id="+array+"&music_name="+title_array);
		})
		$('#playList').on('click', 'td', function(){
			var video_ID = $(this).attr('id');
			changeVideo(video_ID);
		})
		$('#searchBtn').click(function(){ //검색 버튼
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
	})
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
			html += '<div class='+"col-xs-2"+'><input type="checkbox" value='+ id_arr[i]+' name='+"video_id"+'></div><div class='+"col-xs-10"+'><p name='+"title_name"+'>'+title_arr[i]+'</p></div>';
		}
		$('#searchResult').html(html);
	}