//multi-page
function runByURL() { 
    var pageName = document.location.pathname.split('/')[1];

    if      (pageName == 'user')    buildUserPage();
    // else if (pageName == 'listing') buildListingPage();
    else if (pageName == 'search')  buildSearchPage();
    else                            buildFormPage();
}

//form page
function buildFormPage(){
    var path = '/listing/create';
    var form = $("#postForm");

    formData = function() { return form.serializeObject(); }
    
    form.submit(function() {   
        $.post(path, formData())
         .success(function(res) { document.location.href = '/listing/'+res} );
    })
    
    buildOffers();    
}

function buildOffers(){
    offers = {};
    offers.name='nunchucks';
    offers.offersList = [];

    offers.addOffer = function() {
        //submitOfferToServer();
        offers.getAll();    
    }    
    offers.getAll = function(){
        $.getJSON('/offers/123').success(function(res){offers.offersList = res;})    
    }

    jab.bindObj(offers,"offersArea");    
    offers.getAll();
}

function buildListingPage() {
    console.log("In user page");
}

function buildUserPage() {
    console.log("In user page");
}

//run
runByURL();
//$('#submitListing').click();