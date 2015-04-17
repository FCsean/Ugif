class GifsController < ApplicationController
  before_filter :current_user
  def gif_params
    params.require(:gif).permit(:title, :gif, :description)
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
      redirect_to "/view/"+@gif.id.to_s
    else
      flash.now.alert = "Lacking title or gif."
      render "upload"
    end
  end
  
  def home
   if current_user
   else
    @gifs = Gif.order("views desc").limit(10)
   end
  end
  
  def upload
    logged_in?
    @gif = Gif.new
  end
  
  def view
  
    @gif = Gif.find(params[:id])
    @comments = @gif.comments.to_a
    if !@gif
      redirect_to root_url
    end
    @gif.views += 1
    @gif.save
    
    user = current_user
    if user
      if user.have_watched.where(id:@gif.id).length == 0
        user.have_watched << @gif
      end
    end
  end
  
  def search
    @query = params[:query]
    gifs = Gif.where("title like ? or description like ?", "%"+@query+"%", "%"+@query+"%")
    @results = gifs.to_a
    words = @query.downcase.remove(",").split(" ")
    words.each do |word|
      tags = Tag.where(tag:word).first
      if tags
        tags = tags.gifs.scope
        @results += tags.to_a
      end
    end
    username = User.where(username:@query).first
    if username
      usernamegifs = username.gifs.scope
      @results += usernamegifs.to_a
    end
      @results = @results.uniq
  end
  
  def comment
    comment = params[:comment]
    gifid = params[:gifid]
    if !current_user
      redirect_to '/signin'
    else
      com = Comment.new()
      com.comment = comment
      com.gif = Gif.find(gifid)
      com.user = current_user
      com.save
      redirect_to '/view/'+gifid
    end
    
  end
end
