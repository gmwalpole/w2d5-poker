class Hand

  attr_accessor :cards, :high_card

  def initialize
    @cards = []
    @high_card = get_high_card
  end

  def get_high_card(card_set = cards)
    card_set.sort_by{ |i| Card.to_val(i.value) }.last
  end

  def add_cards(drawn_cards)
    @cards += drawn_cards
    @high_card = get_high_card
  end

  def toss(toss_cards)
    num_cards = toss_cards.length
    toss_cards.each do |card|
      cards.delete(card)
    end
    num_cards
  end

  def count
    cards.count
  end

  def calculate_value
    hand_value = :single
    #highest_card = :deuce

    hand_value = :pair if is_pair?
    hand_value = :two_pair if is_two_pair?
    hand_value = :three_of if is_three_of?
    hand_value = :straight if is_straight?
    hand_value = :flush if is_flush?
    hand_value = :full_house if is_full_house?
    hand_value = :four_of if is_four_of?
    hand_value = :straight_flush if is_straight_flush?

    hand_value
  end

  def is_pair?
    get_card_numbers.any? { |k,v| v == 2 }
  end

  def is_three_of?
    get_card_numbers.any? { |k,v| v == 3 }
  end

  def is_four_of?
    get_card_numbers.any? { |k,v| v == 4 }
  end

  def is_two_pair?
    get_card_numbers.select { |k,v| v == 2 }.count == 2
  end

  def is_full_house?
    is_pair? && is_three_of?
  end

  def is_flush?
    get_suit_numbers.count == 1
  end

  def is_straight_flush?
    is_flush? && is_straight?
  end

  def get_cards_where()
  end

  def is_straight?
    temp_cards = cards.map{ |i| Card.to_val(i.value) }.sort
    temp_cards[0...-1].each_index do |index|
      return false if temp_cards[index] != temp_cards[index + 1] - 1
    end
    true
  end

  def get_suit_numbers
    counts = Hash.new(0)
    cards.each do |card|
      counts[card.suit] += 1
    end
    counts
  end

  def get_card_numbers
    counts = Hash.new(0)
    cards.each do |card|
      counts[card.value] += 1
    end
    counts
  end

  def beats?(other_hand)
    hand_values = [:single,:pair,:two_pair,:three_of,:straight,
                  :flush,:full_house,:four_of,:straight_flush]
    our_val = calculate_value
    their_val = other_hand.calculate_value
    hand_values.index(our_val) >= hand_values.index(their_val)
  end

end
