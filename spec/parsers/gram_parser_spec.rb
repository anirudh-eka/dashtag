require 'spec_helper'

describe GramParser do

  let(:response) { SampleInstagramResponses.instagram_response }
  let (:test_grams) { [
        Post.new(
        source: "instagram",
      	text: "#love #TagsForLikes @TagsForLikes #instagood #me #smile #follow #cute #photooftheday #tbt #followme #tagsforlikes #girl #beautiful #happy #picoftheday #instadaily #food #swag #amazing #TFLers #fashion #igers #fun #summer #instalike #bestoftheday #smile #like4like #friends #instamood",
        screen_name: "oksanasovas",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//photos-f.ak.instagram.com/hphotos-ak-xaf1/10597252_804558659575749_663313685_a.jpg",
      	media_url: "http=>//scontent-a.cdninstagram.com/hphotos-xaf1/t51.2885-15/10665585_696868960405101_932172165_n.jpg"
      ),
      Post.new(
        source: "instagram",
      	text: "#elevator #kiss #love #budapest #basilica #tired",
        screen_name: "pollywoah",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//images.ak.instagram.com/profiles/profile_33110152_75sq_1380185157.jpg",
      	media_url: "http=>//scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/10684067_323739034474097_279647979_n.jpg"
      ),
      Post.new(
        source: "instagram",
      	text: "#wadmh3b #hbkl \nMnemani istri siang n mlm di hospital..\nDoakan supaya selamat melahirkan cahaya mata sulung utk kami...\n#Love #family #healthybaby #cute #sweet",
        screen_name: "cainmoxc",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//images.ak.instagram.com/profiles/profile_1090108603_75sq_1392225178.jpg",
        media_url: "http=>//scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10707046_1472778066326633_1828683552_n.jpg"
      ),
      Post.new(
        source: "instagram",
      	text: "[ t o d a y ] \n#me #noi #iger #Italia #italian #love #myboyfriend #tatoo #tatoowhitlove #ops #opslove #sempreassieme #tiamo #aspasso #september #tempodelcavolo #chedobbiamofà",
        screen_name: "jolanda_cirigliano",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//photos-h.ak.instagram.com/hphotos-ak-xfa1/10448944_676691075735007_832582745_a.jpg",
      	media_url: "http=>//scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10691617_1510929602485903_1047906060_n.jpg"
      ) ]}

  it 'should parse gram attributes from instagram response' do 
    attributes = { source: "instagram",
        text: "[ t o d a y ] \n#me #noi #iger #Italia #italian #love #myboyfriend #tatoo #tatoowhitlove #ops #opslove #sempreassieme #tiamo #aspasso #september #tempodelcavolo #chedobbiamofà",
        screen_name: "jolanda_cirigliano",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//photos-h.ak.instagram.com/hphotos-ak-xfa1/10448944_676691075735007_832582745_a.jpg",
        media_url: "http=>//scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10691617_1510929602485903_1047906060_n.jpg" }

    result = GramParser.parse(response)

    expect(result).to include(attributes)
  end

  it 'should make grams from instagram response' do
    
    GramParser.make_grams(response)

    expect(Post.grams).to eq(test_grams)
    expect(Post.grams.reverse).to_not eq(test_grams)
  end

  it 'should not add grams with pics that are already in the db' do

    GramParser.make_grams(response)
    GramParser.make_grams(response)

    expect(Post.grams).to eq(test_grams)
    expect(Post.grams.reverse).to_not eq(test_grams)
  end

  it 'should put empty string as text when no caption exists' do
    no_caption = SampleInstagramResponses.instagram_response_with_no_caption

    GramParser.make_grams(no_caption)

    expect(Post.all.first.text).to eq (String.new)
  end

  it "should not add grams with censored words in the caption" do 
    response = SampleInstagramResponses.instagram_response_with_censored_words
    GramParser.make_grams(response)
    expect(Post.grams).to be_empty
  end
end