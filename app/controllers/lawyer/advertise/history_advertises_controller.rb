class Lawyer::Advertise::HistoryAdvertisesController < Lawyer::BaseController
  def new
    @history_advertise = current_account.history_advertises.build
    @categories = Category.all.pluck(:name, :id)
  end

  def create
    @categories = Category.all.pluck(:name, :id)
    @history_advertise = current_account.history_advertises.new history_advertise_params
    total_point = Point.advertise.first.point_per_time * @history_advertise.advertise_period
    if current_account.lawyer_profile.point >= total_point && update_infomation(@history_advertise.advertise_period)
      flash[:success] = t ".created"
      redirect_to lawyer_root_path
    else
      flash.now[:error] = t ".creat_fail"
      render :new
    end
  end

  private
  def history_advertise_params
    params.require(:history_advertise).permit HistoryAdvertise::HISTORY_ADVERTISE_ATTRIBUTES
  end

  def update_infomation point_amount
    history_point = ::CreateHistoryPointService.new(point: Point.advertise.first,
      account: current_account, amount: point_amount).perform
    ::UpdatePointLawyerService.new(current_account.lawyer_profile).perform
    @history_advertise.history_point_id = history_point.id
    @history_advertise.save
  end
end
