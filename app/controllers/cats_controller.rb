class CatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update destroy ]

  # GET /cats
  def index
    @search = Cat.ransack(params[:q]) 
    # Cat.ransckでCatに対してransackを適用し、検索条件を設定
    # params[:q]は検索フォームから送信されたパラメータを受け取る
    @search.sorts = "id asc" if @search.sorts.empty? # デフォルトのソートをid降順にする
    
    # @search.resultで検索結果となる@catsを取得
    # Kaminariを使用してページネーションを適用
    @cats = @search.result.page(params[:page])
  end

  # GET /cats/1
  def show
  end

  # GET /cats/new
  def new
    @cat = Cat.new
  end

  # GET /cats/1/edit
  def edit
  end

  # POST /cats
  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to @cat, notice: "猫を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cats/1
  def update
    if @cat.update(cat_params)
      redirect_to @cat, notice: "猫を更新しました", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cats/1
  def destroy
    @cat.destroy!
    redirect_to cats_path, notice: "猫を削除しました", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def cat_params
      params.expect(cat: [ :name, :age ])
    end
end
