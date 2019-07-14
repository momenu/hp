module Api
  module V1
    class Api::V1::GameController < ApplicationController
      def index
        @members = Member.all
        render json: @members
      end
    end
  end
end
