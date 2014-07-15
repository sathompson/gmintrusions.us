# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#newTagLink').on 'click', (e) ->
  e.preventDefault()
  $.ajax
    url: '/tags/new.json'
    success: (data) ->
      window.mydata = data
      $('#modalBody').html($.parseHTML(data.html))
      $('#tagForm').on 'submit', (e) ->
        e.preventDefault()
        $('#modal').modal('hide')
        $.ajax
          url: 'tags.json'
          type: 'POST'
          data: $(this).serialize()
          success: (data) ->
            if data.tag
              # alert data.tag.name + ' successfully created'
              displaySuccesses([data.tag.name + ' successfully created'])
            else
              # alert data.errors
              displayErrors(data.errors)
      $('#modal').modal('show')
