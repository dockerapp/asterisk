FROM alpine
MAINTAINER dockerapp
ENV TZ='Asia/Yekaterinburg'

RUN apk add --update asterisk lame sox perl sqlite curl make
WORKDIR /usr/sbin
RUN wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v156.zip \
	&& unzip sendEmail-v156.zip sendEmail.pl \
	&& rm -f sendEmail-v156.zip
RUN  curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm \
	&& chmod +x cpanm && ./cpanm --no-wget Asterisk::AGI && rm -f cpanm
RUN	apk add tzdata && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apk del tzdata
RUN	apk del curl make
RUN  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-U", "root", "-p"]
