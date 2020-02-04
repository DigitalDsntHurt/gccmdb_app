class ScratchController < ApplicationController
  def back

    
    
    
    @font_sizes = []
    @start = 10.0
    50.times do 
      @font_sizes << @start
      @start += 1
    end
  end
  
  def homepage
  end

  def one
  end

  def summaries
    @models = []
    Dir.foreach("app/models") { |model_path|
      puts model_path
      if model_path.include?(".rb")
        next if model_path == "application_record.rb"
        @models << model_path.gsub(".rb","").gsub("_"," ").split(" ").map{|string| string.capitalize }.join("").pluralize
      end
    }

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Year' )
    data_table.new_column('number', 'Measures Written')

    # Add Rows and Values
    data_table.add_rows(Measure.measures_written_per_year_count.map{|year,count| [year.to_s,count] })
    options = { legend: {position: "none"}, height: "600", bar: {width: "16"} }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, options)
    
  end
end
