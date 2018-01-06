const InShare = artifacts.require("InShare");
const InScore = artifacts.require("InScore");
const InbotMediatorGateway = artifacts.require("InbotMediatorGateway");

module.exports = function(deployer, network, accounts) {
	InShare.at(InShare.address).adminAddRole(InbotMediatorGateway.address, "admin");
	InScore.at(InScore.address).adminAddRole(InbotMediatorGateway.address, "admin");
};