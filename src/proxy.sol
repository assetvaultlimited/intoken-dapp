pragma solidity ^0.4.15;

import "ds-token/token.sol";
import "ds-stop/stop.sol";
import "./interfaces.sol";

contract TrustProxy is DSStop {
	DSToken				_token;
	Pricing				_pricing;
	Mediator 			_mediator;
	ShareAllocation		_shareAllocation;

	function TrustProxy (address token, address pricing, address mediator, address shareAllocation) {
		_token = DSToken(token);
		_pricing = Pricing(pricing);
		_mediator = Mediator(mediator);
		_shareAllocation = ShareAllocation(shareAllocation);
	}

	function setToken(address token) auth {
		_token = DSToken(token);
	}

	function getToken() stopable returns (DSToken) {
		return _token;
	}

	function setPricing(address pricing) auth {
		_pricing = Pricing(pricing);
	}

	function getPricing() stopable returns (Pricing) {
		return _pricing;
	}

	function setMediator(address mediator) auth {
		_mediator = Mediator(mediator);
	}

	function getMediator() stopable returns (Mediator) {
		return _mediator;
	}

	function setShareAllocation(address shareAllocation) auth {
		_shareAllocation = Mediator(shareAllocation);
	}

	function getShareAllocation() stopable returns (ShareAllocation) {
		return _shareAllocation;
	}
}
