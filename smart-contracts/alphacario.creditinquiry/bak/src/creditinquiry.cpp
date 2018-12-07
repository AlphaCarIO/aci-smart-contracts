#include "creditinquiry.hpp"
using namespace eosio;

ACTION creditinquiry::notify(uint64_t id, const std::string & account, const std::string & hash_val) {
  require_auth(get_self());
  require_recipient(get_self());
}

ACTION creditinquiry::insert(const std::string & account, const std::string & hash_val) {
  require_auth(get_self());

  records_index _records(_self, get_code().value);

  for(auto& item : _records) {
    if (item.hash_val == hash_val) {
      eosio_assert(false, "already have this hash_val!");
      return;
    }
  }

  uint64_t key = _records.available_primary_key();

  _records.emplace(_self, [&]( auto & row ) {
    row.key = key;
    row.account = account;
    row.hash_val = hash_val;
  });

  //send_summary(key, account, hash_val);

}

ACTION creditinquiry::eraseall() {
    require_auth(get_self());

    records_index _records(_self, get_code().value);

    std::vector<uint64_t> keysForDeletion;
    for(auto& item : _records) {
      keysForDeletion.push_back(item.key);
    }

    for (uint64_t key : keysForDeletion) {
      auto itr = _records.find(key);
      if (itr != _records.end()) {
        _records.erase(itr);
      }
    }
}

ACTION creditinquiry::erasebyacc(const std::string & account) {
    require_auth(get_self());

    records_index _records(_self, get_code().value);

    std::vector<uint64_t> keysForDeletion;
    for(auto& item : _records) {
      if (item.account == account) {
        keysForDeletion.push_back(item.key);
      }
    }

    for (uint64_t key : keysForDeletion) {
      //print_f("remove from records by account: %s key: %d", account, key);
      auto itr = _records.find(key);
      if (itr != _records.end()) {
        _records.erase(itr);
      }
    }
}

ACTION creditinquiry::erasebyhash(const std::string & hash_val) {
    require_auth(get_self());

    records_index _records(_self, get_code().value);

    std::vector<uint64_t> keysForDeletion;
    for(auto& item : _records) {
      if (item.hash_val == hash_val) {
        keysForDeletion.push_back(item.key);
      }
    }

    for (uint64_t key : keysForDeletion) {
      //print_f("remove from records by hash_val: %s key: %d", hash_val, key);
      auto itr = _records.find(key);
      if (itr != _records.end()) {
        _records.erase(itr);
      }
    }
}

void creditinquiry::send_summary(uint64_t id, const std::string & account, const std::string & hash_val) {
  action(
    permission_level{get_self(), "active"_n},
    get_self(),
    "notify"_n,
    std::make_tuple(id, account, hash_val)
  ).send();
};

EOSIO_DISPATCH( creditinquiry, (insert)(eraseall)(erasebyhash)(notify) )
