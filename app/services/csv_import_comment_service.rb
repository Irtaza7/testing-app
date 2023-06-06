class CsvImportCommentService
	require "csv"
  def csv(file)
    file = File.open(file)
		csv = CSV.parse(file, headers: true)
		csv.each do |row|
			comment_hash = {}
			comment_hash[:content] = row ["content"]
			comment_hash[:article_id] = row ["article_id"]
			comment_hash[:user_id] = row ["user_id"]
		  Comment.create(comment_hash)
		end
  end
end