class OnboardDistributorController < ApplicationController
  
  def one

    @distributor = @current_user.distributor

  end

  def two

    @distributor = @current_user.distributor

  end

  def three

    @distributor = @current_user.distributor

  end

  def four

    @distributor = @current_user.distributor

    @channel_capacities = @distributor.channel_capacities
    @new_channel_capacity = ChannelCapacity.new

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


end