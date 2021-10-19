const Greetings = artifacts.require("Greetings");

module.exports = function (deployer) {
  deployer.deploy(Greetings);
};