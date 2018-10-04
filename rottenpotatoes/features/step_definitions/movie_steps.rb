Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

When(/^the director of "(.*?)" should be "(.*?)"$/) do |arg1, arg2|
    movie = Movie.find_by_title(arg1)
    expect(movie.director).to eq arg2
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  test1 = page.body.index(e1)
  test2 = page.body.index(e2)
  if e2 < e1 && e1 && e2
    fail "didn't appear in correct order"
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    field = "ratings_#{rating.strip}"
    if uncheck
      uncheck field
    else
      check field
    end
  end
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movie_hash = Movie.group(:id).count
  movie_counter = movie_hash.keys.count
  page.all('table#movies tr').count.should == movie_counter + 1
end