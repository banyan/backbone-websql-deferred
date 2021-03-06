"use strict"
module.exports = (grunt) ->

  grunt.initConfig
    concat:
      options:
        separator: ';'
      deps:
        src: [
          'node_modules/jquery/dist/jquery.js'
          'node_modules/underscore/underscore.js'
          'node_modules/backbone/backbone.js'
          'node_modules/q/q.js'
        ]
        dest: 'vendor/vendor.js'
      depsForTest:
        src: [
          'node_modules/mocha/mocha.js'
          'node_modules/sinon/lib/sinon.js'
          'node_modules/sinon/lib/sinon/call.js'
          'node_modules/sinon/lib/sinon/spy.js'
          'node_modules/sinon/lib/sinon/behavior.js'
          'node_modules/sinon/lib/sinon/stub.js'
          'node_modules/sinon/lib/sinon/mock.js'
          'node_modules/chai/chai.js'
        ]
        dest: 'vendor/test-vendor.js'
      depsForCSS:
        src: [
          'node_modules/mocha/mocha.css'
        ]
        dest: 'vendor/test.css'

    coffee:
      compile:
        files:
          'dist/backbone.websql.deferred.js': 'src/backbone.websql.deferred.coffee'
          'test/lib/backbone.websql.deferred-test.js': 'test/src/backbone.websql.deferred-test.coffee'

    uglify:
      uglify:
        files:
          'dist/backbone.websql.deferred.min.js': ['dist/backbone.websql.deferred.js']

    watch:
      src:
        files: ["src/*.coffee", "test/src/*.coffee", "Gruntfile.coffee"]
        tasks: ["build"]

    shell:
      'mocha-phantomjs':
        command: 'mocha-phantomjs test/index.html'
        options:
          stdout: true
          stderr: true

    pkg: grunt.file.readJSON 'package.json'
    release:
      options:
        file: 'bower.json'
        npm: false

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-release'

  grunt.registerTask "default", ["watch"]
  grunt.registerTask "build",   ["concat", "coffee", "uglify"]
  grunt.registerTask "test",    ["build", "shell:mocha-phantomjs"]
