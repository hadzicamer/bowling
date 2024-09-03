module Rolls
  class Create < ApplicationCommand
    MAX_FRAMES = 10

    def initialize(params:, game:)
      @params = params
      @game = game
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

    attr_reader :contract, :params, :game

    def roll_attributes
      validation_result.to_h.slice(:pins)
    end

    def find_or_create_frame
      last_frame = game.frames.last
      if new_frame_needed?(last_frame)
        create_new_frame(last_frame)
      else
        validate_roll(last_frame)
      end
    end

    def new_frame_needed?(last_frame)
      last_frame.nil? || last_frame.rolls.count >= 2 || last_frame.rolls.sum(:pins) == 10
    end

    def create_new_frame(last_frame)
      if game.frames.count >= MAX_FRAMES
        [:failure, { error: "Maximum number of frames (#{MAX_FRAMES}) reached" }]
      else
        frame_number = last_frame ? last_frame.number + 1 : 1
        [:success, game.frames.create!(number: frame_number)]
      end
    end

    def validate_roll(last_frame)
      if last_frame.rolls.sum(:pins) + params[:pins] > 10
        [:failure, { error: "Invalid roll: total pins in a frame cannot exceed 10" }]
      else
        [:success, last_frame]
      end
    end
  end
end
