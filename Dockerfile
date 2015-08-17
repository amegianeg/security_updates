# docker run --privileged --rm -v /etc:/etc:rw -v /usr:/usr:rw -v /lib:/lib -v /var:/var -v /boot:/boot -v /sbin:/sbin security
# -v /sbin: ERROR: Couldn't determine iptables version
# -v /boot: update-initramfs: failed for /boot/initrd.img-3.13.0-32-generic with 1.

FROM ubuntu 
ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
