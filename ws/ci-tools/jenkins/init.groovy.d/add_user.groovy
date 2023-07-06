import jenkins.model.Jenkins

import hudson.*
import hudson.model.*

// https://javadoc.jenkins.io/hudson/security/HudsonPrivateSecurityRealm.html#doCreateFirstAccount(org.kohsuke.stapler.StaplerRequest,org.kohsuke.stapler.StaplerResponse)

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def user = System.getenv("JENKINS_ADMIN_USER")
def passwd = System.getenv("JENKINS_ADMIN_PASSWORD")
hudsonRealm.createAccount(user, passwd)

def instance = Jenkins.getInstance()
instance.setSecurityRealm(hudsonRealm)
instance.save()
