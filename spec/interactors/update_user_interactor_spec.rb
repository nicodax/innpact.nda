# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateUserInteractor do
  let!(:administrator) { create(:administrator) }
  let!(:general_manager) { create(:general_manager) }
  let!(:general_manager_2) { create(:general_manager) }
  let!(:investment_manager) { create(:investment_manager) }

  describe "Upgrade user to admnistrator" do
    it "succeeds when I'm an administrator" do
      params = { email: general_manager.email, firstname: general_manager.firstname, lastname: general_manager.lastname, phone_number: ""}
      context = UpdateUserInteractor.call(params: params, user: general_manager, current_user: administrator, role: :administrator)

      expect(context).to be_success
    end

    it "fails when I'm not an administrator" do
      params = { email: general_manager_2.email, firstname: general_manager_2.firstname, lastname: general_manager_2.lastname, phone_number: ""}
      context = UpdateUserInteractor.call(params: params, user: general_manager_2, current_user: general_manager, role: :administrator)

      expect(context).to be_failure
    end
  end

  describe "Upgrade user to general manager" do
    it "succeeds when I'm an administrator" do
      params = { email: investment_manager.email, firstname: investment_manager.firstname, lastname: investment_manager.lastname, phone_number: ""}
      context = UpdateUserInteractor.call(params: params, user: investment_manager, current_user: administrator, role: :general_manager)

      expect(context).to be_success
    end

    it "succeeds when I'm not an administrator" do
      params = { email: investment_manager.email, firstname: investment_manager.firstname, lastname: investment_manager.lastname, phone_number: ""}
      context = UpdateUserInteractor.call(params: params, user: investment_manager, current_user: general_manager, role: :general_manager)

      expect(context).to be_success
    end
  end

end
