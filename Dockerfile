# SSH Server
# VERSION 0.0.1

# Base Image
FROM ubuntu:latest

# Update APT repository & Install OpenSSH
RUN apt-get update \
    && apt-get install -y openssh-server

# Establish the operating directory of OpenSSH
RUN mkdir /var/run/sshd

# Set Root password
RUN echo 'root:password' | chpasswd

# Allow Root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    /etc/ssh/sshd_config

# SSH login fix
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional \
    pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose port 22
EXPOSE 22


# Commands to be executed by default
CMD ["/usr/sbin/sshd", "-D"]