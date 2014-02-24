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

    responsive_images:
      normalize:
        options:
          sizes: [
            {
              width: 970
            }
          ]
        files: [
          {
            expand: true,
            cwd: 'src/files/img/'
            src: [
              'art-direction/*.{jpg,gif,png}'
              'fabrication/*.{jpg,gif,png}'
              'puppets-and-masks/*.{jpg,gif,png}'
              'scenic-painting/*.{jpg,gif,png}'
            ]
            custom_dest: 'src/files/img/{%= path %}/'
          }
        ]

    imagemin:
      dynamic:
        options:
          cache: false
        files: [
          {
            expand: true
            cwd: 'src/files/img/'
            src: ['**/*.{png,jpg,gif}']
          }
        ]

  # Load external Grunt task plugins.
  @loadNpmTasks 'grunt-contrib-compass'
  @loadNpmTasks 'grunt-contrib-imagemin'
  @loadNpmTasks 'grunt-responsive-images'

  # Default task.
  @registerTask 'default', ['compass']
