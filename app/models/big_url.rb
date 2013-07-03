class BigUrl < Base

  attr_accessible :n_big_url_id,
                  :vc_real_url,
                  :vc_short_url,
                  :vc_rem,
                  :d_create

  after_initialize :init_default

  before_save :prepare_alias,
              :fix_real_url

  validates_presence_of :vc_real_url

  validates_uniqueness_of :vc_short_url, :allow_blank => true

  validates_length_of :vc_short_url, :maximum => 16
  validates_length_of :vc_real_url,  :maximum => 2000

  validate :check_url_format


  #Class methods

  class << self
    # Find method for comfortable
    def find_by_id(id)
      self.find_by(n_big_url_id: id)
    end

    # Find method for comfortable
    def find_by_alias(als)
      self.find_by(vc_short_url: als)
    end

    # Clear big_urls table
    def wipe
      BigUrl.all.each do |rec|
        rec.delete
      end
    end

    # Simple alternative for SecureRandom
    def generate_rand_seq(n = 8)
      rnd_list =  [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
      (0...n).map{ rnd_list[rand(rnd_list.length)] }.join
    end

    # Generate uniq sequence for url_name
    def generate_short_name
      short_name = SecureRandom.hex(4)
      until BigUrl.find_by_alias(short_name).nil?
        short_name = SecureRandom.hex(4)
      end
      short_name
    end
  end


  # Object methods

  # Set random alias for record
  def prepare_alias
    if !errors.any? && vc_short_url.blank?
      self.vc_short_url = BigUrl.generate_short_name
    end
  end

  # Set suffix for correct redirect
  def fix_real_url
    unless errors.any?
      unless vc_real_url =~ /^http(s)?:\/\//
        self.vc_real_url = "http://" << vc_real_url
      end
    end
  end

  def check_url_format
    # Regex for common url
    if vc_real_url =~ /^((http|https|ftp)\:\/\/)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9\-\._\?\,\'\/\\+\&\%\$\#\=\~])*$/ || vc_real_url.blank?
      true
    else
      errors.add(:vc_real_url, 'has wrong format')
      false
    end
  end

  # Initialize default values for record
  def init_default
    self.d_create ||= DateTime.now
  end

end
