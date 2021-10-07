const BankDeposit = artifacts.require("BankDeposit");

module.exports = function (deployer) {
  deployer.deploy(BankDeposit);
};