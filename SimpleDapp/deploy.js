const fs = require('fs')
const Web3 = require('web3')
const web3 = new Web3("http://localhost:8545")
const bytecode = fs.readFileSync('Voting_sol_Voting.bin').toString() 
const abi = JSON.parse(fs.readFileSync('Voting_sol_Voting.abi').toString())
const deployedContract = new web3.eth.Contract(abi)
const listOfCandidates = ['Рома', 'Олег', 'Иван']
deployedContract.deploy({
    data: bytecode,
    arguments: [listOfCandidates.map(name => web3.utils.asciiToHex(name))]
  }).send({
   from: '0x5A5787F4F1F2311a2E1Cc96ad864cB7d9CBf72Bd',
   gas: 1500000,
   gasPrice: web3.utils.toWei('0.00003', 'ether')
  }).then((newContractInstance) => {
  deployedContract.options.address = newContractInstance.options.address
  console.log(newContractInstance.options.address)
  });