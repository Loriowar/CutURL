class HomeController < BaseController

  def create
    big_url = BigUrl.create(params[:big_url])
    #TODO create message about success and error
    redirect_to :root
  end

  def redirect_to_big_url
    big_url = BigUrl.find_by_alias(params[:vc_short_url])
    if big_url.present?
      redirect_to big_url.vc_real_url
    else
      #TODO create error message
      redirect_to :root
    end
  end

end
