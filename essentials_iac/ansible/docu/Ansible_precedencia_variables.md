# Ansible Hacks
## Precedencia de variables
En ansible podemos declarar variables en multiples lugares y cuando lo hacemos, ansible sigue el siguiente orden de precedencia, teniendo en cuenta que las que se encuentran más abajo (extra vars) son las que tendrán el mayor orden de prioridad, es decir, si declaramos un valor en una variable como extra vars (-e "user=alberto"), ninguna otra variable tendrá mayor precedencia, ni podrá sobrescribir dicha variable.

- role defaults (defined in role/defaults/main.yml) 1
- inventory file or script group vars 2
- inventory group_vars/all 3
- playbook group_vars/all 3
- inventory group_vars/* 3
- playbook group_vars/* 3
- inventory file or script host vars 2
- inventory host_vars/* 3
- playbook host_vars/* 3
- host facts / cached set_facts 4
- play vars
- play vars_prompt
- play vars_files
- role vars (defined in role/vars/main.yml)
- block vars (only for tasks in block)
- task vars (only for the task)
- include_vars
- set_facts / registered vars
- role (and include_role) params
- include params
- extra vars (for example, -e "user=my_user")(always win precedence)
