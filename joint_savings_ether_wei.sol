pragma solidity ^0.5.0;

//new contract named `JointSavings`
contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    function withdraw(uint amount, address payable recipient) public {


        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        /*
         `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.
        */
        require(contractBalance > amount, "Insufficient funds!");

        /*
         `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient` If `lastToWithdraw` is not equal, then set it to the current value of `recipient`.
        */
        if (lastToWithdraw != recipient )
        {
            lastToWithdraw = recipient;
        }

        //the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
       recipient.transfer(amount);

        //the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.
        contractBalance = address(this).balance;
        lastWithdrawAmount = amount;
        
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {

        /*
        the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.
        */
        contractBalance = address(this).balance;
    }

    /*
    a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2`.
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    function() external payable {}
}