FROM python:3.8

RUN apt-get update; apt-get install -y pipx
RUN pipx install poetry

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

COPY Makefile pyproject.toml poetry.lock /app/

RUN poetry config installer.max-workers 10
RUN make setup

COPY geosan /app/geosan

WORKDIR /app/geosan

EXPOSE 8000

CMD ["poetry", "run", "gunicorn", "--bind", "0.0.0.0:8000", "webmapping.wsgi"]
