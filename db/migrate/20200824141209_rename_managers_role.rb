class RenameManagersRole < ActiveRecord::Migration[6.0]
  def up
    role_gm = Role.find_by(name: :gm)
    if role_gm
      role_gm.name = 'general_manager'
      role_gm.save!
    end
    role_im = Role.find_by(name: :im)
    if role_im
      role_im.name = 'investment_manager'
      role_im.save!
    end
  end

  def down
    role_gm = Role.find_by(name: :general_manager)
    if role_gm
      role_gm.name = 'gm'
      role_gm.save!
    end
    role_im = Role.find_by(name: :investment_manager)
    if role_im
      role_im.name = 'im'
      role_im.save!
    end
  end
end
