module Rolls
  class CreateContract < ApplicationContract
    json do
      required(:pins).maybe(:integer, gteq?: 0, lteq?: 10)
    end
  end
end
