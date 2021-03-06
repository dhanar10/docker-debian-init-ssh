FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

ENV container docker

COPY detect-apt-proxy.sh /usr/bin

RUN chmod +x /usr/bin/detect-apt-proxy.sh \
    && echo 'Acquire::http::ProxyAutoDetect "/usr/bin/detect-apt-proxy.sh";' \
       | tee /etc/apt/apt.conf.d/00aptproxy

RUN apt-get update \  
	&& apt-get install -y \
		avahi-daemon \
		bash-completion \
		cron \
		dbus \
		htop \
		iputils-ping \
		iproute2 \
		less \
		man-db \
		nano \
		openssh-server \
		screen \
		sudo \
		systemd \
		unzip \
		tzdata \
	&& rm -rf /var/lib/apt/lists/*
	
RUN mkdir /var/run/sshd
	
RUN adduser --disabled-password --gecos ' ' user \
	&& echo "user:user" | chpasswd \
	&& adduser user sudo

STOPSIGNAL SIGRTMIN+3

EXPOSE 22

ENTRYPOINT ["/sbin/init"]

CMD []

