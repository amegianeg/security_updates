# docker run --privileged --rm -v /etc:/etc:rw -v /usr/bin:/usr/bin:rw -v /lib:/lib:rw security_updates
FROM ubuntu 
ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
