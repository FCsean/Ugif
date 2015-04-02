class GifsController < ApplicationController
  
  def gif_params
    params.require(:gif).permit(:title, :gif, :descriptions)
  end
  
  def create
    @gif = Gif.new(gif_params)
    @gif.user = current_user
    @gif.views = 0
    if @gif.save
      if params[:tags]
        array = params[:tags].remove(" ").split(",")
        array.each { |x| 
          found = Tag.where(tag:x)[0]
          if found
            @gif.tags << found
          else
            tag = Tag.new(tag:x)
            tag.save
            @gif.tags << tag
          end
        }
      end
      redirect_to root_url
    else
      flash.now.alert = "Lacking title or gif."
      render "upload"
    end
  end
  def home
    current_user
  end
  
  def upload
    logged_in?
    @gif = Gif.new
  end
end
