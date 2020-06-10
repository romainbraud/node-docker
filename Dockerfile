FROM tezos/tezos:mainnet

# Install AWS CLI

USER root
RUN \
	apk -Uuv add groff less python py-pip curl jq && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

COPY ./start-tezos.sh /home/tezos/start-tezos.sh
RUN chmod 755 /home/tezos/start-tezos.sh

COPY ./utc-time-math.py /home/tezos/utc-time-math.py
RUN chmod 755 /home/tezos/utc-time-math.py

COPY ./pipe2kinesis /usr/local/bin/pipe2kinesis
RUN chmod 755 /usr/local/bin/pipe2kinesis

COPY ./start-analytics.sh /home/tezos/start-analytics.sh
RUN chmod 755 /home/tezos/start-analytics.sh

USER tezos
EXPOSE 8732 9732
ENTRYPOINT ["/home/tezos/start-tezos.sh"]
