Dashtag
=================
Check out the example of Hashtag Displayer [here on our staging site](http://hashtag-displayer-staging-1.herokuapp.com/).

The hastag displayer is a light weight rails application that pulls tweets with a particular hashtag and displays them using [masonry](http://masonry.desandro.com/). The app is pretty much plug and play. The only changes you have to make is in the .env file.

The application uses [Twitter's REST API](https://dev.twitter.com/rest/reference/get/search/tweets) and [Instagram's REST API](http://instagram.com/developer/). Please note this is not an exhaustive list of all tweets/instagrams with a particular hashtag.

To Deploy To Heroku
-------------------
 Simply put the environment variables, as described below, into Heroku's dashboard after hitting the Deploy to Heroku Button above. 
 [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/anirudh-eka/dashtag.git)


Environment Variables
---------------------
Currently the application expects the following variables in the environment:
-	HASHTAG
-	CENSORED_WORDS
-	CENSORED_USERS
-	TWITTER_BEARER_CREDENTIALS
- 	INSTAGRAM_CLIENT_ID
-	DISABLE_RETWEETS

`Hashtag` should be set to the text of the hashtag excluding the initial '#'. So if you wanted all of the posts with the "#peace" on Twitter, you set: 
	HASHTAG=peace

To prevent from storing posts with certain words set the environment variable `CENSORED_WORDS` to the words you dont want to include in the .env file. For example, to censor posts that contain the word, "question", add the following line in the .env file:

	CENSORED_WORDS=questions

If you want censor multiple words, simply delimit them with "|", like so

	CENSORED_WORDS=questions|answers|censored

To prevent from storing posts from certain users set the environment variable `CENSORED_USERS` to the users you dont want to include in the .env file. For example, to censor posts by the author, "badGuy", add the following line in the .env file:

	CENSORED_USERS=badGuy

If you want to censor multiple users, simply delimit them with "|", like so

	CENSORED_USERS=badGuy|UglyDog

If you don't want to censor users or words, simply don't put `CENSORED_USERS` or `CENSORED_WORDS` in the .env file.

`Twitter Bearer Credentials` should be set to the Twitter Key followed by a colon and the Twitter secret, like so:

	TWITTER_BEARER_CREDENTIALS=your_twitter_key:your_twitter_secret

To find the key and secret for your app follow these [directions](https://dev.twitter.com/oauth/overview/application-owner-access-tokens). This will require you to register your own Twitter application. Also, in case you were wondering, the application uses [application-only authentication](https://dev.twitter.com/oauth/application-only).

`Instagram Client Id` should be set to the client id you get back from [registering your application with Instagram](http://instagram.com/developer/clients/register/). Where it prompts for `Website` and `OAuth redirect_uri:` and you will need to put your site's address.  You should not need to change the defaults for `Disable implicit OAuth` or `Enforce signed header`.  You only need the CLIENT_ID that they give you, not the secret or anything else.

The application by default does not capture retweet posts from twitter. To capture retweets, set the `DISABLE_RETWEETS`, environment variable to 'false'.

To Run Locally
---------------
To set up the application locally you should first create a new file called `.env` in the root dir of the app. After pulling the app into a local repository on your machine, create a .env file at the root of your repository. This is where you can set environment variable that will be available to your application, but ignored by git (thanks to [dotenv](https://github.com/bkeepers/dotenv)).

Your final .env file should look like this:

	HASHTAG=peace
	CENSORED_WORDS=dictatorship|wowza|more
	TWITTER_BEARER_CREDENTIALS=YOUR_TWITTER_KEY:YOUR_TWITTER_SECRET
	INSTAGRAM_CLIENT_ID=YOUR_INSTAGRAM_CLIENT_ID_CODE

Running the app locally
-----------------------

Once you have the .env file setup, run bundler from the command line:

	$ bundle

create/migrate the database:
	
	$ rake db:create && rake db:migrate

and start the server:

	$ rails s

If everything worked you should be able to see the application at work at http://localhost:3000/ in your favorite browser.

Running tests
-------------

The testing framework used is Rspec and Capybara. To run them:

	$ rspec

*Note: Currently one feature test is pending*


What's in the future?
---------------------
We're working on supporting facebook and videos
