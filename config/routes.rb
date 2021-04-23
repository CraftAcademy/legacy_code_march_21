# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    # Fix the typo :analyses to :analysis
    resources :analyses, only: [:create]
  end
end
