var entityBingMap = {
    searchBox: '#id',
    searchBoxContainer: '#id',
    selectedSuggestion: 'callback'
};

function GetMap() {
    Microsoft.Maps.loadModule('Microsoft.Maps.AutoSuggest', {
        callback: function () {
            var manager = new Microsoft.Maps.AutosuggestManager({
                addressSuggestions: false
            });
            manager.attachAutosuggest(
                entityBingMap.searchBox,
                entityBingMap.searchBoxContainer,
                entityBingMap.selectedSuggestion);
        },
        errorCallback: function(msg){
            alert(msg);
        },
        credentials: 'Your key'
        //credentials: 'An6AlZc46d8KyJUq4zRmNenT57F65DEhLpkF6OAg7PN740Qq-iGjbffqfojP7Lxu'
    });
}

function selectedSuggestion(result) {
    //Populate the address textbox values.
    entityBingMap.value = result.address.locality || '';
    entityBingMap.countryTbx.val(result.address.countryRegion || '');
}

dynamicallyLoadScript('http://www.bing.com/api/maps/mapcontrol?callback=GetMap&setLang=en-US&setMkt=en-US');


function dynamicallyLoadScript(url) {
    var script = document.createElement("script");  // create a script DOM node
    script.src = url;  // set its src to the provided URL
    document.head.appendChild(script);  // add it to the end of the head section of the page (could change 'head' to 'body' to add it to the end of the body section instead)
}