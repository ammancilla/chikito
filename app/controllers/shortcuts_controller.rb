class ShortcutsController < ApplicationController
  def new
    @shortcut = Shortcut.new
  end

  def create
    @shortcut = Shortcuts::Create.call(shortcut_params)

    render :new unless @shortcut.persisted?
  end

  def show
    shortcut = Shortcut.find_by!(key: params[:shortcut_key])

    redirect_to shortcut.url, status: :moved_permanently

    expires_in(365.days)
  end

  private

  def shortcut_params
    params
      .require(:shortcut)
      .permit(:url)
      .to_h.symbolize_keys
  end
end
