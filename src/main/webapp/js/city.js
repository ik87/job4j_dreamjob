Parse.serverURL = 'https://parseapi.back4app.com'; // This is your Server URL
Parse.initialize(
    'xXkttn6i38wSeA1ZVGeCKAp538IGkSDuLPL02bhA', // This is your Application ID
    'PRCvxZhcFqL8BHsfc3Bi2IcRnA14P5HZbknunC8k' // This is your Javascript key
);

function getArrayName(results) {
    var entity = [];
    results.forEach(item => entity.push("<br>" + item.get("name")));
    return entity;
}

const Continentscountriescities_Continent = Parse.Object.extend('Continentscountriescities_Continent');
const Continentscountriescities_Country = Parse.Object.extend('Continentscountriescities_Country');
const Continentscountriescities_City = Parse.Object.extend('Continentscountriescities_City');


const continents = new Parse.Query(Continentscountriescities_Continent);
const cities = new Parse.Query(Continentscountriescities_City);
const countries = new Parse.Query(Continentscountriescities_Country);



countries.startsWith("name",'R');

countries.find().then((result)=> {
/*    if (typeof document !== 'undefined') {
        var entity = getArrayName(result);
        document.write(`found: ${JSON.stringify(entity)}`);
    }*/
});


cities.startsWith("name", 'Mo');

cities.matchesQuery("country", countries);

cities.find().then((results) => {
    // You can use the "get" method to get the value of an attribute
    // Ex: response.get("<ATTRIBUTE_NAME>")
    if (typeof document !== 'undefined') {
/*        var entity = getArrayName(results);
        document.write(`found: ${JSON.stringify(entity)}`);
        console.log('found', results);*/
    }
}, (error) => {
    /*if (typeof document !== 'undefined') document.write(`Error while fetching Continentscountriescities_Country: ${JSON.stringify(error)}`);
    console.error('Error while fetching Continentscountriescities_Country', error);*/
});


$('#country').keyup( function () {

});

