class GifsController < ApplicationController
  before_filter :current_user
  def gif_params
    params.require(:gif).permit(:title, :gif, :descriptions)
  end
  
  def create
    @gif = Gif.new(gif_params)
    @gif.user = current_user
    @gif.views = 0
    if @gif.save
      if params[:tags]
        array = params[:tags].downcase.remove(" ").split(",")
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
  end
  
  def upload
    logged_in?
    @gif = Gif.new
  end
  
  def view
  
    @gif = Gif.find(params[:id])
    if !@gif
      redirect_to root_url
    end
    @gif.views += 1
    @gif.save
  end
end
