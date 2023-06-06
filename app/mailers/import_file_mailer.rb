class ImportFileMailer < ApplicationMailer
  default from: 'irtazaazeem678@gmail.com'

  def error_notification(csv_data)
    attachments['error_rows.csv'] = {
      mime_type: 'text/csv',
      content: csv_data
    }

    mail(to: 'izzubhai3@gmail.com', subject: 'Importing Files Error')
  end
end
