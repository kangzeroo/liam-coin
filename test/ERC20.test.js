const { BN, constants, expectEvent, expectRevert } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');
const { ZERO_ADDRESS } = constants;

const {
    shouldBehaveLikeERC20,
    shouldBehaveLikeERC20Transfer,
    shouldBehaveLikeERC20Approve,
} = require('ERC20.behavior');
const { Contract } = require('ethers');

const ERC20Mock = artifacts.require('ERC20Mock');
const ERC20DecimalsMock = artifacts.require('ERC20DecimalsMock');

contract('ERC20', function (accounts) {
    const [initialHolder, recipient, anotherAccount] = accounts;
    const name = 'LiamToken'
    const symbol = 'SLAM'
    const initialSupply = new BN(100);

    beforeEach(async function () {
        this.token = await ERC20Mock.new(name,  symbol, initialHolder, initialSupply);
    })

    it('has a name', async function () {

    })

    it('has a symbol', async function () {})

    it('has an initial supply', async function () {})

    it('has 18 decimals', async function () {})

    it('has the correct total supply', async function () {})

    it('has the correct balance of the owner', async function () {})

    it('has the correct balance of another account', async function () {})

    describe('set decimals', function (){
        const decimals = new BN(6);
        it ('can set decimals during construction', async function () {
            const token = await ERC20DecimalsMock.new(name, symbol, decimals);
            expect(await token.decimals()).to.be.bignumber.equal(decimals);
        })
    })

    shouldBehaveLikeERC20('ERC20', initialSupply, initialHolder, recipient, anotherAccount);

    describe('decrease allowance', async function () {
        describe('when the spender is not the zero address', async function () {
            const spender = recipient;
            function shouldDecreaseApproval(amount) {
                describe('when there was no approved amount before', async function () {
                    it('reverts', async function () {
                        
                    })
                })
                describe('when the spender had an approved amount', async function () {
                    const approvedAmount = amount;
                    beforeEach(async function () {
                        ({ logs: this.logs } = await this.token.approve(spender, approvedAmount, { from: initialHolder }));
                    })
                    it ('emits an approval event', async function () {

                    })
                    it ('decreases the spender allowance subtracting the requested amount', async function () {

                    })
                    it ('sets the allowance to zero when all allowance is removed', async function () {})
                    it ('reverts when more than the full allowance is removed', async function () {})
                })
            }

            describe('when the sender has enough balance', async function () {

            })
            describe('when the sender does not have enough balance', async function () {

            })
        })

        describe('when the spender is the zero address', async function () {
            const amount = initialSupply;
            const spender = ZERO_ADDRESS;
            it('reverts', async function () {

            })
        })
    })

    describe('increase allowance', async function () {
        const amount = initialSupply;

        describe('when the spender is not the zero address', async function () {
            it('emits an approval event', async function () {})

            describe('when there was no approved amount before', async function () {
                it ('approves the requested amount', async function () {})
            })
        })

        describe('when the spender has an approved amount', async function () {
            it ('increases the spender allowance adding the requested amount', async function () {})
        })
    })
})