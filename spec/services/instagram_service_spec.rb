require 'spec_helper'

describe InstagramService do
  it 'returns Grams' do
    expect(GramFactory).to receive(:make_grams).with(SampleInstagramResponses.instagram_response)
    InstagramService.get_grams_by_hashtag("#{ENV["HASHTAG"]}")
  end
end