require 'spec_helper'

describe MoviesController do
  
  describe 'searching for similar movies' do
    before :each do 
      @fake_movies = [mock('Movie'), mock('Movie')]
      @fake_movie = FactoryGirl.build(:movie, :id => "1", :title => "Star Wars", :director => "George Lucas") 
    end
    
    it 'should follow the route to the similar movies by director page' do
      assert_routing('movies/1/similar', {:controller => 'movies', :action => 'similar', :id => '1'}) 
    end

    it 'should find the similar movies by director' do
      Movie.should_receive(:find_by_id).with("1").and_return(@fake_movie)
      Movie.should_receive(:find_by_director).with(@fake_movie.director).and_return(@fake_movies)
      get :similar, {:id => "1"}
    end

    it 'should select the Similiar Movies template for rendering' do
      Movie.should_receive(:find_by_id).with("1").and_return(@fake_movie)
      Movie.should_receive(:find_by_director).with(@fake_movie.director).and_return(@fake_movies)
      get :similar, {:id => "1"}
      response.should render_template('similar')
    end

    it 'it should make the results available to the template' do
      Movie.should_receive(:find_by_id).with("1").and_return(@fake_movie)
      Movie.should_receive(:find_by_director).with(@fake_movie.director).and_return(@fake_movies)
      get :similar, {:id => "1"}
      assigns(:movies).should == @fake_results
    end
  end
end
