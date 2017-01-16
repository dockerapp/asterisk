FROM alpine
MAINTAINER dockerapp

RUN apk add --update less curl asterisk asterisk-curl lame sox perl make
RUN wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v156.zip \
	&& unzip sendEmail-v156.zip /usr/sbin/sendEmail.pl \
	&& rm -f sendEmail-v156.zip
RUN  curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm \
	&& chmod +x cpanm && ./cpanm --no-wget Asterisk::AGI
RUN  rm -rf /usr/lib/asterisk/modules/*pjsip* \
 &&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/* sendEmail-v156.zip

CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]
