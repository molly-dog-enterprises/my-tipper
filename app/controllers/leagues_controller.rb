class LeaguesController < ApplicationController
  before_action :authenticate_user!

  def index
    @leagues = League.joins(%{
        LEFT JOIN players
          ON players.league_id = leagues.id
      })
      .select(:id, :name, :password, :public, :code, 'count(players.id) as player_count')
      .group(:id, :name, :password, :public, :code)
      .where(['public is true or exists(select from players p where p.league_id = leagues.id and p.user_id = ?)', current_user.id])
      .where(event: false)
      .order('count(players.id) DESC, name')
      .having('count(players.id) > 0')
      .limit(10)
    @members = Player.where(user_id: current_user.id).group(:league_id).maximum(:user_id)
  end

  def show
    @league = League.find_by(code: params[:id])
    if @league.password.blank? || @league.password == params[:password]
      @league.players.create(user_id: current_user.id)
      redirect_to leagues_path(paramify)
    else
      render :password
    end
  end

  def new
    @league = League.new(public: true)
  end

  def create
    @league = League.new(params.require(:league).permit(:name, :public, :password))
    if @league.create(current_user)
      redirect_to leagues_path(paramify(highlight: @league.id))
    else
      render :new
    end
  end

  def update
    @league = League.find(params[:id])
    if @league.password.blank? || @league.password == params[:password]
      @league.players.create(user_id: current_user.id)
      redirect_to leagues_path(paramify)
    else
      flash[:error] = 'Invalid password' if params[:password]
      render :password
    end
  end

  def destroy
    Player.where(
      league_id: params[:id],
      user_id: current_user.id
    ).delete_all
    redirect_to leagues_path(paramify)
  end
end
