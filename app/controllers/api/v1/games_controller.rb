module Api
  module V1
    class GamesController < Api::V1::BaseController
      def create
        game = Game.create!
        render json: { game_id: game.id }, status: :created
      end

      def show
        game = Game.find(params[:id])
        render json: game, include: :frames
      end

      def score
        game = Game.find(params[:id])
        score = CalculateScoreCommand.call(game)
        render json: score
      end
    end
  end
end
