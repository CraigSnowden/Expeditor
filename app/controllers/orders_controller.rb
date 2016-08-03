class OrdersController < ApplicationController
  def index
    @orders = Order.where(closed: false)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.update(closed: true)
      head :ok
    else
      head 422
    end
  end

  def webhook
    payload = JSON.parse(params[:payload])
    @order = Order.create(vend_id: payload["id"], notes: payload["note"], closed: false)
    payload["register_sale_products"].each do |rsp|
      product = Product.find_by(vend_id: rsp["product_id"])
      unless product.nil?
        li = @order.line_items.create(qty: rsp["quantity"], product: product)
        if rsp["attributes"]
          li.notes = rsp["attributes"][0]["value"]
          li.save
        end
      end
    end

    ActionCable.server.broadcast "orders", {order: @order.id}
    head :ok
  end
end
