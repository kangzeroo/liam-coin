/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require('dotenv').config()
require("@nomiclabs/hardhat-waffle");
const DEV_WALLET_PRIVATE_KEY = process.env.DEV_WALLET_PRIVATE_KEY
const PROD_WALLET_PRIVATE_KEY = process.env.PROD_WALLET_PRIVATE_KEY
module.exports = {
  solidity: "0.8.0",
  networks: {
    binance_testnet: {
      url: `https://speedy-nodes-nyc.moralis.io/f111521389b4b4a5701c6b0b/bsc/testnet`,
      accounts: [`${DEV_WALLET_PRIVATE_KEY}`]
    },
    binance_mainnet: {
      url: `https://speedy-nodes-nyc.moralis.io/f111521389b4b4a5701c6b0b/bsc/mainnet`,
      accounts: [`${PROD_WALLET_PRIVATE_KEY}`]
    }
  }
};
