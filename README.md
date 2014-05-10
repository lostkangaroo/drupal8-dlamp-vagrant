# Drupal 8 - DLAMP - Vagrant

### Description
Vagrant VM To quickly setup local dev environments for Drupal 8. Installs a LAMP environment with Drush and adds XDebug as well ready . Integrates with Jetbrains PhpStorm to clone a single environment for multipule projects. Can also be used as a standalone vagrant solution to quickly configure a development VM.

### Requirements
Vagrant [http://www.vagrantup.com/downloads.html]
VirtualBox 4.3.8 [https://www.virtualbox.org/wiki/Download_Old_Builds_4_3]
Vagrant Plugin vagrant-omnibus

### Installation
1. Download and Install Vagrant and VirtualBox.
  * [Installing Vagrant](https://docs.vagrantup.com/v2/installation/)
  * [Installing VirtualBox](https://www.virtualbox.org/manual/ch02.html)
2. Install the vagrant vagrant-omnibus plugin.
  * Run `vagrant plugin install vagrant-omnibus` from a command line tool. [vagrant plugin documentation](https://docs.vagrantup.com/v2/plugins/usage.html)
3. Download this repository

### PhpStorm Setup
1. Within the project you would like to create a dev environment for go to the project settings. `File->Settings->Vagrant`
2. Set Vagrant Executable to the vagrant run file you installed.
  * Windows default: `C:\HashiCorp\Vagrant\bin\vagrant.exe`
  * All other OS's should be where you would expect
3. Set Instance Folder to the directory you downloaded this repository to
4. You will then need to open the Environment Variables config using the button with `...` on it
5. Add a variable and name it `PROJECT_DIR` set the value to the dir you store your projects
6. Add a variable and name it `SITE_ALIAS` set the value to the uri you want to use locally for the project
7. Close out the settings and go to `Tools->Vagrant->Up` to start up the VM

### Standalone Environment Setup
1. Place this repository as the root of the project.
2. Create a folder `Public`
3. Inside the new folder create another folder `dev.local`
4. Place project files in dev.local
5. Run `vagrant up` from within the project directory tree

### Special Thanks
* Neclimdul
* Emma Jane Westby
