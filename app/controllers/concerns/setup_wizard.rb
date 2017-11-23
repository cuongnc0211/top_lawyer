module SetupWizard
  def setup_wizard
    check_steps!
    return if params[:step].nil?

    @step = setup_step_from(params[:step])
    set_previous_next(@step)
  end
end
