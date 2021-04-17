// Mycoins ICO


// Version of compiler
pragma solidity ^0.4.11;

contract mycoin_ico {
    
    // Inroducing the maximum numbers of mycoins available for sale 
    uint public max_mycoins = 1000000;
    
    // Introducing USD to mycoins conversion rate 
    uint public usd_to_mycoins = 1000;
    
    // Introducing the total number of mycoins that have been bought by investors
    uint public total_mycoins_bought = 0;
    
    // Mapping from the investor address to its equity in Mycoins and USD 
    mapping(address => uint) equity_mycoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Mycoins
    modifier can_buy_mycoins(uint usd_invested) {
        require (usd_invested * usd_to_mycoins   + total_mycoins_bought <= max_mycoins);
        _;
    }
    
    // Getting the equity in Mycoins of an investor
    function equity_in_mycoins(address investor) external constant returns (uint) {
        return equity_mycoins[investor];
    }
    
    // Getting the equity to USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }
    
    // Buying Mycoins
    function buy_mycoins(address investor, uint usd_invested) external 
    can_buy_mycoins(usd_invested) {
        uint mycoins_bought = usd_invested * usd_to_mycoins;
        equity_mycoins[investor] += mycoins_bought;
        equity_usd[investor] = equity_mycoins[investor] / 1000;
        total_mycoins_bought += mycoins_bought;
    }
    
    // Selling Mycoins 
    function sell_mycoins(address investor, uint mycoins_sold) external {
        equity_mycoins[investor] -= mycoins_sold;
        equity_usd[investor] = equity_mycoins[investor] / 1000;
        total_mycoins_bought -= mycoins_sold;
    }
}