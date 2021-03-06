require_relative 'db_connection'
require_relative 'sql_object'

module Searchable

  def where(params)
    where_line = params.keys.map { |k| "#{k} = ?" }.join(' AND ')

    data_hashes = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    data_hashes.map { |data| self.new(data) }
  end
end

class SQLObject
  extend Searchable
end
