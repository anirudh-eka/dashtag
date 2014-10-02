require 'spec_helper'

describe APIService do
  context 'when time since last pull is greater than api rate limit' do
    before(:each) do
      ENV["API_Rate"] = 15.to_s
      last_pull_stub = Time.now - 20
      allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
    end

    it "parses grams and tweets from response and creates posts with parsed data" do
        tweet = FactoryGirl.build(:post,
          source: "twitter",
          text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
          screen_name: "bullcityrecords",
          time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
          profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
          media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
        )

        gram = FactoryGirl.build(:post, source: "instagram",
        text: "[ t o d a y ] \n#me #noi #iger #Italia #italian #love #myboyfriend #tatoo #tatoowhitlove #ops #opslove #sempreassieme #tiamo #aspasso #september #tempodelcavolo #chedobbiamofà",
        screen_name: "jolanda_cirigliano",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http://photos-h.ak.instagram.com/hphotos-ak-xfa1/10448944_676691075735007_832582745_a.jpg",
        media_url: "http://scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10691617_1510929602485903_1047906060_n.jpg")

        APIService.instance.pull_posts!("#{ENV["HASHTAG"]}")
        expect(Post.all).to include(tweet)
        expect(Post.all).to include(gram)
    end
  end

  context 'when time since last pull is less than api rate limit' do
    before(:each) do
      ENV["API_Rate"] = 15.to_s
      last_pull_stub = Time.now
      allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
    end
    it "should throw exception" do
      expect { APIService.instance.pull_posts!("#{ENV["HASHTAG"]}") }.to raise_error("Time since last pull is less than api rate limit")
    end
  end


  describe "quiet pull" do
    it 'calls loud pull' do 
      expect(APIService.instance).to receive(:pull_posts!).with("#{ENV["HASHTAG"]}").and_return(nil)
      APIService.instance.pull_posts("#{ENV["HASHTAG"]}")
    end

    context 'when time since last pull is less than api rate limit' do
      before(:each) do
        ENV["API_Rate"] = 15.to_s
        last_pull_stub = Time.now
        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
      end
      it "should return nil" do
        expect(APIService.instance.pull_posts("#{ENV["HASHTAG"]}")).to be_nil
      end
    end
  end
end