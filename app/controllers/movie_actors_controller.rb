class MovieActorsController < ApplicationController
  def create
    actor = Actor.find_by(name: params[:actor][:name])
    if actor
      movie = Movie.find(params[:actor][:movie_id])
      actor.movie_actors.create!({movie: movie})
    end
    redirect_to "/movies/#{params[:movie_id]}"
  end
end
