# oasisnft
Oasis NFT

To Run Locally:

First run the command below inside of your terminal to get foundryup, the Foundry toolchain installer:

```curl -L https://foundry.paradigm.xyz | bash```

Then, run ```foundryup``` in a new terminal session or after reloading your ```PATH```.

Then, run ```forge install; forge update;```

now you should be able to deploy your own local version of the contract to rinkeby following these commands:

```
forge create --rpc-url https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161 \
src/SeedNFT.sol:SeedNFT --extra-output-files abi \
--private-key <Your Private Key>  \
--etherscan-api-key <your etherscan API key> \
--verify \
--constructor-args “<NAME>” "<Symbol>" "ipfs://<IPFSHASH>/" <COST> <TotalSUpply> <MaxMintPerTX> <StartSaleTime> <MaxTxPerWallet> <RoyaltyRecipient> <RoyaltyAmount>
```

you can test sending yourself an NFT with the following command (provided you have installed Cast as well as Forge):

```
cast send <ContractAddress> "mint(address,uint256)" <AddressToSendTo> <NumToSend> \
--rpc-url https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161 \
--private-key <Your Private Key>
```
