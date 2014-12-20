class Deck

  attr_accessor :cards

  def initialize
    refill
  end

  def refill
    @cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        @cards << Card.new(suit, value)
      end
    end

    cards.shuffle!
    self
  end

  def draw(number)
    cards.shift(number)
  end


end
