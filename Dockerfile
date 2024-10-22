FROM rvernica/scidb:19.11-xenial

# Install
RUN <<EOR
        apt update
        apt install -y vim sudo
EOR

# SciDB user
RUN <<EOR
        mkdir /home/scidb
        useradd scidb -d /home/scidb -p qwer1234
        chown -R scidb /home/scidb
        chown -R scidb /opt/scidb/19.11
        echo "export PATH=/opt/scidb/19.11/bin:$PATH" >> /home/scidb/.bash_profile
        echo "export PATH=/opt/scidb/19.11/bin:$PATH" >> /home/scidb/.bashrc
        cp /root/.pgpass /home/scidb
        chown scidb /home/scidb/.pgpass
        chmod 600 /home/scidb/.pgpass
EOR

COPY docker-entrypoint.sh /

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
