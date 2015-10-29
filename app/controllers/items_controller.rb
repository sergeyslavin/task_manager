class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @items = Item.rank(:row_order).all
  end

  def show
  end

  def new
    @item = Item.new
    @tags = nil
  end


  def edit
    @tags = @item.tags.map { |e| e.name }.join(",")
  end

  def create
    current_item, tags_list = get_actual_tags_and_item

    @item = current_user.items.new(current_item)

    create_or_update_tags_list(tags_list)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    current_item, tags_list = get_actual_tags_and_item

    create_or_update_tags_list(tags_list)

    respond_to do |format|
      if @item.update(current_item)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_row_order
    @item = Item.find(item_params[:item_id])
    @item.row_order_position = item_params[:row_order_position]
    @item.save

    render nothing: true
  end

  private

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
          tags << Tag.where(name: tag).first_or_create
        end
        @item.tags = tags
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:user_id, :title, :notes, :done, :tags, :row_order_position, :item_id)
    end
end
