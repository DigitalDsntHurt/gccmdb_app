class FontScale

  # def self.scale(collection)
  #   @count = collection.count
  #   if @count < 10 
  #     @scale = 1.25
  #     arr = [@count,@scale]
  #   if @count < 15
  #     @scale = 1.25
  #     arr = [@count,@scale]
  #   elsif @count < 80
  #     # small font scale
  #     @scale = 1
  #     arr = [@count,@scale]
  #   elsif @count >= 80 and @count < 200
  #     @scale = 0.2
  #     arr = [@count,@scale]
  #   else
  #     # large font scale
  #     @scale = 0.1
  #     arr = [@count,@scale]
  #   end


  #   return arr
  # end

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