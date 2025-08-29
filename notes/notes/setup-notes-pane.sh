#!/bin/bash

# Setup Notes Pane Script
# Creates a narrow right pane with the cheatsheet in Neovim

# Check if we're in tmux
if [ -z "$TMUX" ]; then
    echo "Error: This script must be run from within tmux"
    exit 1
fi

# Get current pane ID
current_pane=$(tmux display-message -p "#{pane_id}")

# Create a narrow right pane (25% width)
tmux split-window -h -p 25

# Open the cheatsheet in Neovim with specific settings
tmux send-keys "nvim ~/notes/tmux-nvim-cheatsheet.md" Enter

# Set up the pane for optimal viewing
sleep 1
tmux send-keys ":set wrap" Enter
tmux send-keys ":set linebreak" Enter  
tmux send-keys ":set number!" Enter
tmux send-keys ":set relativenumber!" Enter

# Enable markdown rendering by default
tmux send-keys ":RenderMarkdown enable" Enter

# Go back to normal mode
tmux send-keys "Escape"

# Return focus to original pane
tmux select-pane -t "$current_pane"

echo "Notes pane created! Use C-l to navigate to it."
echo "Toggle markdown rendering with <leader>mr"
echo "Edit the cheatsheet as needed!"