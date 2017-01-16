FROM alpine
MAINTAINER dockerapp

RUN apk add --update less curl asterisk asterisk-curl lame sox
RUN  rm -rf /usr/lib/asterisk/modules/*pjsip* \
 &&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]
