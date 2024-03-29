RailsAdmin.config do |config|

  config.model 'Block' do
    create do
      field :name
      field :district
      field :zipcode
      field :tour_link
      field :status
    end

    edit do
      field :name
      field :district
      field :zipcode
      field :tour_link
      field :status
    end
  end

  config.model 'Category' do
    create do
      field :name
      field :segment
      field :status
    end

    edit do
      field :name
      field :segment
      field :status
    end
  end

  config.model 'City' do
    create do
      field :name
      field :state
      field :status
    end

    edit do
      field :name
      field :state
      field :status
    end
  end

  config.model 'District' do
    create do
      field :name
      field :district_group
      field :status
    end

    edit do
      field :name
      field :district_group
      field :status
    end
  end

  config.model 'DistrictGroup' do
    create do
      field :name
      field :city
      field :status
    end

    edit do
      field :name
      field :city
      field :status
    end
  end

  config.model 'Segment' do
    create do
      field :name
      field :status
    end

    edit do
      field :name
      field :status
    end
  end

  config.model 'Speciality' do
    create do
      field :name
      field :category
      field :status
    end

    edit do
      field :name
      field :category
      field :status
    end
  end

  config.model SponsorButton do
    configure :customer do
      associated_collection_cache_all true
    end
  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
