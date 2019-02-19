#!/bin/sh

if [ "$1" ]; then
    optrostailn="$1"
else
    optrostailn=1
fi

quote_json () {
    python -c   'import sys,json;print(json.dumps(sys.argv[1])
                    if len(sys.argv)>1 else "ERROR")' "$1"
}

printf '{\n'
printf '  "Hostname":   %s,\n' "$(quote_json "$(hostname)")"
printf '  "OS":         %s,\n' "$(quote_json \
    "$(lsb_release -d | cut -f2) $(lsb_release -c | cut -f2)")"

printf '  "Software":   {\n'

. "/opt/ros/$(ls /opt/ros/ | tail -n"$optrostailn" | head -n1)/setup.sh"
rosv="$(rosversion roscpp) $(rosversion -d)"
[ $? != 0 ] && rosv='<not installed>'
printf '    "ROS":      %s,\n' "$(quote_json "$rosv")"

opencvv="$(pkg-config --modversion opencv)"
[ $? != 0 ] && opencvv='<not installed>'
printf '    "OpenCV":   %s,\n' "$(quote_json "$opencvv")"

gccv="$(gcc --version | head -n1 | awk '{print $4}')"
[ $? != 0 ] && gccv='<not installed>'
printf '    "GCC":      %s\n' "$(quote_json "$gccv")"

printf '  }\n}\n'
