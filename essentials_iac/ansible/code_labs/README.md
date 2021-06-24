# Ansible code Labs for DEH

En éste repositorio encontramos el código de diferentes laboratorios de ansible que pasan por cada uno de los temas core de la tecnología. Se pueden utilizar como referencia de código o para profundizar en una determinada funcionalidad.

## Labs
### LAB 1: Add several plays to a playbook
The power of ansible resides in being able to execute multitude of tasks in a file, from the given
playbook (01.MyFirstPlaybook/playbook.yml), we will create:
- Second play:
- We will act on myServer
- We will install the httpd service, module package
- Third play
- We will start the service, service module
- Remember to help yourself with ansible-doc [module]
- Check the syntax of all playbooks with --syntax-check
- First, run in Dry run -C mode

### LAB 2: Variables
Given a file vars.yml create a playbook called variables.yml:
- Include vars.yml file so the playbook can use the variables declared on it.
- Install the latest version of the package referenced in web_pkg variable.
- The firewall service must be started and enabled at startup.
- The web service must be started and enabled at startup.

### LAB 3: Facts
Create a file called facts.yml that:
- Shows hostname
- Use the debug module
*Use the custom fact available in the repo: custom.fact*

### LAB 4: Custom facts
- We check the file custom.fact.
- We create a customFacts.yml file that does the following:
- Create facts.d directory
- We copy the custom.fact file in the directory previously created, copy module
- Show db_package variable, debug module

### LAB 5: Vault
- Edit the file data.yml, and create username and password.
- Encrypt the data.yml file using vault-pass (ansible-vault encrypt)
- Create a vault.yml file in which you create username and password (user module) from
the data.yml file (vars_files)
- We run the playbook: ansible-playbook --vault-password-file=vault-pass vault.yml. To add more security we could encrypt the vault-pass file (but we will not do it in this exercise)

### LAB 6: Loops and conditionals
- Review the variables file in group_vars/myServer.yml
- Create a loops.yml file:
– Shows host distribution (Use debug module)
– Use the data from the variable file to:
- Create users and assign groups
- Execute the task only when the distribution is CentOS
Two plays, one to show the distribution, another to create the users; we will use loop to scroll through the file, and when as conditional

### LAB 7: Handlers
We create a handlers.yml file that performs the following tasks:
- Copy the file files/sshd_config to /etc/ssh/sshd_config
– mode: 0600
– owner: root
– group: root
- Create handler to restart the sshd service
- Copy the file files/index.html to /var/www/html/index.html
- Create a handler to restart the httpd service and sshd service from previous job. How many times has been restarted httpd and sshd service by handlers?

### LAB 8: Templates
- Create a templates directory, with a file called index.html.j2
- In the file index.html.j2 you need to collect the following information: Hi, my name is **HOSTNAME**, and my ip is **IPHOST**. The data marked between ** must be obtained from the host’s facts
- Apply the template to the /var/www/html/index.html file of myServer, use the template
module
- Restart apache server after applying the file
- Check the content by curling your server’s IP
- Set the greetings variable in your playbook. Run it back again and check the message generated.

### LAB 9: Parallelism
Check the ansible.cfg file and add timer (callback_whitelist = profile_tasks plugin) Include in your inventory at least 3 hosts, and do the following checks:
- For fork = 3
- For fork = 1
- For serial: 3
- For serial: 1
Check the time it took for the different playbooks to run.

### LAB 10: Importing playbooks
- Check the main.yml file
- Use import_playbook to import the playbook templates.yml
- Check the syntax
- Run it in Dry run mode
- Run the playbook

### LAB 11: Hierarchy of variables
- Write a playbook that prints variables defined in the inventory or in group vars
- Write and execute a playbook that prints variables defined inside it
- Redefine that variables at the task level
- Redefine that variable using set_fact on a task
- Overwrite variables using extra vars

### LAB 12: My first Ansible role
Given the file main.yml, convert it to an ansible role

### LAB 13: Error resolution
- Run playbook 00.syntax.yml and solve all the errors it contains.
- Run the playbook 01.playbook_debugger.yml and use the playbook debugger to achieve a correct execution.
- Run playbook 02.python_code.yml and use the option to keep remote files and the debug log to find the error in the Python code.
