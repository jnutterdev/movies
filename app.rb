require 'sinatra'
require 'movie'
require 'movie_store'

# Create a MovieStore that updates the movies.ynl file
store = MovieStore.new('movies.yml')

get('/movies') do
    @movies = store.all # Load all Movie objects from movies.yml
    erb :index # Embed movies in HTML from views/index.erb and return it
end

get('/movies/new') do
    erb :new # Return HTML in views/new.erb
end

post('/movies/create') do # Submitted form data goes here
    @movie = Movie.new # Create object to hold form data
    @movie.title = params['title'] # Add the form data to the object
    @movie.director = params['director'] # form data
    @movie.year = params['year'] # form data
    store.save(@movie) # Save the object!
    redirect 'movies/new' # Show a new, empty form
end

get('/movies/:id') do
    id = params['id'].to_i # Convert the 'id' parameter from a string to an integer
    @movie = store.find(id) # Use the ID to load the movie from the store
    erb :show # Embed the movie in the HTML from show.erb and return it to the browser
end