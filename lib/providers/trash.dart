// Future<bool> experiment() async {
//     var contract = await getContract("Flutter");
//     var function = contract.function("getTotalVotesAlpha");
//     Credentials key = EthPrivateKey.fromHex(
//         "0x31104231120256ff4391727504d0af06c999faeb4eda52d6bf58bcb12b0c0d18");

//     print("key: $key");
//     print("key address: ${key.address}");

//     // local to the method - no writing to blockchain
//     final callResult = await ethClient.call(
//       contract: contract,
//       function: function,
//       params: [],
//     );
//     print("callResult: $callResult");

//     //
//     // final coinbaseAddress = await ethClient.coinbaseAddress();
//     // print("coinbaseAddress: $coinbaseAddress");

//     // returns balance of an eth address in wei
//     EtherAmount balance = await ethClient.getBalance(key.address);
//     print("balance: $balance");

//     // returns the chain id
//     BigInt chainId = await ethClient.getChainId();
//     print("chainId: $chainId");

//     // returns gas price in wei
//     EtherAmount gasPrice = await ethClient.getGasPrice();
//     print("gasPrice: $gasPrice");

//     // get network id
//     int networkId = await ethClient.getNetworkId();
//     print("networkId: $networkId");

//     // returns block number
//     int blockNumber = await ethClient.getBlockNumber();
//     print("blockNumber: $blockNumber");

//     // Returns the version of the client we're sending requests to.
//     String clientVersion = await ethClient.getClientVersion();
//     print("clientVersion: $clientVersion");

//     // returns number of transactions done by an eth address
//     int txCount = await ethClient.getTransactionCount(key.address);
//     print("txCount: $txCount");

//     // sends a transaction to the blockchain (modifies state)
//     function = contract.function("voteAlpha");
//     // String txHash = await ethClient.sendTransaction(
//     //   key,
//     //   Transaction.callContract(
//     //     contract: contract,
//     //     function: function,
//     //     parameters: [],
//     //   ),
//     //   chainId: chainId.toInt(),
//     // );
//     // print(txHash);
//     // // txHash: 0x6d1eb72c1fc549d5e06152a2fa4fda66f276bce88bf7286a035d556e262c8735

//     //
//     TransactionInformation? txInfo = await ethClient.getTransactionByHash(
//         "0x6d1eb72c1fc549d5e06152a2fa4fda66f276bce88bf7286a035d556e262c8735");
//     print(txInfo);
//     print(txInfo!.from);
//     print(txInfo.blockHash);

//     return true;
//   }
