#!/bin/bash

walletpassphrase() {
    request walletpassphrase ['"$1"']
}

walletlock() {
    request walletlock []
}

encryptwallet() {
    request encryptwallet ['"$1"']
}

validateaddress() {
    request validateaddress ['"$1"']
}

sendtoaddress() {
    request sendtoaddress ['"$1"', '"$2"']
}

getnewaddress() {
    request getnewaddress ['"$1"']
}

backupwallet() {
    request backupwallet ['""']
}

checkwallet() {
    request checkwallet []
}

repairwallet() {
    request repairwallet []
}

dumpwallet() {
    request dumpwallet []
}

listreceivedbyaddress() {
    request listreceivedbyaddress '{"minconf":1, "includeempty":true}'
}

listreceivedbyaccount() {
    request listreceivedbyaccount '{"minconf":1, "includeempty":true}'
}

getinfo() {
    request getinfo []
}

getincentiveinfo() {
    request getincentiveinfo []
}

getpeerinfo() {
    request getpeerinfo []
}

getnetworkinfo() {
    request getnetworkinfo []
}

request() {
    method=$1
    shift

    if [ -z "$method" ]; then
        echo "No RPC method supplied"
        exit 1
    else
        curl -i -X POST -H "Content-Type: application/json" -d "{\"jsonrpc\": \"2.0\", \"method\": \"$method\", \"params\": $@}" 127.0.0.1:9195
    fi
}
