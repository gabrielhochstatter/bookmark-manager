require 'pg'

module ConnectHelper

  def connection
    if ENV['ENVIRONMENT'] == 'test'
      # @connection =
      PG.connect(dbname: 'bookmark_manager_test')
    else
      # @connection =
      PG.connect(dbname: 'bookmark_manager')
    end
  end

end
