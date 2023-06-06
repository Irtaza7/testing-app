class ImportFileJob < ApplicationJob
  queue_as :default

  # def perform(file_path)
  #   spreadsheet = Roo::Spreadsheet.open(file_path)

  #   header_row = spreadsheet.row(1)
  #   data_rows = []

  #   (2..spreadsheet.last_row).each do |row_index|
  #     row = header_row.map.with_index { |attr, index| [attr, spreadsheet.row(row_index)[index]] }.to_h
  #     comment = Comment.create(row)
	# 		if !comment.save
	# 			data_rows << row_index - 1
	# 			flash[:alert] = "Failed to import rows: #{data_rows.join(', ')}", comment.errors.full_messages.to_sentence
	# 		else
	# 			flash[:notice] = "Comments imported successfully"
	# 		end
  #   end
  # end
end
