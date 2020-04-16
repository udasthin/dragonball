# 親クラス
class Character
  attr_reader :offense,:defense
  attr_accessor :hp,:name
  
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end

class Zhero < Character
  attr_reader :name,:offense,:defense
  attr_accessor :hp

  SPECIAL_ATTACK_CONSTANT = 1.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    
  end

  def attack(monster)
    puts "#{@name}の攻撃！"

    attack_type = decision_attack_type
    damage = calculate_damage(target:monster, attack_type:attack_type)
    cause_damage(target:monster, damage:damage)
    
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end


  private

    def decision_attack_type
      attack_num = rand(10)    
      if attack_num == 0
        puts "かめはめ波だ！"
        "special_attack"
      else
        puts "通常攻撃"
        "nomal_attack"
      end
    end
    
    def calculate_damage(**params)
      target = params[:target]
      attack_type = params[:attack_type]

      if attack_type == "special_attack"
        calculate_special_attack - target.defense
      else
        @offense - target.defense
      end
    end
    
    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage
      target.hp = 0 if target.hp < 0

      puts "#{target.name}は#{damage}のダメージを受けた！"
    end
      
    def calculate_special_attack
      # 攻撃力が1.5倍
      @offense * SPECIAL_ATTACK_CONSTANT
    end
# ヒーロークラスエンド
end



class Monster < Character

  attr_reader :offense, :defense
  attr_accessor :hp, :name
  # HPが半分の時の処理 
  HALF_HP_MONSTER = 0.5
  # フルパワーになり攻撃力1.5倍
  HULL_POWER = 1.5
  
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    # 変身する際のトリガーを計算
    @trigger_of_transform = params[:hp] * HALF_HP_MONSTER
    # 変身したときのフラグ
    @trans_form_flag = false
  end

  def attack(zhero,zhero2)
    if @hp <= @trigger_of_transform && @trans_form_flag == false
      @trans_form_flag = true
      transform
    end

    
    damage = calculate_damage(zhero,zhero2)
    cause_damage(target:zhero,zhero2:zhero2,damage:damage)

    puts "#{zhero.name}の残りHPは#{zhero.hp}だ"
    puts "#{zhero2.name}の残りHPは#{zhero2.hp}だ"     
  end
  
  private
  
  def calculate_damage(target,zhero2)
    puts "#{@name}の攻撃"
    @offense - target.defense
    @offense - zhero2.defense
  end 
  
  def cause_damage(**params)
    target = params[:target]
    zhero2 = params[:zhero2]
    damage = params[:damage]

    monster_attack_num = rand(1..2)
    if zhero2.hp == 0
      monster_attack_num = 1
    end
    if monster_attack_num == 1
      target.hp -= damage
      puts "#{target.name}は#{damage}ダメージを受けた！"
    elsif monster_attack_num == 2
      zhero2.hp -= damage
      puts "#{zhero2.name}は#{damage}ダメージを受けた！"
    end
    target.hp = 0 if target.hp < 0
    zhero2.hp = 0 if zhero2.hp < 0
  end

    def transform
      transform_name = "フルパワーフリーザ"

      puts <<~TEXT
      #{@name}は怒っている
      #{@name}は#{transform_name}になった！
      TEXT

      @offense *= HULL_POWER
      @name = transform_name
    end
# モンスタークラスの終わり
end

# 勇者クラスとモンスターをインスタンス化
zhero = Zhero.new(name:"悟空",hp:500,offense:150,defense: 100)
zhero2 = Zhero.new(name:"ベジータ",hp:100,offense:130,defense: 120)
monster = Monster.new(name: "フリーザ",hp: 350,offense: 200, defense: 120)

# 攻撃の実装

loop do
  zhero.attack(monster)
  if monster.hp <= 0
    break
  end
  zhero2.attack(monster)
  if monster.hp <= 0
    break
  end
  monster.attack(zhero,zhero2)
  if zhero.hp <= 0
    break
  end
end

battle_result = zhero.hp > 0

if battle_result
  exp = (monster.offense * monster.defense) * 1.5
  gold = (monster.offense * monster.defense) * 2
  puts <<~TEXT
  #{zhero.name}達は勝利した
  #{exp}の経験値と#{gold}ゴールドを獲得した
  TEXT
else
  puts "#{zhero.name}達は敗北した"
  puts "GAME OVER"
end