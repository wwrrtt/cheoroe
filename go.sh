#!/bin/sh

echo "-----  Starting web ...----- ."

nohup ./web >/dev/null 2>&1 &

echo "-----  Starting server...----- "
Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiNmZlMjE3MDEtYmRhOC00MzczLWIxMzAtYTkwOGMyZGUzZWJkIiwicyI6Ik1UUTBNMlUxTkRRdE1UazBaaTAwTW1FeUxUazFOalV0WVRObVl6RXlPVGhoTkRsbSJ9'}

sudo ./server tunnel --edge-ip-version auto run --token $Token

tail -f /dev/null
