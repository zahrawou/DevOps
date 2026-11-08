# ---- build stage: has pip, builds the virtualenv ----
FROM python:3.12-slim AS build
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
WORKDIR /src
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY pyproject.toml README.md ./
COPY src/ ./src/
RUN pip install --no-cache-dir --no-deps .

# ---- runtime stage: only the venv + data, non-root ----
FROM python:3.12-slim AS runtime
RUN useradd --system --uid 10001 --no-create-home scoreboard
WORKDIR /app
COPY --from=build /opt/venv /opt/venv
COPY --chown=10001:10001 data/ ./data/
ARG BUILD_SHA=dev
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    BUILD_SHA=$BUILD_SHA
USER 10001
EXPOSE 8000
CMD ["uvicorn", "--factory", "scoreboard.app:get_app", "--host", "0.0.0.0", "--port", "8000"]
