class FontScale

  def self.size(n)
    #@count = collection.count

    @range = [10.0,80.0]
    @interval = ( @range[1] - @range[0] ) / n

    return n * @interval 
  end

  def self.relative_font_scale(numbers)
    @target_range = [10.0,80.0 ]

    numbers.map{|n| n - numbers.min / numbers.max * @target_range[0] + @target_range[0] }
  end

  def self.hey(nums)
    @range = [10,80]
    @range_min = @range.min
    @range_max = @range.max

    @nums_min = nums.min
    @nums_max = nums.max

    return (@range_min + (@nums_min) * ((@range_max - @range_min)/(@nums_max - @nums_min))).to_f

  end

  def self.again(nums)
    min = 10.0
    max = 80.0
    nums.map{|n| n + 10}.map{|n| (n - min) / (max - min) }
  end

  def self.try(nums)
    @min = 10.0
    @max = 80.0
    #nums.map{|n| (((n - nums.min) / (nums.max - nums.min)) * (@max - @min)) + @min }

    @new = []
    nums.each{|num|
      @one = num - nums.min
      @two = @one / (nums.max - nums.min)
      @three = @two * (@max - @min)
      @four = @three + @min
      @new << @four
    }
    @new
  end

  def self.yee(nums)
    @range_min = 10.0
    @range_max = 80.0

    @nums_min = nums.min
    @nums_max = nums.max

    @nums_range = @max = @min

    nums.map{|n| (n - @min) * scale / @nums_range }
  end
end 