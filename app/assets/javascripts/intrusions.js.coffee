# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#newIntrusionLink').on 'click', (e) ->
  e.preventDefault()
  $('#modalBody').html('Loading...')
  $('#modal').modal('show')
  $.ajax
    url: '/intrusions/new.json'
    success: (data) ->
      $('#modalBody').html($.parseHTML(data.html))
      $('[autofocus]').focus()
      $('#intrusionForm').on 'submit', (e) ->
        e.preventDefault()
        $('#modal').modal('hide')
        $.ajax
          url: '/intrusions.json'
          type: 'POST'
          data: $(this).serialize()
          success: (data) ->
            if data.intrusion
              displaySuccesses(['Intrusion successfully created'])
              if $intrusionsList = $('#intrusionsList')
                $intrusionsList.prepend($.parseHTML(data.html))
            else
              displayErrors(data.errors)
