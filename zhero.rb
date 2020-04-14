require './character'

class Zhero < Character

  SPECIAL_ATTACK_CONSTANT = 1.5

  def attack(monster)
    attack_type = decision_attack_type
    damage = calculate_damage(target:monster, attack_type:attack_type)
    cause_damage(target:monster, damage:damage)

    attack_message(attack_type:attack_type)
    damage_message(target:monster,damage:damage)
    
  end

  private

    def decision_attack_type
      attack_num = rand(8)    
      
      if attack_num == 0
        "special_attack"
      else
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
    end
      
    def calculate_special_attack
      # 攻撃力が1.5倍
      @offense * SPECIAL_ATTACK_CONSTANT
    end
# ヒーロークラスエンド
end
