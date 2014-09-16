require 'spec_helper'


describe Gram do

  let(:gram_one) { Gram.create(
      screen_name: "qwerty",
      created_at: "Fri Sep 21 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      media_url: "abc")
  }

    let(:gram_one_one) { Gram.create(
      screen_name: "qwerty",
      created_at: "Fri Sep 21 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      media_url: "abc")
  }

  let(:gram_two) { Gram.create(
      screen_name: "ABCDEFG",
      created_at: "Fri Sep 21 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      media_url: "abc")}

  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:profile_image_url) }
  it { should validate_presence_of(:media_url) }

  it 'should equal another gram when the attributes are the same' do 
    expect(gram_one).to eq(gram_one_one)
  end

  it 'should not equal another gram when the attributes are different' do
    expect(gram_one).to_not eq(gram_two)
  end

end