//multi-page
function runByURL() { 
    var pageName = document.location.pathname.split('/')[1];
    if      (pageName == 'user')    buildUserPage();
    else if (pageName == 'search')  buildSearchPage();
    else if (pageName == 'listing') buildListingPage();
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

    //listingID = getFormData().id;
    
    form.submit(function(e) {               
        $.post('/listing/create', getFormData())
         .success(function(res) { document.location.href = '/listing/'+res} ).error(genError);
        e.preventDefault();
    })
    
    var w = window;

    w.onTaken = function() {
        $('#goToEmailBtn').toggleClass('hide');
    }
}

window.signup = function() {
    var email = prompt('What is your email?')
    if (email) $.post('/signup', {email: email}).success(function(res){ 
        if (res=='ok') document.location.reload();
        else if (res=='taken') {
            var msg = 'Please click confirmation link sent to your email: '+email+'. Go to gmail.com now?';
            if (confirm(msg)) document.location.href = 'http://www.gmail.com';
        }
        else alert ('Error: '+res);
    }).error(genError)

    return event.preventDefault() && false;        
}

window.logout = function() {
    $.post('/logout').success(function(res){ document.location.reload(); }).error(genError);
}

function buildOffers(){
    offers = {};        

    var newOfferForm = $('#newOfferForm');

    newOfferForm.submit(function(){
        var newOffer = newOfferForm.toObj();
        $.post('/offers/create', newOffer).success(function(res) { document.location.reload();}).error(genError);
    });    

    offers.addMsg = function(elem) {
        var offerID = elem.getAttribute('offer_id');
        $.post('/offers/addMsg/'+offerID, {text: elem.value}, function(res) { document.location.reload() }).error(genError);
    }
}

function buildListingPage() {
    console.log("In listing page");

    $('#updateListingForm').submit(function(e){
        var data = $(this).toObj();
        data.addressDetails = window.addressDetails
        $.post('/listing/update/'+data.listing_id,data)
         .success(function(res) { document.location.reload() }).error(genError);
        e.preventDefault();
    });

    buildOffers();    
}

function buildUserPage() {
    console.log("In user page");
    var target_user_id = $('#target_user_id').val();
    $('#newReviewForm').submit(function(e) {               
        var data = $(this).toObj();
        $.post('/reviews/user/'+target_user_id, data)
         .success(function(res) { document.location.href = '/user/'+target_user_id} ).error(genError);
        e.preventDefault();
    });

    $('#editUserDataForm').submit(function(e){
       $.post('/user/'+target_user_id, $(this).toObj())
        .success(function(res) { document.location.reload(); } ).error(genError);
       e.preventDefault();   
    });
}

function buildSearchPage(){
    console.log("In search page");
    var form = $("#searchForm");
    form.submit(function(){   
        var data = form.toObj();     
        document.location.href='/search/'+data.content+'/'+data.location+'?lat='+(addressDetails.lat || '')+'&lng='+(addressDetails.lng || '');

        return false;
    });    
}

// current_user = {};
// loginBtn             = $('#loginBtn');
// logoutBtn            = $('#logoutBtn');
// currentUserEmailArea = $('#currentUserEmail');
// currentUserEmail = currentUserEmailArea.text();

// current_user.markLoggedIn = function(email) {
//     loginBtn.hide(); logoutBtn.hide();
//     if (email && email.trim()) {        
//         logoutBtn.show();
//         currentUserEmailArea.text(email);    
//     } else { //logged-out
//         loginBtn.show();
//         currentUserEmailArea.text('');
//     }
// }

// current_user.markLoggedIn(currentUserEmailArea.text());

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
    dontSubmitFormsOnEnter();
    addPlaceholdersDefaults();    
    syncTwoInputs('#pfTitle','#sfTitle');
    syncTwoInputs('#pfAddress','#sfAddress');
    syncTwoInputs('#pfContact','#sfContact');
    // $('.datepicker').datepicker();
});


