# Preview all emails at http://localhost:3000/rails/mailers/import_file
class ImportFilePreview < ActionMailer::Preview
  def error_notification
    ImportFileMailer.error_notification(data_rows, error_messages, csv_data)
  end
end
