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
    var getFormData = function() { 
        var res = form.toObj(); 
        res.addressDetails = window.addressDetails; //updated by googleMapsAutocomplete
        return res;
    };

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

    var newOfferForm = $('#newOfferForm');

    offers.addOffer = function() {
        var newOffer = newOfferForm.toObj();
        newOffer.listing_id = listingID;
        $.post('/offers/create', newOffer).success(function(res) { 
            document.location.reload();}).error(genError);
    }        

    offers.addMsg = function(elem) {
        var offerID = elem.getAttribute('offer_id');
        $.post('/offers/addMsg/'+offerID, {text: elem.value}, function(res) { document.location.reload() }).error(genError);
    }
}

function buildListingPage() {
    console.log("In user page");
}

function buildUserPage() {
    console.log("In user page");
}

function buildSearchPage(){
    console.log("In search page");
    var form = $("#searchForm");
    form.submit(function(){   
        var data = form.toObj();     
        document.location.href='/search/'+data.content+'/'+data.location+'?lat='+addressDetails.lat+'&lng='+addressDetails.lng;

        return false;
    });
}

//current user area 
function signup() {
    var email = prompt('What is your email?');
    $.post('/signup', {email: email}).success(function(res){ document.location.reload(); }).error(genError)        
}

function logout() {
    $.post('/logout').success(function(res){ document.location.reload(); }).error(genError);
}

current_user = {};
loginBtn             = $('#loginBtn');
logoutBtn            = $('#logoutBtn');
currentUserEmailArea = $('#currentUserEmail');
currentUserEmail = currentUserEmailArea.text();

current_user.markLoggedIn = function(email) {
    loginBtn.hide(); logoutBtn.hide();
    if (email && email.trim()) {        
        logoutBtn.show();
        currentUserEmailArea.text(email);    
    } else { //logged-out
        loginBtn.show();
        currentUserEmailArea.text('');
    }
}

current_user.markLoggedIn(currentUserEmailArea.text());

//run
runByURL();
//$('#submitListing').click();


Mousetrap.bind(['command+k'], function(e) {
    fillFormRandom('#postForm');
    fillFormRandom('#newOfferForm');
    return false;
});

$(function() {
    console.log( "ready!" );
    addPlaceholdersDefaults();    
    // $('.datepicker').datepicker();
});
