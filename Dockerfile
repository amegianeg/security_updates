# docker run --privileged --rm -v /etc:/etc:rw -v /usr:/usr:rw -v /lib:/lib -v /var/lib:/var/lib -v /var/cache:/var/cache -v /boot:/boot security
FROM ubuntu 
ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
