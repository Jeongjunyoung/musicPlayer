$(document).ready(function () {
        $('.tab-pane').hide();
        $('#tab2').show();
        $('#tab-list').on('click','.close',function(){
            var tabID = $(this).parents('a').attr('href');
            $(this).parents('li').remove();
            $(tabID).remove();
            var tabFirst = $('#tab-list a:first');
            tabFirst.tab('show');
        });
        //탭 클릭
        $('#tab-list').on('click', 'li',function(){
        	var str = $(this).find('a').attr('href');
        	var index = str.indexOf('#');
        	var id_str = str.substring(index+1);
        	$('.tab-pane').hide();
        	$('#'+id_str).show();
        })
        $('.tab-list').click(function(){
        	if($(this).hasClass('tab-list-click')){
        		$(this).removeClass('tab-list-click');
        	}else{
        		$(this).addClass('tab-list-click');
        	}
        })
        $('#tabMusicAddBtn').click(function(){
        	var arr = [];
        	var tab_id = '';
        	$('.tab-pane').each(function(){
        		if($(this).hasClass('active')){
        			tab_id = $(this).attr('id');
        			console.log(tab_id);
        		}
        	})
        	$('.tab-list').each(function(){
        		if($(this).hasClass('tab-list-click')){
        			arr.push($(this).attr('id'));
        		}
        	})
        	$(location).attr('href','addTabMusic?arr='+arr+'&tab_id='+tab_id);
        })
        //탭 모달창 띄우기
        $('#btn-add-tab').click(function(){
        	$('#AddTabModal').modal('show');
        })
        $('.tadAddMusic').click(function(){
        	$('#AddTabMusicModal').modal('show');
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
        			$('#tab-list').append($('<li><a href="#tab' + data.tab_id + '" role="tab" data-toggle="tab">' + data.tab_name + '</a></li>'));
        			$('#tab-content').append($('<div class="tab-pane fade" id="tab' + data.tab_id + '"></div>'));
        			$('#tabInput').val('');
        			$('#AddTabModal').modal('hide');
        		}
        	})
        })
});