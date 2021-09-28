const RLottery = artifacts.require("RLottery");

module.exports = function (deployer) {
  deployer.deploy(RLottery);
};