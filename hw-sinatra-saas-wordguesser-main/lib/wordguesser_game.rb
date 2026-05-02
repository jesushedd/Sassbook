class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.length
    @state_game = :play
  end

  def word
    @word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end

  def word_with_guesses
    @word_with_guesses
  end



  def guess(a_letter)
    if is_valid_guess(a_letter)
      handle_guess_correctness(a_letter)
      return true
    else
      return false
    end
  end


  def handle_guess_correctness(a_letter)
    
    if @word.include? a_letter
      @guesses = @guesses + a_letter
      assemble_new_word_with_gesses(a_letter, @word, @word_with_guesses)
      if ! @word_with_guesses.include? '-'
        @state_game = :win
      end
    else
      @wrong_guesses = @wrong_guesses + a_letter
      if @wrong_guesses.length >= 7
        @state_game = :lose
      end
    end
  end


  def check_win_or_lose
    @state_game
  end


  def assemble_new_word_with_gesses(letter_guessed, word, word_with_guesses)
    new_word_with_guesses = ''
    word_chars = word.chars
    word_with_guesses_chars = word_with_guesses.chars

    while word_chars.size > 0
      word_char_to_compare = word_chars.shift
      word_with_guesses_char_be_replaced = word_with_guesses_chars.shift
      if letter_guessed == word_char_to_compare
        new_word_with_guesses = new_word_with_guesses + letter_guessed
      else
        new_word_with_guesses = new_word_with_guesses + word_with_guesses_char_be_replaced
      end
    end
    @word_with_guesses =  new_word_with_guesses
  end

  def is_valid_guess(a_letter)
    if a_letter.class != String
      raise ArgumentError
    end

    if a_letter.length != 1
      raise ArgumentError
    end
    a_letter = a_letter.downcase
    if @guesses.include? a_letter or @wrong_guesses.include? a_letter
      return false
    end



    if  ! /[a-zA-Z]/.match? a_letter
      raise ArgumentError
    end

    true
    
  end





  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
