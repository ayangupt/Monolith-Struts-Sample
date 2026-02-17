#!/usr/bin/env sh
set -e

CATALINA_HOME=${CATALINA_HOME:-/usr/local/tomcat}
CONTEXT_DIR="$CATALINA_HOME/conf/Catalina/localhost"

# Create context directory if it doesn't exist (with proper permissions for non-root user)
if [ ! -d "$CONTEXT_DIR" ]; then
  mkdir -p "$CONTEXT_DIR"
fi

DB_HOST=${DB_HOST:-db}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-skishop}
DB_USER=${DB_USER:-skishop}
DB_PASSWORD=${DB_PASSWORD:-skishop}
DB_POOL_MAX_ACTIVE=${DB_POOL_MAX_ACTIVE:-20}
DB_POOL_MAX_IDLE=${DB_POOL_MAX_IDLE:-5}
DB_POOL_MAX_WAIT=${DB_POOL_MAX_WAIT:-10000}

xml_escape() {
  printf '%s' "$1" | sed -e 's/&/\&amp;/g' \
    -e 's/</\&lt;/g' \
    -e 's/>/\&gt;/g' \
    -e 's/\"/\&quot;/g' \
    -e "s/'/\&apos;/g"
}

DB_USER_ESC=$(xml_escape "$DB_USER")
DB_PASSWORD_ESC=$(xml_escape "$DB_PASSWORD")
DB_URL="jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}"
DB_URL_ESC=$(xml_escape "$DB_URL")
DB_POOL_MAX_ACTIVE_ESC=$(xml_escape "$DB_POOL_MAX_ACTIVE")
DB_POOL_MAX_IDLE_ESC=$(xml_escape "$DB_POOL_MAX_IDLE")
DB_POOL_MAX_WAIT_ESC=$(xml_escape "$DB_POOL_MAX_WAIT")
POOL_ATTRS="maxActive=\"${DB_POOL_MAX_ACTIVE_ESC}\" maxIdle=\"${DB_POOL_MAX_IDLE_ESC}\" maxWait=\"${DB_POOL_MAX_WAIT_ESC}\""

cat > "$CONTEXT_DIR/ROOT.xml" <<EOF
<Context>
  <Resource name="jdbc/skishop"
            auth="Container"
            type="javax.sql.DataSource"
            ${POOL_ATTRS}
            username="${DB_USER_ESC}"
            password="${DB_PASSWORD_ESC}"
            driverClassName="org.postgresql.Driver"
            url="${DB_URL_ESC}" />
</Context>
EOF

echo "[entrypoint] Generated ROOT.xml for jdbc/skishop -> jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}"

# Run Tomcat as tomcat user for security
if [ "$(id -u)" = "0" ]; then
  # Running as root, switch to tomcat user and execute command
  # Ensure proper ownership of runtime directories
  chown -R tomcat:tomcat ${CATALINA_HOME}/conf ${CATALINA_HOME}/logs ${CATALINA_HOME}/temp ${CATALINA_HOME}/work ${CATALINA_HOME}/webapps 2>/dev/null || true
  # Preserve environment and switch to tomcat user
  exec su -p tomcat -c "export PATH=${PATH} JAVA_HOME=${JAVA_HOME} CATALINA_HOME=${CATALINA_HOME}; exec $*"
else
  # Already running as non-root
  exec "$@"
fi
