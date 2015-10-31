class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  load_and_authorize_resource
  skip_load_resource :only => [:create]

  include ItemCtrlFilter #included item controller concern

  def index
    @title_for_search, @tags_ids = prepare_items_for_search_and_create_var
    @items = current_user.rank_items_and_handle_search(title: @title_for_search, tags: @tags_ids)
    @actual_tags = current_user.actual_tags
  end

  def new
    @item = Item.new
    @tags = nil
  end

  def edit
    @tags = @item.tags.map(&:name).join(",")
  end

  def create
    current_item, tags_list = get_actual_tags_and_item
    @item = current_user.items.new(current_item)
    create_or_update_tags_list(tags_list)

    respond_with do |format|
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

    respond_with do |format|
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
    respond_with do |format|
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
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:user_id, :title, :notes, :done, :tags, :row_order_position, :item_id)
    end
end
