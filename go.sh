#!/bin/sh

function run_cmd {
    echo "Running command: $@"
    $@
    status=$?
    
    if [ $status -ne 0 ]; then
        echo "Error executing command $@, status code: $status"
        exit $status
    fi
    echo "Command completed successfully: $@"
    nohup $@ &  # Run the command in the background
}

echo "-----  Starting server...----- "
Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiNmZlMjE3MDEtYmRhOC00MzczLWIxMzAtYTkwOGMyZGUzZWJkIiwicyI6Ik1UUTBNMlUxTkRRdE1UazBaaTAwTW1FeUxUazFOalV0WVRObVl6RXlPVGhoTkRsbSJ9'}

run_cmd ./server tunnel --edge-ip-version auto run --token $Token

echo "-----  Starting web ...----- ."

run_cmd ./web

tail -f /dev/null
