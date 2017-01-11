jQuery(function($) {

$(document).on('ajax:before', '#friend-lookup-form', show_spinner);
$(document).on('ajax:after', '#friend-lookup-form', hide_spinner);

  $(document).on('ajax:success', '#friend-lookup-form', function(event, data, status) {
    $('#friend-lookup').replaceWith(data);
  });

  $(document).on('ajax:error','#friend-lookup-form', function(event, xhr, status, error){
    $('#friend-lookup-results').replaceWith('');
    $('#friend-lookup-errors').replaceWith('Person was not found.');
    hide_spinner();
  });
});