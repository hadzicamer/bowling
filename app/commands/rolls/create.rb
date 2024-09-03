module Rolls
  class Create < ApplicationCommand
    def initialize(params:, game_id:)
      @params = params
      @game_id = game_id
      @contract = Rolls::CreateContract.new
    end

    def call
      return [:failure, validation_result.errors.to_h] if validation_result.failure?

      frame_result = find_or_create_frame
      return frame_result if frame_result.first == :failure

      roll = Roll.create!(roll_attributes.merge(frame: frame_result.last))

      [:success, roll]
    end

    private

    attr_reader :contract, :params, :game_id

    def roll_attributes
      validation_result.to_h.slice(:pins)
    end

    def find_or_create_frame
      game = Game.find(game_id)
      last_frame = game.frames.last
      if last_frame.nil? || last_frame.rolls.count >= 2 || last_frame.rolls.sum(:pins) == 10
        [:success, game.frames.create!(number: last_frame ? last_frame.number + 1 : 1)]
      else
        if last_frame.rolls.sum(:pins) + params[:pins] > 10
          return [:failure, { error: "Invalid roll: total pins in a frame cannot exceed 10" }]
        end
        [:success, last_frame]
      end
    end
  end
end
