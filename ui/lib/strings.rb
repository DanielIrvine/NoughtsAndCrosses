require 'locales/en.rb'

module NoughtsAndCrosses
  class Strings
   
    def self.translate(symbol, arg = '')
      STRINGS[symbol].gsub('%', arg)
    end
  end
end
