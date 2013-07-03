class HomeController < BaseController

  def create
    @big_url = BigUrl.create(params[:big_url])

    # Clear variable after success save
    unless @big_url.errors.any?
      @big_url = nil
    end
    #TODO create message about success and error
    respond_to do |format|
      format.js
    end
  end

  def redirect_to_big_url
    @big_url = BigUrl.find_by_alias(params[:vc_short_url])
    if @big_url.present?
      redirect_to @big_url.vc_real_url
    else
      #TODO change 404 page
      not_found
    end
  end

end
