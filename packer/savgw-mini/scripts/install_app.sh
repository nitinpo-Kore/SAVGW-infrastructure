#!/bin/bash
VERSION=$1
DB_USER=$2
DB_PASS=$3

cd /home/admin
cp /tmp/ecosystem.config.js apps


#Rename of Main WEB page

sed -i 's/jambonz is open source MIT on/Kore.ai /g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/github.com\/jambonz/kore.ai/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/alt="jambonz"/alt="kore"/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/<Icons.GitHub \/>/ /g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/<span>GitHub<\/span>/ /g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx

echo "building savgw-feature-server.."
cd /home/admin/apps/savgw-feature-server && npm ci --unsafe-perm
echo "building fsw-clear-old-calls.."
cd /home/admin/apps/fsw-clear-old-calls && npm ci --unsafe-perm && sudo npm install -g .
echo "building savgw-api-server.."
cd /home/admin/apps/savgw-api-server && npm ci --unsafe-perm
echo "building savgw-webapp.."
cd /home/admin/apps/savgw-webapp && npm ci --unsafe-perm && npm run build
echo "building sbc-sip-sidecar.."
cd /home/admin/apps/sbc-sip-sidecar && npm ci --unsafe-perm
echo "building sbc-inbound.."
cd /home/admin/apps/sbc-inbound  && npm ci --unsafe-perm 
echo "building sbc-outbound.."
cd /home/admin/apps/sbc-outbound && npm ci --unsafe-perm 
echo "building sbc-registrar.."
cd /home/admin/apps/sbc-call-router  && npm ci --unsafe-perm 
echo "building savgw-smpp-esme.."
cd /home/admin/apps/savgw-smpp-esme && npm ci --unsafe-perm
echo "building sbc-rtpengine-sidecar.."
cd /home/admin/apps/sbc-rtpengine-sidecar && npm ci --unsafe-perm 

sudo npm install -g pino-pretty pm2 pm2-logrotate gulp grunt
sudo pm2 install pm2-logrotate

echo "0 *	* * * root    fsw-clear-old-calls --password Samrtassistgw11$ >> /var/log/fsw-clear-old-calls.log 2>&1" | sudo tee -a /etc/crontab
echo "0 1	* * * root    find /tmp -name \"*.mp3\" -mtime +2 -exec rm {} \; > /dev/null 2>&1" | sudo tee -a /etc/crontab

sudo -u admin bash -c "pm2 install pm2-logrotate"
sudo -u admin bash -c "pm2 set pm2-logrotate:max_size 1G"
sudo -u admin bash -c "pm2 set pm2-logrotate:retain 5"
sudo -u admin bash -c "pm2 set pm2-logrotate:compress true"

sudo chown -R admin:admin  /home/admin/apps

sudo rm /home/admin/apps/savgw-webapp/.env



#Copying Kore Logob and TLS config
cp -rvf /tmp/jambonz--light.svg /home/admin/apps/savgw-webapp/dist/svg/jambonz--light.svg
cp -rvf /tmp/korevg.conf /etc/nginx/snippets/korevg.conf

# Copy Certificate file from tmp 
mkdir -p /etc/ssl/private/
cp -rvf /tmp/*.pem /etc/ssl/private/


#Rename of title
sed -i 's/Jambonz/SAVGW/g' /home/admin/apps/savgw-webapp/dist/index.html
sed -i 's/Jambonz/SAVGW/g' /home/admin/apps/savgw-webapp/index.html

sed -i 's/jambonz is open source MIT on/Kore.ai is on/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/github.com\/jambonz/kore.ai/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/alt="jambonz"/alt="kore"/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/GitHub/Kore/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx

