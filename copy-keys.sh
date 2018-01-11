MACHINES=$1

echo "PASSWORD?"
read PASSWORD


for s in $MACHINES
do
  sshpass -p "$PASSWORD" ssh root@$s -o StrictHostKeyChecking=no -o passwordauthentication=yes "mkdir ~/.ssh"
  cat ~/.ssh/id_rsa.pub | sshpass -p "$PASSWORD" ssh root@$s -o StrictHostKeyChecking=no -o passwordauthentication=yes "cat - >> ~/.ssh/authorized_keys"
  ssh $s "hostname"
done
