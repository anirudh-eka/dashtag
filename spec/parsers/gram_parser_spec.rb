require 'spec_helper'

describe GramParser do

  let(:response) { SampleInstagramResponses.instagram_response }

  it 'should parse gram attributes from instagram response' do 
    attributes = { source: "instagram",
        text: "[ t o d a y ] \n#me #noi #iger #Italia #italian #love #myboyfriend #tatoo #tatoowhitlove #ops #opslove #sempreassieme #tiamo #aspasso #september #tempodelcavolo #chedobbiamofà",
        screen_name: "jolanda_cirigliano",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http://photos-h.ak.instagram.com/hphotos-ak-xfa1/10448944_676691075735007_832582745_a.jpg",
        media_url: "http://scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10691617_1510929602485903_1047906060_n.jpg" }

    result = GramParser.parse(response)

    expect(result).to include(attributes)
  end

  it "should not add grams with censored words in the caption" do 
    response = SampleInstagramResponses.instagram_response_with_censored_words
    result = GramParser.parse(response)
    expect(result).to be_empty
  end
  
  it "should not add grams by censored users" do 
    response = SampleInstagramResponses.instagram_response_from_censored_users
    result = GramParser.parse(response)
    expect(result).to be_empty
  end

  it "should allow no censoring of users" do 
    default_env_censored_users = ENV["CENSORED_USERS"]
    ENV["CENSORED_USERS"]=""
    response = SampleInstagramResponses.instagram_response_from_censored_users
    result = GramParser.parse(response)
    expect(result).to_not be_empty
    ENV["CENSORED_USERS"]= default_env_censored_users
  end

  it "should allow no censoring of words" do
    default_env_censored_words = ENV["CENSORED_USERS"]
    ENV["CENSORED_WORDS"]=""
    response = SampleInstagramResponses.instagram_response_with_censored_words
    result = GramParser.parse(response)
    expect(result).to_not be_empty
    ENV["CENSORED_WORDS"]= default_env_censored_words
  end
end