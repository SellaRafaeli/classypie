//multi-page
function showPage(pageName) { $('.full-page').hide(); $(pageName).show(); }

//form page
form = {
    title: 'default title',
    where: 'Paris',
    when: '12/25/14',
    for_about: '20',
    details: 'some details',
    contact: 'bob@email.com',
    submit: function() { 
        renderListingPage(form)    
    }
};    

function buildFormPage(){    
    jab.bindObj(form,"#postForm");
}

//listing page
listing = {};
function renderListingPage(data) {
    listing = data; 
    listing.offers = listing.offers || [{name: 'Joe'}, {name: 'Bob'}]; 
    listing.submitOffer = function() { listing.offers.push({name: 'new offer'}) };
    jab.bindObj(listing,"#listing-page");
    showPage('listing-page');
}

//run
buildFormPage();
$('#submitListing').click();