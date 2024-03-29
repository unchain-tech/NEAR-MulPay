import { loadFixture } from '@nomicfoundation/hardhat-network-helpers';
import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('Swap Contract', function () {
  async function deployTokenFixture() {
    const [owner, addr1] = await ethers.getSigners();

    const swapFactory = await ethers.getContractFactory('SwapContract');
    const auroraToken = await ethers.getContractFactory('AuroraToken');
    const daiToken = await ethers.getContractFactory('DaiToken');
    const ethToken = await ethers.getContractFactory('EthToken');
    const polygonToken = await ethers.getContractFactory('PolygonToken');
    const shibainuToken = await ethers.getContractFactory('ShibainuToken');
    const solanaToken = await ethers.getContractFactory('SolanaToken');
    const tetherToken = await ethers.getContractFactory('TetherToken');
    const uniswapToken = await ethers.getContractFactory('UniswapToken');

    const SwapContract = await swapFactory.deploy();
    const AoaToken = await auroraToken.deploy(SwapContract.address);
    const DaiToken = await daiToken.deploy(SwapContract.address);
    const EthToken = await ethToken.deploy(SwapContract.address);
    const MaticToken = await polygonToken.deploy(SwapContract.address);
    const ShibToken = await shibainuToken.deploy(SwapContract.address);
    const SolToken = await solanaToken.deploy(SwapContract.address);
    const UniToken = await uniswapToken.deploy(SwapContract.address);
    const UsdtToken = await tetherToken.deploy(SwapContract.address);

    return {
      owner,
      addr1,
      SwapContract,
      AoaToken,
      DaiToken,
      EthToken,
      MaticToken,
      ShibToken,
      SolToken,
      UniToken,
      UsdtToken,
    };
  }
  describe('Deployment', function () {
    // check if the owner of DAI token is smart contract
    it('ERC20 token is minted from smart contract', async function () {
      const { DaiToken, SwapContract } = await loadFixture(deployTokenFixture);

      const balanceOfDai = await DaiToken.balanceOf(SwapContract.address);
      // convert expected value `1000000 Ether` to Wei units
      const expectedValue = ethers.utils.parseUnits('1000000', 18);

      expect(balanceOfDai).to.equal(expectedValue);
    });

    // get the value between DAI and ETH
    it('Get value between DAI and ETH', async function () {
      const { DaiToken, EthToken, SwapContract } = await loadFixture(
        deployTokenFixture,
      );

      const value = await SwapContract.calculateValue(
        EthToken.address,
        DaiToken.address,
      );
      // convert expected value `0.1 Ether` to Wei units
      const expectedValue = ethers.utils.parseUnits('0.1', 18);

      expect(value).to.equal(expectedValue);
    });

    // check swap function works
    it('Swap function', async function () {
      const { owner, addr1, DaiToken, EthToken, UniToken, SwapContract } =
        await loadFixture(deployTokenFixture);

      await DaiToken.approve(
        SwapContract.address,
        ethers.utils.parseEther('200'),
      );
      await SwapContract.distributeToken(
        DaiToken.address,
        ethers.utils.parseEther('100'),
        owner.address,
      );

      const ethAmountBefore = await DaiToken.balanceOf(addr1.address);
      expect(ethAmountBefore).to.equal(0);

      await SwapContract.swap(
        DaiToken.address,
        UniToken.address,
        EthToken.address,
        ethers.utils.parseEther('1'),
        addr1.address,
      );

      const ethAmountAfter = await EthToken.balanceOf(addr1.address);
      const expectedValue = ethers.utils.parseUnits('0.1', 18);
      expect(ethAmountAfter).to.equal(expectedValue);
    });
  });
});
