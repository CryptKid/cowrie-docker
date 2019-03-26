from ubuntu:rolling
RUN apt update
RUN apt-get dist-upgrade -y
RUN apt-get install git python-virtualenv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind -y
RUN useradd -ms /bin/bash cowrie
RUN mkdir /cowrie
RUN chown cowrie:cowrie /cowrie -Rc
USER cowrie
WORKDIR /cowrie
RUN git clone http://github.com/cowrie/cowrie
WORKDIR /cowrie/cowrie/
RUN cp etc/cowrie.cfg.dist cowrie.cfg
RUN virtualenv --python=python3 cowrie-env
RUN ./cowrie-env/bin/pip3 install --upgrade pip
RUN ./cowrie-env/bin/pip3 install --upgrade -r requirements.txt
RUN sed -i 's/DAEMONIZE=""/DAEMONIZE="-n"/g' bin/cowrie
ENTRYPOINT ["./bin/cowrie", "start"]
