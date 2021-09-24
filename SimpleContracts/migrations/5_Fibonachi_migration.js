const Fibonachi = artifacts.require("Fibonachi");

module.exports = function (deployer) {
  deployer.deploy(Fibonachi);
};
