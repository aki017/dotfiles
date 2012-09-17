#!/bin/sh
# Cofigurations for tmux-powerline.

if [ -z "$PLATFORM" ]; then
  # You platform \in {linux,bsd,mac}.
    case "`uname`" in
        # Mac(Unix)
        Darwin)
        export PLATFORM="mac"
        ;;
        Linux*)
        export PLATFORM="linux"
        ;;
    esac
fi

if [ -z "$USE_PATCHED_FONT" ]; then
  # Useage of patched font for symbols. true or false.
  export USE_PATCHED_FONT="true"
fi
