$(document).ready ->
  getOrders = ->
    $.get "/orders.json", (data) ->
      $("#orders").empty()
      for order in data.orders
        $("#orders").append HandlebarsTemplates["orders/order"]({order: order})

  $("#orders").on "click", "button", ->
    closeOrder $(this).data("order")

  closeOrder = (order) ->
    $.ajax {url: "/orders/#{order}", type: "DELETE", success: (data) ->
      $("[data-order='#{order}']").parents(".col-md-3").remove()
    }
  getOrders()
