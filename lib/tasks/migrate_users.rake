namespace :migrate_to_devise do
    desc "Sposta tutti gli utenti dalla vecchia tabella a quella nuova"
    task :migrate_users => :environment do
        count = 0
        puts "Importazione di: #{OldUser.all.count} utenti"
        OldUser.all.each do |old_user|
            u = User.new
            u.email = old_user.email
            u.password_salt = old_user.salt
            u.login = old_user.email
            u.password = ''
            u.save!
            puts "Inserito l'utent: #{u.email}"
            count += 1
        end
        puts "Fine importazione (#{count})"
    end
end