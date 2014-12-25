//multi-page
function runByURL() { 
    var pageName = document.location.pathname.split('/')[1];
    if      (pageName == 'user')    buildUserPage();
    else if (pageName == 'search')  buildSearchPage();
    else                            buildFormPage();
}

//form page
function buildFormPage(){
    var form = $("#postForm");
    var getFormData = function() { return form.toObj() };
    listingID = getFormData().id;

    form.submit(function(e) {               
        $.post('/listing/create', getFormData())
         .success(function(res) { document.location.href = '/listing/'+res} ).error(genError);
        e.preventDefault();
    })
    
    buildOffers();    
}

function buildOffers(){
    offers = {};    
    offers.offersList = [];

    var newOfferForm = $('#newOfferForm');

    offers.addOffer = function() {
        var newOffer = newOfferForm.toObj();
        newOffer.listing_id = listingID;
        $.post('/offers/create', newOffer)
         .success(function(res) { 
            newOffer.id = res;
            offers.offersList.unshift(newOffer);
        }).error(genError);
    }    
    
    offers.getAll = function(){
        $.getJSON('/offers/by_listing/'+listingID).success(function(res){offers.offersList = res;})    
    }

    jab.bindObj(offers,"offersArea");    
    if (listingID) offers.getAll();
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