FROM alpine:edge

# add openssh and clean
RUN apk add --update openssh sudo bash \
&& rm  -rf /tmp/* /var/cache/apk/*
# add entrypoint script
ADD docker-entrypoint.sh /usr/local/bin
#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

RUN addgroup alpine
RUN adduser  -G alpine -s /bin/sh -D alpine
RUN echo "alpine:alpine" | /usr/sbin/chpasswd
RUN echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
