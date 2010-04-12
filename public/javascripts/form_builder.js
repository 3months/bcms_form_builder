/* CustomForm edit form functions */
function newFormElement(selector) {
    var next_pos = $("input[name*='[position]']").length + 1
    var new_form_element = $('#new_form_element');
    $.get('/cms/custom_forms/new_element_partial', {type: selector.value, position : next_pos}, function(data, textStatus) {
        new_form_element.hide();
        new_form_element[0].innerHTML = data;
        new_form_element.removeAttr('id');
        new_form_element.addClass('dyn_element');
        new_form_element.after("<li id=\"new_form_element\"></li>")
        new_form_element.show(500);
        selector.value = '';
    });
}
function deleteFormElement(link_el) {
    var parent_element = link_el.parents("li.dyn_element");
    if(parent_element){
        $(parent_element).fadeOut(500, function() { parent_element.remove(); });
    }
}
/* End CustomForm edit form functions */

/* Element form functions */
function newFormOption() {
    var new_option = $('#option_template').clone().insertBefore('#options_list tbody tr#option_template').removeAttr('id');
    new_option.children().find('div').show(500);
}
function deleteFormOption(link_el) {
    var parent_element = link_el.parents("tr.option");
    if(parent_element){
        $(parent_element).fadeOut(500, function() { parent_element.remove(); });
    }
}
/* End element form functions */
