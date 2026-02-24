#!/bin/sh
# ---------------------------------------------------------
# Hook 08: Versioned JAR Management
# ---------------------------------------------------------

DEPLOY_DIR="${OUT_DIR}/instance/server/default/deploy"
JAR_VERSION="${MFA_ADAPTER_VERSION:-1.3.2}"
NEW_JAR="pf-pingone-mfa-adapter-${JAR_VERSION}.jar"
ARTIFACT_URL="${ARTIFACT_SERVER}/${NEW_JAR}"

echo "--- Custom Hook: Checking for Version ${JAR_VERSION} ---"

# 1. CLEANUP: Ensure no other versions exist
echo "Cleaning up old versions of pf-pingone-mfa-adapter..."
rm -f "${DEPLOY_DIR}"/pf-pingone-mfa-adapter-*.jar

# 2. PULL: Fetch the specific versioned JAR
echo "Downloading ${NEW_JAR} from ${ARTIFACT_URL}..."
curl -k -f -sS "${ARTIFACT_URL}" -o "${DEPLOY_DIR}/${NEW_JAR}"

if [ $? -eq 0 ]; then
    echo "Successfully updated to ${NEW_JAR}"
else
    echo "ERROR: Could not fetch JAR from ${ARTIFACT_URL}"
    exit 1
fi