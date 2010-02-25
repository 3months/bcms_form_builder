function newFormElement(selector) {
    var new_form_element = $('#new_form_element');
    $.get('/cms/custom_forms/new_element_partial', {type: selector.value}, function(data, textStatus) {
        new_form_element.hide();
        new_form_element[0].innerHTML = data;
        new_form_element.removeAttr('id');
        new_form_element.addClass('dyn_element');
        new_form_element.after("<li id=\"new_form_element\"></li>")
        new_form_element.show(500);
        /*new_form_element.siblings('.dyn_element').each(function(){
            hideElement($(this));
        });*/
        selector.value = '';
    });
}

function toggleElement(el) {
    var section = el.find('.to_hide');
    if(section.is(':visible')){
        hideElement(el);
    } else {
        showElement(el);
    }
}

function hideElement(el) {
    var section = el.find('.to_hide');
    section.hide();
    el.find('.hide_link').hide();
    el.find('.show_link').show();
}

function showElement(el) {
    var section = el.find('.to_hide');
    section.show();
    el.find('.hide_link').show();
    el.find('.show_link').hide();
}

function deleteFormElement(link_el) {
    var parent_element = link_el.parents("li.dyn_element");
    if(parent_element){
        //parent_element.remove();
        $(parent_element).fadeOut(500, function() { parent_element.remove(); });
    }
}
