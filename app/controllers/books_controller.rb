class BooksController < ApplicationController
  before_action :set_seriesbook
  before_action :set_book, only: [:edit, :update, :destroy]

  def create
    @book = @seriesbook.books.build(book_params)
    if @book.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @seriesbook, notice: "巻を追加しました" }
      end
    else
      render turbo_stream: turbo_stream.replace("book_form", partial: "books/form", locals: { seriesbook: @seriesbook, book: @book })
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "book_#{@book.id}",
          partial: "books/form",
          locals: { seriesbook: @seriesbook, book: @book }
        )
      end
      format.html do
        render partial: "books/form",
              locals: { seriesbook: @seriesbook, book: @book },
              layout: false
      end
    end
  end

  def update
    if @book.update(book_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @seriesbook, notice: "巻を更新しました" }
      end
    else
      render turbo_stream: turbo_stream.replace("book_#{@book.id}", partial: "books/form", locals: { seriesbook: @seriesbook, book: @book })
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @seriesbook, notice: "巻を削除しました" }
    end
  end

  def bulk_create
    @seriesbook = Seriesbook.find(params[:seriesbook_id])
    store_id = params[:book][:store_id]
    volume_input = params[:book][:volumes]

    volumes = parse_volumes(volume_input)

    volumes.each do |v|
      @seriesbook.books.create(volume_number: v, store_id: store_id)
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("books_list", partial: "books/list", locals: { seriesbook: @seriesbook, books: @seriesbook.books }) }
      format.html { redirect_to @seriesbook }
    end
  end

  def bulk_delete
    @seriesbook = Seriesbook.find(params[:seriesbook_id])
    book_ids = params[:book_ids] || []

    @seriesbook.books.where(id: book_ids).destroy_all

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "books_list",
          partial: "books/list",
          locals: { seriesbook: @seriesbook, books: @seriesbook.books }
        )
      end
      format.html { redirect_to @seriesbook, notice: "#{book_ids.size}件を削除しました" }
    end
  end

  private

  # "1, 3, 5" や "1-3, 5" を [1, 3, 5] に変換
  def parse_volumes(input)
    input.split(",").flat_map do |part|
      if part.include?("-")
        start_vol, end_vol = part.split("-").map(&:to_i)
        (start_vol..end_vol).to_a
      else
        part.to_i
      end
    end.uniq.sort
  end

  def set_seriesbook
    @seriesbook = current_user.seriesbooks.find(params[:seriesbook_id])
  end

  def set_book
    @book = @seriesbook.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:volume_number, :store_id)
  end
end