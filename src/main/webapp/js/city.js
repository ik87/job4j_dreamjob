Parse.serverURL = 'https://parseapi.back4app.com'; // This is your Server URL
Parse.initialize(
    'xXkttn6i38wSeA1ZVGeCKAp538IGkSDuLPL02bhA', // This is your Application ID
    'PRCvxZhcFqL8BHsfc3Bi2IcRnA14P5HZbknunC8k' // This is your Javascript key
);

const Continentscountriescities_Country = Parse.Object.extend('Continentscountriescities_Country');
const Continentscountriescities_City = Parse.Object.extend('Continentscountriescities_City');

const countries = new Parse.Query(Continentscountriescities_Country);
const cities = new Parse.Query(Continentscountriescities_City);


$(function () {

    autocomplete("#country", countries, function (event, ui) {
            console.log("selected " + ui.item.value);
            $("#country").prop('disabled', true);
            $("#city").prop('disabled', false).focus();
            cities.matchesQuery("country", countries);
            autocomplete("#city", cities, function (event, ui) {
                $("#city").prop('disabled', true);
                return false;
            });
    });

    function autocomplete(id, place, then) {
        $(id).autocomplete({
            source: function (request, response) {
                var word = request.term[0].toUpperCase() + request.term.slice(1).toLowerCase();
                place.startsWith("name", word);
                place.find().then(function (results) {
                    var res = results.map(item => item.attributes.name);
                    response(res);
                });
                return false;
            },
            select: then,
            minLength: 2,
            delay: 100
        })
    }

});