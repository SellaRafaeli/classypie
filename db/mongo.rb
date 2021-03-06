include Mongo

# Production environment will have the MONGOLAB_URI and related variables set.
DEFAULT_MONGODB_DB_NAME = "classypie"
set :mongodb_db_name, ENV["MONGOLAB_DB_NAME"] || DEFAULT_MONGODB_DB_NAME

DEFAULT_MONGODB_URI = "mongodb://localhost:27017/#{settings.mongodb_db_name}"
set :mongodb_uri,     ENV["MONGOLAB_URI"]     || DEFAULT_MONGODB_URI

# Instantiate and connect to the production MongoLab database if production, or
# a local instance if development.
$mongo = CONN = MongoClient.from_uri(settings.mongodb_uri).db(settings.mongodb_db_name)
puts "Running against MongoDB: #{settings.mongodb_uri} db:#{settings.mongodb_db_name}"


# Custom methods to make dealing with Mongo object ids easier.
# Some ruby/mongo hacking here. 
class Mongo::Collection

	#WIP
	# def find_one_with_cache(params)
	# 	$cache[params.to_s] ||= find_one(params)
	# end

	#get/find_by/find_one('id123')
	#get/find_by/find_one({email: 'bob@gmail.com'})
	#get/find_by/find_one('bob@gmail.com', 'email')
	def find_one(params, field = :_id)		
		return self.find(params).first if params.is_a? Hash

		find_one((field.to_s) => params.to_s)
	end
	alias_method :find_by, :find_one
  alias_method :get, :find_one


	def find_all(params = {})
		self.find(params).to_a
	end
	alias_method :all, :find_all

	def add(doc)
		doc[:_id] = nice_id
		doc[:created_at] = Time.now
		self.insert(doc)
		doc
	end

	def first
		self.all[0]
	end

	def last 
		all = self.all
		all[all.size-1]
	end

	def one
		all = self.all
		all[rand(all.size)]
	end
	alias_method :any, :one

	def update_id(_id, fields)
		fields.updated_at = Time.now
		self.update({_id: _id}, '$set' => fields)		
	end
end
