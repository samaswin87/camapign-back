require 'faker'

class Demo
  def initialize
    setup_companies
    setup_users
    setup_user_settings
    setup_company_settings
    setup_company_plans
    setup_platforms
    setup_workflow
    setup_campaign
    setup_menu
    setup_tags
  end

  private

  def setup_tags
    puts "Creating tags"
    (1..10).each do |index|
      (1..10).each do |i|
        print "."
        Tag.create({
          status: [0, 1].sample,
          company_id: index,
          name: Faker::Name.initials(5),
        })
      end
    end
    puts "\nTags creation completed"
  end

  def setup_menu
    setup_menu_depositories
    setup_menu_declarations
    setup_menu_prompts
    setup_menu_recipients
    setup_menu_communications
  end
  
  def setup_menu_communications
    puts "Creating menu communications"
    Menu::Recipient.all.each do |recipient|
      (1..5).each do |i|
        print "."
        Menu::Communication.create({
          delivery: [0, 1, 2, 3].sample,
          recipient_id: recipient.id,
          message: Faker::Lorem.paragraph,
        })
      end
    end
    puts "\nMenu communications creation completed"
  end
  
  def setup_menu_recipients
    puts "Creating menu recipients"
    Menu::Depository.all.each do |depository|
      (1..10).each do |i|
        print "."
        Menu::Recipient.create({
          status: [0, 1].sample,
          depository_id: depository.id,
          recipient_id: i,
        })
      end
    end
    puts "\nMenu recipients creation completed"
  end
  
  def setup_menu_prompts
    puts "Creating menu prompts"
    Menu::Depository.all.each do |depository|
      (1..5).each do |i|
        print "."
        Menu::Prompt.create({
          order: i,
          depository_id: depository.id,
          body: Faker::Lorem.paragraph,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nMenu prompts creation completed"
  end
  
  def setup_menu_declarations
    puts "Creating menu declarations"
    Menu::Depository.all.each do |depository|
      print "."
      Menu::Declaration.create({
        depository_id: depository.id,
        destination_url: Faker::Internet.url,
        body: Faker::Lorem.paragraph,
        created_by_id: 1,
        updated_by_id: 1
      })
    end
    puts "\nMenu declarations creation completed"
  end
  
  def setup_menu_depositories
    puts "Creating menu depositories"
    (1..10).each do |index|
      (1..10).each do |i|
        print "."
        Menu::Depository.create({
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
    puts "\nMenu depositories creation completed"
  end

  def setup_company_plans
    puts "Creating company plans"
    Company.all.each do |company|
      print "."
      ['Jan-2021', 'Feb-2021', 'Mar-2021', 'Apr-2021', 'May-2021', 'Jun-2021', 'Jul-2021', 'Aug-2021', 'Sep-2021', 'Oct-2021', 'Nov-2021', 'Dec-2021'].each do |month|
        CompanyPlan.create({
          company_id: company.id,
          month: month,
          credits: Faker::Number.between(1000, 2000),
          additional_credits: Faker::Number.between(1000, 2000),
          inbounds: Faker::Number.between(100, 200),
          outbounds: Faker::Number.between(100, 200),
          voice_inbounds: Faker::Number.between(100, 200),
          voice_outbounds: Faker::Number.between(100, 200),
          availed_inbounds: Faker::Number.between(100, 200),
          availed_outbounds: Faker::Number.between(100, 200),
          availed_voice_inbounds: Faker::Number.between(100, 200),
          availed_voice_outbounds: Faker::Number.between(100, 200),
        })
      end
    end
    puts "\nCompany plans creation completed"
  end


  def setup_user_settings
    puts "Creating user settings"
    User.all.each do |user|
      print "."
      UserSetting.create({
        user: user,
        notify_workflow: false,
        notify_menu: false,
        notify_campaign: false,
        notify_creditlimit: false,
        time_zone: 'UTC'
      })
    end
    puts "\nUser settings creation completed"
  end

  def setup_company_settings
    puts "Creating company settings"
    Company.all.each do |company|
      print "."
      CompanySetting.create({
        company: company,
        updated_by_id: 1,
        address: Faker::Address.full_address,
        message_length: 300,
        maxuser: 1000,
        max_campaign: 1000,
        max_workflow: 1000,
        max_menu: 1000,
        max_contacts_in_campaign: 1000,
        use_short_code: true,
        use_destination_link: true,
        notify_credit_limit: true,
        notify_user_creation: true,
        notify_campaign_creation: true,
        notify_workflow_creation: true,
        notify_menu_creation: true,
        sso: true,
        import_workflows: true,
        import_menus: true,
        import_users: true,
        import_contacts: true,
        import_campaigns: true,
        plan_start_date: Time.now,
        plan_end_date: 1.year.from_now,
      })
    end
    puts "\nCompany settings creation completed"
  end

  def setup_campaign
    setup_campaign_depositories
    setup_campaign_recipients
    setup_campaign_communications
  end

  def setup_campaign_recipients
    puts "Creating Campaign recipients"
    Workflow::Depository.all.each do |depository|
      (1..10).each do |i|
        print "."
        Campaign::Recipient.create({
          status: [0, 1].sample,
          depository_id: depository.id,
          recipient_id: i,
          data: Faker::Json.shallow_json(3, { key: 'Name.first_name', value: 'Name.last_name' })
        })
      end
    end
    puts "\nCampaign recipients creation completed"
  end

  def setup_campaign_depositories
    puts "Creating campaign depositories"
    (1..10).each do |index|
      (1..10).each do |i|
        print "."
        Campaign::Depository.create({
          status: [0, 1].sample,
          operator_id: Faker::Number.between(1, 10),
          company_id: index,
          no_of_contacts: 10,
          name: Faker::Name.unique.name,
          message: Faker::Lorem.paragraph,
          group: [0, 1, 2].sample,
          scheduled_at: Time.now,
          recurring_at: Time.now,
          recurring_days: ['Mon', 'Tue'],
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nCampaign depositories creation completed"
  end

  def setup_campaign_communications
    puts "Creating Campaign communications"
    Campaign::Recipient.all.each do |recipient|
      (1..5).each do |i|
        print "."
        Campaign::Communication.create({
          delivery: [0, 1, 2, 3].sample,
          recipient_id: recipient.id,
          message: Faker::Lorem.paragraph,
        })
      end
    end
    puts "\nCampaign communications creation completed"
  end

  def setup_workflow
    setup_workflow_depositories
    setup_workflow_declarations
    setup_workflow_prompts
    setup_workflow_recipients
    setup_workflow_communications
  end

  def setup_workflow_communications
    puts "Creating workflow communications"
    Workflow::Recipient.all.each do |recipient|
      (1..5).each do |i|
        print "."
        Workflow::Communication.create({
          delivery: [0, 1, 2, 3].sample,
          recipient_id: recipient.id,
          message: Faker::Lorem.paragraph,
        })
      end
    end
    puts "\nWorkflow communications creation completed"
  end

  def setup_workflow_recipients
    puts "Creating workflow recipients"
    Workflow::Depository.all.each do |depository|
      (1..10).each do |i|
        print "."
        Workflow::Recipient.create({
          status: [0, 1].sample,
          depository_id: depository.id,
          recipient_id: i,
        })
      end
    end
    puts "\nWorkflow recipients creation completed"
  end

  def setup_workflow_prompts
    puts "Creating workflow prompts"
    Workflow::Depository.all.each do |depository|
      (1..5).each do |i|
        print "."
        Workflow::Prompt.create({
          order: i,
          depository_id: depository.id,
          body: Faker::Lorem.paragraph,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nWorkflow prompts creation completed"
  end

  def setup_workflow_declarations
    puts "Creating workflow declarations"
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
    puts "\nWorkflow declarations creation completed"
  end
  
  def setup_workflow_depositories
    puts "Creating workflow depositories"
    (1..10).each do |index|
      (1..10).each do |i|
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
    puts "\nWorkflow depositories creation completed"
  end

  def setup_platforms
    setup_operators
    setup_recipients
  end

  def setup_operators
    puts "Creating operators"
    (1..10).each do |index|
      (1..10).each do |i|
        print "."
        Platform::Operator.create({
          status: [0, 1].sample,
          phone: Faker::PhoneNumber.unique.cell_phone,
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
    (1..10).each do |index|
      (1..10).each do |i|
        print "."
        Platform::Recipient.create({
          status: [0, 1].sample,
          phone: Faker::PhoneNumber.unique.cell_phone,
          email: Faker::Internet.email,
          company_id: index,
          no_of_campaigns: Faker::Number.between(100, 1000),
          keywords: [Faker::Name.initials(5), Faker::Name.initials(5)],
          tags: [Faker::Name.initials(5), Faker::Name.initials(5)],
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
      [1, 2].each do |index|
        print "."
        Company.create(
          {
            status: 0,
            name: Faker::Company.name,
            email: Faker::Internet.email,
            phone: Faker::PhoneNumber.unique.cell_phone,
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
    User.create(
      {
        status: 0,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        role: 0,
        company_id: 1,
        email: 'admin@demo.com',
        password: 'password',
        password_confirmation: 'password'
      }
    )
    (1..10).each do |index|
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

    (1..10).each do |index|
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