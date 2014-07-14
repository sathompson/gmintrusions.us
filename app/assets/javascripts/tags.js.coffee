# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#newTagLink').on 'click', (e) ->
  e.preventDefault()
  $.ajax
    url: '/tags/new.json'
    success: (data) ->
      window.mydata = data
      # $('.intrusion-div').first().html data.html
    error: (data) ->
      console.debug data
