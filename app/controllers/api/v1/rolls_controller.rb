module Api
  module V1
    class RollsController < ApplicationController
      def create
        result = Rolls::Create.call(params: roll_params, game_id: params[:game_id])
        render_command_result(result, status: :created)
      end

      private

      def roll_params
        params.require(:roll).permit(:pins).to_h
      end
    end
  end
end
