# Example of Mule app running on Dockerised Mule CE server

This is the companion project for [Dock Tales: Mule-In-A-Container
](http://www.sixtree.com.au/articles/2015/dock-tales-mule/) blog post.

Build the image

	# docker build --tag sample-app .

Run the container

	# docker run -it -p 8080:9000 -v /data/mule-app:/opt/mule/logs -e "SAMPLE_USER_NAME=Sohrab" sample-app

Verify the app

	curl localhost:8080/test

Should return

	{ "message": "Hello, Sohrab" }	
