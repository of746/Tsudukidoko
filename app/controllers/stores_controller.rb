class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:edit, :update, :destroy]

  def index
    @stores = Store.where(user_id: nil).or(Store.where(user_id: current_user.id))
    @store = Store.new
  end

  def create
    @store = current_user.stores.build(store_params)
    if @store.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to stores_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :form_errors }
        format.html do
          @stores = Store.where(user_id: nil).or(Store.where(user_id: current_user.id))
          render :index
        end
      end
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to stores_path, notice: "ストアを更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @store.user_id.nil?
      redirect_to stores_path, alert: "共通ストアは削除できません"
    else
      @store.destroy
      redirect_to stores_path, notice: "ストアを削除しました"
    end
  end

  private

  def set_store
    @store = current_user.stores.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:store_name)
  end
end


