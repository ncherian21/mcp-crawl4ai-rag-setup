#!/bin/bash

# Create project directory
mkdir -p /Users/nevin/CascadeProjects/mcp-crawl4ai-rag
cd /Users/nevin/CascadeProjects/mcp-crawl4ai-rag

# Clone the repository
git clone https://github.com/coleam00/mcp-crawl4ai-rag.git .

# Create virtual environment
python -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

echo "Repository cloned and dependencies installed!"