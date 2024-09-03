module Games
  class Calculate < ApplicationCommand
    def initialize(game:)
      @game = game
    end

    def call
      total_score = 0
      frames = game.frames.order(:number)
      frames.each_with_index do |frame, index|
        total_score += frame_score(frame, frames[index + 1], frames[index + 2])
      end
      score = { total_score: total_score, frames: frames.map { |f| frame_details(f) } }
      [:success, score]
    end

    private

    attr_reader :game

    def frame_score(frame, next_frame, second_next_frame)
      if strike?(frame)
        10 + strike_bonus(next_frame, second_next_frame)
      elsif spare?(frame)
        10 + spare_bonus(next_frame)
      else
        frame.rolls.sum(:pins)
      end
    end

    def strike?(frame)
      frame.rolls.first.pins == 10
    end

    def spare?(frame)
      frame.rolls.sum(:pins) == 10
    end

    def strike_bonus(next_frame, second_next_frame)
      if next_frame&.rolls&.first&.pins == 10
        10 + (second_next_frame&.rolls&.first&.pins || 0)
      else
        next_frame&.rolls&.sum(:pins) || 0
      end
    end

    def spare_bonus(next_frame)
      next_frame&.rolls&.first&.pins || 0
    end

    def frame_details(frame)
      {
        number: frame.number,
        rolls: frame.rolls.map(&:pins),
        score: frame_score(frame, nil, nil),
      }
    end
  end
end
