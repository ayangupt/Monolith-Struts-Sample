# Docker Container Troubleshooting Guide

## 🔍 Issue Identified

**Problem**: Container failed to start due to database connection error

**Root Cause**: The container could not connect to PostgreSQL because:
1. `host.docker.internal` hostname doesn't work on Linux (it's a Docker Desktop feature for macOS/Windows)
2. The application tried to connect to a database that wasn't accessible from the container

**Error Message**:
```
java.net.UnknownHostException: host.docker.internal
Caused by: org.postgresql.util.PSQLException: The connection attempt failed.
```

## ✅ Solutions

### Solution 1: Use H2 In-Memory Database (Recommended for Testing)

This is the easiest option for local development and testing - no external database required!

**Quick Start:**
```bash
./docker-run.sh
# Then select option 1
```

**Manual Command:**
```bash
docker run -d \
  --name skishop-app \
  -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=dev \
  -v $(pwd)/logs:/app/logs \
  --memory=512m \
  --cpus=1 \
  skishop-monolith:1.0.0
```

**Benefits:**
- ✅ No external database required
- ✅ Fast startup
- ✅ Perfect for testing and development
- ✅ H2 console available at http://localhost:8080/h2-console

**H2 Console Access:**
- URL: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:skishop`
- Username: `sa`
- Password: (leave blank)

---

### Solution 2: Connect to PostgreSQL on Host (Linux/WSL)

If you have PostgreSQL running on your host machine:

**Quick Start:**
```bash
./docker-run.sh
# Then select option 2
```

**Manual Command:**
```bash
# Use the Docker bridge gateway IP (172.17.0.1)
docker run -d \
  --name skishop-app \
  -p 8080:8080 \
  -e SPRING_DATASOURCE_URL="jdbc:postgresql://172.17.0.1:5432/skishop" \
  -e SPRING_DATASOURCE_USERNAME=skishop \
  -e DB_PASSWORD=your-password \
  -v $(pwd)/logs:/app/logs \
  --memory=512m \
  --cpus=1 \
  skishop-monolith:1.0.0
```

**Prerequisites:**
1. PostgreSQL must be configured to accept connections from Docker network
2. Edit PostgreSQL configuration:
   ```bash
   # Edit postgresql.conf
   sudo nano /etc/postgresql/*/main/postgresql.conf
   # Change: listen_addresses = '*'
   
   # Edit pg_hba.conf
   sudo nano /etc/postgresql/*/main/pg_hba.conf
   # Add: host    all    all    172.17.0.0/16    md5
   
   # Restart PostgreSQL
   sudo service postgresql restart
   ```

---

### Solution 3: Use Host Network Mode (Linux Only - Simplest)

This mode allows the container to use the host's network directly:

**Quick Start:**
```bash
./docker-run.sh
# Then select option 4
```

**Manual Command:**
```bash
docker run -d \
  --name skishop-app \
  --network host \
  -e SPRING_DATASOURCE_URL="jdbc:postgresql://localhost:5432/skishop" \
  -e SPRING_DATASOURCE_USERNAME=skishop \
  -e DB_PASSWORD=your-password \
  -v $(pwd)/logs:/app/logs \
  --memory=512m \
  --cpus=1 \
  skishop-monolith:1.0.0
```

**Benefits:**
- ✅ Simplest configuration for local PostgreSQL
- ✅ Container can access localhost directly
- ✅ No network configuration needed

**Note:** Host network mode only works on Linux, not on macOS or Windows.

---

### Solution 4: External PostgreSQL (Cloud/Remote Database)

For connecting to a remote PostgreSQL instance (Azure, AWS, etc.):

**Quick Start:**
```bash
./docker-run.sh
# Then select option 3
```

**Manual Command:**
```bash
docker run -d \
  --name skishop-app \
  -p 8080:8080 \
  -e SPRING_DATASOURCE_URL="jdbc:postgresql://your-db-host:5432/skishop" \
  -e SPRING_DATASOURCE_USERNAME=your-username \
  -e DB_PASSWORD=your-password \
  -v $(pwd)/logs:/app/logs \
  --memory=512m \
  --cpus=1 \
  skishop-monolith:1.0.0
```

---

## 🛠️ Useful Commands

### Check Container Status
```bash
docker ps -a | grep skishop-app
```

### View Container Logs
```bash
docker logs skishop-app

# Follow logs in real-time
docker logs -f skishop-app

