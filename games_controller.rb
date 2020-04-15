require './message_dialog'

class GamesController
  include MessageDialog
  
  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  def battle(**params)
    build_characters(params)
    
    loop do
      @zhero.attack(@monster)
      if battle_end?
        break
      end
      @monster.attack(@zhero,@zhero2)
      if battle_end?
        break
      end
    end   
    battle_judgment
  end
  
  private
  # キャラクターのインスタンスをインスタンス変数に格納
  def build_characters(**params)
    @zhero = params[:zhero]
    @zhero2 = params[:zhero2]
    @monster = params[:monster]
  end
  # バトル終了の判定
  def battle_end?
    @zhero.hp <= 0 || @monster.hp <= 0
  end
  # ヒーローの勝利判定
  def zhero_win?
    @zhero.hp > 0 
  end
  
  def battle_judgment
    result = calculate_of_exp_and_gold
    end_message(result)
  end
  # 経験値とゴールドの計算
  def calculate_of_exp_and_gold
    if zhero_win?
      zhero_win_flag = true
      exp = (@monster.offense * @monster.defense) * EXP_CONSTANT
      gold = (@monster.offense * @monster.defense) * GOLD_CONSTANT
    else
      zhero_win_flag = false
      exp = 0
      gold = 0
    end

    {zhero_win_flag:zhero_win_flag,exp:exp,gold:gold}
  end
end