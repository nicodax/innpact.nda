# frozen_string_literal: true

module Settings
  class FundsUsersController < ApplicationController
    include FundScoped
    before_action :set_readers

    def show
    end

    def update

      fund.readers_ids = readers_ids.map(&:to_i)

      fund.save

      redirect_to fund_settings_funds_users_path
    end

    private

    def set_readers
      scope = User.with_role(User::ROLE_READER)

      @available_readers = scope.where.not(id: fund.readers_ids)
      @assigned_readers = scope - @available_readers
    end

    def readers_ids
      params["reader"]["user_ids"].reject { |i| i.empty? }
    end

  end
end
