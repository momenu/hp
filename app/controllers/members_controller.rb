class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    per = 10
    @members = Member.page(params[:page]).per(per)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @member = Member.new(member_params)
      @user = User.new(name: @member.name, password: '111111', password_confirmation: '111111')
      @member.position = '管理者' if @member.name == 'mome'
      @member.save!
      @user.member_id = @member.id
      @user.save!
    end
    flash[:notice] = "#{@member.name}を登録しました。"
    respond_to do |format|
      format.html { redirect_to @member }
      format.json { render :show, status: :created, location: @member }
    end
  rescue => e
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @member.errors, status: :unprocessable_entity }
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @member.update!(member_params)
      if params[:member][:password].present? || params[:member][:password_confirmation].present?
        params[:member][:password] == params[:member][:password_confirmation] unless raise
        current_user.update!(password: params[:member][:password], password_confirmation: params[:member][:password_confirmation])
      end
    end
    respond_to do |format|
      flash[:notice] = "#{@member.name}を編集しました。"
      format.html { redirect_to @member }
      format.json { render :show, status: :ok, location: @member }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @member.errors, status: :unprocessable_entity }
    end
  rescue RuntimeError => e
    if params[:member][:password].length < 6
      @member.errors.messages[:password] = ["は6文字以上で入力してください"]
    elsif params[:member][:password_confirmation].length < 6
      @member.errors.messages[:password_confirmation] = ["は6文字以上で入力してください"]
    else
      @member.errors.messages[:password] = @member.errors.messages[:password_confirmation] = ["が確認用パスワードと一致していません"]
    end
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @member.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @member.destroy
    flash[:notice] = "#{@member.name}を削除しました。"
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:name, :rate, :discord_id, :game_num, :win_num, :lose_num, :twitter, :position)
    end

end
