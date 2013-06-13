###
   Class AppUtil : used to embed static methods not related to the UI
   and used throughout the application
###
class @AppUtil
  @setupAjax = ->
    $.ajaxSetup
      beforeSend: (xhr) ->
        xhr.setRequestHeader "AUTHORIZATION", "Token token=" + AppUtil.apiToken()

  @apiToken = ->
    $('[data-api-token]').data('api-token')

$(document).ready ->
  AppUtil.setupAjax()
