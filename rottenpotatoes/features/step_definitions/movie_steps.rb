# Add a declarative step here for populating the DB with movies.




Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
      Movie.create(title:movie[:title], rating: movie[:rating], release_date:movie[:release_date])
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
 # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  all_page = page.body 
  index_1 = all_page.index(e1)
  index_2 = all_page.index(e2)
  if index_1 > index_2
      fail 
  end
 # assert index_1 < index_2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    #print(uncheck)
    rating_list.split(',') do |rating| 
        if not uncheck
            check('ratings_' + rating.lstrip)
        else 
            uncheck('ratings_' + rating.lstrip)
        end
    end


end

Then /I should see all the movies/ do
  all_movies = Movie.all
    
  all_movies.each do |m| 
      page.should have_content(m.title)
  end
end

When('I press {string}') do |string|
  click_button(string)
end




    

