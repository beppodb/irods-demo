FROM ubuntu:14.04
MAINTAINER danb@renci.org

RUN apt-get update
RUN apt-get upgrade -y

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server supervisor postgresql-9.3 wget dpkg sudo libcurl4-gnutls-dev

RUN mkdir -p /var/run/sshd

#set up supervisor
RUN mkdir -p /var/log/supervisor
ADD ./common/supervisord.conf.etc /etc/supervisor/supervisord.conf
ADD ./common/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# set up an admin user
RUN useradd admin
RUN echo 'admin:admin' | chpasswd
RUN mkdir /home/admin
RUN chown admin:admin /home/admin
RUN chsh -s /bin/bash admin

#install iRODS
RUN wget -P /home/admin ftp://ftp.renci.org/pub/irods/releases/4.0.3/irods-database-plugin-postgres-1.3.deb
RUN wget -P /home/admin ftp://ftp.renci.org/pub/irods/releases/4.0.3/irods-icat-4.0.3-64bit.deb

# install package dependencies to prevent Docker build from erring out
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y `dpkg -I /home/admin/irods-icat-4.0.3-64bit.deb | sed -n 's/^ Depends: //p' | sed 's/,//g'`
RUN dpkg -i /home/admin/irods-icat-4.0.3-64bit.deb

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y `dpkg -I /home/admin/irods-database-plugin-postgres-1.3.deb | sed -n 's/^ Depends: //p' | sed 's/,//g'`
RUN dpkg -i /home/admin/irods-database-plugin-postgres-1.3.deb

# install php server
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server supervisor git apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc curl && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# set up the iCAT database
RUN service postgresql start && \
  sudo -u postgres createdb -O postgres 'ICAT' -E UTF8 -l en_US.UTF-8 -T template0 && \
  sudo -u postgres psql -U postgres -d postgres -c "CREATE USER irods WITH PASSWORD 'testpassword'" && \
  sudo -u postgres psql -U postgres -d postgres -c 'GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods'

ADD ./icat/server.sh /home/admin/server.sh
RUN chmod a+x /home/admin/server.sh

#irods setup_database
ADD ./icat/dbresp /home/admin/dbresp
RUN service postgresql start && \ 
  sudo su -c "/var/lib/irods/packaging/setup_irods.sh </home/admin/dbresp"

# irods needs to be part of admin to execute supervisorctl
RUN usermod -G admin -a irods

#change irods user's irodsEnv file to point to localhost, since it was configured with a transient Docker container's hostname
RUN sed -i 's/^irodsHost.*/irodsHost localhost/' /var/lib/irods/.irods/.irodsEnv

#begin idrop-web installation
#set up tomcat and nginx
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-6-jdk tomcat6
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick

RUN mkdir /usr/share/tomcat6/server
RUN mkdir /usr/share/tomcat6/server/classes
RUN mkdir /usr/share/tomcat6/classes
RUN mkdir /usr/share/tomcat6/shared
RUN mkdir /usr/share/tomcat6/shared/classes

ADD ./idrop/tcstart.sh /home/admin/tcstart.sh
RUN chmod a+x /home/admin/tcstart.sh
ADD ./idrop/server.xml /etc/tomcat6/server.xml

# Deprecate: set up fake SSL keys
#ADD ./idrop/keyresp /home/admin/keyresp
#RUN mkdir /usr/local/ssl
#RUN /usr/lib/jvm/java-6-openjdk-amd64/bin/keytool -genkey -alias tomcat -keyalg RSA -keystore /usr/local/ssl/.keystore </home/admin/keyresp

#pull idrop-web files
RUN mkdir /etc/idrop-web
ADD ./idrop/idrop-web-config2.groovy /etc/idrop-web/idrop-web-config2.groovy

# set defaults for runtime variables that will be loaded into idrop-web-config2.groovy
ENV port80 8552
ENV port8443 8551
ENV hostsname localhost
ENV ZONENAME tempZone

ADD ./idrop/update_idwconfig.sh /home/admin/update_idwconfig.sh
RUN chmod a+x /home/admin/update_idwconfig.sh

#RUN mkdir /usr/share/nginx/html/idrop-release
#RUN wget -P /usr/share/nginx/html/idrop-release https://code.renci.org/gf/download/frsrelease/217/2371/idrop-lite-2.0.1-SNAPSHOT-jar-with-dependencies.jar
#RUN wget -P /usr/share/nginx/html/idrop-release http://iren-web.renci.org/idrop-snapshot/idrop.jnlp
RUN wget -P /var/lib/tomcat6/webapps http://people.renci.org/~danb/FOR_DEMOS/iDrop-Web-2/idrop-web2.war

ADD ./idrop/runAll.sh /home/admin/runAll.sh
RUN chmod a+x /home/admin/runAll.sh

ADD ./common/start.sh /home/admin/start.sh
RUN chmod a+x /home/admin/start.sh

RUN rm -fr /var/www && ln -s /home/admin/www /var/www

RUN usermod -a -G admin www-data
RUN sed -i 's/%admin ALL=(ALL) ALL/%admin ALL=(ALL) NOPASSWD:ALL/' /etc/sudoers
RUN chmod u+s /usr/bin/sudo
RUN mkdir /home/admin/.irods
RUN chown admin:admin /home/admin/.irods

# disable strict ACLs
ADD ./icat/core.re /etc/irods/core.re
RUN chown irods:irods /etc/irods/core.re
#ADD ./icat/makethumb.sh /var/lib/irods/iRODS/server/bin/cmd/makethumb.sh
#RUN chown irods:irods /var/lib/irods/iRODS/server/bin/cmd/makethumb.sh
#RUN chmod a+xr /var/lib/irods/iRODS/server/bin/cmd/makethumb.sh


EXPOSE 22 80 8443 1247
ENTRYPOINT /usr/bin/supervisord "-n"

