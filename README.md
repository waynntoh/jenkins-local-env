# Docker setup for local Jenkins Master/Agent environment

### Requirements
1. Running on a Unix Machine.
2. Docker & docker-compose installed.
3. Sudo privilege.

### Initial Startup
1. Build Jenkins master/agent image with the *build-image.sh* script. | `./build-images.sh`
2. Start containers with docker-compose. | `docker compose up -d`
3. Access Jenkins on [localhost:8080](http://localhost:8080).
4. Setup Jenkins initial configuration.
   - Enter intial admin password. | `sudo docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword`
   - Do not install any plugins.
   - Create a new Admin user.
5. Connect Inbound Agent.
   - Retrieve agent secret. | *Manage Jenkins > Manage Nodes and Clouds > Inbound_Agent*
   - Insert secret into file *agent-docker-compose.yaml* line 24.
6. Restart and recreate all containers. | `docker compose up -d --force-recreate`

### Notes
1. Jenkins container is required to have the matching docker GID as the host's to grant the default jenkins user access to the Docker Daemon, thus requiring the docker-build.sh script.
2. Jenkins configuration is automatically restored according to *jenkins.yaml* with JCasC plugin.
3. Jenkins base plugins are pre-installed when images were built.

### Possible Improvements
1. Have Jenkins agent automatically download and inject the agent secret into its container environment and restart.

### Issues
1. Shell commands hang in Jenkins pipelines when using Docker containers.
   - Only occurs on certain machines.
   - True root cause still unknown.