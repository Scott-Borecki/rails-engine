shared_examples 'bad query: name and price' do
  it 'returns a jSON object with an error', :aggregate_failures do
    expect(json).to have_key(:error)
    expect(json[:error]).to eq(bad_price_name_message)
  end
end

shared_examples 'bad query: blank' do
  it 'returns a jSON object with an error', :aggregate_failures do
    expect(json).to have_key(:error)
    expect(json[:error]).to eq(bad_query_message)
  end
end

shared_examples 'bad query: blank name' do
  it 'returns a jSON object with an error', :aggregate_failures do
    expect(json).to have_key(:error)
    expect(json[:error]).to eq(blank_name_message)
  end
end

shared_examples 'bad query: blank quantity' do
  it 'returns an error message', :aggregate_failures do
    expect(json).not_to be_empty
    expect(json.size).to eq(3)

    expect(json[:error]).to be_a Hash
    expect(json[:error]).to eq(blank_quantity_message)
  end
end

shared_examples 'bad query: empty quantity' do
  it 'returns an error message', :aggregate_failures do
    expect(json).not_to be_empty
    expect(json.size).to eq(3)

    expect(json[:error]).to be_a Hash
    expect(json[:error]).to eq(empty_quantity_message)
  end
end

shared_examples 'bad query: negative quantity' do
  it 'returns an error message', :aggregate_failures do
    expect(json).not_to be_empty
    expect(json.size).to eq(3)

    expect(json[:error]).to be_a Hash
    expect(json[:error]).to eq(neg_quantity_message)
  end
end

shared_examples 'bad query: quantity not a number' do
  it 'returns an error message', :aggregate_failures do
    expect(json).not_to be_empty
    expect(json.size).to eq(3)

    expect(json[:error]).to be_a Hash
    expect(json[:error]).to eq(no_number_quantity_message)
  end
end

shared_examples 'bad query: price range' do
  it 'returns a jSON object with an error', :aggregate_failures do
    expect(json).to have_key(:error)
    expect(json[:error]).to eq(bad_price_range_message)
  end
end

shared_examples 'bad query: negative max price' do
  it 'returns a jSON object with an error', :aggregate_failures do
    expect(json).to have_key(:error)
    expect(json[:error]).to eq(neg_max_price_message)
  end
end

shared_examples 'bad query: negative min price' do
  it 'returns a jSON object with an error', :aggregate_failures do
    expect(json).to have_key(:error)
    expect(json[:error]).to eq(neg_min_price_message)
  end
end

shared_examples 'returns nil data' do
  it 'returns a jSON with nil data', :aggregate_failures do
    expect(json).not_to be_empty
    expect(json_data).to be_empty
  end
end

shared_examples 'status code 200' do
  it 'returns status code 200: ok' do
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'status code 201' do
  it 'returns status code 201: created' do
    expect(response).to have_http_status(:created)
  end
end

shared_examples 'status code 204' do
  it 'returns status code 204: no content' do
    expect(response).to have_http_status(:no_content)
  end
end

shared_examples 'status code 400' do
  it 'returns status code 400: bad request' do
    expect(response).to have_http_status(:bad_request)
  end
end

shared_examples 'status code 404' do
  it 'returns status code 404: not found' do
    expect(response).to have_http_status(:not_found)
  end
end

shared_examples 'status code 422' do
  it 'returns status code 422: unprocessable entity' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
