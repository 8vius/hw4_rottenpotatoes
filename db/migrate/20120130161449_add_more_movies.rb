class AddMoreMovies < ActiveRecord::Migration
  MORE_MOVIES = [
    {:title => 'Star Wars', :rating => 'PG', :release_date => '25-May-1977'},
    {:title => 'Blade Runner', :rating => 'PG', :release_date => '25-Jun-1982'},
    {:title => 'Alien', :rating => 'R', :release_date => '25-May-1979'},
    {:title => 'THX-1138', :rating => 'R', :release_date => '11-Mar-1971'},
  ]
  def up
    MORE_MOVIES.each do |movie|
      Movie.create!(movie)
    end
  end

  def down
    MORE_MOVIES.each do |movie|
      Movie.find_by_title_and_rating(movie[:title], movie[:rating]).destroy
    end
  end
end
