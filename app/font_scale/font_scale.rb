class FontScale

  def self.size(collection)

    @count = collection.count

    if @count < 10 
      10
    elsif @count >= 10 and @count < 50
      @count * 1.25
    elsif @count >= 50 and @count < 80
      @count
    elsif @count >= 80 and @count < 200
      @count * 0.2
    else
      @count * 0.1
    end
  end

end 