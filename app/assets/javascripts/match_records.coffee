# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener 'turbolinks:load', ->
  $(".username").autocomplete
    source: (req, res) ->
      $.ajax
        url: "/match_records/autocomplete/" + encodeURIComponent(req.term) + ".json",
        dataType: "json",
        success: (data) ->
          res(data)
    ,
    autoFocus: true,
    delay: 10,
    minLength: 2
  $(".ui-helper-hidden-accessible").hide()
