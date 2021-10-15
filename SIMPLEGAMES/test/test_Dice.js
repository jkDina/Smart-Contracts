const Dice3 = artifacts.require("./Dice3.sol");
require("chai").use(require("chai-bignumber")(web3.bignumber)).should();

contract("Dice3", function([account]) {

    let diceContract = null;

    it("should check the manager is valid", async () => {
        diceContract = await Dice3.deployed();
        const manager = await diceContract.manager.call()
        manager.should.be.bignumber.eql(account);
    });
})