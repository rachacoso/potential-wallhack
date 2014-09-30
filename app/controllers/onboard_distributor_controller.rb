class OnboardDistributorController < ApplicationController
  
  before_action do
    check_usertype("distributor")
  end  

  def one

    @distributor = @current_user.distributor

  end

  def two

    @distributor = @current_user.distributor

  end

  def three

    @distributor = @current_user.distributor

  end

  def three_a

    @distributor = @current_user.distributor
    @sectors = @distributor.sectors rescue nil
    @channels = @distributor.channels rescue nil
    @new_channel_capacity = ChannelCapacity.new

  end

  def four

    @distributor = @current_user.distributor
    @channel_capacities = @distributor.channel_capacities

  end

  def five

    @distributor = @current_user.distributor

    @current_brands = @distributor.distributor_brands.where(current: true) rescue nil
    @past_brands = @distributor.distributor_brands.where(current: false) rescue nil
    @new_brand = DistributorBrand.new

  end

  def six

    @distributor = @current_user.distributor


  end

  def seven

    @distributor = @current_user.distributor

    @trade_shows = @distributor.trade_shows rescue nil
    @new_trade_show = TradeShow.new

  end

  def eight

    @distributor = @current_user.distributor

  end

  private
  def check_usertype(type)
    if @current_user.type? != type
      redirect_to dashboard_url
    end
  end


end