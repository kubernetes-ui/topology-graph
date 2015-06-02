module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    concat: {
      options: {
        separator: ';'
      },
      dist: {
        src: ['src/**/*.js'],
        dest: 'dist/<%= pkg.name %>.js'
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      },
      dist: {
        files: {
          'dist/topology-graph.min.js': ['<%= concat.dist.dest %>']
        }
      }
    },
    qunit: {
      files: ['test/**/*.html']
    },
    jshint: {
      files: ['Gruntfile.js', 'src/**/*.js', 'test/**/*.js'],
      options: {
        // options here to override JSHint defaults
        globals: {
          define: true,
          console: true,
          document: true
        }
      }
    },
    watch: {
      files: ['<%= jshint.files %>'],
      tasks: ['jshint', 'qunit'],
      css: {
        files: 'styles/*.less',
        tasks: ['less']
      },
      js: {
        files: [
          'topology-graph.js',
          'topology-graph.css',
          'index.html'
        ],
        tasks: ['build']
      }
    },
    // The actual grunt server settings
    connect: {
      options: {
        protocol: grunt.option('scheme') || 'http',
        port: grunt.option('port') || 9000,
        hostname: grunt.option('hostname') || 'localhost'
      },
      server: {}
    },
    concat: {
      dist: {
        src: [ 'topology-graph.js' ],
        dest: 'dist/topology-graph.js'
      }
    },
  });

  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('serve', [
    'less',
    'build',
    'connect:server',
    "watch"
  ]);

  grunt.registerTask('build', [
    'concat:dist',
    'uglify',
    'jshint'
  ]);

  grunt.registerTask('default', ['serve']);

};
