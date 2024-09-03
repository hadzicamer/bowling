module Games
  class Create < ApplicationCommand
    def call
      game = Game.create!
      [:success, game]
    end
  end
end
