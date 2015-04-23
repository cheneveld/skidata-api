The Skidata Ruby Gem
====================
A Ruby wrapper for the Skidata API

Installation
------------
in your rails project

```gem "skidata", :git => "https://github.com/cheneveld/skidata-api"```

then bundle.


Notes
------------
- This is a barebones gem that is missing alot.  It was written just to get the job done.

- Codebase is half assed with no test bench. Feel free to write one!

- This gem assumes you have a model which calls acts_as_tableless_skidata_user and has the following fields: id, email, password, name, leaderboard_overall_position, season_points_earned, points (which is a hash).  A sample model using the activerecord-tableless gem looks like:

```ruby
class SkidataUser < ActiveRecord::Base
	has_no_table
	column :id, :integer
	column :email, :string
	column :password, :string

	column :name, :string

	column :leaderboard_overall_position, :string
	column :leaderboard_season_position, :string
	column :leaderboard_weekly_position, :string
	
	column :season_points_earned, :string

	column :points, :string # is really a hash

	
	validates_presence_of :email, :password
	validate :authenticate_user
	acts_as_tableless_skidata_user
end
```

- Calling valid? on a model with acts_as_tableless_skidata_user will set the id of the object, as valid? runs authentication with the skidata api

- The skidata api was meant for 1-1 api/client interaction.  This gem was built using a different approach.  An admin authentication cookie can be used to make requests in behalf of users.  A client method named get_authorization_cookie will pull the authoriation cookie string which can be passed into various api methods.

- An ENV variabled named SKIDATA_API_ENDPOINT must be set

- https://faithful49.com/apidocs

- The [instagram-ruby-gem](https://github.com/Instagram/instagram-ruby-gem) was inspriation for writing this.