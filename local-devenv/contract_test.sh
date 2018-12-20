#!/bin/bash

lcleos create account eosio alphacar EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd

#path in docker container
./build.sh && \
lcleos set contract alphacar /contracts/AlphaCarCreditInquiry/aci-smart-contracts/smart-contracts/build/alphacario.creditinquiry \
creditinquiry.wasm creditinquiry.abi -p alphacar@active

lcleos push action alphacar insert '[ "18017370947", "2b01c69ca0f5ee6989e5ebd3407b7695337b9ff52aa2cff3eda302eb86c86e43"]' -p alphacar@active

lcleos push action alphacar insert '[ "18017370947", "c28fce0eb36b811e87c8c56234bc1e0996f8598a6658c6120f694b701c42344b"]' -p alphacar@active

lcleos push action alphacar eraseall '[]' -p alphacar@active

lcleos push action alphacar erasebyacc '[ "18017390847" ]' -p alphacar@active

lcleos push action alphacar erasebyhash '[ "2b01c69ca0f5ee6989e5ebd3407b7695337b9ff52aa2cff3eda302eb86c86e43" ]' -p alphacar@active
#lcleos push action eosio.token create '{"issuer":"eosio.token", "maximum_supply":"1000000000.0000 SYS"}' -p eosio.token@active

lcleos get table alphacar alphacar records
