echo PROVISIONIERE TOOLS --------------------------------------------------------------------------

if [ ! -f /usr/local/bin/jq ] ; then 
  curl -sS -o /usr/local/bin/jq --location https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
  chmod +x /usr/local/bin/jq
  echo jq heruntergeladen
else
  echo jq bereits vorhanden
fi


