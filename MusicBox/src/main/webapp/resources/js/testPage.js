$(function(){
var paperMenu = {
		$window: $('#paper-window'),
		$paperFront: $('#paper-front'),
		$hamburger: $('.hamburger'),
		offset: 1800,
		pageHeight: $('#paper-front').outerHeight(),
		
		open: function() {
			this.$window.addClass('tilt');
			this.$hamburger.off('click');
			$('#container, .hamburger').on('click', this.close.bind(this));
			this.hamburgerFix(true);
			console.log('opening...');
		},
		close: function() {
			this.$window.removeClass('tilt'); 
			$('#container, .hamburger').off('click');
			this.$hamburger.on('click', this.open.bind(this));
			this.hamburgerFix(false);
			console.log('closing...');
		},
		updateTransformOrigin: function() {
			scrollTop = this.$window.scrollTop();
			equation = (scrollTop + this.offset) / this.pageHeight * 100;
			this.$paperFront.css('transform-origin', 'center ' + equation + '%');
		},
		//hamburger icon fix to keep its position
		hamburgerFix: function(opening) {
				if(opening) {
					$('.hamburger').css({
						position: 'absolute',
						top: this.$window.scrollTop() + 30 + 'px'
					});
				} else {
					setTimeout(function() {
						$('.hamburger').css({
							position: 'fixed',
							top: '30px'
						});
					}, 300);
				}
			},
		bindEvents: function() {
			this.$hamburger.on('click', this.open.bind(this));
			$('.close').on('click', this.close.bind(this));
			this.$window.on('scroll', this.updateTransformOrigin.bind(this));
		},
		init: function() {
			this.bindEvents();
			this.updateTransformOrigin();
		},
	};
	paperMenu.init();
	$('.paper-menu').on('click',function(){
		var $this = $(this);
		var href = $this.attr('href');
		$('#home-section').hide();
		$('#search-section').hide();
		$('#playList-section').hide();
		$(href).show();
		paperMenu.close();
	})
})
/*function playlist_show(){
		$('#paper-window').removeClass('tilt');
		$('#home').hide();
		$('#search-section').hide();
		$('#playList-section').show();
	}
	function search_show(){
		$('#home').hide();
		$('#playList-section').hide();
		$('#search-section').show();
	}*/