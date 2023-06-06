FactoryBot.define do
  factory :article do
    title { 'Sample Article' }
    description { 'This is a sample article.' }
    # trait :with_pdf do
    #   after(:create) do |article|
    #     pdf_file = generate_pdf(article) # Replace this with your PDF generation logic
    #     article.pdf.attach(io: pdf_file, filename: 'example.pdf', content_type: 'application/pdf')
    #   end
    #end
  end
end
