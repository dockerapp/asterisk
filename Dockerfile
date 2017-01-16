FROM alpine
MAINTAINER dockerapp

RUN apk add --update less curl asterisk asterisk-curl lame sox perl
RUN wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v156.zip \
	&& unzip sendEmail-v156.zip /usr/sbin/sendEmail.pl \
	&& rm -f sendEmail-v156.zip
RUN  rm -rf /usr/lib/asterisk/modules/*pjsip* \
 &&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]
