folder('/docker') {
    displayName('Whanos base images')
    description('Whanos base images for Jenkins')
}

freeStyleJob('/docker/whanos-befunge') {
    displayName('whanos-befunge')
    description('Whanos befunge image')
    label('built-in')

    wrappers {
        preBuildCleanup()
    }
    steps {
        shell("""#!/bin/sh
        cp -f $JENKINS_HOME/jobs/docker/images/befunge/Dockerfile.base ./Dockerfile""".stripIndent())

        dockerBuildAndPublish {
            repositoryName("whanos-befunge")
            forcePull(false)
            skipPush()
            noCache()
        }
    }
}

freeStyleJob('/docker/whanos-c') {
    displayName('whanos-c')
    description('Whanos C image')
    label('built-in')

    wrappers {
        preBuildCleanup()
    }
    steps {
        shell("""#!/bin/sh
        cp -f $JENKINS_HOME/jobs/docker/images/c/Dockerfile.base ./Dockerfile""".stripIndent())

        dockerBuildAndPublish {
            repositoryName("whanos-c")
            forcePull(false)
            skipPush()
            noCache()
        }
    }
}

freeStyleJob('/docker/whanos-java') {
    displayName('whanos-java')
    description('Whanos Java image')
    label('built-in')

    wrappers {
        preBuildCleanup()
    }
    steps {
        shell("""#!/bin/sh
        cp -f $JENKINS_HOME/jobs/docker/images/java/Dockerfile.base ./Dockerfile""".stripIndent())

        dockerBuildAndPublish {
            repositoryName("whanos-java")
            forcePull(false)
            skipPush()
            noCache()
        }
    }
}

freeStyleJob('/docker/whanos-javascript') {
    displayName('whanos-javascript')
    description('Whanos Javascript image')
    label('built-in')

    wrappers {
        preBuildCleanup()
    }
    steps {
        shell("""#!/bin/sh
        cp -f $JENKINS_HOME/jobs/docker/images/javascript/Dockerfile.base ./Dockerfile""".stripIndent())

        dockerBuildAndPublish {
            repositoryName("whanos-javascript")
            forcePull(false)
            skipPush()
            noCache()
        }
    }
}

freeStyleJob('/docker/whanos-python') {
    displayName('whanos-python')
    description('Whanos Python image')
    label('built-in')

    wrappers {
        preBuildCleanup()
    }
    steps {
        shell("""#!/bin/sh
        cp -f $JENKINS_HOME/jobs/docker/images/python/Dockerfile.base ./Dockerfile""".stripIndent())

        dockerBuildAndPublish {
            repositoryName("whanos-python")
            forcePull(false)
            skipPush()
            noCache()
        }
    }
}

job('/docker/build_all') {
    displayName('Build all base images')
    description('Build all base images for Whanos')
    label('built-in')

    steps {
        downstreamParameterized {
            trigger('/docker/whanos-befunge')
            trigger('/docker/whanos-c')
            trigger('/docker/whanos-java')
            trigger('/docker/whanos-javascript')
            trigger('/docker/whanos-python')
        }
    }
}