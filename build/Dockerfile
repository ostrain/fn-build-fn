FROM fnproject/python:3.6
WORKDIR /function
ADD . /function/
ADD /python /python
ENV PYTHONPATH=/python
ENTRYPOINT ["/python/bin/fdk", "/function/func.py", "handler"]
