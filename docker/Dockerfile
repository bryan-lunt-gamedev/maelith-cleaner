FROM centos:8 as builder

RUN yum update -y && \
    yum install -y git wget which less vim zip unzip && \
    yum install -y java-11-openjdk-devel && \
    yum clean all

RUN wget https://services.gradle.org/distributions/gradle-6.7-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-*.zip && \
    rm -rf /tmp/gradle-*.zip

ADD ./gradle.sh /etc/profile.d/gradle.sh
RUN chmod 755 /etc/profile.d/gradle.sh

WORKDIR /root
RUN git clone https://github.com/Kakoen/valheim-save-tools.git && \
    cd valheim-save-tools && \
    source /etc/profile.d/gradle.sh && \
    gradle build

# Install Conda
#RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
#        wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#        /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#        rm ~/miniconda.sh

FROM beakerx/beakerx AS server
COPY --from=builder /root/valheim-save-tools/build/libs .
USER root
#remove JDK from conda
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt update -y && \
    apt install -y openjdk-11-jdk
RUN . /opt/conda/bin/activate && conda activate beakerx && conda remove openjdk
USER beakerx
ADD ./ExampleGroovy.ipynb .
