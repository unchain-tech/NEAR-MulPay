import '@nomicfoundation/hardhat-toolbox';
import '@typechain/hardhat';
import { HardhatUserConfig } from 'hardhat/config';

require('dotenv').config();

const config: HardhatUserConfig = {
  solidity: '0.8.17',
  networks: {
    testnet_aurora: {
      url: 'https://testnet.aurora.dev',
      accounts: process.env.AURORA_PRIVATE_KEY
        ? [process.env.AURORA_PRIVATE_KEY]
        : ['0'.repeat(64)],
    },
  },
};

export default config;
