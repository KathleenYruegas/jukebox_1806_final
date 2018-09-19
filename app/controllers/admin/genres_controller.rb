class Admin::GenresController < Admin::BaseController
 def create
   @genre = Genre.create(genre_params)
   if @genre.save
   else
     flash[:error] = "Genre not saved."
   end
   redirect_to genres_path
 end

 private
 def genre_params
   params.require(:genre).permit(:name)
 end
end
