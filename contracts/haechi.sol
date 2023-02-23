
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;


contract Haechi is ERC20, Ownable {
    uint8 private _decimals;
    mapping(address => bool) private _pausedUsers;

    event PausedUser(address sender, address account);
    event UnpausedUser(address sender, address account);
    
    constructor() ERC20("Haechi", "HAC") {
        _decimals = 18;
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
}