$(document).ready ->
  ws = new WebSocket("ws://" + location.host + "/signatures/generator");
  ws.onmessage = (e) ->
    console.log e.data