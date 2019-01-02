#!/bin/bash

#https://github.com/cryptokylin/CryptoKylin-Testnet#http-api-list

#http://faucet.cryptokylin.io/create_account?alphacartest
#http://faucet.cryptokylin.io/get_token?alphacarshow

tcleos wallet open

tcleos wallet unlock --password PW5Jhock9AYNjiExjTis3RaqoFfLktu7VcwVNq6wLmYF9cYCHRNk9
tcleos wallet private_keys --password PW5Jhock9AYNjiExjTis3RaqoFfLktu7VcwVNq6wLmYF9cYCHRNk9

tcleos system delegatebw --buyram '400 EOS' alphacartest alphacartest '200 EOS' '200 EOS'

tcleos system delegatebw --buyram '500 EOS' alphacarshow alphacarshow '100 EOS' '100 EOS'

tcleos system delegatebw --buyram '300 EOS' alphacarshow alphacarshow '50 EOS' '50 EOS'

tcleos set contract alphacartest /contracts/AlphaCarCreditInquiry/smart-contracts/build/alphacario.creditinquiry \
creditinquiry.wasm creditinquiry.abi -p alphacartest@active

tcleos set contract alphacarshow /contracts/AlphaCarCreditInquiry/smart-contracts/build/alphacario.creditinquiry \
creditinquiry.wasm creditinquiry.abi -p alphacarshow@active

tcleos get table alphacartest alphacartest records

tcleos push action alphacartest insert '["c28fce0eb36b811e87c8c56234bc1e0996f8598a6658c6120f694b701c42344b"]' -p alphacartest@active

tcleos push action alphacartest eraseall '[]' -p alphacartest@active

##-------------------------------------------------------------------------------
#start testnet env
docker stop eosio_t && docker rm -v eosio_t

docker run --name eosio_t --publish 127.0.0.1:8888:8888 \
  -v ~/test-eosio-wallet:/root/eosio-wallet \
  --volume ~/Documents/src_codes/eos/contracts:/contracts \
  --detach \
  eosio/eos:v1.4.4 \
  /bin/bash -c \
  "keosd --http-server-address=0.0.0.0:8888"

alias tcleos="docker exec -i eosio_t /opt/eosio/bin/cleos --wallet-url http://127.0.0.1:8888 -u http://jungle.eosbcn.com:8080"
alias tcleos="docker exec -i eosio_t /opt/eosio/bin/cleos --wallet-url http://127.0.0.1:8888 -u http://api.kylin.eosbeijing.one:8880"

#local
export MONGODB_URL=mongodb://root:example@localhost:27017
export MONGODB_OPT=?authSource=admin
export EOSIO_HTTP_URL=http://127.0.0.1:7777
export EOSIO_CONTRACT_ACCOUNT=alphacar
export EOSIO_STARTING_BLOCK=1
export EOSIO_CHAINID=""

#jungle
export MONGODB_URL=mongodb://root:example@localhost:27017/alphacar?authSource=admin
export EOSIO_HTTP_URL=http://jungle.eosbcn.com:8080
export EOSIO_CONTRACT_ACCOUNT=alphacartest
export EOSIO_STARTING_BLOCK=1000000
export EOSIO_CHAINID=""

#kylin
export MONGODB_URL=mongodb://root:example@localhost:27017
export MONGODB_OPT=?authSource=admin
export EOSIO_HTTP_URL=http://api.kylin.eosbeijing.one:8880
export EOSIO_CONTRACT_ACCOUNT=alphacartest
export EOSIO_STARTING_BLOCK=24003980
export EOSIO_CHAINID="5fff1dae8dc8e2fc4d5b23b2c7665c97f9e9d8edf2b6485a86ba311c25639191"

#kylin data_mgr
export MONGODB_URL=mongodb://root:example@localhost:27017/alphacar
export EOSIO_HTTP_URL=http://api.kylin.eosbeijing.one:8880
export EOSIO_CONTRACT_ACCOUNT=alphacartest
export EOSIO_CHAINID="5fff1dae8dc8e2fc4d5b23b2c7665c97f9e9d8edf2b6485a86ba311c25639191"
export EOSIO_PK=5J8CXU3fPjxQRLjDCbdbkrYcZthaSsLMusndM19Yrh1NhfX7dvn

http://jungle2.cryptolions.io:80
https://jungle2.cryptolions.io:443
https://api.jungle.alohaeos.com:443
http://145.239.133.201:8888
http://eos.eosza.io:8888
https://jungle.eosn.io:443
http://jungle.eosbcn.com:8080
http://jungle.eosmetal.io:18888
http://jungle2-eos.blckchnd.com:8888
http://88.99.193.44:8888
https://jungleapi.eossweden.se:443

http://39.108.231.157:30065/v1/chain/get_info
https://api.kylin-testnet.eospacex.com/v1/chain/get_info
http://kylin.fn.eosbixin.com/v1/chain/get_info
http://api.kylin.eoseco.com/v1/chain/get_info
http://13.125.53.113:8888/v1/chain/get_info
http://119.254.15.40:8888/v1/chain/get_info
https://api.kylin.alohaeos.com/v1/chain/get_info
http://api.kylin.helloeos.com.cn/v1/chain/get_info
http://api-kylin.starteos.io/v1/chain/get_info
http://kylin-fn001.eossv.org/v1/chain/get_info
http://api-kylin.eoshenzhen.io:8890/v1/chain/get_info
http://api.kylin.eosbeijing.one:8880/v1/chain/get_info
http://testnet.zbeos.com/v1/chain/get_info
https://kylin.eoscanada.com
http://kylin-testnet.jeda.one:8888/v1/chain/get_info
http://kylin.meet.one:8888/v1/chain/get_info

https://api-kylin.eoslaomao.com/v1/chain/get_info
https://api-kylin.eosasia.one/v1/chain/get_info
