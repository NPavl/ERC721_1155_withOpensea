
const { assert, expect } = require("chai")
const { ethers } = require("hardhat")

describe("Deployment token contract", () => {

    beforeEach(async () => {
        [admin, addr1, addr2, ...addrs] = await ethers.getSigners()
        arg1 = "ERC20token"; arg2 = "BLR"; arg3 = 18
        value = ethers.utils.parseEther('10')
        ERC20token = await ethers.getContractFactory("ERC20token")
        token = await ERC20token.deploy(arg1, arg2, arg3)
        await token.deployed()
    });

    it('set the right owner', async () => {
        actual = await token.admin()

        assert.equal(actual, admin.address, " owner address should match")
    });

    it('set the right arguments', async () => {
        actual1 = await token.name()
        assert.equal(actual1, arg1, "arguments name should match")
        actual2 = await token.symbol()
        assert.equal(actual2, arg2, "arguments symbol should match")
        actual3 = await token.decimals()
        assert.equal(actual3, arg3, "arguments decimals should match")
    })

    it('total supply of tokens must belong to the admin address', async () => {
        await token.connect(admin).mint(admin.address, value)
        adminBalance = await token.balanceOf(admin.address)

        expect(await token.totalSupply()).to.equal(adminBalance)
    })
})