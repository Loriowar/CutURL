class HomeController < BaseController

  def create
    big_url = BigUrl.create(params[:big_url])
    binding.pry
    redirect_to :root
  end

  def redirect_to_url
    big_url = BigUrl.find_by_alias(params[:vc_short_url])
    redirect_to big_url.vc_real_url
  end

end
