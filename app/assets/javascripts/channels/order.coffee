App.order = App.cable.subscriptions.create "OrderChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $.get "orders/#{data.order}.json", (d) ->
      $("#orders").append HandlebarsTemplates["orders/order"]({order: d.order})