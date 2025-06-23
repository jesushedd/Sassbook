class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor:word
  attr_accessor:guesses
  attr_accessor:wrong_guesses
  attr_accessor:word_with_guesses

  
  

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = '-' * word.length 
    @tries = 0
    @max_tries = 7 
  end

  def guess(a_letter)

    if a_letter == nil
      raise ArgumentError.new('Empty string')
    end
    
    if a_letter.empty?
      raise ArgumentError.new('Empty string')
    end



    @tries += 1

    a_letter = a_letter.downcase

    if not a_letter.match?(/[a-zA-Z]/)
      raise ArgumentError.new('no valid letter')
    end
      if @guesses.include? a_letter or @wrong_guesses.include? a_letter
        return false        
      elsif @word.include? a_letter
        @guesses += a_letter
        @word_with_guesses = insert_to_word_guess(a_letter)
      else
        @wrong_guesses += a_letter
      end
      
  end

  def insert_to_word_guess(letter)
    mid = @word_with_guesses.chars
    
    #find all positions of the letter in word
    indexes = []
    @word.each_char.with_index do |char, index|
       indexes << index if char == letter 
    end

    #replace
    indexes.each do |index|
      mid[index]=letter
    end

    mid.join

  end

  def check_win_or_lose()
    puts @tries
    puts @word_with_guesses
    puts @max_tries
    if not @word_with_guesses.include? '-' 
      :win
    elsif @word_with_guesses.include? '-' and @max_tries == @tries
      :lose
    else
      :play
    end
    
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
