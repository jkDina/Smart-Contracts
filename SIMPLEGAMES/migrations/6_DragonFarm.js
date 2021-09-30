const DragonFarm = artifacts.require("DragonFarm");

module.exports = function (deployer) {
  deployer.deploy(DragonFarm);
};