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
    Measure.all.group_by{|measure| measure.measure_written_year }.reject{|array| array == nil }.map{|year,measures| [year,measures.count] }.sort_by{|array| array[0] }
  end

  # <%= column_chart Measure.measures_written_per_year_count %>
  # <%= column_chart Measure.measures_written_per_year_count.map{|year,count| {year: year, measures_written: count}} %>
  # <%= new Chartkick.column_chart [["Football", 10], ["Basketball", 5]] %>

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

    return hsh.sort_by{|k,v| v }.reverse
  end


  def self.all_measure_statuses_by_country
    @status_totals_per_country = []
    Country.all.each{|country|
      @hsh = Hash.new(0)
      Measure.where(country_id: country.id).pluck(:measure_status).each{|status|
        @hsh[status] += 1
      }

      @status_totals_per_country << [country.country, @hsh]

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

    return hsh.sort_by{|k,v| v }.reverse
  end


  ##
  ## ## MEASURE TARGETS
  ##
  def self.target_frequencies
    #@targets = MeasureTarget.all.pluck(:target).uniq

    hsh = Hash.new(0)

    MeasureTarget.all.each{|target|
      hsh[target.target] = Measure.where('measure_targets && ARRAY[?]::varchar[]', target.id).count
    }

    return hsh.sort_by{|k,v| v }.reverse
  end


end
