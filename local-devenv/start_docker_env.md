docker stop $(docker ps -aq) && docker rm -v $(docker ps -aq)

#start local test env
docker stop eosio && docker rm -v eosio

docker run --name eosio \
  --publish 7777:7777 \
  --publish 5555:5555 \
  -v ~/local-eosio-wallet:/root/eosio-wallet \
  --volume ~/Documents/src_codes/eos/contracts:/contracts \
  --detach --restart always \
  eosio/eos:latest \
  /bin/bash -c \
  "keosd --unlock-timeout 86400 --http-server-address=0.0.0.0:5555 & exec nodeos -e -p eosio \
  --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin \
  --plugin eosio::history_plugin --plugin eosio::history_api_plugin \
  --plugin eosio::http_plugin -d /mnt/dev/data --config-dir /mnt/dev/config \
  --http-server-address=0.0.0.0:7777 --access-control-allow-origin=* \
  --contracts-console --http-validate-host=false --filter-on='*'"

#start mainnet env
docker stop eosio_m && docker rm -v eosio_m

docker run --name eosio_m --publish 127.0.0.1:6666:6666 \
  -v ~/eosio-wallet:/root/eosio-wallet \
  --volume ~/Documents/src_codes/eos/contracts:/contracts \
  --detach \
  eosio/eos:latest \
  /bin/bash -c \
  "keosd --http-server-address=0.0.0.0:6666"

alias lcleos="docker exec -i eosio /opt/eosio/bin/cleos --wallet-url http://127.0.0.1:5555 -u http://127.0.0.1:7777"
alias mcleos="docker exec -i eosio_m /opt/eosio/bin/cleos --wallet-url http://127.0.0.1:6666 -u https://api.eosnewyork.io:443"

mcleos system newaccount --stake-net "5.0000 EOS" --stake-cpu "5.0000 EOS" --buy-ram "50 EOS" leochan54321 acarservice1 EOS8XCZendjc5cMSQfHXkiiCYu4ynoAdTkWa5ny6AkPHceWstgMQk EOS8XCZendjc5cMSQfHXkiiCYu4ynoAdTkWa5ny6AkPHceWstgMQk
