function GetMap() {
    Microsoft.Maps.loadModule('Microsoft.Maps.AutoSuggest', {
        callback: function () {

        },
        errorCallback: function(msg){
            alert(msg);
        },
        credentials: 'An6AlZc46d8KyJUq4zRmNenT57F65DEhLpkF6OAg7PN740Qq-iGjbffqfojP7Lxu'
    });
}

function mapFormEntity(searchBox, searchBoxContainer, city, country) {
    var manager = new Microsoft.Maps.AutosuggestManager({addressSuggestions: false});
    manager.attachAutosuggest(searchBox, searchBoxContainer, function (result) {
        //Populate the address textbox values.
        document.getElementById(city).value = result.address.locality || '';
        document.getElementById(country).value = result.address.countryRegion || '';
    });

}