const CheapCoin = artifacts.require("CheapCoin");

contract("CheapCoin", (accounts) => {
  let CheapCoinInstance;

  beforeEach(async () => {
    CheapCoinInstance = await CheapCoin.deployed();
  });

  it("admin should be able to mint tokens", async () => {
    const admin = accounts[0];
    await CheapCoinInstance.mint(admin, (100 * 10 ** 18).toString());
    const expectedBalance = 200 * 10 ** 18;
    const actualBalance = await CheapCoinInstance.balanceOf(admin);
    assert.equal(actualBalance, expectedBalance);
  });
  
  it("user should not be able to mint tokens", async () => {
    const user = accounts[1];
    try {
      await CheapCoinInstance.mint(user, (100 * 10 ** 18).toString(), {
        from: user,
      });
    } catch (err) {}
    const expectedBalance = 0;
    const actualBalance = await CheapCoinInstance.balanceOf(user);
    assert.equal(actualBalance, expectedBalance);
  });

  it("should not mint more than 10000 tokens", async () => {
    const admin = accounts[0];
    try {
      await CheapCoinInstance.mint(admin, (10000 * 10 ** 18).toString());
    } catch (err) {}
    const expectedBalance = (200 * 10 ** 18).toString();
    const actualBalance = await CheapCoinInstance.balanceOf(admin);
    assert.equal(actualBalance.toString(), expectedBalance);
  });

  it("total supply should not exceed 10000", async () => {
    const admin = accounts[0];
    try {
      await CheapCoinInstance.mint(admin, (10000 * 10 ** 18).toString());
    } catch (err) {}
    const expectedTotalSupply = 200 * 10 ** 18;
    const actualTotalSupply = await CheapCoinInstance.totalSupply();
    assert.equal(actualTotalSupply, expectedTotalSupply);
  });

  it("admin should be able to burn tokens", async () => {
    const admin = accounts[0];
    try {
      await CheapCoinInstance.burnFrom(admin, 10 * 10 ** 18);
    } catch (err) {}
    const expectedSupply = (190 * 10 ** 18).toString();
    const actualSupply = await CheapCoinInstance.totalSupply();
    assert.equal(actualSupply.toString(), expectedSupply);
  });

  it("user should not be able to burn tokens", async () => {
    const user = accounts[1];
    try {
      await CheapCoinInstance.burnFrom(user, 100 * 10 ** 18);
    } catch (err) {}

    const expectedSupply = (200 * 10 ** 18).toString();
    const actualSupply = await CheapCoinInstance.totalSupply();
    assert.equal(actualSupply.toString(), expectedSupply);
  });
});
