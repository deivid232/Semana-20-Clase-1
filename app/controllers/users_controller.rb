class UsersController < ApplicationController
  skip_authorization_check except: [:destroy, :edit]
  load_and_authorize_resource
  def index
    @users = User.all
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to pages_dashboard_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def edit
    @user = User.find(params[:id])
    if @user.role == "visit"
      @user.role = "admin"
      @user.save
    else
      @user.role = "visit"
      @user.save
    end
    redirect_to pages_dashboard_path
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:name, :email, :role, :password)
  end
end
