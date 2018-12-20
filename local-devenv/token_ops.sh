#!/bin/bash

lcleos create account eosio eosio.token EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

#path in docker container
lcleos set contract eosio.token /contracts/eosio.contracts/build/eosio.token eosio.token.wasm eosio.token.abi -p eosio.token@active

lcleos push action eosio.token create '[ "eosio.token", "1000000000.0000 SYS"]' -p eosio.token@active
#lcleos push action eosio.token create '{"issuer":"eosio.token", "maximum_supply":"1000000000.0000 SYS"}' -p eosio.token@active

lcleos push action eosio.token issue '[ "alice", "100.0000 SYS", "memo" ]' -p eosio.token@active

lcleos push action eosio.token transfer '[ "alice", "bob", "25.0000 SYS", "m" ]' -p alice@active

lcleos get currency balance eosio.token eosio.token DEMO

lcleos set account permission addressbook active '{"threshold": 1,"keys": [{"key": "EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1","weight": 1}], "accounts": [{"permission":{"actor":"addressbook","permission":"eosio.code"},"weight":1}]}' -p addressbook@owner
