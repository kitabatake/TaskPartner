module.exports = function (grunt) {
    grunt.initConfig({
        watch: {
            coffee: {
                files: ['src/**/*.coffee'],
                tasks: ['coffee']
            }
        },
        connect: {
            server: {
                options: {
                    port: 9000,
                    base: 'html',
                    keepalive: true
                }
            }
        },
        coffee:{
            compile:{
                files:[{ 
                    expand: true,
                    cwd: 'src/',
                    src: ['**/*.coffee'],
                    dest: 'html/js',
                    ext: '.js',
                }]
            }
        },
        bower: {
            install: {
                options: {
                    targetDir: './html/lib',
                    layout: 'byComponent',
                    install: true,
                    verbose: true,
                    cleanTargetDir: true,
                    cleanBowerDir: false
                }
            }
        }
    });

    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.loadNpmTasks("grunt-contrib-connect");
    grunt.loadNpmTasks('grunt-contrib-coffee');

    grunt.loadNpmTasks('grunt-bower-task');
    
    grunt.registerTask("default", "coffee", ["connect", "watch"]);
};