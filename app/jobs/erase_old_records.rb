class EraseOldRecords
  @queue = :simple

  def self.perform
    BigUrl.delete_expired
  end
end