class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Movie was added.'
    else
      @movies = Movie.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    if @bookmark.destroy
      redirect_to list_path(@list), notice: 'Movie was removed from the list.', status: :see_other
    else
      redirect_to list_path(@list), alert: 'Failed to remove the movie from the list.', status: :unprocessable_entity
    end
  end


  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
