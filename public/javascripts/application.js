// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function show_add_review_form() {
    if ($('add_review_form').getStyle('display') == 'none') {
        Effect.BlindDown('add_review_form');
    } else {
        Effect.BlindUp('add_review_form');
    }
    Element.toggle('add_review');
    Element.toggle('cancel_add_review');
}

function show_menu_value() {
	if (window.name.length > 1) {
		show_menu(window.name);
	} else {
		show_menu('Books');
	}
}

function show_menu(object) {
	if (object == 'Books') {
		$('books_menu').show(); $('books_btn').setStyle({ backgroundColor: '#EEEEEE'});
		$('music_menu').hide(); $('music_btn').setStyle({ backgroundColor: '#FFFFFF'});
		$('dvds_menu').hide();  $('dvds_btn').setStyle({ backgroundColor: '#FFFFFF'});
		window.name = "Books";
	} else if (object == 'CDs') {
		$('books_menu').hide(); $('books_btn').setStyle({ backgroundColor: '#FFFFFF'});
		$('music_menu').show(); $('music_btn').setStyle({ backgroundColor: '#EEEEEE'});
		$('dvds_menu').hide();  $('dvds_btn').setStyle({  backgroundColor: '#FFFFFF'});
		window.name = "CDs";	
	} else {
		$('books_menu').hide(); $('books_btn').setStyle({ backgroundColor: '#FFFFFF'});
		$('music_menu').hide(); $('music_btn').setStyle({ backgroundColor: '#FFFFFF'});
		$('dvds_menu').show();	$('dvds_btn').setStyle({ backgroundColor: '#EEEEEE'});
		window.name = "DVDs";
	}
}