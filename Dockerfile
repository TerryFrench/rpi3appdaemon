# trying to get a working version of https://github.com/torkildr/rpi-appdaemon-docker/
FROM arm32v7/python:3.6
MAINTAINER TerryFrench

VOLUME /conf
EXPOSE 5050

RUN [ "cross-build-start" ]

RUN pip3 install requests
RUN pip3 install ics
RUN pip3 install appdaemon

# hack to support symlinks in static folders
RUN sed -ri "s/add_static\((.*)\)/add_static\(\1, follow_symlinks=True\)/g" /usr/local/lib/python3.6/site-packages/appdaemon/rundash.py \
    && ln -s /conf/assets/javascript /usr/local/lib/python3.6/site-packages/appdaemon/assets/javascript/custom \
    && ln -s /conf/assets/images /usr/local/lib/python3.6/site-packages/appdaemon/assets/images/custom

RUN [ "cross-build-end" ]

CMD appdaemon -c /conf
