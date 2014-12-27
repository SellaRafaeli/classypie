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
1. 'User Page' which includes:
  > list of user's postings and his offers (only he can see).
  > reviews and ratings (publicly viewable/'addable')
2. Search page for listings 
3. Sign-Up page for sellers (email me when new listing of certain criteria)
4. Front-End design. 

Todo someday: 
- Signup with FB, Gmail, Twitter, GitHub
- Get images of users (and encourage them to post images and personal data)
