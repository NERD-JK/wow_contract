
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;


contract Haechi is ERC20, ERC20Burnable, Pausable, Ownable {
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

    function pause() public virtual onlyOwner {
        _pause();
    }

    function unpause() public virtual onlyOwner {
        _unpause();
    }

    function pauseUser(address address_) public virtual onlyOwner {
        _pausedUsers[address_] = true;
        emit PausedUser(msg.sender, address_);
    }

    function unpauseUser(address address_) public virtual onlyOwner {
        _pausedUsers[address_] = false;
        emit UnpausedUser(msg.sender, address_);
    }

    function pausedUser(address address_) public view virtual returns (bool) {
        return _pausedUsers[address_];
    }

    function _beforeTokenTransfer(address from_, address to_, uint256 amount_) internal virtual override {
        super._beforeTokenTransfer(from_, to_, amount_);

        require(msg.sender == owner() || (msg.sender != owner() && !paused()), "ERC20Pausable: token transfer while paused");
        require(msg.sender == owner() || (msg.sender != owner() && !pausedUser(msg.sender)), "ERC20PausableUser: user token transfer while paused");
    }
}