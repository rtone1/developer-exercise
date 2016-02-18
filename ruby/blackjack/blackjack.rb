#NOTE. Hi, this was a lot of fun. You can play the game on terminal by uncommenting
# some methods I marked below and initializing the Game class(just uncomment).

class Card

  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
      @suite, @name, @value = suite, name, value
  end

  def makeCardOdj
      return  @suite => {@name => @value} # METHOD TO GET A CARD HASH OBJECT
  end

end # END OF CARD CLASS


class Deck

  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value).makeCardOdj # ADDED makeCardOdj METHOD TO GET MY HASH DECK
      end
    end
  end

end # END OF DECK CLASS



class Hand

  attr_accessor :cards

  def initialize
    @cards = []
  end

end # END OF HAND CLASS


# CLASS BELOW IS TO CREATE A GAME
class Game
  attr_accessor :player, :dealer, :game_deck

  def initialize
      @player = Hand.new.cards
      @dealer = Hand.new.cards
      startGame
  end

  def startGame
      @game_deck = Deck.new
      2.times do                            # HAND OUT 2 CARDS TO PLAYER AND DEALER
          @player << @game_deck.deal_card
          @dealer << @game_deck.deal_card
      end
      puts "DEALER hand is: #{@dealer[1]}"
      puts "PLAYER hand is: #{@player}"
      # sum_of_player                       #UNCOMMENT THESE METHODS TO PLAY
      # bust_or_win
  end

  # METHOD TO ASK PLAYER TO STAY OR HIT, ELSE DEALERS TURN
  def hit
      puts "Hit or Stay? respone yes or no"
      play_one = gets.chomp.downcase
      if play_one == ""
          puts "Are you sure you want to stay?"
          hit
      elsif play_one == 'yes' || play_one == 'y'
          @player.push(@game_deck.deal_card)
          puts "Player's hand: #{@player}"
          sum_of_player
          bust_or_win
      elsif play_one == "n" || play_one == "no"
          dealer_bust_or_win
      end
  end

  def bust_or_win
      if @total == 21
          puts "YOU WON!!!"
          return true
      elsif @total > 21
          puts "Bust! You lose everything!"
          return true
      else
          hit
      end
  end

  def dealer_bust_or_win
      sum_of_dealer
        while @dealertotal <= @total        # LOOP UNTIL DEALER's TOTAL IS GREATER THAN PLAYERS
            @dealer.push(@game_deck.deal_card)
            sum_of_dealer
        end

        if @dealertotal >= @total && @dealertotal <= 21
            puts "DEALER has won!"
        elsif @dealertotal > 21
            puts "YOU WON!!!"
        elsif @total > @dealertotal
            puts "YOU WON!!!"
        end

  end

  def sum_of_player
      @total = 0
      acevalue = 0
      playerCards = []
      @player.each do |suite|
          suite.each do |k,v|
                v.each do |key,values|
                      playerCards << values
                end
          end
      end

      playerCards.each do |x|
          if x[0] != 11
              @total += x
          elsif x[0] == 11
              puts "Is your Ace a 1 or 11?"
              ask = gets.chomp.to_i
              acevalue = ask
              @total += acevalue
          end
      end

      puts "Sum of PLAYER'S cards are = #{@total}"
  end

  def sum_of_dealer
      @dealertotal = 0
      acevalue = 0
      dealerCards = []
      @dealer.each do |suite|
          suite.each do |k,v|
                v.each do |key,values|
                      dealerCards << values
                end
          end
      end

      dealerCards.each do |x|
          if x[0] != 11
              @dealertotal += x
          elsif x[0] == 11
              if @dealertotal > 10
                  acevalue = 1
                  @dealertotal += acevalue
              else
                  acevalue = 11
                  @dealertotal += acevalue
              end
          end
      end

      puts "Sum of DEALER'S cards are = #{@dealertotal}"
  end

end # END OF GAME CLASS


# Game.new    # INITIALIZE GAME __uncomment if you want to play__
              # comment test so values don't interfere with Game
              # and uncomment the two methods above

######################
# TEST FOR BLACKJACK #
#       BELOW        #
######################

# require 'test/unit'
#
# class CardTest < Test::Unit::TestCase
#   def setup
#     @card = Card.new(:hearts, :ten, 10)
#   end
#
#   def test_card_suite_is_correct
#     assert_equal @card.suite, :hearts
#   end
#
#   def test_card_name_is_correct
#     assert_equal @card.name, :ten
#   end
#   def test_card_value_is_correct
#     assert_equal @card.value, 10
#   end
# end
#
# class DeckTest < Test::Unit::TestCase
#   def setup
#     @deck = Deck.new
#   end
#
#   def test_new_deck_has_52_playable_cards
#     assert_equal @deck.playable_cards.size, 52
#   end
#
#   def test_dealt_card_should_not_be_included_in_playable_cards
#     card = @deck.deal_card
#     assert_equal(@deck.playable_cards.include?(card), false)
#   end
#
#   def test_shuffled_deck_has_52_playable_cards
#     @deck.shuffle
#     assert_equal @deck.playable_cards.size, 52
#   end
# end
#
# class GameTest < Test::Unit::TestCase
#   def setup
#     @game = Game.new
#   end
#
#   def test_players_hand_has_2_playable_cards
#     assert_equal @game.player.size, 2
#   end
#
#   def test_dealer_hand_has_2_playable_cards
#     assert_equal @game.dealer.size, 2
#   end
#
#   def test_to_see_if_4_cards_are_handed_out
#     assert_equal @game.game_deck.playable_cards.size, 48
#   end
#
# end
