geth --datadir . --nodiscover --mine --minerthreads 2 --rpcapi eth,web3,personal,miner,net --rpc --rpcport "8545" --port "30303" --rpccorsdomain "*" --nat "any" --unlock 0 --password ./password.sec --allow-insecure-unlock