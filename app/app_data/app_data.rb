class AppData

  def self.count_records_in_all_models
    @models = []
    Dir.foreach("app/models") { |model_path|
      if model_path.include?(".rb")
        next if model_path == "application_record.rb"
        @model_display_name = model_path.gsub(".rb","").gsub("_"," ").split(" ").map{|string| string.capitalize }.join("").pluralize
        @model_records_count = @model_display_name.singularize.constantize.all.count
        @models << [@model_display_name, @model_records_count]
      end
    }

    @models.sort_by{|model,count| count }.reverse
  end

  def self.summaries
    @summaries = []
    Dir.foreach("app/views/summaries/slices") { |summary_partial|
      next if summary_partial[0] != "_"
      @summaries << summary_partial
    }

    @summaries
  end

end