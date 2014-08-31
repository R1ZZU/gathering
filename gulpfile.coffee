gulp    = require 'gulp'
rimraf  = require 'gulp-rimraf'
concat  = require 'gulp-concat'
rename  = require 'gulp-rename'
notify  = require 'gulp-notify'
nib     = require 'nib'

app = require './lib-build/app-task.coffee'

# Main tasks

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do rimraf

apps = [
	app 'article-stash',
		entry:     './public/article-stash/app.coffee'
		output:    "#{__dirname}/public/build-dev/article-stash"
		app_class: 'ArticleStashApp'
]

pre_watch = apps

gulp.task 'watch', pre_watch, ->
	gulp.watch './public/article-stash/**/*', ['article-stash']
	# gulp.watch './public/common/**/*', tasks.main.concat(tasks.article_stash)
	# gulp.watch './public/nexus-extensions/**/*', spa.article_stash

gulp.task 'default', ['watch']
