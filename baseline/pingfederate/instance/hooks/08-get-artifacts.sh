#!/bin/sh
# ---------------------------------------------------------
# Hook 20: Versioned JAR Management
# ---------------------------------------------------------

# The directory where PF looks for plugins
DEPLOY_DIR="${OUT_DIR}/instance/server/default/deploy"

# The specific version we want to pull (Ideally passed from K8s YAML)
# If the variable isn't set, we fall back to a default version
JAR_VERSION="${MFA_ADAPTER_VERSION:-1.3.2}"
NEW_JAR="pf-pingone-mfa-adapter-${JAR_VERSION}.jar"

echo "--- Custom Hook: Checking for Version ${JAR_VERSION} ---"

# 1. CLEANUP: Delete ANY existing version of this specific adapter
# We use a wildcard (*) to find and remove older versions
echo "Cleaning up old versions of pf-pingone-mfa-adapter..."
rm -f ${DEPLOY_DIR}/pf-pingone-mfa-adapter-*.jar

# 2. PULL: Fetch the specific versioned JAR
echo "Downloading ${NEW_JAR} from local repository..."
curl -f -sS "${ARTIFACT_SERVER}/${NEW_JAR}" \
     -o "${DEPLOY_DIR}/${NEW_JAR}"

if [ $? -eq 0 ]; then
    echo "Successfully updated to ${NEW_JAR}"
else
    echo "ERROR: Could not fetch version ${JAR_VERSION}."
    exit 1
<<<<<<< HEAD
fi
=======
fi
>>>>>>> eb5e7552d82faf14495a10a15c6d04da04bdddf7
