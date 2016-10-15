# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( core.js base.css base.js admin.scss admin.js region-filter.js.coffee market-filter.js.coffee property-filter.js.coffee )
Rails.application.config.assets.precompile += %w( application/comercio.scss application/imoveis.scss )
