require './character'

class Monster < Character

  # HPが半分の時の処理 
  HALF_HP_MONSTER = 0.5
  # フルパワーになり攻撃力1.5倍
  HULL_POWER = 1.5
  
  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )
    @trigger_of_transform = params[:hp] * HALF_HP_MONSTER
    # 変身したときのフラグ
    @trans_form_flag = false
  end

  def attack(zhero,zhero2)
    if @hp <= @trigger_of_transform && @trans_form_flag == false
      @trans_form_flag = true
      transform
    end
    attack_type = decision_attack_type
    damage = calculate_damage(zhero,zhero2,attack_type:attack_type)
    cause_damage(target:zhero,zhero2:zhero2,damage:damage)
    attack_message(target:zhero,zhero2:zhero2)
    damage_message(target:zhero,zhero2:zhero2,damage:damage)
  end
  
  private
  
  def decision_attack_type
    attack_num = rand(1..2)    
    
    if attack_num == 1
      "悟空"
    elsif attack_num == 2
      "ベジータ"
    end
  end

  def calculate_damage(target,zhero2,attack_type)
    if attack_type == "悟空"
      @offense - target.defense
    else
      @offense - zhero2.defense
    end
  end 
  
  def cause_damage(**params)
    target = params[:target]
    zhero2 = params[:zhero2]
    damage = params[:damage]

    target.hp -= damage
    zhero2.hp -= damage

    puts <<~TEXT
    #{zhero2.name}は#{damage}のダメージを受けた
    #{zhero2.name}のHPは#{zhero2.hp}だ
    TEXT

    target.hp = 0 if target.hp < 0
    zhero2.hp = 0 if zhero2.hp < 0
  end

  def transform
    transform_name = "フルパワーフリーザ"

    transform_message(origin_name:@name,transform_name:transform_name)

    @offense *= HULL_POWER
    @name = transform_name
  end
# モンスタークラスの終わり
end

