class SampleAPI < Grape::API
  resource 'cases' do
    desc 'cases list'
    params do
      optional :limit_results,
               type: 'integer',
               desc: 'Return this number of cases as a maximum',
               documentation: { example: 100 }
    end
    get '/' do
    end

    desc 'individual case'
    get ':id' do
    end

    desc 'create a case'
    params do
      requires :name,
               type: 'string',
               desc: 'the cases name',
               documentation: { example: 'super case' }
      optional :description,
               type: 'string',
               desc: 'the cases name',
               documentation: { example: 'the best case ever made' }
    end
    post '/' do
    end

    desc 'update a case'
    params do
      optional :name, type: 'string', desc: 'the cases name'
      optional :description, type: 'string', desc: 'the cases name'
    end
    put ':id' do
    end
  end

  resource '/cases/:case_id/studies' do
    desc 'get a list of all studies in a case'
    params do
      optional :limit_results,
               type: 'integer',
               desc: 'Return this number of cases as a maximum',
               documentation: { example: 100 }
    end
    get '/' do
    end

    desc 'create a study for a specific case'
    params do
      requires :name,
               type: 'string',
               desc: 'the cases name',
               documentation: { example: 'super case' }
    end
    post '/' do
    end

    desc 'updates a study for a specific case'
    params do
      requires :name,
               type: 'string',
               desc: 'the cases name',
               documentation: { example: 'super case' }
    end
    put ':id' do
    end
  end

  resource 'admin' do
    get '/' do
    end
  end
end
