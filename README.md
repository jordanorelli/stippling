This project is inspired by the work of Robert Hodgin, who has done a much more impressive stippling program that you can find [here](http://roberthodgin.com/stippling/).  I used this program to create a self-portrait that I posted to my tumblr [here](http://jordanorelli.tumblr.com/post/62062328549/self-portrait).  It looks way better if you just run the app and look at it being rendered live; I had to crunch the image a lot to get it to fit on Tumblr which has a max gif size of 1MB (unless you want to host the image yourself, which I didn't want to have to do).

Here's an example of the output:

![my stupid face](example.gif)

The Processing program is able to turn its output into a series of uncompressed png images saved at regular frame intervals.  I then run these frames through [Imagemagick](http://www.imagemagick.org/script/index.php) to create an animated gif.  The specific incantation used to generate the example image is as follows: `convert -delay 10 -size 500x500 -colors 2 -loop 0 *.png out.gif`
