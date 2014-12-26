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

    var newOfferForm = $('#newOfferForm');

    offers.addOffer = function() {
        var newOffer = newOfferForm.toObj();
        newOffer.listing_id = listingID;
        $.post('/offers/create', newOffer).success(function(res) { 
            document.location.reload();}).error(genError);
    }        
}

function buildListingPage() {
    console.log("In user page");
}

function buildUserPage() {
    console.log("In user page");
}

//current user area 
function signup() {
    var email = prompt('What is your email?');
    $.post('/signup', {email: email}).success(function(res){ current_user.markLoggedIn(email)}).error(genError)        
}

function logout() {
    $.post('/logout').success(function(res){current_user.markLoggedIn(false)}).error(genError);
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
    } else {
        loginBtn.show();
        currentUserEmailArea.text('');
    }
}

current_user.markLoggedIn(currentUserEmailArea.text());

//run
runByURL();
//$('#submitListing').click();

function fillRandomListingVals() {
    var gr = getRandomName;
    objToForm($("#postForm"),{title: gr(), where: gr(), 
                              when: gr(), for_about: gr(), 
                              details: gr(), contact: 'me@hello.com'});
}

Mousetrap.bind(['command+k'], function(e) {
    fillRandomListingVals();
    return false;
});