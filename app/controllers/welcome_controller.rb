class WelcomeController < ApplicationController

	def import
		redirect_path = welcome_index_path
		# Assuming `uploaded_file` is an ActionDispatch::Http::UploadedFile object.
		uploaded_file = params[:file]
		# Generate a unique filename.
		filename = "#{Time.now.to_i}_#{uploaded_file.original_filename}"
		# Determine a location to store the file.
		directory = "public/uploads"
		# Create the directory if it doesn't exist.
		Dir.mkdir(directory) unless Dir.exist?(directory)
		# Full path
		file_path = Rails.root.join(directory, filename)
		# Write the uploaded file to this location.
		File.open(file_path, 'wb') do |file|
			file.write(uploaded_file.read)
		end
		ImportingFilesJob.perform_later(file_path.to_s)

	end

	def index
		@comments = Comment.all
	end
end