#!/bin/bash

STATE_FILE="/tmp/screen_awake_state"

if [[ $1 == "--status" ]]; then
    # 输出当前状态供Waybar显示
    if [[ -f "$STATE_FILE" ]]; then
        CURRENT_STATE=$(cat "$STATE_FILE")
        if [[ "$CURRENT_STATE" == "on" ]]; then
            echo '{"alt": "awake"}'
        else
            echo '{"alt": "sleep"}'
        fi
    else
        echo '{"alt": "sleep"}'
    fi
    exit 0
else
  # 默认逻辑
  if [[ ! -f "$STATE_FILE" ]]; then
      echo "off" > "$STATE_FILE"
  fi

  CURRENT_STATE=$(cat "$STATE_FILE")

  if [[ "$CURRENT_STATE" == "off" ]]; then
      pkill swayidle
      echo "on" > "$STATE_FILE"
  else
      pkill swayidle
      swayidle -w timeout 300 'swaylock -f -c 000000' timeout 600 '~/.config/custom_scripts/dpms-off' before-sleep 'swaylock -f -c 000000' &
      echo "off" > "$STATE_FILE"
  fi
fi
