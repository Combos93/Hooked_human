if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'game'
require_relative 'result_printer'
require_relative 'word_reader'
require 'unicode_utils/upcase'

current_path = './' + File.dirname(__FILE__)
words_file_name = current_path + '/data/vis_words.txt'

word_reader = WordReader.new
game = Game.new(word_reader.read_from_file(words_file_name))
printer = ResultPrinter.new

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)