jQuery(function($) {

$(document).on('ajax:before', '#stock-lookup-form', show_spinner);
$(document).on('ajax:after', '#stock-lookup-form', hide_spinner);

  $(document).on('ajax:success', '#stock-lookup-form', function(event, data, status) {
    $('#stock-lookup').replaceWith(data);
  });

  $(document).on('ajax:error','#stock-lookup-form', function(event, xhr, status, error){
    $('#stock-lookup-results').replaceWith('');
    $('#stock-lookup-errors').replaceWith('Stock was not found.');
    hide_spinner();
  });
});