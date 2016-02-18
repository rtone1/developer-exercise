Please fork the repository, complete following exercises, both ruby and javascript.<br />
When you are complete submit a pull request for review.

If you have any questions feel free to email developers@benchprep.com

## Javascript/Coffeescript

### Accordion

In `accordion.html` you will find ACT course sections breakdown.

Please, write code to simulate [jquery accordion](http://docs.jquery.com/UI/Accordion) plugin behavior with those sections.
By default current setup comes with qunit, feel free to drop and use your own testing framework or write all your code as coffescript.

### Simple Backbone List

In `quotes.html` you will need to build a simple backbone.js view to list given quotes.

Please provide the following functionality:

 * Fetch quotes from source [quotes.json](https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json) and display available information in the list-like structure (table/list)
 * Provide client-side pagination (up to 15 quotes per page)
 * Optionally: Provide way to filter between game and movie quotes
 * Optionally: Provide client-side search filter by the quote text

Please, use your discretion in implementing nice-to-have features (if interested).

## Ruby

### Array extension

Please, write a module that provides `where` behavior to the array of hashes (see test.rb and make it pass, feel free to convert it to your favorite test framework).

### Youtube client

Please, write a ruby api that for now takes a search string and returns 3 relevant search results from youtube (links to youtube videos)

### Simplified Blackjack

`blackjack.rb` contains initial work on blackjack simulation

Please, use your discretion in fixing/adding tests. You are free to use/convert to any testing framework you want.
You will need to implement the following functionality.

 * As a Player I can get a hand with two cards in it
 * As a Dealer I can get a hand with two cards in it
 * As a User I can see what card the dealer is showing
 * As a User I can bust (lose immediately) when I am getting cards
 * As a User I can blackjack (win immediately) when I am getting cards
 * As a Dealer I can draw cards after the player until I win or lose


 Bonus:

 * Simulate a random round of the game (you dont have to write educated user decision logic - it could be guesses)

 Rules:

 * Bust - all possible hand values are greater than 21 points
 * Blackjack - any possible hand value is exactly 21 point
 * Assume dealer stays on 17 (any hand value)

 For more rules on blackjack please refer to the [wiki](http://en.wikipedia.org/wiki/Blackjack)
