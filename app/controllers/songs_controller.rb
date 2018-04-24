class SongsController < ApplicationController

    def index
        redirect_to root_path if not_current_user
        @songs = Song.all
    end

    def create
         new_song = User.find(current_user.id).songs.new(song_params)
         new_song.count = 0
         if new_song.save
            User.find(current_user.id).adds.create(song:Song.find(new_song.id))
            flash[:success] = "song Successfully saved"
            redirect_to songs_path
         else
            flash[:errors] = new_song.errors.full_messages
           redirect_to songs_path
         end
    end

    def destroy
        Song.find(params[:song_id]).destroy
        redirect_to songs_path
    end

    def show
        redirect_to root_path if not_current_user
        @song = Song.find(params[:song_id])
    end

    def add
        new_song = Song.find(params[:song_id])
        number = new_song.count + 1
        new_song.update(count: number)
        User.find(current_user.id).adds.create(song:Song.find(params[:song_id]))
        redirect_to "/songs/#{params[:song_id]}"
    end

    def unadd
        User.find(current_user.id).adds.find_by(song:Song.find(params[:song_id])).destroy
        redirect_to "/songs/#{params[:song_id]}"
    end

    private
    def song_params
        params.require(:song).permit(:name, :description)
    end

end
