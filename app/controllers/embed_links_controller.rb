class EmbedLinksController < ApplicationController
  before_action :set_embed_link, only: [:show, :edit, :update, :destroy]

  @@tempBorder = false
  @@tempBorderColor = " "
  @@tempWidth = " "
  @@tempHeight = " "
  @@tempBottom = 0
  @@tempRight = 0
  @@tempPosition = " "

  # GET /embed_links
  def index
    @embed_links = EmbedLink.all
  end

  # GET /embed_links/1
  def show
  end

  # GET /embed_links/new
  def new
    @embed_link = EmbedLink.new
  end

  # GET /embed_links/1/edit
  def edit
    
  end

  # POST /embed_links
  def create
    @embed_link = EmbedLink.new(embed_link_params)

    if @embed_link.save

      newHeight = ""
      newWidth = ""
      case embed_link_params["size"]
      when "A small portion of the screen"
        newHeight = "200px"
        newWidth = "400px"
      when "A decent portion of the screen"
        newHeight = "400px"
        newWidth = "800px"
      when "A large portion of the screen"
        newHeight = "800px"
        newWidth = "1000px"
      else
        newHeight = "400px"
        newWidth = "800px"
      end

      @@tempHeight = newHeight
      @@tempWidth = newWidth

      @@tempBorder = embed_link_params["border"]
      @@tempBorderColor = embed_link_params["border_color"]

      newBottom = 0
      newRight = 1
      case embed_link_params["location"]
      when "The lower left corner"
        newBottom = 0
        newRight = 1
      when "The upper left corner"
        newBottom = 1
        newRight = 1
      when "The upper right corner"
        newBottom = 1
        newRight = 0
      when "The lower right corner"
        newBottom = 0
        newRight = 0
      else
        newBottom = -1
        newRight = -1
      end
      @@tempBottom = newBottom
      @@tempRight = newRight

      newSpecial = "";
      case embed_link_params["special_position"]
      when "I want users to be able to scroll past the embed page"
        newSpecial = "absolute"
      else
        newSpecial = "fixed"
      end
      @@tempPosition = newSpecial  

      # redirect_to @embed_link, notice: 'Embed link was successfully created.'
      redirect_to new_embed_link_confirm_path, success: embed_error_message + "Your code has been crafted!"
    else
      render :new
    end
  end

  # PATCH/PUT /embed_links/1
  def update
    if @embed_link.update(embed_link_params)
      redirect_to @embed_link, notice: 'Embed link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /embed_links/1
  def destroy
    @embed_link.destroy
    redirect_to embed_links_url, notice: 'Embed link was successfully destroyed.'
  end

  def embed_error_message
    msg = ""
    return msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embed_link
      @embed_link = EmbedLink.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def embed_link_params
      params.require(:embed_link).permit(:border, :border_color, :border_size, :size, :location, :special_position)
    end
end
