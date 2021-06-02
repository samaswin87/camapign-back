require 'faker'

class Demo
  def initialize
    setup_companies
    setup_users
    setup_platforms
    setup_worflow
  end

  private

  def setup_worflow
    setup_workflow_depositories
    setup_workflow_declarations
    setup_workflow_prompts
  end

  def setup_workflow_prompts
    puts "Creating prompts"
    Workflow::Depository.all.each do |index|
      (1..5).each do |i|
        print "."
        Workflow::Prompt.create({
          order: i,
          depository_id: index.id,
          body: Faker::Lorem.paragraph,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nPrompts creation completed"
  end

  def setup_workflow_declarations
    puts "Creating declarations"
    Workflow::Depository.all.each do |depository|
      print "."
      Workflow::Declaration.create({
        depository_id: depository.id,
        destination_url: Faker::Internet.url,
        body: Faker::Lorem.paragraph,
        created_by_id: 1,
        updated_by_id: 1
      })
    end
    puts "\nDeclarations creation completed"
  end
  
  def setup_workflow_depositories
    puts "Creating depositories"
    (1..100).each do |index|
      (1..30).each do |i|
        print "."
        Workflow::Depository.create({
          status: 0,
          operator_id: Faker::Number.between(1, 10),
          company_id: index,
          no_of_contacts: 10,
          keyword: Faker::Name.initials(5),
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nDepositories creation completed"
  end

  def setup_platforms
    setup_operators
    setup_recipients
  end

  def setup_operators
    puts "Creating operators"
    (1..100).each do |index|
      (1..10).each do |i|
        print "."
        Platform::Operator.create({
          status: 0,
          phone: Faker::PhoneNumber.cell_phone,
          company_id: index,
          name: Faker::Company.name,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nOperators creation completed"
  end

  def setup_recipients
    puts "Creating recipients"
    (1..100).each do |index|
      (1..10).each do |i|
        print "."
        Platform::Recipient.create({
          status: 0,
          phone: Faker::PhoneNumber.cell_phone,
          email: Faker::Internet.email,
          company_id: index,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nRecipients creation completed"
  end

  def setup_companies
    puts "Creating Companies"
    (0..4).each do |plan|
      (1..20).each do |index|
        print "."
        Company.create(
          {
            status: 0,
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
    puts "\nCompanies creation completed"
  end

  def setup_users
    puts "Creating Users"
    (1..100).each do |index|
      print "."
      User.create(
        {
          status: 0,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          role: 0,
          company_id: index,
          email: Faker::Internet.email,
          password: 'password',
          password_confirmation: 'password'
        }
      )
    end

    (1..100).each do |index|
      (1..5).each do |user|
        print "."
        User.create(
          {
            status: 0,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            role: 1,
            company_id: index,
            email: Faker::Internet.email,
            password: 'password',
            password_confirmation: 'password'
          }
        )
      end
    end
    puts "\nUsers creation completed"
  end
    
end