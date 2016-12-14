$(document).ready(function () {
        var tabID = 1;
        $('.tab-pane').hide();
        $('#tab2').show();
        $('#btn-add-tab').click(function () {
            tabID++;
            $('#tab-list').append($('<li><a href="#tab' + tabID + '" role="tab" data-toggle="tab">Tab ' + tabID + '<button class="close" type="button" title="Remove this page">×</button></a></li>'));
            $('#tab-content').append($('<div class="tab-pane fade" id="tab' + tabID + '">Tab '+ tabID +' content</div>'));
        });
        $('#tab-list').on('click','.close',function(){
            var tabID = $(this).parents('a').attr('href');
            $(this).parents('li').remove();
            $(tabID).remove();

            //display first tab
            var tabFirst = $('#tab-list a:first');
            tabFirst.tab('show');
        });
        $('#tab-list').on('click', 'li',function(){
        	var str = $(this).find('a').attr('href');
        	var index = str.indexOf('#');
        	var id_str = str.substring(index+1);
        	/*$('.tab-pane').hide();
        	$('#'+id_str).show();*/
        })
});