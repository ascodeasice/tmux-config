#!/usr/bin/env bash
# NOTE: create symlink of this under PATH

mem=$(free -m | awk '/Mem/{printf "%.0f%", 100*$3/$2}')

# 取得電池容量與狀態
capacity=$(cat /sys/class/power_supply/BAT1/capacity)
status=$(cat /sys/class/power_supply/BAT1/status)
battery_icon=" "

charging_icons=("󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰂉 " "󰂊 " "󰂋 " "󰂅 " "󰂄 ")
discharging_icons=("󰁺 " "󰁻 " "󰁼 " "󰁽 " "󰁾 " "󰁿 " "󰂀 " "󰁿 " "󰁹 ")

# 計算圖示索引（將電池容量除以 10，並向下取整）
index=$((capacity / 10))
if [ "$index" -gt 8 ]; then
	index=8 # 確保索引不超出陣列範圍
fi

# 根據充電狀態選擇對應圖示
if [ "$status" == "Charging" ] || [ "$status" == "Full" ]; then
	battery_icon="${charging_icons[$index]}"
else
	battery_icon="${discharging_icons[$index]}"
fi

internet_icon="󰖪 "
wired=$(nmcli device status | grep ethernet | grep connected)
wifi=$(nmcli device status | grep wifi | grep connected)

if [ -n "$wired" ]; then
	internet_icon="󰌗 "
elif [ -n "$wifi" ]; then
	internet_icon="󰖩 " # seeing wifi strength doesn't provide much value for me, just test its speed
fi

battery="$battery_icon$capacity%"

# # 取得藍牙連接數量
# bluetooth_count=$(bluetoothctl devices Connected | wc -l)
#
# # 顯示藍牙圖示與連接數量
# if [ "$bluetooth_count" -gt 0 ]; then
# 	bluetooth="󰂯 $bluetooth_count"
# else
# 	bluetooth="󰂲 " # 無連接的藍牙圖示
# fi

echo "$internet_icon 󰍛 $mem $battery"