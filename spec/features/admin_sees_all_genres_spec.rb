require "rails_helper"

describe "As an admin" do
  describe "when I visit the genre index" do
    it 'should show all genres and options' do
      admin = User.create!(username: "dk", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      genre_1 = Genre.create!(name: "Blues")
      genre_2 = Genre.create!(name: "Alternative")
      genre_3 = Genre.create!(name: "Trip Hop")

      visit genres_path

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(genre_3.name)
    end

    it 'should be able to make a new genre' do
      admin = User.create!(username: "dk", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      genre_1 = Genre.create!(name: "Blues")
      genre_2 = Genre.create!(name: "Alternative")
      genre_3 = Genre.create!(name: "Trip Hop")

      visit genres_path

      new_name = "Country"

      fill_in :genre_name, with: new_name
      click_on("Create Genre")

      expect(current_path).to eq(genres_path)
      expect(page).to have_content(new_name)
    end

    it 'should error if genre name not present' do
      genre_1 = Genre.create!(name: "Blues")
      genre_2 = Genre.create!(name: "Alternative")
      genre_3 = Genre.create!(name: "Trip Hop")
      admin = User.create!(username: "dk", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit genres_path

      click_on("Create Genre")

      expect(page).to have_content("Genre not saved.")
    end

    it 'should not allow a visitor to make new genre' do
      visit genres_path

      expect(page).to_not have_content("Make New Genre!")
    end
  end
end
