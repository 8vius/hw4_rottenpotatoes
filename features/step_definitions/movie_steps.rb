# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    db_movie = Movie.find_or_create_by_title(movie[:title], :rating => movie[:rating], :release_date => movie[:release_date])
    if !db_movie
      assert false, "#{movie[:title]} movie does not exist"
    end
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page_string = page.body
  ordered_list = [e1,e2].sort
  e1_index = page_string.index(e1)
  e2_index = page_string.index(e2)
  assert e1_index < e2_index
end

Then /I should( not)? see the following movies: (.*)/ do |not_see, movie_list|
  movies = movie_list.strip.split(',') 
  movies.each do |movie|
    step %Q{I should#{not_see} see "#{movie}"}
  end
end

Then /I should see all the movies/ do
  count = Movie.count  
  assert count == 10
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.gsub(/\s+/, "").split(',')
  ratings.each do |rating|
    step %Q{I #{uncheck}check "ratings_#{rating}"}
  end
end

Then /^the director of "(.*)" should be "(.*)"/ do |movie_title, director|
  movie = Movie.find_by_title(movie_title)
  assert movie.director == director
end
