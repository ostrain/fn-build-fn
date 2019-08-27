FROM fnproject/python:3.6-dev as build-stage
WORKDIR /function
ADD requirements.txt /function/

RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt &&\
		rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv
ADD . /function/
RUN rm -fr /function/.pip_cache
FROM fnproject/python:3.6
RUN apt-get update && apt-get install -y uidmap && apt-get install -y libseccomp-dev
ADD img-linux-amd64 /usr/local/bin/img
WORKDIR /function
COPY --from=build-stage /function /function
COPY --from=build-stage /python /python
ENV PYTHONPATH=/python
ENTRYPOINT ["/python/bin/fdk", "/function/func.py", "handler"]
