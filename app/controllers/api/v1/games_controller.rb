module Api
  module V1
    class GamesController < ApplicationController
      def create
        result = Games::Create.call
        render_command_result(result, status: :created)
      end

      def show
        render json: game, include: :frames, status: :ok
      end

      def score
        result = Games::Score.call(game:)
        render_command_result(result, status: :ok)
      end

      private

      def game
        @game ||= Game.find(params[:id])
      end
    end
  end
end
