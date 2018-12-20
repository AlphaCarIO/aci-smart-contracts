#!/bin/bash

set -x
set -e

#alias lcleos='docker exec -i eosio /opt/eosio/bin/cleos --wallet-url http://127.0.0.1:5555 -u http://127.0.0.1:7777'
#export lcleos
#lcleos wallet create --to-console

lcleos wallet open
lcleos wallet unlock --password PW5JgB3VPuNpsX19xq3ntPx2DoweyFanJDvkN1dAntx1zUoztobKj
lcleos wallet private_keys --password PW5JgB3VPuNpsX19xq3ntPx2DoweyFanJDvkN1dAntx1zUoztobKj

#EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd
lcleos wallet import --private-key 5K3UUSU7aM5nUSg3UR9XoUHfDK53CuSXpwe2q3Y7x9WG4yMLQhj

#EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1
lcleos wallet import --private-key 5JC34pBkD7JqR37tjc6DA1vDUa8Bdfo5CXHWMprM9BEoDeDnrSw

#EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV dev key
lcleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

lcleos create account eosio alice EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd
lcleos create account eosio bob EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1
lcleos create account eosio alphacario EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
#cleos wallet remove_key EOS6xhekghwi1NmWZ7x9X6XCCFdJAWXnMKMafMUYT2F85Wq1AWarW --password PW5JQEf6yhKy9B44RHKAfowYi7zWcADw38yQWx1oAaJArVJnP2cmS

lcleos set account permission bob owner \
'{"threshold":1,"keys":[{"key":"EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd","weight":1}]}' -p bob@owner

lcleos set account permission bob owner \
'{"threshold":1,"keys":[{"key":"EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1","weight":1}]}' -p bob@owner

lcleos set account permission bob owner EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd -p bob@owner

lcleos set account permission bob owner EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1 -p bob@owner

lcleos set account permission bob newauth \
'{"threshold":2,"keys":[{"key":"EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd","weight":1},
{"key":"EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1","weight":1}]}' -p bob@owner

lcleos set account permission bob newauth NULL

#lcleos set account permission bob active NULL -p bob@owner
