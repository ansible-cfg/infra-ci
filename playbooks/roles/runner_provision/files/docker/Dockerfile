#
# Auto Register Gitlab Runner with Java and Maven Dockerfile
# 
# Dumb-init source : https://github.com/Yelp/dumb-init
FROM gitlab/gitlab-runner

ADD dumb-init_1.0.2_amd64 /usr/bin/dumb-init
RUN chmod +x /usr/bin/dumb-init

ADD install-letsencrypt-in-jdk.sh /usr/bin/install-letsencrypt-in-jdk.sh
RUN chmod +x /usr/bin/install-letsencrypt-in-jdk.sh

RUN apt-get update -y && \
    apt-get upgrade -y

# Install Open Java 8 and set it as default
RUN apt-get install -y software-properties-common debconf-utils
RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update
RUN apt-get install -y openjdk-8-jdk && apt-get update

# Install Maven
RUN apt-get install -y maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install  Let's Encrypt certificate in jdk
RUN echo "Installing Let's Encrypt certificate in jdk" \
    && /usr/bin/install-letsencrypt-in-jdk.sh /usr/lib/jvm/java-8-openjdk-amd64

# Autoregister shell script
ADD autoregister /
RUN chmod +x /autoregister

ENTRYPOINT ["/usr/bin/dumb-init", "/autoregister"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
