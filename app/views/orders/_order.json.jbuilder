json.extract! order, :id, :item_id, :requester, :requested_at, :approver, :approved_at, :deadline, :returned, :created_at, :updated_at
json.url order_url(order, format: :json)
