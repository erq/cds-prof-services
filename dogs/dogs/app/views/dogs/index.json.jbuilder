json.array!(@dogs) do |dog|
  json.extract! dog, :id, :description
  json.url dog_url(dog, format: :json)
end
