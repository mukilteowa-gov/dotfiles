#!/bin/bash
# Claude Badge Helper Script
# Usage: claude-badge [working|done|waiting|clear] [window-number]

case "$1" in
  working) BADGE="⚡" ;;
  done) BADGE="✅" ;;
  waiting) BADGE="🔴" ;;
  sleeping|idle) BADGE="💤" ;;
  clear) BADGE="" ;;
  *)
    echo "Usage: claude-badge [working|done|waiting|sleeping|clear] [window-number]"
    echo "  working  - Shows ⚡ (processing)"
    echo "  done     - Shows ✅ (task complete)" 
    echo "  waiting  - Shows 🔴 (needs input)"
    echo "  sleeping - Shows 💤 (idle/no task)"
    echo "  clear    - Removes badge"
    echo ""
    echo "Examples:"
    echo "  claude-badge working     # Set current window as working"
    echo "  claude-badge done 2      # Set window 2 as done"
    echo "  claude-badge clear       # Clear current window badge"
    exit 1
    ;;
esac

# Use provided window number or current window
WINDOW=${2:-$(tmux display-message -p '#I')}

# Get current window name without any existing badges
NAME=$(tmux display-message -p -t $WINDOW '#W' | sed 's/ [🔴✅⚡💤]$//')

# Set the new name with badge (or without if clearing)
if [ -n "$BADGE" ]; then
  tmux rename-window -t $WINDOW "$NAME $BADGE"
else
  tmux rename-window -t $WINDOW "$NAME"
fi

echo "Window $WINDOW: $NAME $BADGE"