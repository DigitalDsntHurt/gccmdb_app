# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

# #
# # ## seed Countries Table
# #
# @start_count = Country.all.count
# country_payload = []
# country_csv = CSV.read('lib/truth_csvs/Country.csv', headers: true)
# country_csv.each{|row|
#   country_payload << row.to_h.map{|k,v| [k.to_sym, v] }.to_h
# }

# sorted_country_payload = country_payload.sort_by{|hsh| hsh[:country] }
# #p sorted_country_payload
# Country.create(sorted_country_payload)
# puts "#{Country.all.count - @start_count} Country records created"






# ##
# ## ## seed DataSources Table
# ##
# @start_count = DataSource.all.count
# data_source_payload = []
# data_source_csv = CSV.read('lib/truth_csvs/DataSource.csv', headers: true)
# data_source_csv.each{|row|
#   data_source_payload << row.to_h.map{|k,v| [k.to_sym, v] }.to_h
# }

# sorted_data_source_payload = data_source_payload.sort_by{|hsh| hsh[:source] }
# #p sorted_data_source_payload
# DataSource.create(sorted_data_source_payload)
# puts "#{DataSource.all.count - @start_count} DataSource records created"






# ##
# ## ## seed MeasureTargets Table
# ##
# @start_count = MeasureTarget.all.count
# measure_target_payload = []
# measure_target_csv = CSV.read('lib/truth_csvs/MeasureTarget.csv', headers: true)
# measure_target_csv.each{|row|
#   measure_target_payload << row.to_h.map{|k,v| [k.to_sym, v] }.to_h
# }

# sorted_measure_target_payload = measure_target_payload.sort_by{|hsh| hsh[:target] }
# # 
# ## verify uniqueness
# #
# # p sorted_measure_target_payload
# # p sorted_measure_target_payload.map{|hsh| hsh[:target] }.count
# # p sorted_measure_target_payload.map{|hsh| hsh[:target] }.uniq.count
# # p sorted_measure_target_payload.map{|hsh| hsh[:target] }.detect{ |e| sorted_measure_target_payload.map{|hsh| hsh[:target] }.count(e) > 1 }
# MeasureTarget.create(sorted_measure_target_payload)
# puts "#{MeasureTarget.all.count - @start_count} MeasureTarget records created"






# ##
# ## ## seed Measures Table
# ##
# @start_count = Measure.all.count
# measure_payload = []
# measure_csv = CSV.read('lib/truth_csvs/Measure_ids.csv', headers: true)
# measure_csv.each{|row|
#   measure_payload << row.to_h.map{|k,v| [k.to_sym, v] }.to_h
# }

# #sorted_measure_payload = measure_payload.sort_by{|hsh| hsh[:name] }


# measure_payload.each{|hsh|
#   hsh.each{|k,v|
    
#     # replace country string with country id
#     if k == :country_id
#       @country = Country.where(country: v)[0]
#       unless @country == nil
#         hsh[k] = @country.id
#       end
#     end

#     # replace data source string with country id
#     if k == :data_source_id
#       @source = DataSource.where(source: v)[0]
#       unless @source == nil
#         hsh[k] = @source.id
#       end
#     end

#     # replace measure targets string with array of measure target ##ids##
#     if k == :measure_targets
#       if v == nil
#         hsh[k] = []
#       else
#         measure_strings = v.split(", ")
#         targets = []
#         measure_strings.each{|string|
#           if string.include?("/")
#             string.split("/").each{|s|

#               @target = MeasureTarget.where(target: s.strip)[0] #.gsub(" ","")
#                 # puts s
#                 targets << @target.id
#               }
#           else
#             @target = MeasureTarget.where(target: string.strip)[0]
#               # puts string
#               targets << @target.id
#           end
#           hsh[k] = targets
#         }
#       end
#     end
#   }
#   # p hsh
#   # puts ""
# }

# Measure.create(measure_payload)
# puts "#{Measure.all.count - @start_count} Measure records created"




# Measure.all.group_by{|measure| measure.measure_written_year }.reject{|hsh| hsh == nil }.to_a.sort_by{|hsh| hsh[0] }.in_groups_of(10).each{ |group_measure_group|
#   group_measure_group.reject{|a| a == nil }.each{|measure_group| 
#     if measure_group.join().length == 0
#     puts "==="
#     p measure_group[0]
#     p measure_group[1]
#     p measure_group.count
#     p measure_group.class
#     p FontScale.scale(measure_group[1])
#     end

#   }
# }


# numbers = [0,3,4,7,9,13,22].map{|n| n.to_f }
# target_range = [10.0,80.0]

# puts "numbers array is #{numbers}"
# puts "target range is #{target_range}"

# # identify minimum number in numbers array
# min_number = numbers.min
# puts "min number is #{min_number}"

# # identify maximum number in numbers array
# max_number = numbers.max
# puts "max number is #{max_number}"

# # subtract the minimum number from every number in numbers array
# subtracted_numbers = numbers.map{|n| n - min_number }
# puts "subtracting min number from each number in the numbers array yields #{subtracted_numbers}" 

# # divide each number in numbers array by the max number
# divided_numbers = subtracted_numbers.map{|n| n / max_number }
# puts "dividing each number in the numbers array by the max number yields #{divided_numbers}" 

# # multiply each number by the min number of the target range
# multiplied_numbers = divided_numbers.map{|n| n * target_range.min }
# puts "multiplying each number in the numbers array by the min value in the target range yields #{multiplied_numbers}"

# # add the minimum number in the target range to each number in the numbers array
# added_numbers = multiplied_numbers.map{|n| n + target_range.min }
# puts "adding the min value in the target range to each number in the numbers array yields #{added_numbers}"


# puts 
# puts FontScale.try([1,2,3,4,5,6,7,8,9,10,50,100])


