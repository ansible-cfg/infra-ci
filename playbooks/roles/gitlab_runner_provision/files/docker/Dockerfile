#
# Auto Register Gitlab Runner with Java and Maven Dockerfile
# 
# Dumb-init source : https://github.com/Yelp/dumb-init
FROM gitlab/gitlab-runner

ADD dumb-init_1.0.2_amd64 /usr/bin/dumb-init
RUN chmod +x /usr/bin/dumb-init

RUN apt-get update -y && \
    apt-get upgrade -y

# Install Oralce Java 8 and set it as default
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:webupd8team/java && apt-get update

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

RUN apt-get install -y oracle-java8-set-default

# Install maven
RUN apt-get install -y maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Autoregister shell script
ADD autoregister /
RUN chmod +x /autoregister

ENTRYPOINT ["/usr/bin/dumb-init", "/autoregister"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
