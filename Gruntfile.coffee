module.exports = ->

  # Initialize the configuration.
  @initConfig
    compass:
      main:
        options:
          importPath: ['bower_components/foundation/scss']
          require: 'compass-normalize'
          cssDir: 'out/css'
          sassDir: 'src/scss'
          imagesDir: 'out/img'
          javascriptsDir: 'out/js'
          outputStyle: 'compressed'
          raw: 'http_path = "/"\n relative_assets = true\n'

  # Load external Grunt task plugins.
  @loadNpmTasks 'grunt-contrib-compass'

  # Default task.
  @registerTask 'default', ['compass']
