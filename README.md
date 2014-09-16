To prevent from storing tweets with certain words set environment variable `CENSORED_WORDS` to  the words you dont want to include in the .env file. For example, to censor tweets that contain the word, "question", add the following line in the .env file:

	CENSORED_WORDS=questions

If you want censor multiple words, simply delimit them with "|", like so

	CENSORED_WORDS=questions|answers

