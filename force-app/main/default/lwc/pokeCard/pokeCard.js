import { LightningElement } from 'lwc';

export default class PokeCard extends LightningElement {
  pokeName = null;
  _pokeName = null;
  spriteImgUrl;
  abilities = [];
  moves = [];

  handleChange(event) {
    this.pokeName = event.detail.value;
  }

  findPoke() {
    this.spriteImgUrl = null;
    this.abilities = [];
    this.moves = [];
    this._pokeName = null;

    fetch('https://pokeapi.co/api/v2/pokemon/' + this.pokeName, { method: 'GET' })
      .then((response) => response.json())
      .then((data) => {
        this._pokeName = data.name;
        this.spriteImgUrl = data.sprites.front_default;

        for (let i = 0; i < data.abilities.length; i++) {
          this.abilities[i] = data.abilities[i].ability.name;
        }
        for (let j = 0; j < data.moves.length; j++) {
          this.moves[j] = data.moves[j].move.name;
        }
      });
    }

  reset() {
    this.pokeName = null;
    this._pokeName = null;
    this.spriteImgUrl = null;
    this.abilities = [];
    this.moves = [];
  }
}
