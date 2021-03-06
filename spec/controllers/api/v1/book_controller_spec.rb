require 'rails_helper'

describe Api::V1::BooksController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #show' do
    context 'When fetching a book' do
      let!(:book) { create(:book) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responses with the book json' do
        expect(response_body.to_json).to eq BookSerializer.new(
          book, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #index' do
    context 'When fetching all the books' do
      let!(:books) { FactoryBot.create_list(:book, 2) }
      before do
        get :index
      end

      it 'responses with the lists of books' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response_body.to_json).to eq expected
      end

      it 'responses with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
