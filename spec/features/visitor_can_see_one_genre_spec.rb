require "rails_helper"

describe "As a visitor" do
  describe "when I visit a genre show" do
    it 'should show all songs under genre' do
      artist_1 = Artist.create(name: "Rick James")
      artist_2 = Artist.create(name: "Vanilla Ice")
      genre = Genre.create!(name: "Alternative")
      song_1 = artist_1.songs.create(title: 'Superfreak', length: 300, play_count: 5000000, rating: 2)
      song_2 = artist_2.songs.create(title: 'Ice Ice Baby', length: 200, play_count: 10000, rating: 1)
      song_3 = artist_2.songs.create(title: 'Another Song', length: 242, play_count: 33353, rating: 5)
      song_4 = artist_1.songs.create(title: 'Not Alternative', length: 211, play_count: 983)
      genre.songs << song_1
      genre.songs << song_2
      genre.songs << song_3

      visit genre_path(genre)

      expect(page).to have_content(song_1.title)
      expect(page).to have_content(song_2.title)
      expect(page).to have_content(song_3.title)
      expect(page).to_not have_content(song_4.title)

      expect(page).to have_content("Average Song Rating: #{genre.avg_song_rating.round(2)}")
      expect(page).to have_content("Song with highest rating: #{song_3.title} with a rating of #{song_3.rating}")
      expect(page).to have_content("Song with lowest rating: #{song_2.title} with a rating of #{song_2.rating}")
    end
  end
end
