#!/bin/sh
kill -s 9 $(niri msg -j focused-window | jq ".pid")

