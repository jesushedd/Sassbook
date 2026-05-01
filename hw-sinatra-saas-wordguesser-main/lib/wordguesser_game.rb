class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
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

  def guess(a_letter)
    if is_valid_guess(a_letter)
      handle_guess_correctness(a_letter)
      return true
    else
      return false
    end
  end


  def handle_guess_correctness(a_letter)
    if @guesses.include? a_letter or @wrong_guesses.include? a_letter
      return
    elsif @word.include? a_letter
      @guesses = @guesses + a_letter
    else
      @wrong_guesses = @wrong_guesses + a_letter
    end
  end

  def is_valid_guess(a_letter)
    if a_letter.class != String
      return false
    end

    if a_letter.length != 1
      return false
    end

    /[a-zA-Z]/.match? a_letter
    
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
