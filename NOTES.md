BEER REVIEW

----------------       LAYOUT       -------------------------
- homepage - '/' welcomes user displays links for:
  - Log in:
    - if logged in, displays account name
  - Log out
  - list of all beers - '/beers'
    - do not need to be logged in to look at list, but displays the log in link
    - list will contain links to each individual beer('/beers/:id') and the following attributes:
      - displays the login link:
        - if logged in will display a 'add beer button'('/add') and 'review beer button'('/review'), beers are automatically added when a review is written
        - if logged in and beer has already been added but review hasn't been written, will replace 'add beer' button with 'already in your portfolio' but keeps 'review beer'
        - if logged in and both beer has been added and review has been written, will replace 'add beer' with 'already in your portfolio' and replaces 'review beer' with 'edit review'
      - ABV, - TOTAL REVIEWS(links to all the reviews ('/beers/:id/reviews')), -BREWERY(links to brewery('/breweries/:id')), - OVERALL RATINGS, - NAME
              - review will contain a review, and 5 different ratings:
                - look, feel, smell, taste === OVERALL
  - list of all breweries ('/breweries')
    - list will contain a link to each individual brewery('/breweries/:id') and the following attributes:
      - OVERALL RATING - list of its beers('/breweries/:id/beers') - list of all of its reviews('/breweries/:id/reviews')
  - list of all users ('/users')
    - list will contain an individual link to each user ('/users/:id')
  - user profile
--------------------------------------------------------------------------


sesssion[:message's]?
refactor my code
