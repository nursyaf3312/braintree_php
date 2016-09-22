#!/usr/bin/env bash
set -e

ca_file="./tests/root-ca.crt"
access_token="integratexxxxxx_xxxxxx_xxxxxx_xxxxxx_xx1"

params="{
  \"type\": \"us_bank_account\",
  \"billing_address\": {
    \"street_address\": \"123 Ave\",
    \"region\": \"CA\",
    \"locality\": \"San Francisco\",
    \"postal_code\": \"94112\"
  },
  \"routing_number\": \"123456789\",
  \"account_number\": \"567891234\",
  \"account_type\": \"checking\",
  \"account_holder_name\": \"Dan Schulman\",
  \"account_description\": \"PayPal Checking - 1234\",
  \"ach_mandate\": {
    \"text\": \"\"
  }
}"

output=`curl -s -H "Content-type: application/json"\
  -H "Braintree-Version: 2015-11-01"\
  -H "Authorization: Bearer $access_token"\
  -d "$params"\
  --cacert $ca_file\
  -XPost "https://atmosphere.bt.local:8080/tokens"`

token=`echo $output | jq -r '.data.id'`
echo $token
