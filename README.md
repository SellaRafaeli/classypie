ClassyPie is a platform to connect local buyers and sellers. 

## Installation

Prerequisites - MongoDB.

1. $ git clone https://github.com/SellaRafaeli/classypie.git
2. $ cd classypie
3. $ bundle install
4. $ rackup 
5. #open localhost:9292

## Flow

1. Users can post listings. Users are 'remembered' by their session. Upon first posting, the email is used to create a user with that email. 
2. When viewing a listing, you can post an offer if your are not the listing owner and. If you have already posted an offer, you will see only your offer. Listing owner sees all offers. 
3. Buyer (listing poster) and Seller (offer poster) can write messages to each other via the offer posted. (And/or trade emails and continue conversation via email).

Next steps:
- homepage:
  - make bottom form work 
  - make bottom map sync with address 
  - form validation
- listing-page:
  - remove extra whitespace
  - support updating of listing for buyer
  - disable editing of listing for non-buyer
  - make nicer 'working on it'
  - offers:
    - form validation
    - show user image in offer
    - make nicer 'us/them'
- user-page:
  - enable setting of image for user
  - show reviews in a nicer way
- search-page:
  - make general design 


Todo someday: 
- Signup with FB, Gmail, Twitter, GitHub
- Get images of users (and encourage them to post images and personal data)
3. Sign-Up page for sellers (email me when new listing of certain criteria)
3.5 send email to sellers that have signed up for a keyword/area
3.6 send email to buyers whenever something happens for me 
3.7 send email to Sella whenever anything happens. 