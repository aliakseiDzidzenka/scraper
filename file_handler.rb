class FileHandler
	attr_accessor :file_name

	def initialize(file_name)
		@file_name = file_name
	end
	def write_csv(data)
		csv_rows = []
		data.each do |e| 
			e.each_index do |i|  
				csv_rows[i] = [] if csv_rows[i].nil?
				csv_rows[i].push(e[i])
			end
		end
		CSV.open(file_name.to_s + '.csv', 'wb') do |csv|
   			csv_rows.each do |csv_row|
   				csv << csv_row
  			end
		end
	end
end