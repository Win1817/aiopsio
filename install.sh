#!/usr/bin/env bash
set -e

echo "========================================="
echo "  ai.ops Installation"
echo "========================================="

# Check docker
if ! command -v docker &> /dev/null; then
  echo "ERROR: Docker is not installed. Please install Docker first."
  exit 1
fi

if ! docker compose version &> /dev/null; then
  echo "ERROR: Docker Compose is not available."
  exit 1
fi

# Check ollama is reachable on host
echo "Checking Ollama connection..."
if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
  echo "✓ Ollama is running on localhost:11434"
else
  echo "WARNING: Ollama doesn't appear to be running. Make sure it's started before using ai.ops."
fi

echo ""
echo "Building and starting ai.ops..."
docker compose down --remove-orphans 2>/dev/null || true
docker compose build --no-cache
docker compose up -d

echo ""
echo "========================================="
echo "  ai.ops is starting up!"
echo "  Open http://localhost:3000 in your browser"
echo "========================================="
echo ""
echo "To check logs: docker compose logs -f"
echo "To stop:       docker compose down"
