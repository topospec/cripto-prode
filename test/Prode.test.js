const {accounts, contract, web3} = require('@openzeppelin/test-environment');

const [admin, apostador1, apostador2] = accounts;

const Prode = contract.fromArtifact('Prode');

describe('Prode', () => {
    beforeEach(async () => {
        console.log('Initialize Contract:');
        console.log(admin);
        this.prodeContract = await Prode.new({from: admin});
    });
    it('Use Case 1', async () => {

        await this.prodeContract.crearPartido('1668553617');

        const miPartido = await this.prodeContract.leerPartido(0, {from: admin});
        console.log('Resultados partido:');
        miPartido.map((item, i) => console.log(item.toNumber()));


    })
})