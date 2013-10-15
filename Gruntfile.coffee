# Gruntfile to build the whole thing
module.exports = (grunt) ->

  coffees = [
    'src/background.coffee'
    'src/deezer-video-controller-monitor.coffee'
    'src/deezer-video-controller.coffee'
    'src/youtube-deezer-controller-monitor.coffee'
    'src/youtube-deezer-controller.coffee'
    'src/popup.coffee'
  ]


  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # Lint .coffee files
    coffeelint:
      app: ['Gruntfile.coffee'].concat coffees

    # Compile CoffeeScript
    coffee:
      options:
        bare: true
      compile:
        files:
          'dist/src/background.js' : coffees[0]

          'dist/src/deezer-video-controller-monitor.js' : coffees[1]

          'dist/src/deezer-video-controller.js' : coffees[2]

          'dist/src/youtube-deezer-controller-monitor.js' : coffees[3]

          'dist/src/youtube-deezer-controller.js' : coffees[4]

          'dist/src/popup.js' : coffees[5]


    # Compile LESS files
    less:
      development:
        files:
          'dist/css/popup.css': 'css/popup.less'

    # Copy need files to dist folder (icons, htmls, etc)
    copy:
      main:
        files: [
          {
            src: 'popup.html'
            dest: 'dist/popup.html'
          }
          {
            src: 'manifest.json'
            dest: 'dist/manifest.json'
          }
          {
            src: 'icons/**'
            dest: 'dist/'
          }
          {
            src: 'fonts/**'
            dest: 'dist/'
          }
        ]

    # Generate basic documentation
    docco:
      debug:
        src: coffees
        options:
          output: 'docs/'

    # Clean folders and build files
    clean: ['docs', 'dist']

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-docco'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', [
    'coffeelint'
    'coffee'
    'less'
    'copy'
    'docco'
  ]
  grunt.registerTask 'build', ['default']
  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'document', ['docco']

  # Task for Travis CI
  grunt.registerTask 'travis', ['lint']