# Last 50 lines
docker logs --tail 50 skishop-app
```

### Test Application Health
```bash
# Health check endpoint
curl http://localhost:8080/actuator/health

# Test login page
curl -I http://localhost:8080/login
```

### Stop and Remove Container
```bash
docker stop skishop-app
docker rm skishop-app
```

### Restart Container
```bash
docker restart skishop-app
```

### Execute Commands Inside Container
```bash
# Access container shell
docker exec -it skishop-app sh

# Check Java version
docker exec skishop-app java -version

# View application properties
docker exec skishop-app cat /app/app.jar
```

---

## 🔧 Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `SPRING_PROFILES_ACTIVE` | Active Spring profile | `dev`, `prod` |
| `SPRING_DATASOURCE_URL` | Database JDBC URL | `jdbc:postgresql://172.17.0.1:5432/skishop` |
| `SPRING_DATASOURCE_USERNAME` | Database username | `skishop` |
| `DB_PASSWORD` | Database password | `your-password` |
| `SPRING_MAIL_HOST` | SMTP server host | `smtp.gmail.com` |
| `SPRING_MAIL_PORT` | SMTP server port | `587` |
| `JAVA_OPTS` | JVM options | `-Xmx512m -Xms256m` |

---

## 📊 Troubleshooting Checklist

### Container Won't Start
- [ ] Check if port 8080 is already in use: `netstat -tulpn | grep 8080`
- [ ] Verify Docker is running: `docker info`
- [ ] Check container logs: `docker logs skishop-app`
- [ ] Ensure image exists: `docker images | grep skishop-monolith`

### Database Connection Issues
- [ ] Verify database is running: `sudo service postgresql status`
- [ ] Check PostgreSQL accepts connections from Docker: `pg_hba.conf`
- [ ] Test connectivity: `telnet 172.17.0.1 5432`
- [ ] Verify database exists: `psql -U skishop -d skishop -c "SELECT 1"`
- [ ] Use H2 profile for testing: `-e SPRING_PROFILES_ACTIVE=dev`

### Application Not Responding
- [ ] Check if container is running: `docker ps | grep skishop-app`
- [ ] Verify health endpoint: `curl http://localhost:8080/actuator/health`
- [ ] Check application logs: `docker logs -f skishop-app`
- [ ] Inspect container: `docker inspect skishop-app`

### Performance Issues
- [ ] Check container resource usage: `docker stats skishop-app`
- [ ] Increase memory limit: `--memory=1g`
- [ ] Adjust JVM heap: `-e JAVA_OPTS="-Xmx768m"`
- [ ] Review application logs for slow queries

---

## 🎯 Recommended Approach

**For Quick Testing:**
```bash
./docker-run.sh  # Select option 1 (H2)
```

**For Development with Real Database:**
```bash
./docker-run.sh  # Select option 4 (Host Network)
```

**For Production:**
- Use external PostgreSQL (Azure Database for PostgreSQL, AWS RDS, etc.)
- Configure proper secrets management
- Use container orchestration (Kubernetes, Azure Container Apps)
- Enable monitoring and logging

---

## 🌐 Accessing the Application

Once the container is running successfully:

**Application URLs:**
- Main Application: http://localhost:8080
- Login Page: http://localhost:8080/login
- Health Check: http://localhost:8080/actuator/health
- H2 Console (dev profile): http://localhost:8080/h2-console

**Default Test Credentials** (check data.sql):
- Username: Check the database initialization scripts
- Password: Check the database initialization scripts

---

## 📝 Notes

1. **Linux/WSL**: The Docker bridge IP is typically `172.17.0.1`
2. **macOS/Windows**: If using Docker Desktop, use `host.docker.internal` instead
3. **Production**: Always use proper secrets management (Azure Key Vault, AWS Secrets Manager, etc.)
4. **Development**: H2 profile is perfect for quick testing without external dependencies
5. **Network Mode**: Host network mode is simplest for local PostgreSQL on Linux

---

## 🚀 Next Steps After Fixing

1. ✅ Start container with H2 or host network mode
2. ✅ Verify application is accessible
3. ✅ Test key functionality (login, browse products, etc.)
4. ✅ Review logs for any warnings
5. ✅ Plan deployment to cloud platform

For production deployment, consider:
- Using managed PostgreSQL (Azure Database for PostgreSQL)
- Container orchestration (Kubernetes, Azure Container Apps)
- Proper secrets management
- Monitoring and observability setup
