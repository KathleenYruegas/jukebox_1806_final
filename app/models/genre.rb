class Genre < ApplicationRecord
  validates_presence_of :name
  has_many :song_genres
  has_many :songs, through: :song_genres

  def avg_song_rating
    songs.average(:rating).to_f
  end

  def highest_rated
    songs.where(rating: songs.maximum(:rating)).first
  end

  def lowest_rated
    songs.where(rating: songs.minimum(:rating)).first
  end
end
