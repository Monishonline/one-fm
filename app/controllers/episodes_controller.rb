class EpisodesController < ApplicationController
before_action :authenticate_podcast!, except: [:show]
before_filter :require_permission
before_action :find_podcast
before_action :find_episodes, only: [:show, :edit, :update, :destroy]

	def new
		@episode = @podcast.episodes.new
	end

	def create
       @episode = @podcast.episodes.new episode_params
       if @episode.save
       	redirect_to podcast_episode_path(@podcast,@episode)
       else
       		render 'new'
       	end
	end

	def show
		@episode = Episode.where(podcast_id: @podcast).order("created_at DESC").reject {|e| e.id == @episodes.id}
	end

	def edit
      @podcast = Podcast.find(params[:podcast_id])
      @episode = @podcast.episodes.find(params[:id])
	end

	def update
		@podcast = Podcast.find(params[:podcast_id])
      @episode = @podcast.episodes.find(params[:id])
		if @episode.update episode_params
			redirect_to podcast_episode_path(@podcast, @episode), notice: "Episode was succesfully updated!"
		else
			render 'edit'
		end
	end

    def destroy
    	@podcast = Podcast.find(params[:podcast_id])
      @episode = @podcast.episodes.find(params[:id])
		@episode.destroy
		redirect_to root_path
	end


	private

	def episode_params
		params.require(:episode).permit(:title, :description, :avatar)
	end

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end

	def find_episodes
		@episodes =Episode.find(params[:id])
	end

	def require_permission
		@podcast = Podcast.find(params[:podcast_id])
		if current_podcast != @podcast
			redirect_to root_path, notice: "Sorry, you're not allowdwd to view that page"
	end
	end
end
