#!/bin/sh

echo "Starting simpleproxy."

ARGS=$@
echo "ARGS: $ARGS"

echo "Press <ctrl>-c to abort"

c=$(($(echo $ARGS | grep -o "|" | wc -l)+1))

for a in $(seq 1 $c); do
  xargs=$(echo $ARGS | cut -d'|' -f$a)
  su -s /bin/sh -c "simpleproxy $xargs" simpleproxy &
done

while [ true ] ; do
    sleep 5
done

#su -s /bin/sh -c "simpleproxy $ARGS" simpleproxy
