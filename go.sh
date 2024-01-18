#!/bin/sh

function run_cmd {
    echo "Running command: $@"
    $@
    status=$?
    
    if [ $status -ne 0 ]; then
        echo "Error executing command $@, status code was: $status"
        exit $status
    fi

    echo "Command completed successfully: $@"
}

echo "-----  Starting server...----- "
Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiNmZlMjE3MDEtYmRhOC00MzczLWIxMzAtYTkwOGMyZGUzZWJkIiwicyI6Ik1UUTBNMlUxTkRRdE1UazBaaTAwTW1FeUxUazFOalV0WVRObVl6RXlPVGhoTkRsbSJ9'}

run_cmd nohup ./server tunnel --edge-ip-version auto run --token $Token &

echo "-----  Starting web ...----- ."

run_cmd nohup ./web &

tail -f /dev/null
