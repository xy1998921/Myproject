pragma solidity >=0.4.22 <0.7.0;

contract Myproject4{
    struct receipt {
    string things;  //why
    uint number;
	address come; 
	address to; 
	int mount; 
}
    address public bank;
   // mapping (address => company) public companys;
    mapping (uint => receipt) public receipts;
    mapping (address => int) public balances;
    constructor(){
        bank=msg.sender;
      }
      
    function IssueReceivables(address receive,int amount,uint num){
        balances[msg.sender]-=amount;
        balances[receive]+=amount;
        receipts[num].come=msg.sender;
        receipts[num].to=receive;
        receipts[num].mount=amount;
        receipts[num].number=num;
    }
    
    function TransferOfReceivables(uint one, uint two){
        if(receipts[one].come!=msg.sender)
            return;
        if(receipts[one].to==receipts[two].come){
            receipts[one].mount-=receipts[two].mount;
            receipts[two].come=receipts[one].come;
        }
    }
    
    function FinancingFromBank(uint own){
        if(receipts[own].come!=msg.sender||receipts[own].mount<=0)
            return;
        balances[msg.sender] += receipts[own].mount;
        receipts[own].come=bank;
    }
    
    function AccountsSettlement(uint own){
        if(receipts[own].come!=msg.sender||receipts[own].mount<=0||receipts[own].mount>balances[receipts[own].to])
            return;
        balances[msg.sender] += receipts[own].mount;
        balances[receipts[own].to] -= receipts[own].mount;
        receipts[own].mount = 0;
    }
}