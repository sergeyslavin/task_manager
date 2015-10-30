module Manager
  module Item
    module Decorator
      
      def prepare_items_for_search_and_create_var
        tags_ids = []
        if params.has_key? :search
          search_params = params[:search]
          title_for_search = search_params[:title] if search_params.has_key? :title          
          if search_params.has_key? :tags_ids
            tags_ids = search_params[:tags_ids].reject!(&:empty?)
            tags_ids = tags_ids.map!{ |item| item.to_i } unless tags_ids.empty? 
          end
        end
        [title_for_search, tags_ids]
      end

      def get_actual_tags_and_item
        current_item = item_params
        tags_list = (!current_item[:tags].empty?) ? current_item[:tags].split(",") : []
        current_item.delete(:tags)

        [current_item, tags_list]
      end

      def create_or_update_tags_list(tags_list)
        if !tags_list.nil?
          tags = []
          tags_list.each do |tag|
          tags << Tag.where(name: tag.strip).first_or_create
        end
          @item.tags = tags
        end
      end
      
      private :prepare_items_for_search_and_create_var, :get_actual_tags_and_item

    end
  end
end