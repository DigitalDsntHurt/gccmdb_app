class Measure < ApplicationRecord
  belongs_to :country
  belongs_to :data_source


  ##
  ## ##
  ## ## ## DATA QUERIES
  ## ##
  ##  
  def self.all_measures
    Measure.all
  end


  ##
  ## ## MEASURES PER YEAR
  ##

  def self.measures_written_per_year_count
    Measure.all.group_by{|measure| measure.measure_written_year }.reject{|array| array == nil }.map{|year,measures| [year,measures.count] }.sort_by{|year,measures| measures }
  end


  ##
  ## ## MEASURES BY COUNTRY
  ##

  def self.measures_by_country
    @payload = []
    Country.all.each{ |country|
      @payload << [country, Measure.where(country_id: country.id).count]
    }

    @payload.sort_by{|country,count| count }.reverse
  end

  def self.measure_written_year_range_by_country
    @payload = []
    Country.all.each{|country|
      @measure_written_years = Measure.where(country_id: country.id).pluck(:measure_written_year).reject{|year| year == nil }.sort

        @first = @measure_written_years.first
        @last = @measure_written_years.last
        @payload << [country.country, @first, @last]

    }

    @payload
  end

  def self.measure_implementation_start_year_range_by_country
    @payload = []
    Country.all.each{|country|
      @measure_years = Measure.where(country_id: country.id).pluck(:measure_implementation_period_start_year).reject{|year| year == nil }.sort

        @first = @measure_years.first
        @last = @measure_years.last
        @payload << [country.country, @first, @last]

    }

    @payload
  end

  def self.measure_implementation_end_year_range_by_country
    @payload = []
    Country.all.each{|country|
      @measure_years = Measure.where(country_id: country.id).pluck(:measure_implementation_period_end_year).reject{|year| year == nil }.sort

        @first = @measure_years.first
        @last = @measure_years.last
        @payload << [country.country, @first, @last]

    }

    @payload
  end


  ##
  ## ## MEASURE IMPLEMENTATION YEAR FREQUENCY
  ##

  def self.measure_implementation_start_year_frequency
    Measure.all.group_by{|measure| measure.measure_implementation_period_start_year }.reject{|hsh| hsh == nil }.to_a.map{|k,v| [k,v.count] }.sort_by{|arr| arr[0] }
  end

  def self.measure_implementation_end_year_frequency
    Measure.all.group_by{|measure| measure.measure_implementation_period_end_year }.reject{|hsh| hsh == nil }.to_a.map{|k,v| [k,v.count] }.sort_by{|arr| arr[0] }
  end



  ##
  ## ## MEASURE STATUSES
  ##

  def self.unique_measure_statuses
    Measure.all.pluck(:measure_status).uniq
  end

  def self.status_frequencies
    hsh = Hash.new(0)
    
    unique_measure_statuses.each{|status|
      hsh[status] += Measure.where(measure_status: status).count
    }

    hsh.sort_by{|k,v| v }.reverse
  end


  def self.all_measure_statuses_by_country
    @status_totals_per_country = []

    Country.all.each{|country|
      @hsh = Hash.new(0)
      Measure.where(country_id: country.id).pluck(:measure_status).each{|status|
        @hsh[status] += 1
      }

      @status_totals_per_country << [country.country, @hsh.sort_by{|k,v| -v }]

    }

    @status_totals_per_country
  end

  def self.active_measure_status_by_country
    @active_statuses = ["Ongoing", "In Force", "Operational"]
    @status_totals_per_country = []

    Country.all.each{|country|
      @count = 0
      Measure.where(country_id: country.id).pluck(:measure_status).select{|status| @active_statuses.include?(status) }.each{|status|
        @count += 1
      }

      @status_totals_per_country << [country.country, @count, Measure.where(country_id: country.id).count]

    }

    @status_totals_per_country
  end

  def self.completed_measure_status_by_country
    @active_statuses = ["Completed", "Implemented", "Ended", "Concluded", "Adopted"]
    @status_totals_per_country = []

    Country.all.each{|country|
      @count = 0
      Measure.where(country_id: country.id).pluck(:measure_status).select{|status| @active_statuses.include?(status) }.each{|status|
        @count += 1
      }

      @status_totals_per_country << [country.country, @count, Measure.where(country_id: country.id).count]

    }

    @status_totals_per_country
  end

  def self.canceled_measure_status_by_country
    @active_statuses = ["Canceled"]
    @status_totals_per_country = []

    Country.all.each{|country|
      @count = 0
      Measure.where(country_id: country.id).pluck(:measure_status).select{|status| @active_statuses.include?(status) }.each{|status|
        @count += 1
      }
      @status_totals_per_country << [country.country, @count, Measure.where(country_id: country.id).count]
    }

    @status_totals_per_country
  end


  ##
  ## ## MEASURE JUSRISDICTIONS
  ##

  def self.unique_jurisdictions
    Measure.all.pluck(:jurisdiction).uniq
  end

  def self.jurisdiction_frequencies
    hsh = Hash.new(0)

    unique_jurisdictions.each{|jurisdiction|
      hsh[jurisdiction] = Measure.where(jurisdiction: jurisdiction).count
    }

    hsh.sort_by{|k,v| v }.reverse
  end

  def self.unique_jurisdictions_by_country
    @payload = []

    Country.all.each{|country|
      @country_measures = Measure.where(country_id: country.id)
      @uniq_jurisdictions = @country_measures.pluck(:jurisdiction).uniq.reject{|j| j == ".." or j == nil }
      @payload << [country.country, @uniq_jurisdictions.count, @uniq_jurisdictions]
    }

    @payload
  end

  ##
  ## ## MEASURE AGENCY
  ##

  def self.avg_agencies_per_country
    @payload = []

    Country.all.each{|country|
      @country_measures = Measure.where(country_id: country.id)
      @country_agencies = @country_measures.pluck(:agency).reject{|agency|  agency == nil}
      if @country_agencies.count == 0
        @payload << [country.country, 0]
      else 
        @country_agencies_avg = @country_agencies.map{|agency| agency.split(",").count }.inject{|count,sum| count + sum } / @country_measures.count
        @payload << [country.country, @country_agencies_avg]
      end
    }

    @payload
  end

  ##
  ## ## MEASURE REPORTED FINANCIAL COST
  ##

  def self.measures_with_reported_financial_cost_per_country
    @payload = []
    Country.all.each{|country|
      @country_total = Measure.where(country_id: country.id)
      @count = @country_total.reject{|measure| measure.measure_financing_quantity == nil or measure.measure_financing_quantity == 0 }.count
      @payload << [country.country, @count, @country_total.count]
    }

    @payload
  end


  ##
  ## ## MEASURE TARGETS
  ##
  def self.target_frequencies
    hsh = Hash.new(0)

    MeasureTarget.all.each{|target|
      hsh[target] = Measure.where('measure_targets && ARRAY[?]::varchar[]', target.id).count
    }

    hsh.sort_by{|k,v| v }.reverse
  end

  ##
  ## ## MEASURE GHGS AFFECTED
  ##
  def self.total_unique_ghs_in_dataset
    @payload = []

    Measure.all.pluck(:ghgs_affected).reject{|ghg| ghg == nil }.map{|ghg| ghg.split(",") }.flatten.map{|ghg| ghg.strip }.uniq.each{|ghg|
      @payload << [ghg, Measure.where("ghgs_affected LIKE ?", "#{ghg}").count]
    }

    @payload
  end

end
