# sixLitle.rb - SixLitle class implementation
# Author: Khyran Bush
# Date: January 22, 2024
# Description: A Ruby program defining a SixLitle class with Ask, Prepare, Display, and Run methods.

class SixLitle
  attr_accessor :words, :hints, :tokens

  def initialize
    # Initialize collections
    @words = []
    @hints = []
    @tokens = []
  end

  # Ask method to collect six pairs of words and hints
  def ask
    6.times do |i|
      loop do
        print "Enter word #{i + 1} (at least 4 characters): "
        word = gets.chomp
        print "Enter hint #{i + 1}: "
        hint = gets.chomp

        if word.length >= 4
          @words << word
          @hints << hint
          break
        else
          puts "Word is too short. Please enter a word with at least 4 characters."
        end
      end
    end
  end

  # Prepare method to break words, capitalize parts, and shuffle tokens
  def prepare
    @tokens = @words.flat_map { |word| word.scan(/.{1,2}/).map(&:capitalize) }.shuffle
  end

  # Display method to show the formatted output
  def display
    puts "Six Little Words (Ruby)"
    puts "\nTokens:"
    @tokens.each_slice(4) { |row| puts row.join("\t") }
    puts "\nHints:"
    @hints.each { |hint| puts "- #{hint}" }
    puts "\nAnswer Key:"
    @words.each_slice(2) { |pair| puts pair.join("\t") }
  end

  # Run method to clear collections, call Ask, Prepare, and Display in turn
  def run
    @words.clear
    @hints.clear
    @tokens.clear

    ask
    prepare
    display
  end
end

# Example of usage:
six_little_game = SixLitle.new
six_little_game.run