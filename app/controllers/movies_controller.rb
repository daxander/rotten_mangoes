class MoviesController < ApplicationController

      def search
        @movies = Movie.all
        @movies = @movies.where("title LIKE ?", "%#{params[:title]}%") 
        @movies = @movies.where("director LIKE ?", "%#{params[:director]}%") 
        if params[:duration] != "None"
          split = params[:duration].split("-")
          min = split[0]
          max = split[1]
          @movies = @movies.where(runtime_in_minutes:  (min..max)) 
        end
        render :index
      end

      def index
        @movies = Movie.all
      end

      def show
        @movie = Movie.find(params[:id])
      end

      def new
        @movie = Movie.new
      end

      def edit
        @movie = Movie.find(params[:id])
      end

      def create
        @movie = Movie.new(movie_params)

        if @movie.save
          redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
        else
          render :new
        end
      end

      def update
        @movie = Movie.find(params[:id])

        if @movie.update_attributes(movie_params)
          redirect_to movie_path(@movie)
        else
          render :edit
        end
      end

      def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to movies_path
      end

      protected

      def movie_params
        params.require(:movie).permit(
          :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
        )
      end

    end