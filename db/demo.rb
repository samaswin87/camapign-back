require 'faker'

class Demo
    def initialize
        setup_companies
    end

    private

    def setup_companies
        (0..4).each do |plan|
            (1..20).each do |index|
                Company.create(
                    {
                        status: 1,
                        name: Faker::Company.name,
                        email: Faker::Internet.email,
                        phone: Faker::PhoneNumber.cell_phone,
                        plan: plan,
                        call_forwarding: false,
                        total_credits: 1000,
                        remaining_credits: 100,
                        message_forward: true,
                        plan_credits: 10000,
                        credit_percentage: 0,
                    })
            end
        end
    end
    
end