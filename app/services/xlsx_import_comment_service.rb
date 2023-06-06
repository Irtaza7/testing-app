class XlsxImportCommentService 
require 'roo'

  def excel_import(file)

    spreadsheet = Roo::Spreadsheet.open(file)

    header_row = spreadsheet.row(1)
    data_rows = []

    (2..spreadsheet.last_row).each do |row_index|
      row = header_row.map.with_index { |attr, index| [attr, spreadsheet.row(row_index)[index]] }.to_h
      comment = Comment.create(row)
    end
  end
end
