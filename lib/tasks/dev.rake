namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
   if Rails.env.development?
    show_spinner("Apagando o BD...","BD apagado com sucesso!") { %x(rails db:drop:_unsafe) }
    show_spinner("Criando o BD...","BD criado com sucesso!") { %x(rails db:create) }
    show_spinner("Migrando o BD...","Migração do BD concluída com sucesso!") { %x(rails db:migrate) }
    %x(rails dev:add_mining_types)
    %x(rails dev:add_coins)
    
   else
       puts "Você não está em ambiente de desenvolvimento!"
   end
  end
  
  desc "Adiciona as moedas"
  task add_coins: :environment do
    show_spinner("Adicionando as moedas...") do
        coins = [
            {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "https://i.pinimg.com/originals/71/9f/ab/719fabd98acf607114e22efc5c389782.png",
                mining_type: MiningType.find_by(acronym: 'PoW')           
            },
        
        
    
            { 
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://icons-for-free.com/iconfiles/png/512/ether+ethereum+icon-1320162897141993857.png",
                mining_type: MiningType.all.sample
            },
        
        
    
            {  
                description: "Dash",
                acronym: "DASH",
                url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
                mining_type: MiningType.all.sample
            },

            {  
                description: "Iota",
                acronym: "IOT",
                url_image: "https://www.coinstaker.com/wp-content/uploads/2018/01/iota-cryptocurrency-logo-1.png",
                mining_type: MiningType.all.sample
            },

            { 

                description: "ZCash",
                acronym: "ZEC",
                url_image: "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/512/Zcash-ZEC-icon.png",
                mining_type: MiningType.all.sample
            }
            ]
        
            coins.each do |coin|
            Coin.find_or_create_by!(coin)  
            end
        end
    end

   desc "Adiciona os tipos de mineração..."
    task add_mining_types: :environment do
        show_spinner("Adicionando os tipos de mineração...") do
            miningtypes = [
                {description: "Proof of Work", acronym: "PoW"},
                {description: "Proof of Stake", acronym: "PoS"},
                {description: "Proof of Capacity", acronym: "PoC"}
            ]

            miningtypes.each do |miningtype|
                MiningType.find_or_create_by!(miningtype)
            end
        end
    end

private
    def show_spinner(msg_start, msg_end = "Concluído!")
        spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
        spinner.auto_spin
        yield
        spinner.success("(#{msg_end})")
    end
end
