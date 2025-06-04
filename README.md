# ISE Ansible Intro

This repository provides Ansible playbooks and resources for automating Cisco Identity Services Engine (ISE) network device management. It demonstrates how to use Ansible and the Cisco ISE Ansible collection to create, update, retrieve, and delete network devices in ISE.

I created this repository to help customers start using Ansible with ISE without being overwhelmed. It uses [playbooks by Charlie Moreton](https://github.com/ISEDemoLab) and shows how to start using Python virtual environments or Docker containers to bootstrap Ansible dev environments.

## Features
- Create, update, retrieve, and delete Cisco ISE network devices via Ansible playbooks
- Example inventory and variable files for quick setup
- Dockerfile for a reproducible environment
- Uses the `cisco.ise` Ansible collection and `ciscoisesdk` Python SDK

## Prerequisites
- Python 3.8+
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Cisco ISE instance (with API access enabled)

### Python Requirements
Install dependencies with:
```bash
pip install -r requirements.txt
```

### Ansible Collections
Install the required Ansible collection:
```bash
ansible-galaxy collection install cisco.ise:==2.10.0
```

## Quick Start with Docker
A Dockerfile is provided for a ready-to-use environment:
```bash
docker build -t ise-ansible .
docker run -it --rm -v $(pwd):/workspace ise-ansible
# In the container shell
git clone git@github.com:codeyonet/ise-ansible-intro.git
```

## Quick Start with Python Virtual Environment
You can also run the project using a Python virtual environment:

1. Create a virtual environment:
   ```bash
   python -m venv .venv
   ```

2. Activate the virtual environment:
   - On macOS/Linux:
     ```bash
     source .venv/bin/activate
     ```
   - On Windows:
     ```bash
     .venv\Scripts\activate
     ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Install the required Ansible collection:
   ```bash
   ansible-galaxy collection install cisco.ise:==2.10.0
   ```

5. Run your Ansible playbooks as usual:
   ```bash
   ansible-playbook -i inventory/ise.yaml ise_create_network_device.yaml
   ```

6. When you're done, deactivate the virtual environment:
   ```bash
   deactivate
   ```

## Inventory and Variables
- Inventory files are in the `inventory/` directory. Edit `ise.yaml` to match your ISE nodes and IP addresses.
- Variables are defined in `vars/main.yaml`. Sensitive values (like credentials) are loaded from environment variables for security.

Example environment variables:
```bash
export ISE_REST_USERNAME=admin
export ISE_REST_PASSWORD=yourpassword
export ISE_VERIFY=false
```

## Playbooks
- `ise_create_network_device.yaml`: Create a new network device in ISE
- `ise_update_network_device.yaml`: Update an existing network device
- `ise_get_network_device.yaml`: Retrieve network device information
- `ise_delete_network_device.yaml`: Delete a network device

### Running a Playbook
```bash
ansible-playbook -i inventory/ise.yaml ise_create_network_device.yaml
```

## Example Inventory (inventory/ise.yaml)
```yaml
all:
  children:
    ise:
      hosts:
        ise_nodes:
          ansible_host: 10.207.195.71
```

## Example Variables (vars/main.yaml)
```yaml
ise_username: "{{ lookup('env','ISE_REST_USERNAME') }}"
ise_password: "{{ lookup('env','ISE_REST_PASSWORD') }}"
ise_verify: "{{ lookup('env','ISE_VERIFY') | default(False, true) }}"
```

## Contributing
Pull requests and issues are welcome! Please open an issue to discuss your ideas or report bugs.

## License
Specify your license here (e.g., MIT, Apache 2.0, etc.) 