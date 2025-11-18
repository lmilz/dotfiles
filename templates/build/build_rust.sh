#!/bin/bash

# Exit immediately if any command fails
set -e

# Define some ANSI color codes for styling
GREEN='\033[1;92m'
BLUE='\033[1;94m'
RED='\033[1;91m'
YELLOW='\033[1;93m'
NC='\033[0m' # No color

# Pretty banner
echo -e "${BLUE}==============================="
echo -e "🚀 Rust Format, Lint, Build & Test"
echo -e "===============================${NC}"

# Format check
echo -e "${YELLOW}🧹 Checking code format with rustfmt...${NC}"
cargo fmt --all -- --check
echo -e "${GREEN}✅ Code format is clean.${NC}"

# Clippy lint check
echo -e "${YELLOW}🔎 Running Clippy linter...${NC}"
cargo clippy --all --all-targets -- -D warnings
echo -e "${GREEN}✅ Clippy passed with no warnings.${NC}"

# Build the library
echo -e "${YELLOW}🔨 Building the Rust library...${NC}"
cargo build --lib
echo -e "${GREEN}✅ Build successful!${NC}"

# Run the library tests
echo -e "${YELLOW}🧪 Running library tests...${NC}"
cargo test --lib
echo -e "${GREEN}✅ All tests passed!${NC}"

# Done
echo -e "${BLUE}==============================="
echo -e "🎉 Done! Everything looks great."
echo -e "===============================${NC}"
