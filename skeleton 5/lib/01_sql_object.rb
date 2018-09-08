require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    col = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = col.map { |el| el.to_sym }
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    results = results.map { |result| self.new(result)}
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
    SELECT
      #{table_name}.*
    FROM
      #{table_name}
    WHERE
      #{table_name}.id = ?
    SQL

    parse_all(results).first
  end

  def initialize(params = {})
    params.each do |key, value|
      key = key.to_sym
      self.send("#{key}=", value)
    end

    # ...
  end

  def attributes
    @attributes ||= Hash.new
    # ...
  end

  def attribute_values
    self.class.columns.map { |attr| self.send(attr) }
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
