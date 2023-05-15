module Settings
  class SelectedDeletedItemsController < ApplicationController
    def restore
      items = params[:deletedItems].to_unsafe_h
      items.each do |item|
        item_id = item[1]["itemId"]
        item_class = item[1]["itemClass"]
        record = item_class.classify.constantize.only_deleted.find(item_id)

        record.restore(:recursive => true, :recovery_window => 2.minutes)
      end
    end

    def destroy
      items = params[:deletedItems].to_unsafe_h
      items.each do |item|
        item_id = item[1]["itemId"]
        item_class = item[1]["itemClass"]
        record = item_class.classify.constantize.only_deleted.find(item_id)

        record.really_destroy!
      end
    end
  end
end
