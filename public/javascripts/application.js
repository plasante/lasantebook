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