require 'rails_helper'

describe 'Items Find API', type: :request do
  describe 'GET /api/v1/items/find' do
    context 'when there are item records' do
      let!(:item1) { create(:item, name: 'BaA', unit_price: 5.25) } # Name Asc: 2; Price Desc: 5
      let!(:item2) { create(:item, name: 'baa', unit_price: 7.53) } # Name Asc: 5; Price Desc: 3
      let!(:item3) { create(:item, name: 'bAA', unit_price: 9.41) } # Name Asc: 4; Price Desc: 1
      let!(:item4) { create(:item, name: 'Baa', unit_price: 8.32) } # Name Asc: 3; Price Desc: 2
      let!(:item5) { create(:item, name: 'BAa', unit_price: 6.14) } # Name Asc: 1; Price Desc: 4
      let(:first_item_by_name) { item5 }

      let(:bad_query_message) { { query: ['query must be provided with a value'] } }
      let(:bad_price_name_message) { { name: ['cannot be queried with price'] } }
      let(:bad_price_range_message) { { price: ['max price must be greater than min price'] } }
      let(:neg_max_price_message) { { max_price: ['must be greater than 0'] } }
      let(:neg_min_price_message) { { min_price: ['must be greater than 0'] } }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/items/find' }

        it 'returns a jSON object with an error', :aggregate_failures do
          expect(json).to have_key(:error)
          expect(json[:error]).to eq(bad_query_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide an empty query parameter' do
        before { get '/api/v1/items/find?name=' }

        it 'returns a jSON object with an error', :aggregate_failures do
          expect(json).to have_key(:error)
          expect(json[:error]).to eq(bad_query_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I search by name' do
        before { get '/api/v1/items/find?name=aa' }

        it 'returns the first item matching the search by case-sensitive alphabetical order', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(3)
          expect(json_data[:id]).to eq(first_item_by_name.id.to_s)
        end

        it 'returns status code 200: ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I search by minimum price' do
        context 'when there are items with unit price more than the minimum price' do
          before { get '/api/v1/items/find?min_price=7.24' }

          it 'returns the first item in the results by case-sensitive alphabetical order', :aggregate_failures do
            expect(json).not_to be_empty
            expect(json_data.size).to eq(3)
            expect(json_data[:id]).to eq(item4.id.to_s)
          end

          it 'returns status code 200: ok' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when there are no items with unit price more than the minimum price' do
          before { get '/api/v1/items/find?min_price=10' }

          it 'returns a jSON with nil data', :aggregate_failures do
            expect(json).not_to be_empty
            expect(json_data).to be_empty
          end

          it 'returns status code 200: ok' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when I use a negative minimum price' do
          before { get '/api/v1/items/find?min_price=-10' }

          it 'returns a jSON object with an error', :aggregate_failures do
            expect(json).to have_key(:error)
            expect(json[:error]).to eq(neg_min_price_message)
          end

          it 'returns status code 400: bad request' do
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when I search by maximum price' do
        context 'when there are items with unit price less than the maximum price' do
          before { get '/api/v1/items/find?max_price=8.25' }

          it 'returns the first item in the results by case-sensitive alphabetical order', :aggregate_failures do
            expect(json).not_to be_empty
            expect(json_data.size).to eq(3)
            expect(json_data[:id]).to eq(item5.id.to_s)
          end

          it 'returns status code 200: ok' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when there are no items with unit price less than the maximum price' do
          before { get '/api/v1/items/find?min_price=10' }

          it 'returns a jSON with nil data', :aggregate_failures do
            expect(json).not_to be_empty
            expect(json_data).to be_empty
          end

          it 'returns status code 200: ok' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when I use a negative maximum price' do
          before { get '/api/v1/items/find?max_price=-10' }

          it 'returns a jSON object with an error', :aggregate_failures do
            expect(json).to have_key(:error)
            expect(json[:error]).to eq(neg_max_price_message)
          end

          it 'returns status code 400: bad request' do
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when I search by minimum and maximum price' do
        context 'when there are items in the price range' do
          before { get '/api/v1/items/find?max_price=10&min_price=7' }

          it 'returns the first item within the price range by case-sensitive alphabetical order', :aggregate_failures do
            expect(json).not_to be_empty
            expect(json_data.size).to eq(3)
            expect(json_data[:id]).to eq(item4.id.to_s)
          end

          it 'returns status code 200: ok' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when there are no items in the price range' do
          before { get '/api/v1/items/find?max_price=50&min_price=25' }

          it 'returns a jSON with nil data', :aggregate_failures do
            expect(json).not_to be_empty
            expect(json_data).to be_empty
          end

          it 'returns status code 200: ok' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when the minimum price is greater than the maximum price' do
          before { get '/api/v1/items/find?max_price=1&min_price=10' }

          it 'returns a jSON object with an error', :aggregate_failures do
            expect(json).to have_key(:error)
            expect(json[:error]).to eq(bad_price_range_message)
          end

          it 'returns status code 400: bad request' do
            expect(response).to have_http_status(:bad_request)
          end
        end

        context 'when I use a negative minimum or maximum price' do
          it 'returns status code 400: bad request', :aggregate_failures do
            get '/api/v1/items/find?max_price=-1&min_price=10'
            expect(response).to have_http_status(:bad_request)

            get '/api/v1/items/find?max_price=1&min_price=-10'
            expect(response).to have_http_status(:bad_request)

            get '/api/v1/items/find?max_price=-1&min_price=-10'
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when I search by name, minimum price, and maximum price' do
        context 'when I use valid parameters' do
          before { get '/api/v1/items/find?name=aa&max_price=150&min_price=10' }

          it 'returns a jSON object with an error', :aggregate_failures do
            expect(json).to have_key(:error)
            expect(json[:error]).to eq(bad_price_name_message)
          end

          it 'returns status code 400: bad request' do
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when I search by name and minimum price' do
        context 'when I use valid parameters' do
          before { get '/api/v1/items/find?name=aa&min_price=10' }

          it 'returns a jSON object with an error', :aggregate_failures do
            expect(json).to have_key(:error)
            expect(json[:error]).to eq(bad_price_name_message)
          end

          it 'returns status code 400: bad request' do
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when I search by name and maximum price' do
        context 'when I use valid parameters' do
          before { get '/api/v1/items/find?name=aa&max_price=100' }

          it 'returns a jSON object with an error', :aggregate_failures do
            expect(json).to have_key(:error)
            expect(json[:error]).to eq(bad_price_name_message)
          end

          it 'returns status code 400: bad request' do
            expect(response).to have_http_status(:bad_request)
          end
        end
      end
    end

    context 'when there are no item records' do
      before { get '/api/v1/items/find?name=ccc' }

      it 'returns a jSON with nil data', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data).to be_empty
      end

      it 'returns status code 200: ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
