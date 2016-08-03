json.(order, :id, :vend_id, :notes)
json.line_items order.line_items do |li|
  json.(li, :id, :notes, :qty)
  json.(li.product, :name, :vend_id)
end
