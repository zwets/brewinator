#!/bin/sh

set -e

# Seconds between logging
INTERVAL=5

LOG_DIR="/home/zwets/public_html"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/datalog_$(date +'%Y%m%d%H%M%S').tsv"
touch "$LOG_FILE"

WRITE_LCD="$(realpath "$(dirname "$0")/../lcd-module/write_this.py")"
GET_TEMPS="$(realpath "$(dirname "$0")/get-the-temps.sh")"

# Trap interrupt to write nothing (turn off) display
trap "$WRITE_LCD; exit" INT TERM
trap "$WRITE_LCD" EXIT

# Count
COUNT=1

# Loop the Loop
while true; do

	# Display the network address
	IP_ADDR="$(ip -4 addr show scope global up | sed -Ene 's/^ *inet ([[:digit:].]+)\/[[:digit:]]+ .*/\1/p')"
	"$WRITE_LCD" "IP: ${IP_ADDR:-"*NO NETWORK*"}
- count ${COUNT}
- interval ${INTERVAL}s"

	# Wait a second (not needed, reading the sensors takes time)
	#sleep 1
	
	# Display the timestamp and temperatures
	TIMESTAMP="$(date +'%Y-%m-%d %H:%M:%S')"
	TEMPS="$($GET_TEMPS | tee /tmp/temps)"

#	[ ! -f /tmp/temps.prev ] || paste /tmp/temps /tmp/temps.prev | sed -e 's/$/ - p/' | dc | sed -e 's/^/ (/;s/$/)/' >/tmp/temps.diff
#	[ ! -f /tmp/temps.diff ] || TEMPS="$(paste /tmp/temps /tmp/temps.diff)"
#	mv -f /tmp/temps /tmp/temps.prev

	"$WRITE_LCD" "$TIMESTAMP
$TEMPS"

        # Log the timestamp and temperatures
	printf "$COUNT\t$TIMESTAMP\t$TEMPS@" | tr ' \n@' 'T\t\n' >> "$LOG_FILE"

	# Wait
	sleep $INTERVAL

	COUNT=$((COUNT+1))
done

