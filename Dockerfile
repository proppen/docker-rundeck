FROM ubuntu:14.04
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive

# Download Rundeck
ADD http://download.rundeck.org/deb/rundeck-2.1.1-1-GA.deb /tmp/rundeck.deb

# Add supervisord services
ADD ./supervisor /etc/supervisor

# Add rundeck to sudoers
ADD ./sudoers.d/rundeck /etc/sudoers.d/

# Add files to cron.d
ADD ./cron.d /etc/

# Add the install commands
ADD ./install.sh /

# Change Rundeck admin from default to CH4NGE_Me
ENV RDPASS CH4NGE_Me

# Change MYHOST to your IP or hostname
ENV MYHOST 127.0.0.1

# Run the installation script
RUN /install.sh

# Start the services with supervisord
CMD ["/usr/bin/supervisord", "--nodaemon"]

EXPOSE 4440 22
