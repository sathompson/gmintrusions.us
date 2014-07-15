window.alertDiv = (msg, style) ->
  $('<div/>', {
    class: "alert alert-#{style} col-xs-12"
    }).text(msg)

window.displayAlerts = (msgs, style) ->
  $alerts = $('#alerts')
  $alerts.append(alertDiv(msg, style)) for msg in msgs
  $alerts.children().each ->
    $(this).delay(2000).slideUp(400)
    setTimeout (->
      $(this).remove()
      ), 2400

window.displayErrors = (msgs) ->
  displayAlerts(msgs, 'danger')

window.displaySuccesses = (msgs) ->
  displayAlerts(msgs, 'success')
