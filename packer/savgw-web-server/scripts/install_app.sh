#!/bin/bash
VERSION=$1

cd /home/admin/apps
cp /tmp/ecosystem.config.js .

#Rename of Main WEB page

sed -i 's/jambonz is open source MIT on/Kore.ai /g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/github.com\/jambonz/kore.ai/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/alt="jambonz"/alt="kore"/g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/<Icons.GitHub \/>/ /g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx
sed -i 's/<span>GitHub<\/span>/ /g' /home/admin/apps/savgw-webapp/src/containers/login/layout.tsx

#keep kore logo with name jambonz--light.svg
cp -rvf /tmp/jambonz--light.svg /home/admin/apps/savgw-webapp/public/svg/jambonz--light.svg
cp -rvf /tmp/jambonz--light.svg /home/admin//apps/savgw-webapp/public/svg/jambonz.svg
cp -rvf /tmp/favicon.ico /home/admin/apps/savgw-webapp/public/favicon.ico


echo "building savgw-api-server.."
cd /home/admin/apps/savgw-api-server && npm ci
echo "building savgw-webapp.."
cd /home/admin/apps/savgw-webapp && npm ci && npm run build
echo "building public-apps.."
mkdir -p /home/admin/apps/public-apps
cd /home/admin/apps/public-apps && npm install

sudo npm install -g pino-pretty pm2 pm2-logrotate gulp grunt

sudo -u admin bash -c "pm2 install pm2-logrotate"
sudo -u admin bash -c "pm2 set pm2-logrotate:max_size 1G"
sudo -u admin bash -c "pm2 set pm2-logrotate:retain 5"
sudo -u admin bash -c "pm2 set pm2-logrotate:compress true"

sudo chown -R admin:admin  /home/admin/apps

sudo cp /tmp/auto-assign-elastic-ip.sh /usr/local/bin
sudo chmod +x /usr/local/bin/auto-assign-elastic-ip.sh

#Copying Kore TLS config
cp -rvf /tmp/korevg.conf /etc/nginx/snippets/korevg.conf

# Copy Certificate file from tmp 
mkdir -p /etc/ssl/private/
cp -rvf /tmp/*.pem /etc/ssl/private/


#Rename of title and copy logo
sed -i 's/Jambonz Web App/SAVGW Web App/g' /home/admin/apps/savgw-webapp/dist/index.html
sed -i 's/Simple provisioning webapp for jambonz/Simple provisioning webapp for SAVGW/g' /home/admin/apps/savgw-webapp/dist/index.html

#keep kore logo with name jambonz--light.svg
cp -rvf /tmp/jambonz--light.svg /home/admin/apps/savgw-webapp/public/svg/jambonz--light.svg
cp -rvf /tmp/jambonz--light.svg /home/admin//apps/savgw-webapp/public/svg/jambonz.svg
cp -rvf /tmp/favicon.ico /home/admin/apps/savgw-webapp/public/favicon.ico

