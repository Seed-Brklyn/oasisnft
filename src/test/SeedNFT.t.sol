// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import {Utilities} from "../utils/Utilities.sol";
import {SeedNFT} from "../SeedNFT.sol";

contract SeedNFTTest is DSTest {
    Vm internal vm;
    Utilities internal utils;
    SeedNFT internal seednft;
    address internal jawaun;
    address internal joel;
    address payable[] users;

    function setUp() public{
        utils = new Utilities();
        users = utils.createUsers(3);
        jawaun = users[0];
        joel = users[1];
        /* price - 0, maxSupply - 1, maxPerAddress - 2, 
        publicSaleTime - 3, _maxTxPerAddress - 4 */
        uint256[5] memory numericValues = [uint256(0.08 ether), uint256(10), 
        uint256(1), uint256(100), uint256(2)];
        seednft = new SeedNFT(
            "oasisnft", "OAS", "ipfs:/x", 
            numericValues, jawaun, 10
        );
    }

    function testPrice() public {
        assertEq(seednft.PRICE(), 0.08 ether);
    }

    /*
    uint256 publicSaleTime,
    uint256 maxPerAddress,
    uint256 price,
    uint256 maxTxPerAddress
    */
    function testSetSaleInfo() public {
        seednft.setSaleInformation(105, 2, 0.08 ether, 4);
    }
    //string memory baseUri
    function testSetBaseUri() public {}

    // address to, uint256 count
    function testMint() public {}

    // uint256 count
    function testPurchase() public {} // whenNotPaused

    function testIsPublicSaleActive() public {}
    function testIsPreSaleActive() public {}
    function testMAX_TOTAL_MINT() public {} 
    function testPRICE() public {}
    function testMAX_TOTAL_MINT_PER_ADDRESS() public {}
    function testPause() public {}
    function testUnpause() public {}
    // function testX() public {}
}