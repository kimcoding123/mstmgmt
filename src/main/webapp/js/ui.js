function datePicker() {


	if ( $('.date-picker').length) {

		$('.date-picker').datepicker(
			{
				autoClose: true,
				language: 'ko',
				onShow: function(){
					
				}
			}
			
		);
		$('.date-picker').each(function(){
			if( $(this).val() !== '' ){
				$(this).data('datepicker').selectDate(new Date($(this).val()));
			}
		});
		$('.date-picker').on('keyup',function(){
			
			if( $(this).val() !== '' && $(this).val().length==10){
				$(this).data('datepicker').selectDate(new Date($(this).val()));
			}
		});
	}
	$('.date-picker').mask('0000-00-00');

}

datePicker();


// lnb 토글
$('nav.lnb .lnb-list li > a').on('click',function (){

	if($(this).hasClass('no-sub-menu')){

	}else{

		$(this).toggleClass('on');
	}
})

// lnb 토글
$('nav.lnb .toggle-btn').on('click',function (){

	$('.contents-wrapper').toggleClass('on');



	if($(this).hasClass('on')){

	}else{


	}

})



// like 토글
$('article.page-head .like-btn').on('click',function (){
	$(this).toggleClass('on');
})


var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
};
$('.sortable-table tbody').sortable({
	helper: fixHelper
}).disableSelection();


function popupClose(name){
	$('.container').removeClass('overlay');
	$('article.popup-'+name+'').hide();
}

function popupOpen(name){
	$('.container').addClass('overlay');
	$('article.popup-'+name+'').show();
}

function popupOpenInner(name){
	$('article.popup-'+name+'').show().addClass('depth1');
	$('.container').addClass('depth1');
}

function popupCloseDirect(e){

	$(e).parents('article.popup').hide();
	$('.container').removeClass('overlay');
}

function createOverlay(){
	return '<article class="overlay-layer"></article>';
}


function popupCloseInner(e){
	$(e).parents('article.popup').hide().removeClass('depth1');
	$('.container').removeClass('depth1');
}



function createOverlay(){
	if(!$('article.overlay-layer').length){
		return '<article class="overlay-layer"></article>';
	}
}

function removeOverlay(){
	$('article.overlay-layer').remove();
}


// sub-page-info effect

$('article.page-navigator .navi-select').on('mouseenter',function (){
	$(this).find('ul').stop().slideDown('300');
})
$('article.page-navigator .navi-select').on('mouseleave',function (){
	$(this).find('ul').stop().slideUp('300');
})

$('article.page-navigator .navi-select ul a').on('click',function (){
	$(this).parents('.navi-select').find('.set').removeClass('on');
})

// header effect

// $('header nav.gnb .gnb-menu').on('click',function (){
//
// 	if($('header').hasClass('on')){
// 		$('header').removeClass('on')
// 		removeOverlay();
// 	}else{
// 		$('header').addClass('on')
// 		$('body').append(createOverlay());
// 	}
// })
//
$('header nav.gnb ul').mouseenter(function () {
	$('header').addClass('on')
}).mouseleave(function (){
	$('header').removeClass('on')
});

$('header nav.gnb ul > li').mouseenter(function () {
	$(this).addClass('on')
}).mouseleave(function (){
	$(this).removeClass('on')
});

// file event
function fileRemove(e){
	$(e).parents('.file-box').remove();
}