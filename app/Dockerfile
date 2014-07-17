FROM tavisto/python-base 
ADD . /app
RUN pip install -r /app/requirements.txt

EXPOSE 8000
ENV PYTHONPATH /app
CMD [ "python", "/app/bin/run" ]
