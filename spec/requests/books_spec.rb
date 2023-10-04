require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET Books' do

    before do
      FactoryBot.create(:book, title: "Factory Bot First", author: "Factory Bot George")
      FactoryBot.create(:book, title: "Factory Bot First", author: "Factory Bot George")
    end

    it 'returns all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'Create Book' do
    it "creates a Book" do

      post "/api/v1/books", params: { book: { title: "The Martian", author: "Edwing Cullen"}}

      expect { post "/api/v1/books" , params: { book: {title: "GoT", author: "G.R.R Martin"}}}.to change{ Book.count }

      expect { post "/api/v1/books" , params: { book: {title: "GoT", author: "G.R.R Martin"}}}.to change{ Book.count }.from(2).to(3)


      expect(response).to have_http_status(:created)

    end
  end

  describe 'Destroy a Book' do
    it 'destroyes a Book' do

      book = FactoryBot.create(:book, title: "Factory Bot First", author: "Factory Bot George")
      #   let(:book) { FactoryBot.create(:book, title: "Factory Bot First", author: "Factory Bot George") }

      delete "/api/v1/books/#{book.id}"

      expect(response).to have_http_status(:no_content)


      book2 = FactoryBot.create(:book, title: "Factory Bot First", author: "Factory Bot George")

      expect { delete "/api/v1/books/#{book2.id}" }.to change{Book.count}.from(1).to(0)


    end
  end
end
