require 'locales/en.rb'

module NoughtsAndCrosses
  module Strings
   
    def translate(symbol, arg = '')
      STRINGS[symbol].gsub('%', arg)
    end
  end

end
