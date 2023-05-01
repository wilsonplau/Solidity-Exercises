// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        // your code here

        (bool success1, bytes memory price1Bytes) = _priceOracle1.call(
            abi.encodeWithSignature("price()")
        );
        require(
            success1,
            "CrossContract: Failed to call price() on _priceOracle1."
        );
        uint256 price1 = abi.decode(price1Bytes, (uint256));
        (bool success2, bytes memory price2Bytes) = _priceOracle2.call(
            abi.encodeWithSignature("price()")
        );
        require(
            success2,
            "CrossContract: Failed to call price() on _priceOracle2."
        );
        uint256 price2 = abi.decode(price2Bytes, (uint256));
        if (price1 > price2) return price2;
        return price1;
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
