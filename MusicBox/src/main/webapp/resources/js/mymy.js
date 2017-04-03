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
	var nowPlaying_tab = 'tab';
	var play_index = 1;
	var last_index = 0;
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
		     'onStateChange': onPlayerStateChange
		   }
		});
	}
	function onPlayerStateChange(event) {
		if(player.getPlayerState()==0){
			switch (replay) {
			case "true":
				if(nowPlaying_tab == 'tab1'){
					top100ChangeMusic();
				}else{
					player.loadPlaylist(repeatArr,0);
					player.setLoop(true);
				}
				break;
			case "false":
				var id = get_playing_id();
				var index=0;
				for(var i=0;i<arr.length;i++){
					if(arr[i] == id){
						index = i+1;
					}
				}
				$('.clickList-td').removeClass('now-playing');
				changeListBlock(index);
				replay = 'normal';
				break;
			case "normal":
				if(nowPlaying_tab == 'tab1'){
					play_index+=1;
					changeMusic();
				}else{
					if(play_index == last_index){
						play_index = 1;
						changeMusic();
					}else{
						play_index += 1;
						changeMusic();
					}
				}
				break;
			}
		}
	}
	//클릭 노래 플레이 블록 변경
	function changeListBlock(index){
		var getPlaylist = player.getPlaylist();
		var $playing_tab = null;
		$('.tab-pane').each(function(){
			if($(this).hasClass('active')){
				$playing_tab = $(this).find('.clickList-td');
			}
		})
		$playing_tab.each(function(){
			if($(this).attr('id') == getPlaylist[index]){
				$(this).addClass('now-playing');
				var playing_music_name = $(this).text();
				$('#plaing-music-name').text(playing_music_name);
				return false;
			}
		})
	}
	function changeMusic(){
		var $this;
		if(nowPlaying_tab == 'tab1'){
			$this = $('.top100Index-'+play_index);
		}else{
			$this = $('.myIndex-'+play_index);
		}
		var video_id = $this.attr('id');
		var playing_music_name = $this.text();
		$('#plaing-music-name').text(playing_music_name);
		$('.clickList-td').removeClass('now-playing');
		$this.addClass('now-playing');
		player.loadVideoById(video_id);
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
			if(nowPlaying_tab == 'tab1'){
				
			}else{
				player.setShuffle(shuffle);
				player.setLoop(true);
				shuffle = false;
				$('#shuffleBtn').addClass('click-play-option');
			}
		}else{
			if(nowPlaying_tab == 'tab1'){
				replay == ''
			}else{
				player.setShuffle(shuffle);
				player.setLoop(true);
				shuffle = true;
				$('#shuffleBtn').removeClass('click-play-option');
			}
		}
	}
	//Play 버튼 클릭 이벤트
	function playVideo(){ 
		player.playVideo();
		$('#playBtn').css('display','none');
		$('#stopBtn').css('display','inline');    	
	}
	//Pause 버튼 클릭 이벤트
    function pauseVideo(){ 
    	player.pauseVideo();
    	$('#stopBtn').css('display','none');
    	$('#playBtn').css('display','inline');
    }
    //Next 버튼 클릭 이벤트
    function nextVideo(){
    	if(nowPlaying_tab != 'tab1'){
    		if(play_index == last_index){
    			play_index = 1;
    		}else{
    			play_index += 1;
    		}
    	}else{
    		if(play_index == 100){
    			play_index = 1;
    		}else{
    			play_index += 1;
    		}
    	}
    	changeMusic();
    }
    //Prev 버튼 클릭 이벤트
    function prevVideo(){
    	if(nowPlaying_tab != 'tab1'){
    		if(play_index == 1){
    			play_index = last_index;
    		}else{
    			play_index -= 1;
    		}
    	}else{
    		if(play_index == 1){
    			play_index = 100;
    		}else{
    			play_index -= 1;
    		}
    	}
    	changeMusic();
    }
    //음악 변경 이벤트
    function changeVideo(video_ID){ 
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
			var td = '<tr class='+" "+' id='+"playList-add"+'><td id='+value.music_id+' class='+"clickList-td"+'>'+ value.music_name +'</td></tr>';
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
	function delSuccess(data){
		var tabID = '';
		  $('#tab-list li').each(function(){
			  if($(this).hasClass('active')){
				  tabID = $(this).find('a').attr('href');
			  }
		  })
		  var $table = $(tabID).find('.tab-playList');
		  for(var i=0;i<editArr.length;i++){
			  $table.find('#'+editArr[i]).remove();
		  }
		swal("Delete Success!!", "탭이 삭제되었습니다.", "success");
		editArr.splice(0, editArr.length)
	}
	$(function(){
		$('.tab-pane').hide();
        $('#tab1').show();
        $('.delete-tab').hide();
		//DEL 버튼
		$('#delBtn').click(function(){
			if(editArr.length == 0){
				swal("Delete Failed...", "삭제할 음악을 선택하세요.", "error");
			}else{
				var tab = '';
				if(nowPlaying_tab == 'tab2'){
					tab = 'myList';
				}else{
					tab = 'tab';
				}
				var url = 'delPlayList?editArr='+editArr+'&tab='+tab;
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
					  ajax_load("GET", url, null, "json", delSuccess);
					  /*var tabID = '';
					  $('#tab-list li').each(function(){
						  if($(this).hasClass('active')){
							  tabID = $(this).find('a').attr('href');
						  }
					  })
					  var $table = $(tabID).find('.tab-playList');
					  for(var i=0;i<editArr.length;i++){
						  $table.find('#'+editArr[i]).remove();
					  }*/
					  //swal("삭제 성공", "음악들이 삭제되었습니다.", "success");
				});
			}
		})
		
		//EDIT 버튼
		$('#editBtn').click(function(){
			edit = true;
			if($(this).css('display') != 'none'){
				$('.hideBtn').hide();
				$('.delCancelBtn').show();
				$('.delete-tab').show();
			}
		})
		//CANCEL 버튼
		$('#cancelBtn').click(function(){
			edit = false;
			$('.clickList-td').removeClass('edit-click');
			$('.delCancelBtn').hide();
			$('.delete-tab').hide();
			$('.hideBtn').show();
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
		//TOP-100 리스트 클릭
		$('.top100-list').on('click','td',function(){
			var $this = $(this);
			var video_ID = $this.attr('id');
			var playing_music_name = $(this).text();
			var tab_id = 'tab1';
			nowPlaying_tab = tab_id;
			$('.clickList-td').removeClass('now-playing');
			$('#plaing-music-name').text(playing_music_name);
			$this.addClass('now-playing');
			var str = $(this).prev().text();
			play_index = Number(str);
			changeMusic();
		})
		//리스트 클릭 이벤트
		$('#tab-content').on('click', '.user-list td', function(){
				var $this = $(this);
				var video_ID = $this.attr('id');
				var playing_music_name = $this.text();
				var tab_id = $this.parent().parent().parent().parent().attr('id');
			if(edit){ //수정 중일때..
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
				var str = $(this).prev().text();
				play_index = Number(str);
				var video_ID = $this.attr('id');
				$('.clickList-td').removeClass('now-playing');
				$this.addClass('now-playing');
				$('#plaing-music-name').text(playing_music_name);
				if(tab_id == nowPlaying_tab){
					//changeVideo(video_ID);
					changeMusic();
				}else{
					nowPlaying_tab = tab_id;
					/*arr.splice(0, arr.length)
					$('#'+tab_id).find('.clickList-td').each(function(){
						var tab_video_ID = $(this).attr('id');
						arr.push(tab_video_ID);
					})*/
					//changeVideo(video_ID);
					last_index = Number($this.parent().parent().find('.last-index').text());
					changeMusic();
				}
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
				$(this).addClass('click-play-option');
				repeatArr[0] = get_playing_id();
				replay = 'true';
			}else if(replay){
				$(this).removeClass('click-play-option');
				replay = 'false';
			}
		})
		//탭 삭제
        $('#tab-list').on('click','.delete-tab',function(){
        	var $this = $(this);
        	var tabID = $this.parents('a').attr('href');
        	var tab_id = tabID.substr(tabID.indexOf('#')+1);
			var url = 'deleteTab?tab_id='+tab_id;
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
					ajax_load('GET', url, null, 'json');
					$this.parents('li').remove();
					$(tabID).remove();
					var tabFirst = $('#a-tab2');
					tabFirst.tab('show');
					$('#tab2').show();
					swal("Delete Success!!", "탭이 삭제되었습니다.", "success");
			});
        	
        });
        //탭 클릭
        $('#tab-list').on('click', 'li',function(){
        	var str = $(this).find('a').attr('href');
        	var index = str.indexOf('#');
        	var id_str = str.substring(index+1);
        	$('.tab-pane').hide();
        	$('#'+id_str).show();
        })
        $('.tab-click').click(function(){
        	if($(this).hasClass('tab-list-click')){
        		$(this).removeClass('tab-list-click');
        	}else{
        		$(this).addClass('tab-list-click');
        	}
        })
        //탭 뮤직 추가 버튼
        $('#tabMusicAddBtn').click(function(){
        	var arr = [];
        	var arr_top = [];
        	var tab_id = '';
        	$('.tab-pane').each(function(){
        		if($(this).hasClass('active')){
        			tab_id = $(this).attr('id');
        		}
        	})
        	$('.tab-list').each(function(){
        		if($(this).hasClass('tab-list-click')){
        			arr.push($(this).attr('id'));
        		}
        	})
        	$('.tab-list-top100').each(function(){
        		if($(this).hasClass('tab-list-click')){
        			arr_top.push($(this).attr('id'));
        		}
        	})
        	ajax_load('get', 'addTabMusic?arr='+arr+'&arr_top='+arr_top+'&tab_id='+tab_id, null,'json', addTabMusicSuccess)
        })
        function addTabMusicSuccess(data){
        	$.each(data,function(index,value){
        		var tab_id = value.tab_id;
        		var td = '<tr class='+"playList-td"+' id='+"playList-add"+'><td class='+"clickList-td"+' id='+value.tabs_music_id+'>'+ value.tabs_music_name +'</td></tr>';
    			$('#'+tab_id).find('table').append(td);
    			$('#AddTabMusicModal').modal('hide');
    			$('.tab-list').removeClass('tab-list-click');
    			$('.tab-list-top100').removeClass('tab-list-click');
    			swal("Add Success!!", "음악을 추가하였습니다.", "success");
        	})
        }
        //탭 모달창 띄우기
        $('#btn-add-tab').click(function(){
        	$('#AddTabModal').modal('show');
        })
        $('#tab-content').on('click','button',function(){
        	$('#AddTabMusicModal').modal('show');
        })
        $('#tabCloseBtn').click(function(){
        	$('#AddTabModal').modal('hide');
        })
        $('#tabMusicCloseBtn').click(function(){
        	$('.tab-list').removeClass('tab-list-click');
        	$('.tab-list-top100').removeClass('tab-list-click');
        	$('#AddTabMusicModal').modal('hide');
        })
        $('.add-tab').click(function(){
        	var list_id = $(this).find('span').attr('title');
        	$('.add-tab').removeClass('add-tab-list-none');
        	$(this).addClass('add-tab-list-none');
        	$('.add-tab-table').hide();
        	$('#'+list_id).show();
        })
        //탭 ADD 버튼 클릭
        $('#tabAddBtn').click(function(){
        	var tab_name = escape(encodeURIComponent($('#tabInput').val()));
        	if("" == tab_name || null == tab_name){
				swal("Login Failed...", "TAB NAME을(를) 입력하세요", "error");
				return false;
			}
        	var url = 'addTabs?tab_name='+tab_name;
        	$.ajax({
        		url : url,
        		type : 'get',
        		dataType : 'json',
        		success : function(data){
        			$('#tab-list').append($('<li><a href="#' + data.tab_id + '" role="tab" data-toggle="tab">' + data.tab_name + '<button class="delete-tab" type="button" title="Remove this page">×</button></a></li>'));
        			$('#tab-content').append($('<div class="tab-pane fade user-list" id="'+data.tab_id+'"><table class="table hoverList tab-playList"></table><div class="col-lg-12 text-center"><button class="tabadd-btn tadAddMusic">ADD MUSIC</button></div></div>'));
        			$('#tabInput').val('');
        			$('#'+data.tab_id).hide();
        			$('#AddTabModal').modal('hide');
        		}
        	})
        })
	})