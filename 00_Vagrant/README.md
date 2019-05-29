# Installation

- Vagrant: https://www.vagrantup.com/downloads.html
- Virtual Box: https://www.virtualbox.org/
- Git SCM: https://git-scm.com/downloads


# Vorbereitung

- vagrant.yml bearbeiten wenn notwendig
- Die Maschine erhält den Namen `machine.host`.`machine.domain` aus der YAML, der VirtualBox-Host den Namen host bzw. host.`machine.domain`
- entsprechende Einträge sollten in der `C:\Windows\System32\drivers\etc\hosts` vorgenommen werden (Lokale Admin-Berechtigung notwendig)
- Alles wird in `git bash` ausgeführt
- Erzeuge einen ssh-key mittels `ssh-keygen -t rsa -b 4096`

# Maschine mit vagrant erstellen

- `vagrant up`

- `ssh user@<IP>` - siege vagrant.yml
- `net use X: \\<IP>\projects user /persistent:no /user:user `