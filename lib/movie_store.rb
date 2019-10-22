require 'yaml/store' # Load the YAML::Store class

# The MovieStore class is responsible for saving Movie objects to the YAML file and retrieving them later

class MovieStore
    
    def initialize(file_name)
        @store = YAML::Store.new(file_name) # Create a store that reads/writes the given filename
    end

    def find(id) # Find the Movie with this ID
        @store.transaction do # Accessing the store requires a transaction
            @store[id] # Return the Movie object stored under this key
        end
    end

    def all # Retreives all movies in the store
        @store.transaction do # Must be in a transaction
            @store.roots.map { |id| @store[id] } # Create an array with the values for each key
        end
    end

    def save(movie) # Saves a Movie to the store
        @store.transaction do # Must be in a transaction
            unless movie.id # If the movie doesn't have an ID
                highest_id = @store.roots.max || 0 # Find the highest key
                movie.id = highest_id + 1 # And increment it
            end
            @store[movie.id] = movie # Store the movie under the key matching its ID
        end    
    end
end

