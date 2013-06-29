class BigUrl < Base
  attr_accessible :n_big_url_id,
                  :vc_real_url,
                  :vc_short_url,
                  :vc_rem,
                  :d_create

  validates_presence_of :vc_real_url

  def self.find_by_id(id)
    self.find_by(n_big_url_id: id)
  end

  def self.find_by_alias(als)
    self.find_by(vc_short_url: als)
  end

end
