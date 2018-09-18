require "rails_helper"

describe Genre, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:song_genres) }
    it { should have_many(:songs), through: :song_genres }
  end

  describe 'instance methods' do
    before(:each) do
      @artist_1 = Artist.create(name: "Rick James")
      @artist_2 = Artist.create(name: "Vanilla Ice")
      @genre = Genre.create!(name: "Alternative")
      @song_1 = @artist_1.songs.create(title: 'Superfreak', length: 300, play_count: 5000000, rating: 2)
      @song_2 = @artist_2.songs.create(title: 'Ice Ice Baby', length: 200, play_count: 10000, rating: 1)
      @song_3 = @artist_2.songs.create(title: 'Another Song', length: 242, play_count: 33353, rating: 5)
      @genre.songs << @song_1
      @genre.songs << @song_2
      @genre.songs << @song_3
    end
    context '#avg_song_rating' do
      it 'should return an average rating of all songs in this genre' do
        expect(@genre.avg_song_rating).to eq(((@song_1.rating + @song_2.rating + @song_3.rating) / @genre.songs.count.to_f))
      end
    end
    context '#highest_rated' do
      it 'should return highest rated song' do
        expect(@genre.highest_rated).to eq(@song_3)
      end
    end

    context '#lowest_rated' do
      it 'should return lowest rated song' do
        expect(@genre.lowest_rated).to eq(@song_2)
      end
    end

    context '#show_info' do
      it 'should deliver all info for that genres show page' do
        expect(@genre.show_info).to eq({avg_song_rating: @genre.avg_song_rating,
                                        highest_rated: {title: @genre.highest_rated.title,
                                                        rating: @genre.highest_rated.rating},
                                        lowest_rated: {title: @genre.lowest_rated.title,
                                                        rating: @genre.lowest_rated.rating}
                                          })
      end
    end
  end
end
