FROM centos:6
MAINTAINER Masood Alam <masood.alam@vectracom.com>


# Execute system update
RUN yum -y update && yum clean all

# Install packages necessary to run EAP
RUN yum -y install xmlstarlet saxon augeas bsdtar unzip && yum clean all


# User root user to install software
USER root

# Install necessary packages
RUN yum -y install java-1.7.0-openjdk-devel && yum clean all
#RUN yum -y install java-1.8.0-openjdk-devel && yum clean all

ENV JAVA_JOME /usr/lib/jvm/java

ENV JBOSS_HOME /opt/jboss-5.1.0.GA-networkside

#RUN yum -y install glibc.i686 && yum -y install lksctp-tools

# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
#RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

# Set the working directory to jboss' user home directory
#WORKDIR /opt/jboss

# Switch back to jboss user
#USER jboss

# Set the JAVA_HOME variable to make it clear where Java is located
#ENV JAVA_HOME /usr/lib/jvm/java


#ADD septel.tar.gz /opt

#RUN cd /opt/septel && ln -s /opt/septel/libgctlib.so.1.0.0 /opt/septel/libgctlib.so.1 && echo "/opt/septel" >> /etc/ld.so.conf && ldconfig -v

#ADD gmlc-1.0.66-working.tar.gz /opt
#ADD bin.tar.gz /opt
#ADD hlr-simulator-7.1.89.tar.gz /opt
ADD jboss-5.1.0.GA-networkside.tar.gz /opt
#ADD jboss-5.1.0.GA-networkside-hlr.tar.gz /opt
#ADD jboss-5.1.0.GA-networkside.tar.gz /opt

#ADD SCTPManagement_sctp.xml /opt/jboss-5.1.0.GA-networkside4smscgateway/server/default/data
#ADD Mtp3UserPart_m3ua1.xml /opt/jboss-5.1.0.GA-networkside4smscgateway/server/default/data
#ADD SccpStack_sccpresource2.xml /opt/jboss-5.1.0.GA-networkside4smscgateway/server/default/data
#ADD SccpStack_sccprouter2.xml /opt/jboss-5.1.0.GA-networkside4smscgateway/server/default/data
#ADD ms-initiated-ussdrequest-docker18.war /opt/jboss-5.1.0.GA-networkside4smscgateway/server/default/deploy/ms-initiated-ussdrequest.war


#ADD SCTPManagement_sctp.xml /opt/jboss-5.1.0.GA-networkside/server/default/data
#ADD Mtp3UserPart_m3ua1.xml /opt/jboss-5.1.0.GA-networkside/server/default/data
#ADD SccpStack_sccpresource2.xml /opt/jboss-5.1.0.GA-networkside/server/default/data
#ADD SccpStack_sccprouter2.xml /opt/jboss-5.1.0.GA-networkside/server/default/data
ADD ms-initiated-ussdrequest-docker18.war /opt/jboss-5.1.0.GA-networkside/server/default/deploy/ms-initiated-ussdrequest.war


#ADD Server-docker.jar /opt
# Set the WILDFLY_VERSION env variable
#ENV WILDFLY_VERSION 8.2.0.Final

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
#RUN cd $HOME && curl -O http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.zip && unzip wildfly-##$WILDFLY_VERSION.zip && mv $HOME/wildfly-$WILDFLY_VERSION $HOME/wildfly && rm wildfly-$WILDFLY_VERSION.zip

# Set the JBOSS_HOME env variable
#ENV JBOSS_HOME /opt/jboss/wildfly

# Expose the ports we're interested in
#EXPOSE 8080 8080

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]
#CMD ["java", "-jar", "/opt/bin/SctpServer.jar", "org.totalbeginner.tutorial.SctpServer"]
#CMD ["/opt/jboss-5.1.0.GA-networkside4smscgateway/bin/run.sh", "-b","172.17.0.2"]
#CMD ["/opt/jboss-5.1.0.GA-networkside/bin/run.sh", "-b","172.17.0.2"]
CMD ["/opt/jboss-5.1.0.GA-networkside/bin/run.sh", "-b","0.0.0.0"]
