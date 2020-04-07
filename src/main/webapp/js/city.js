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
    $("#e_country").on("click", function () {
        autocomplete("#country", countries, function (event, ui) {
            console.log("selected " + ui.item.value);
            $("#e_city").val('').focus();
            cities.matchesQuery("country", countries);
            autocomplete("#city", cities, function (event, ui) {
                $("#e_city").blur();
            });
        });
    });

    $("#e_city").on("click", function () {
        countries.equalTo("name", $("#e_country").val());
        cities.matchesQuery("country", countries);
        autocomplete("#city", cities, function (event, ui) {
            $("#e_city").blur();
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
            },
            select: then,
            minLength: 2,
            delay: 100
        })
    }

});