class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update]

  def index
    subscriptions = Subscription.all
    render json: SubscriptionSerializer.new(subscriptions).serializable_hash.to_json
  end

  def show
    render json: SubscriptionSerializer.new(@subscription, include: [:teas, :customer ])
  end

  def update
    if @subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(@subscription).serializable_hash.to_json
    else
      render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Subscription not found" }, status: :not_found
  end

  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end
end
