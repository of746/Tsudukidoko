class SeriesbooksController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_seriesbook, only: [:show, :edit, :update, :destroy]

  require 'net/http'
  require 'json'
  require 'uri'

  def index
    @seriesbooks = current_user.seriesbooks
    @stores = Store.where(user_id: nil).or(Store.where(user_id: current_user.id))
    if params[:q].present?
      keyword = "%#{params[:q]}%"
      @seriesbooks = Seriesbook.where("title LIKE ? OR author LIKE ?", keyword, keyword)
    else
      @seriesbooks = current_user.seriesbooks
    end
  end

  def new
    @seriesbook = Seriesbook.new
    @stores = Store.where(user_id: nil).or(Store.where(user_id: current_user.id))
  end

  def create
    @seriesbook = current_user.seriesbooks.build(seriesbook_params)
    if @seriesbook.save
      flash[:notice] = "シリーズを新規登録しました"
      redirect_to seriesbook_path(@seriesbook)
    else
      @stores = Store.where(user_id: nil).or(Store.where(user_id: current_user.id))
      render "new"
    end
  end

  def show
    redirect_to seriesbooks_path, alert: "アクセス権限がありません" unless @seriesbook.user == current_user

    @seriesbook = Seriesbook.find(params[:id])
    @books = @seriesbook.books.includes(:store)
    @stores = Store.where(user_id: nil).or(Store.where(user_id: current_user.id))
    @book = Book.new

    # 昇順・降順で並び替え機能
    sort_order = params[:sort] == "desc" ? :desc : :asc
    @books = @seriesbook.books.order(volume_number: sort_order)

    # ストアで絞り込み機能
    if params[:store_id].present?
      @books = @books.where(store_id: params[:store_id])
    end

    # 合計冊数
    @total_books = @books.count
  end

  def edit
    @seriesbook = Seriesbook.find(params[:id])
  end

  def update
    if @seriesbook.update(seriesbook_params)
      redirect_to @seriesbook, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @seriesbook = current_user.seriesbooks.find(params[:id])
    @seriesbook.destroy
    flash[:notice] = "シリーズを削除しました"
    redirect_to :seriesbooks
  end

  def search_books
    query = params[:query]
    return render plain: "No query" if query.blank?

    url = URI("https://www.googleapis.com/books/v1/volumes?q=#{CGI.escape(query)}&maxResults=5")
    res = Net::HTTP.get(url)
    json = JSON.parse(res)

    @candidates = json['items']&.map do |item|
      volume = item['volumeInfo']
      {
        title: volume['title'],
        authors: (volume['authors'] || []).join(', '),
        cover: volume.dig('imageLinks', 'thumbnail')
      }
    end || []

    render partial: "candidates", locals: { candidates: @candidates }
  end

  private

  def seriesbook_params
    params.require(:seriesbook).permit(:title, :author, :cover_url, :user_id)
  end

  def set_seriesbook
    @seriesbook = Seriesbook.find(params[:id])
  end
end
