	var arr = ['y7gCktBEn5U','-sVo6NWwK_o','BTM68fJS1nM'];
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
		/*$('#signUp_btn').click(function(){
			$('#signUp_paper').modal('show');
		})*/
		$('#checkAdd').on('click', function(){ //체크 선택 추가 이벤트
			var array = [];
			var title_array = [];
			$("input[name=video_id]:checked").each(function() {
				array.push($(this).val());
				title_array.push($(this).parent().find('p').text());
			})
			for(var i=0;i<array.length;i++){
				var html = '<li value='+ array[i] +'>'+ title_array[i] +'</li>';
				$('#playList').append(html);
				arr.push(array[i]);
			}
		})
		$('#playBtn').click(function(){			
			playList(arr);
		})
		$('#list').on('click', 'li', function(){
			var video_ID = $(this).attr('value');
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
	})
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
			html += '<div><input type="checkbox" value='+ id_arr[i]+' class='+"resultCheck resultList"+' name='+"video_id"+'><p name='+"title_name"+'>'+title_arr[i]+'</p></div>';
		}
		$('#searchResult').html(html);
	}