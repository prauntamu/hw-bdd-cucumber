#paige raun
#software engineering tamu csce 431 
#singapore wintermester 2020 

# Add a declarative step here for populating the DB with movies.


Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  (page.body).index(e1) < (page.body).index(e2)
  #`````````````````` fail "Unimplemented"
end

Given /^(?:|I )check the following ratings list:$/ do |rating_list|
  
  "PG, G, R, PG-13".split(',').each do |rating|
    uncheck("ratings_#{rating.strip}") 
  end 
  
  rating_list.split(',').each do |rating|
    check("ratings_#{rating.strip}")
  end 

end 

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  #strip the "" 
  rating_list.split(',').each do |rating|
      if uncheck
        uncheck( "ratings_#{rating.strip}") 
      else 
        check( "ratings_#{rating.strip}")
      end 
      
  end 

  
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  

  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"
  #the table id is counted as a row which is why the 1
  # I couldnt figure out how to get the number of rows in the table so I googled it 
  # https://stackoverflow.com/questions/37018177/how-to-get-row-count-from-a-table-using-ruby-capybara
  #thats where i found page.all(:css, 'table tr').size 
  expect(page.all(:css, 'table tr').size).to eq (Movie.count+1)


end
