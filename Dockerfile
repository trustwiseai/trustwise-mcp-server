# Stage 1: Build with uv
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS uv

WORKDIR /app

# Enable bytecode compilation and set uv link mode to copy
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Install dependencies using lockfile and settings only (no project code yet)
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev --no-editable

# Add the rest of the project and install it
ADD . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev --no-editable

# Stage 2: Final runtime image
FROM python:3.12-slim-bookworm

WORKDIR /app

# Copy installed packages and venv from builder
COPY --from=uv /root/.local /root/.local
COPY --from=uv /app/.venv /app/.venv
COPY --from=uv /app /app

# Place executables in the environment at the front of the path
ENV PATH="/app/.venv/bin:$PATH"

# Run your server
CMD ["python", "server.py"]