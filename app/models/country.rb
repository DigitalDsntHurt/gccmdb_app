class Country < ApplicationRecord
  has_many :measures

  
  ##
  ## ## DATA QUERIES
  ##

  def self.ghgs_targeted_by_country
    @payload = []
    Country.all.each{|country|
      @ghgs_affected = Measure.where(country_id: country.id).pluck(:ghgs_affected).reject{|ghg| ghg == nil }.map{|ghg| ghg.split(",") }.flatten.uniq
      @payload << [country,@ghgs_affected]
    }

    @payload.reject{|country,ghgs| ghgs.count == 0 }.sort_by{|country,ghgs| ghgs.count }.reverse
  end

  def self.measures_with_ghg_reduction_targets_2020_2030_by_country
    @payload = []
    Country.all.each{|country|
      @twentytwenty = Measure.where(country_id: country.id).where.not(total_ghg_emissions_reductions_in_2020: nil).where.not(total_ghg_emissions_reductions_in_2020: 0).count
      @twentythirty = Measure.where(country_id: country.id).where.not(total_ghg_emissions_reductions_in_2030: nil).where.not(total_ghg_emissions_reductions_in_2030: 0).count
      @payload << [country,@twentytwenty,@twentythirty] unless @twentytwenty == 0 and @twentythirty == 0
    }

    @payload.sort_by{|country,twenty,thirty| twenty + thirty }.reverse
  end

  def self.avg_targeted_ghg_reduction_target_in_2020_by_country
    @payload = []
    Country.all.each{|country|
      @twentytwenty = Measure.where(country_id: country.id).where.not(total_ghg_emissions_reductions_in_2020: nil).where.not(total_ghg_emissions_reductions_in_2020: 0).pluck(:total_ghg_emissions_reductions_in_2020)
      unless @twentytwenty.count == 0
        @avg = @twentytwenty.inject{|target, sum| target + sum } / @twentytwenty.count
        @payload << [country,@avg]
      end
    }

    @payload.sort_by{|country,avg| avg }.reverse
  end

  def self.avg_targeted_ghg_reduction_target_in_2030_by_country
    @payload = []
    Country.all.each{|country|
      @twentythirty = Measure.where(country_id: country.id).where.not(total_ghg_emissions_reductions_in_2030: nil).where.not(total_ghg_emissions_reductions_in_2030: 0).pluck(:total_ghg_emissions_reductions_in_2030)
      unless @twentythirty.count == 0
        @avg = @twentythirty.inject{|target, sum| target + sum } / @twentythirty.count
        @payload << [country,@avg]
      end
    }

    @payload.sort_by{|country,avg| avg }.reverse
  end

end
