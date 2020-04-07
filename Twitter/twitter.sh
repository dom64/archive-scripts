mkdir $1
cd $1
twint -u $1 -o tweets.csv --csv
twint -u $1 >$1
awk '{print "https://twitter.com/" substr($5, 2, length($5) - 2) "/status/" $1}' $1 >$1-all
wget -v --adjust-extension -nc -i $1-all
twint -u $1 --media >$1-media
awk '{print "https://twitter.com/" substr($5, 2, length($5) - 2) "/status/" $1}' $1-media >$1-dl
gallery-dl -v -i $1-dl -d media -o 'extractor.*.retries=-1'
mv media/twitter/$1/* media/
rm -rf media/twitter/
rm $1*
echo done downloading all of $1\'s tweets
