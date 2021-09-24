const Grades = artifacts.require("Grades");

module.exports = function (deployer) {
  deployer.deploy(Grades);
};