// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import {Utilities} from "../utils/Utilities.sol";
import {SeedNFT} from "../SeedNFT.sol";

contract SeedNFTTest is DSTest {
    Vm internal immutable vm = Vm(HEVM_ADDRESS);
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
        // 0.08 ether, 20, 4, 100, 3
        /*
        "XYZ", "x", "ipfs://QmUV6Uo8HsXhbeQkCoGX2sr9Ukxc4ufAkWswyd1FEvQaDx/", [1,100, 2, 100, 3], 0x68E9C7983665eEF302AA2a6FD69B11fbfd655AE9, 1000
        0x68E9C7983665eEF302AA2a6FD69B11fbfd655AE9, 2

        "demo4nft", "OAS", "ipfs://QmUV6Uo8HsXhbeQkCoGX2sr9Ukxc4ufAkWswyd1FEvQaDx/", [1,100, 2, 100, 3], 0x68E9C7983665eEF302AA2a6FD69B11fbfd655AE9, 1000
        0x68E9C7983665eEF302AA2a6FD69B11fbfd655AE9, 2

        "demo4nft", "OAS", "ipfs://QmUV6Uo8HsXhbeQkCoGX2sr9Ukxc4ufAkWswyd1FEvQaDx/", [1,100, 2, 100, 3], 0x68E9C7983665eEF302AA2a6FD69B11fbfd655AE9, 1000, 0x68E9C7983665eEF302AA2a6FD69B11fbfd655AE9, 2 
        ^ deployed @ 0x486409104819A2B16DA01e5C904335596aac540E on Ropsten
        */
        uint256[5] memory numericValues = [uint256(0.08 ether), uint256(20),
        uint256(4), uint256(100), uint256(3)];
        seednft = new SeedNFT(
            "oasisnft", "OAS", "ipfs://QmUV6Uo8HsXhbeQkCoGX2sr9Ukxc4ufAkWswyd1FEvQaDx/", 
            numericValues, jawaun, 1000
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
        seednft.setSaleInformation(100, 2, 0.1 ether, 4);
        uint256 currMaxPerAddress = seednft.MAX_TOTAL_MINT_PER_ADDRESS();
        uint256 currPrice = seednft.PRICE();
        uint256 maxTxsPerAddress = seednft._maxTxPerAddress();
        assertEq(currMaxPerAddress, 2);
        assertEq(currPrice, 0.1 ether);
        assertEq(maxTxsPerAddress, 4);
    }

    //string memory baseUri
    function testSetBaseUri() public {
        string memory currUri = seednft._baseTokenURI();
        console.log("Base URI", currUri);
    }

    // address to, uint256 count
    function testMinting() public{
        vm.warp(105);
        seednft.mint(joel, 3);
        seednft.mint(jawaun, 2);
    }

    function testIPFSTokenID() public {
        vm.warp(105);
        seednft.mint(joel, 3);
        string memory uri = seednft.tokenURI(1);
        console.log("uri", uri);
    }

    function testIsPublicSaleActiveWhenActive() public {
        vm.warp(105);
        bool publicSaleActive = seednft.isPublicSaleActive();
        assertTrue(publicSaleActive);
    }

    function testIsPublicSaleActiveWhenInactive() public {
        vm.warp(99);
        bool publicSaleActive = seednft.isPublicSaleActive();
        assertTrue(publicSaleActive == false);
    }

    // uint256 count
    function testPurchase() public {
        vm.warp(105);
        vm.prank(jawaun);
        seednft.purchase{value: 0.16 ether}(2);
        vm.stopPrank();
    } // whenNotPaused

    function testIsPreSaleActive() public {}
    function testMAX_TOTAL_MINT() public {
        uint256 maxsply = seednft.MAX_TOTAL_MINT();
        assertEq(maxsply, 20);
    } 

    function testPause() public {}
    function testUnpause() public {}
    // function testX() public {}
}