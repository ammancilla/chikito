source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.0'
gem 'strong_migrations', '~> 0.7.2'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.13'
  gem 'listen'
end

group :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'shoulda-matchers', '~> 4.0'
end
