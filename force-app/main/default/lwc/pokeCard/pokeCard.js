import { LightningElement } from 'lwc';

export default class PokeCard extends LightningElement {
  pokeName;

  findPoke() {
    console.log('findPoke');
  }

  reset() {
    console.log('reset');
  }
}
