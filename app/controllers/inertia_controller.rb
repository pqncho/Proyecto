# frozen_string_literal: true

class InertiaController < ApplicationController
  inertia_share do
    {
      auth: {
        user: current_user ? current_user.as_json(only: [:id, :name, :admin]) : nil
      }
    }
  end
end