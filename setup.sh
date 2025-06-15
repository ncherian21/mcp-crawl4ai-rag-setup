#!/bin/bash

# Create project directory
PROJECT_DIR="/Users/nevin/CascadeProjects/mcp-crawl4ai-rag"
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

echo "Creating project directory at $PROJECT_DIR"

# Clone the repository
echo "Cloning mcp-crawl4ai-rag repository..."
git clone https://github.com/coleam00/mcp-crawl4ai-rag.git .

# Create .env file template
echo "Creating .env file template..."
cat > .env << EOL
# MCP Server Configuration
HOST=0.0.0.0
PORT=8051
TRANSPORT=sse

# OpenAI API Configuration
OPENAI_API_KEY=your_openai_api_key

# LLM for summaries and contextual embeddings
MODEL_CHOICE=gpt-4.1-nano

# RAG Strategies (set to "true" or "false", default to "false")
USE_CONTEXTUAL_EMBEDDINGS=false
USE_HYBRID_SEARCH=false
USE_AGENTIC_RAG=false
USE_RERANKING=false

# Supabase Configuration
SUPABASE_URL=your_supabase_project_url
SUPABASE_SERVICE_KEY=your_supabase_service_key
EOL

echo ".env file template created. Please update with your API keys and Supabase information."

# Setup options
echo "Setup Options:"
echo "1. Setup with Docker (Recommended)"
echo "2. Setup with local Python environment"
read -p "Choose an option (1/2): " setup_option

if [ "$setup_option" == "1" ]; then
    echo "Building Docker image..."
    docker build -t mcp/crawl4ai-rag --build-arg PORT=8051 .
    
    echo "Docker setup complete!"
    echo "To run the server, use: docker run -p 8051:8051 --env-file .env mcp/crawl4ai-rag"
else
    echo "Setting up local Python environment..."
    
    # Create virtual environment
    python -m venv .venv
    source .venv/bin/activate
    
    # Install dependencies
    echo "Installing dependencies..."
    pip install -r requirements.txt
    
    echo "Local environment setup complete!"
    echo "To run the server, use: source .venv/bin/activate && python -m server"
fi

echo ""
echo "IMPORTANT: Before running the server, you need to:"
echo "1. Create a Supabase project at https://supabase.com"
echo "2. Go to the SQL Editor in your Supabase dashboard"
echo "3. Create a new query and paste the contents of crawled_pages.sql"
echo "4. Run the query to create the necessary tables and functions"
echo "5. Update the .env file with your OpenAI API key and Supabase credentials"