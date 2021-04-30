#!/bin/zsh

Clock(){
	TIME=$(date "+%H:%M:%S")
	echo -e -n " \uf017 ${TIME}" 
}

Cal() {
    DATE=$(date "+%a, %d %B %Y")
    echo -e -n "\uf073 ${DATE}"
}

Battery() {
	#BATTACPI=$(acpi --battery)
	#BATPERC=$(echo $BATTACPI | grep 'Battery 0' | cut -d, -f2 | tr -d '[:space:]')
	#echo -e "$BATPERC"
	BATTACPI=$(acpi --battery | grep 'Battery 0' | cut -d, -f2 | tr -d '[:space:]')
	echo -e "\uf240 $BATTACPI"
}

Wifi(){
	WIFISTR=$( iwconfig wlp4s0 | grep "Link" | sed 's/ //g' | sed 's/LinkQuality=//g' | sed 's/\/.*//g')
	if [ ! -z $WIFISTR ] ; then
		WIFISTR=$(( ${WIFISTR} * 100 / 70))
		ESSID=$(iwconfig wlp4s0 | grep ESSID | sed 's/ //g' | sed 's/.*://' | cut -d "\"" -f 2)
		if [ $WIFISTR -ge 1 ] ; then
			echo -e "\uf1eb ${ESSID} ${WIFISTR}%"
		fi
	fi
}

Sound(){
  volStatus=$(amixer get Master | tail -n 1 | cut -d '[' -f 3 | sed 's/]//g')
  volLevel=$(amixer get Master | awk '/Front Left:/ {print $5}' | tr -dc "0-9" | sed 's/%//g' )
    echo -e "\uf028 $volLevel $volStatus"
}

while true; do
	echo -e "%{c}%{F#FFF430}%{B#D59C59D1} %{r}$(Wifi)  $(Battery)  $(Sound)  $(Clock) $(Cal)"
	sleep 1s
done
