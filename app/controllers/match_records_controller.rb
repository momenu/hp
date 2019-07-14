class MatchRecordsController < ApplicationController
  before_action :set_match_record, only: [:edit, :update, :destroy]
  before_action :set_team, only: :confirm
  def index
    per = 2
    @match_records = MatchRecord.page(params[:page]).per(per)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    redirect_to new_match_record_path
  end

  def new
    @match_record = session[:match_record_params].present? ? MatchRecord.new(session[:match_record_params]) : MatchRecord.new
    session.delete(:match_record_params)
  end

  def autocomplete
    members = Member.autocomplete(params[:term]).pluck(:name)
    respond_to do |format|
      format.html
      format.json {
        render json: members
      }
    end
  end

  def confirm
    @match_record = MatchRecord.new(match_record_params)
    session[:match_record_params] = match_record_params
    render :new if @match_record.invalid?
  end

  def edit
  end

  def create
    session.delete(:match_record_params)
    @match_record = MatchRecord.new(match_record_params)
    respond_to do |format|
      if params[:back]
        format.html { render :new }
      elsif @match_record.save
        format.html { redirect_to edit_match_record_path(@match_record) }
        format.json { render :show, status: :created, location: @match_record }
      else
        format.html { render :new }
        format.json { render json: @match_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @match_record.update(match_record_params)
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @match_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    def set_match_record
      @match_record = MatchRecord.find(params[:id])
    end

    def match_record_params
      params.require(:match_record).permit(
        :player1, :player2, :player3, :player4, :player5, :player6,
        :player7, :player8, :term, :team1ids, :team2ids, :win_team, :lose_team
      )
    end

    def set_team
      return unless match_record_params.values.reject(&:blank?).count == 8
      @members = []
      match_record_params.values.each_with_index do |value, i|
        member = Member.find_by(name: value)
        @members.push([member.name, member.rate, member.id])
      end
      dif = 100000
      (1..5).each do |i|
        ((i + 1)..6).each do |j|
          ((j + 1)..7).each do |k|
            team1 = [0, i, j, k]
            team2 = []
            (1..7).each{ |index| team2.push(index) unless team1.include?(index) }
            sumTeam1 = 0
            sumTeam2 = 0
            team1.each{ |t| sumTeam1 += @members[t][1]}
            team2.each{ |t| sumTeam2 += @members[t][1]}
            if (sumTeam1 - sumTeam2).abs < dif
              dif = (sumTeam1 - sumTeam2).abs
              @sumTeam1 = sumTeam1
              @sumTeam2 = sumTeam2
              @team1 = team1
              @team2 = team2
            end
          end
        end
      end
    end
end
