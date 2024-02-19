// Install Jenkins Job DSL plugin in your Jenkins instance

// Import necessary classes
import javaposse.jobdsl.dsl.JobDSL
import javaposse.jobdsl.plugin.ExecutableJobDSL
import javaposse.jobdsl.plugin.LookupStrategy
import hudson.model.FreeStyleProject
import hudson.triggers.*
import hudson.plugins.git.*
import javaposse.jobdsl.plugin.GlobalJobDslSecurityConfiguration

// Define the repository information
def gitUrl = 'https://github.com/omprakashbhanarkar19/jenkins.git'
def branch = 'main'

// Job DSL script to create Jenkins pipeline job with GitHub webhook
def jobDslScript = '''
pipelineJob('SamplePipelineJob') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('${gitUrl}')
                        credentials('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') // Set your credentials ID here
                    }
                    branches('${branch}')
                }
            }
            scriptPath('Jenkinsfile')
        }
    }
    triggers {
        githubPush()
    }
}
'''

// Execute the Job DSL script
def jobDsl = JobDSL.createScript(jobDslScript)
def executable = ExecutableJobDSL.createExecutable()
executable.with {
    script(jobDsl)
    lookupStrategy(LookupStrategy.JENKINS_ROOT)
    additionalClasspath([])
}
executable.run()
