class ImportingFilesJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    spreadsheet = Roo::Spreadsheet.open(file_path)

    header_row = spreadsheet.row(1)
    error_rows = []
    error_messages = []
    data_row = []
    (2..spreadsheet.last_row).each do |row_index, row|
      row = header_row.map.with_index { |attr, index| [attr, spreadsheet.row(row_index)[index]] }.to_h
      comment = Comment.create(row)
			if !comment.save
				error_rows << row_index - 1
        data_row << row
        error_messages << comment.errors.full_messages.to_sentence
			end
    end

    File.delete(file_path)

    if error_rows.any?
      csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Row Index', 'Row Data', 'Error Message']
        error_rows.each_with_index do |row_index, index|
          csv << [row_index, data_row[index], error_messages[index]]
        end
      end
      ImportFileMailer.error_notification(csv_data).deliver_now
    end
  end
end
