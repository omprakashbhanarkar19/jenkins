#!/bin/bash

# Jenkins URL and API token (replace with your Jenkins URL and API token)
JENKINS_URL="http://54.87.147.137:8080/"
API_TOKEN="11b6ffb2c0ab8a7b9cec763bd824a4e919"

# GitHub repository information
REPO_URL="https://github.com/omprakashbhanarkar19/jenkins.git"
BRANCH="main"

# Job configuration XML template
JOB_CONFIG_TEMPLATE="<flow-definition>
  <actions>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobAction plugin=\"pipeline-model-definition@1.11.0\"/>
    <hudson.model.ParametersDefinitionProperty>
      <parameterDefinitions>
        <hudson.model.StringParameterDefinition>
          <name>BRANCH_NAME</name>
          <description>Branch to build</description>
          <defaultValue>${BRANCH}</defaultValue>
        </hudson.model.StringParameterDefinition>
      </parameterDefinitions>
    </hudson.model.ParametersDefinitionProperty>
  </actions>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <definition class=\"org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition\" plugin=\"workflow-cps@2.89\">
    <scm class=\"hudson.plugins.git.GitSCM\" plugin=\"git@4.12.0\">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>${REPO_URL}</url>
          <credentialsId>your-credentials-id</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>\${BRANCH_NAME}</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class=\"list\"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
  </definition>
  <triggers>
    <jenkins.triggers.SCMTrigger>
      <spec>* * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </jenkins.triggers.SCMTrigger>
  </triggers>
</flow-definition>"

# Create a Jenkins pipeline job via REST API
create_pipeline_job() {
    local job_name="$demo"
    local job_config="$sample"

    curl -X POST \
         -u "${API_TOKEN}:" \
         -H "Content-Type: application/xml" \
         -d "${job_config}" \
         "${JENKINS_URL}/createItem?name=${job_name}"
}

# Main function
main() {
    local job_name="SamplePipelineJob"
    local job_config="${JOB_CONFIG_TEMPLATE}"

    create_pipeline_job "${job_name}" "${job_config}"
}

main
