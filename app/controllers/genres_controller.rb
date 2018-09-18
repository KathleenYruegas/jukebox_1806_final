class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new()
  end

  def show
    @genre = Genre.find(params[:id])
    @show_info = @genre.show_info unless @genre.songs.empty?
  end
end
