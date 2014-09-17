require 'spec_helper'


describe GramFactory do

  let(:response) { SampleInstagramResponses.instagram_response }
  
  it 'should make grams from instagram response' do

    test_grams = [
      # Gram.new(
        # screen_name: "bullcityrecords",
        # created_at: "Fri Sep 21 23:40:54 +0000 2012",
        # profile_image_url: "http://photos-f.ak.instagram.com/hphotos-ak-xpa1/10520248_932685676748549_540936009_a.jpg",
        # media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
      # ),
      Gram.new(
        screen_name: "MonkiesFist",
        created_at: "Fri Sep 21 23:30:20 +0000 2012",
        profile_image_url: "http://photos-a.ak.instagram.com/hphotos-ak-xaf1/10643829_788034637906280_135223026_a.jpg",
      	media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
      )
    ]
    
    factory_grams = GramFactory.make_grams(response)

    expect(Gram.all).to eq(test_grams)
    # expect(Gram.all.reverse).to_not eq(test_grams)
  end

  # it 'should not add grams with text that is already in the db' do
  #     test_grams = [
  #     Gram.new(
  #       text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
  #       screen_name: "bullcityrecords",
  #       created_at: "Fri Sep 21 23:40:54 +0000 2012",
  #       profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
  #       media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
  #     ),
  #     Gram.new(
  #       text: "Mexican Heaven, Mexican Hell ##{ENV["HASHTAG"]}",
  #       screen_name: "MonkiesFist",
  #       created_at: "Fri Sep 21 23:30:20 +0000 2012",
  #       profile_image_url: "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png"
  #     )
  #   ]

  #   GramFactory.make_grams(response)
  #   GramFactory.make_grams(response)

  #   expect(Gram.all).to eq(test_grams)
  #   expect(Gram.all.reverse).to_not eq(test_grams)
  # end

end