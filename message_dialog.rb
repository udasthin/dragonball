module MessageDialog
  
  def attack_message(**params)
    attack_type = params[:attack_type]
    puts "#{@name}の攻撃"
    puts "かめはめ波！"if attack_type == "special_attack"

  end

  def damage_message(**params)
    target = params[:target]
    zhero2 = params[:zhero2]
    damage = params[:damage]

    puts <<~TEXT
    #{target.name}は#{damage}のダメージを受けた
    #{target.name}のHPは#{target.hp}だ
    TEXT
  end

  def end_message(result)
    if result[:zhero_win_flag]
      
      puts <<~TEXT
      #{@zhero.name}達は勝利した
      #{result[:exp]}の経験値と#{result[:gold]}ゴールドを獲得した
      TEXT
    else
      puts "#{@zhero.name}達は敗北した"
      puts "GAME OVER"   
    end
  end

  def transform_message(**params)
    origin_name = params[:origin_name]
    transform_name = params[:transform_name]

    puts <<~TEXT
    #{origin_name}は怒っている
    #{origin_name}は#{transform_name}になった！
    TEXT
  end
end