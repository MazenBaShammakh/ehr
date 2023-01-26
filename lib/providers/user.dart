import 'package:dapp_ehr_1/config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class User extends ChangeNotifier {
  late Client httpClient;

  late Web3Client ethClient;

  final String myAddress = "0x34c2384aF2bbE4f14725b3dDC0281b7ca6D61E5F";
  String? _privateKey;
  Credentials? _cred;
  final String blockchainUrl =
      "https://sepolia.infura.io/v3/a6ab5f5f86dd42e2ae5aa65b5ed535be";

  User() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
  }

  set privateKey(String? pk) {
    _privateKey = pk;
    _cred = EthPrivateKey.fromHex(pk!);
  }

  EthereumAddress get address => _cred!.address;

  Future<DeployedContract> getContract(String contractName) async {
    String abiFile =
        await rootBundle.loadString("assets/contracts/$contractName.json");
    String contractAddress = contractAddresses[contractName] as String;
    final contract = DeployedContract(
        ContractAbi.fromJson(abiFile, contractName),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> callFunction({
    required String functionName,
    required String contractName,
    List<dynamic> params = const [],
  }) async {
    // interact with functions that don't require state modification (view)
    final contract = await getContract(contractName);
    final function = contract.function(functionName);
    final result = await ethClient.call(
      sender: _cred!.address,
      contract: contract,
      function: function,
      params: params,
    );
    return result;
  }

  Future<bool> experiment() async {
    var contract = await getContract("Flutter");
    var function = contract.function("getTotalVotesAlpha");
    Credentials key = EthPrivateKey.fromHex(
        "0x31104231120256ff4391727504d0af06c999faeb4eda52d6bf58bcb12b0c0d18");

    print("key: $key");
    print("key address: ${key.address}");

    // local to the method - no writing to blockchain
    final callResult = await ethClient.call(
      contract: contract,
      function: function,
      params: [],
    );
    print("callResult: $callResult");

    //
    // final coinbaseAddress = await ethClient.coinbaseAddress();
    // print("coinbaseAddress: $coinbaseAddress");

    // returns balance of an eth address in wei
    EtherAmount balance = await ethClient.getBalance(key.address);
    print("balance: $balance");

    // returns the chain id
    BigInt chainId = await ethClient.getChainId();
    print("chainId: $chainId");

    // returns gas price in wei
    EtherAmount gasPrice = await ethClient.getGasPrice();
    print("gasPrice: $gasPrice");

    // get network id
    int networkId = await ethClient.getNetworkId();
    print("networkId: $networkId");

    // returns block number
    int blockNumber = await ethClient.getBlockNumber();
    print("blockNumber: $blockNumber");

    // Returns the version of the client we're sending requests to.
    String clientVersion = await ethClient.getClientVersion();
    print("clientVersion: $clientVersion");

    // returns number of transactions done by an eth address
    int txCount = await ethClient.getTransactionCount(key.address);
    print("txCount: $txCount");

    // sends a transaction to the blockchain (modifies state)
    function = contract.function("voteAlpha");
    // String txHash = await ethClient.sendTransaction(
    //   key,
    //   Transaction.callContract(
    //     contract: contract,
    //     function: function,
    //     parameters: [],
    //   ),
    //   chainId: chainId.toInt(),
    // );
    // print(txHash);
    // // txHash: 0x6d1eb72c1fc549d5e06152a2fa4fda66f276bce88bf7286a035d556e262c8735

    //
    TransactionInformation? txInfo = await ethClient.getTransactionByHash(
        "0x6d1eb72c1fc549d5e06152a2fa4fda66f276bce88bf7286a035d556e262c8735");
    print(txInfo);
    print(txInfo!.from);
    print(txInfo.blockHash);

    return true;
  }
  
  // Future<void> vote(bool voteAlpha) async {
  //   //obtain private key for write operation
  //   Credentials key = EthPrivateKey.fromHex(
  //       "0x31104231120256ff4391727504d0af06c999faeb4eda52d6bf58bcb12b0c0d18");

  //   //obtain our contract from abi in json file
  //   final contract = await getContract("Flutter");

  //   // extract function from json file
  //   final function = contract.function(
  //     voteAlpha ? "voteAlpha" : "voteBeta",
  //   );
  //   //send transaction using our private key, function and contract
  //   await ethClient.sendTransaction(
  //       key,
  //       Transaction.callContract(
  //           contract: contract, function: function, parameters: []),
  //       chainId: 11155111);
  // }

}
