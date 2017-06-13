module Api::V1
  class ApiController < ApplicationController
    # before_action :doorkeeper_authorize!

    def index
      render text: 'Rake monitor API'
    end

    private

    def current_account_user
      @current_account_user ||=
        AccountUser.new(user: current_user, account: current_account)
    end

    def current_user
      if doorkeeper_token
        @current_user ||=
          User.find(doorkeeper_token.resource_owner_id)
      end
    end

    def current_account
      @current_account ||=
        current_user.accounts.find_by_id(request.headers['X-accountId']) ||
        current_user.accounts.first
    end
  end
end
