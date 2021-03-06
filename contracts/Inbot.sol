pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/lifecycle/Pausable.sol";
import "zeppelin-solidity/contracts/lifecycle/TokenDestructible.sol";
import "zeppelin-solidity/contracts/ownership/CanReclaimToken.sol";
import "zeppelin-solidity/contracts/ownership/rbac/RBAC.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./Proxy.sol";

contract InbotControlled is RBAC {
    /**
     * A constant role name for indicating vendor.
     */
    string public constant ROLE_VENDOR = "vendor";
}

contract InbotContract is InbotControlled, TokenDestructible, CanReclaimToken, Pausable {
    using SafeMath for uint;

    uint public constant WAD = 10**18;
    uint public constant RAY = 10**27;
    InbotProxy public proxy;

    modifier proxyExists() {
        require(proxy != address(0x0));
        _;
    }

    function setProxy(address _proxy) public onlyAdmin {
        proxy = InbotProxy(_proxy);
    }

    function reclaimToken() public proxyExists onlyOwner {
        this.reclaimToken(proxy.getToken());
    }

    function pause() public onlyAdmin whenNotPaused {
        paused = true;
        Pause();
    }

    function unpause() public onlyAdmin whenPaused {
        paused = false;
        Unpause();
    }

    function getTime(uint _time) internal view returns (uint t) {
        return _time == 0 ? now : _time;
    }

    function min(uint x, uint y) internal pure returns (uint z) {
        return x <= y ? x : y;
    }

    function max(uint x, uint y) internal pure returns (uint z) {
        return x >= y ? x : y;
    }

    function wmul(uint x, uint y) internal pure returns (uint z) {
        z = x.mul(y).add(WAD.div(2)).div(WAD);
    }

    function rmul(uint x, uint y) internal pure returns (uint z) {
        z = x.mul(y).add(RAY.div(2)).div(RAY);
    }

    function wdiv(uint x, uint y) internal pure returns (uint z) {
        z = x.mul(WAD).add(y.div(2)).div(y);
    }

    function rdiv(uint x, uint y) internal pure returns (uint z) {
        z = x.mul(RAY).add(y.div(2)).div(y);
    }
}