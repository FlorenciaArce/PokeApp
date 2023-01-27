import { LightningElement, wire, api, track  } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getPokemons from '@salesforce/apex/PokemonLwc.getPokemons';
import  getPokemonsByType  from '@salesforce/apex/PokemonLwc.getPokemonsByType';
//import traerPokemones from '@salesforce/apex/PokemonLwc.traerPokemones';
import getGeneracion from '@salesforce/apex/PokemonLwc.getGeneracion';

export default class pokelist extends NavigationMixin(LightningElement) {
    @api pokemon;
    error;
    searchTerm='';
    @track selectedType;
    generacionSelected
    count=0;

    
    @wire(getPokemonsByType, { type: '$selectedType' })
    wiredPokemons({ data, error }) {
        if (data) {
            this.pokemon = data;
            this.count=Object.keys(this.pokemon).length;
        } else if (error) {
            console.error(error);
        }
        
    }
    @wire(getGeneracion, { generacionSelected: '$generacionSelected' })
    wiredPokemonsG({ data, error }) {
        if (data) {
            this.pokemon = data;
            this.count=Object.keys(this.pokemon).length;
        } else if (error) {
            console.error(error);
        }
        
    }

    options = 
        [
            { label: 'Normal', value: 'Normal' },
            { label: 'Fighting', value: 'Fighting' },
            { label: 'Flying', value: 'Flying' },
            { label: 'Poison', value:'Poison' },
            { label: 'Ground', value: 'Ground' },
            { label: 'Rock', value: 'Rock' },
            { label: 'Bug', value:'Bug' },
            { label: 'Ghost', value:'Ghost' },
            { label: 'Steel', value: 'Steel' },
            { label: 'Fire', value: 'Fire' },
            { label: 'Water', value: 'Water' },
            { label: 'Grass', value:'Grass' },
            { label: 'Electric', value:'Electric' },
            { label: 'Psychic', value:'Psychic' },
            { label: 'Ice', value: 'Ice' },
            { label: 'Dragon', value:'Dragon' },
            { label: 'Dark', value:'Dark'},
            { label: 'Fairy', value: 'Fairy' },
            { label: 'Unknown', value:'Unknown' },
            { label: 'Shadow', value:'Shadow' },
        ];
        options1=[
            
            { label: 'Generación 1', value: '1' },
            { label: 'Generación 2', value: '2' },
            { label: 'Generación 3', value: '3' },
            { label: 'Generación 4', value: '4' },
            { label: 'Generación 5', value: '5' },
            { label: 'Generación 6', value: '6' },
            { label: 'Generación 7', value: '7' },
            { label: 'Generación 8', value: '8' },
    ];
    
    handleChange(event) {
        console.log(event.detail.value);
        this.selectedType = event.detail.value;
        this.count=Object.keys(this.pokemon).length;
        
    }
    handleGeneracionChange(event) {
        console.log(event.detail.value);
        this.generacionSelected = event.detail.value;
        this.count=Object.keys(this.pokemon).length;
    }
    connectedCallback() {
        this.cargarPokemones(this.searchTerm);
    }
    cargarPokemones(searchTerm){
        getPokemons({searchKey:searchTerm })
        .then(result=>{
            
            this.pokemon =result;
            this.count=Object.keys(this.pokemon).length;
            console.log("this.pokemon: "+ JSON.stringify(this.pokemon))
        })
        .catch(error=>{
            this.error = error
        })
    }
    handleSearch(event){
        this.searchTerm= event.target.value;
        this.cargarPokemones(this.searchTerm);
        this.count=Object.keys(this.pokemon).length;
    }
    handlePokemonView(event) {
        // Get pokemon record id from event
        const pokemonId = event.currentTarget.dataset.pokemonId;
        // Navigate to pokemon record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: pokemonId,
                objectApiName: 'Pokemon__c',
                actionName: 'view', 
            },
        });
    }
    
    /*traerPokemones(searchTerm, selectedType, generacionSelected) {
    return new Promise((resolve, reject) => {
        try {
            let filtros= {};
            filtros.name= "Name LIKE '%" + searchTerm + "%'";
            filtros.type= "Tipos__c = '" + selectedType + "'";
            filtros.generacion= "Generacion__c = '" + generacionSelected + "'";
            const pokemons = traerPokemones(filtros);
            resolve(pokemons);
        } catch (error) {
            reject(error);
        }
    });
}*/

}




