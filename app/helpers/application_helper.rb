module ApplicationHelper
  def get_current_path_with_locale(locale)
    current_url = request.fullpath
    if current_url =~ /locale=[a-z]{2}/
      current_url.gsub(/locale=[a-z]{2}/, "locale=#{locale}")
    elsif current_url.include?('?')
      "#{current_url}&locale=#{locale}"
    else
      "#{current_url}?locale=#{locale}"
    end
  end
end
