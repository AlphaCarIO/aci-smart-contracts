#include <eosiolib/eosio.hpp>

CONTRACT creditinquiry : public eosio::contract {

  public:

    using eosio::contract::contract;

    creditinquiry(eosio::name receiver, eosio::name code, eosio::datastream<const char*> ds): contract(receiver, code, ds) {}

    ACTION insert(const std::string & account, const std::string & hash_val);

    ACTION eraseall();

    ACTION erasebyacc(const std::string & account);

    ACTION erasebyhash(const std::string & hash_val);

    ACTION notify(uint64_t id, const std::string & account, const std::string & hash_val);

    using insertAction = eosio::action_wrapper<"insert"_n, &creditinquiry::insert>;

    using eraseallAction = eosio::action_wrapper<"eraseall"_n, &creditinquiry::eraseall>;

    using eraseByAccAction = eosio::action_wrapper<"erasebyacc"_n, &creditinquiry::erasebyacc>;

    using eraseByHashAction = eosio::action_wrapper<"erasebyhash"_n, &creditinquiry::erasebyhash>;

    using notify_action = eosio::action_wrapper<"notify"_n, &creditinquiry::notify>;

  private:

    TABLE record {
       uint64_t key;
       std::string account;
       std::string hash_val;

       uint64_t primary_key() const { return key; }
    };

    void send_summary(uint64_t id, const std::string & account, const std::string & hash_val);

    typedef eosio::multi_index<"records"_n, record> records_index;

};
