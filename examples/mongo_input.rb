require 'rb_etl'
require 'mongo'
require 'json'
require 'tempfile'

class MongoInput
  attr_reader :client, :db, :collection

  include RbEtl::Step

  def initialize
    @client = Mongo::MongoClient.new('localhost', 27017)
    @db = client['inventory_events']
    @collection = db['model_events']
    @incoming = collection.find.limit(4)
  end

  def transform(row)
    row.to_json
  end
end

class TempfileOut
  include RbEtl::Step

  def initialize
    @outgoing = File.new('output.txt', 'w')
  end

  def transform(row)
    JSON.parse(row).keys.join(',')
  end
end

t = RbEtl::Transformation.new
s1 = MongoInput.new
s2 = TempfileOut.new
t.steps << s1
t.steps << s2
t.run
puts "Transformation to #{s2.outgoing.path} complete!"
