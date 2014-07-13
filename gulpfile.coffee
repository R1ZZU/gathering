gulp 	 = require 'gulp'
clean  = require 'gulp-clean'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do clean

gulp.task 'newsletter-layout.stylus', ->
	gulp.src [
			'./public/layout/newsletter/stylesheets/reset.css'
			'./public/layout/newsletter/stylesheets/*.styl'
		]
		.pipe do stylus
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'newsletter.css'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return

gulp.task 'copy', ->
	gulp.src './public/layout/newsletter/*.html'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return

gulp.task 'admin-newsletter.coffee', ->
	gulp.src [

		# Nexus extensions
		'./public/nexus-extensions/input.coffee'
		'./public/nexus-extensions/html-helper.coffee'

		# Application
		'./public/admin-newsletter/src/app.coffee'

		# Models
		'./public/admin-newsletter/src/models/article.coffee'
		'./public/admin-newsletter/src/models/article-collection.coffee'

		# ViewModels
		'./public/admin-newsletter/src/viewmodels/articles-viewmodel.coffee'
		'./public/admin-newsletter/src/viewmodels/app-viewmodel.coffee'

		# Views
		'./public/admin-newsletter/src/views/articles-view.coffee'
		'./public/admin-newsletter/src/views/app-view.coffee'

		]
		.pipe do coffee
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'admin-newsletter.js'
		.pipe gulp.dest './public/build-dev/admin-newsletter'
		return

gulp.task 'admin-newsletter.stylus', ->
	gulp.src './public/admin-newsletter/stylesheets/*.styl'
		.pipe do stylus
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'admin-newsletter.css'
		.pipe gulp.dest './public/build-dev/admin-newsletter'
		return

gulp.task 'coffee', ['admin-newsletter.coffee']
gulp.task 'stylus', ['admin-newsletter.stylus', 'newsletter-layout.stylus']

gulp.task 'watch', ['coffee', 'stylus', 'copy'], ->
	gulp.watch './public/admin-newsletter/src/**/*.coffee', ['admin-newsletter.coffee']
	gulp.watch './public/admin-newsletter/stylesheets/*.styl', ['admin-newsletter.stylus']
	gulp.watch './public/layout/newsletter/stylesheets/*.styl', ['newsletter-layout.stylus']
	gulp.watch './public/layout/newsletter/*.html', ['copy']
