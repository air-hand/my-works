import jenkins.model.Jenkins

import hudson.*
import hudson.model.*

// https://javadoc.jenkins.io/hudson/security/HudsonPrivateSecurityRealm.html#doCreateFirstAccount(org.kohsuke.stapler.StaplerRequest,org.kohsuke.stapler.StaplerResponse)

def user = System.getenv("JENKINS_ADMIN_USER")
def passwd = System.getenv("JENKINS_ADMIN_PASSWORD")

def instance = Jenkins.instance
def realm = instance.securityRealm
realm.createAccount(user, passwd)
instance.save()
