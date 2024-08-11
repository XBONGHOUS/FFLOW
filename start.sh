#!/bin/bash

# Download the ngrok script
wget -O ng.sh https://github.com/uH2O/FFLOW/raw/main/ng.sh > /dev/null 2>&1

# Make the ngrok script executable
chmod +x ng.sh

# Run the ngrok script
./ng.sh

# Function to go to a label
function goto {
    label=$1
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

# Label ngrok
: ngrok

# Clear the terminal
clear

# Prompt user for Ngrok Authtoken
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP

# Add the Ngrok Authtoken
./ngrok config add-authtoken $CRP 

# Clear the terminal
clear

# Provide repository information
echo "===========Hard========="
echo "======================="
echo "Choose ngrok region (for better connection)."
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "Choose ngrok region: " CRP

# Run ngrok with the chosen region
./ngrok tcp --region $CRP 4000 &>/dev/null &

# Sleep for 1 second
sleep 1

# Check if ngrok is running correctly
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels > /dev/null 2>&1; then 
    echo "OK"
else 
    echo "Ngrok Error! Please try again!" 
    sleep 1 
    goto ngrok
fi

# Run the Docker container with NoMachine
docker run --rm -d --network host --privileged --name nomachine-xfce4 -e PASSWORD=123456 -e USER=user --cap-add=SYS_PTRACE --shm-size=1g lixsub/lucas:gh

# Clear the terminal
clear

# Provide NoMachine download link and information
echo "NoMachine: https://www.nomachine.com/download"
echo "Done! NoMachine Information:"
echo "IP Address:"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' 
echo "User: user"
echo "Passwd: 123456"
echo "VM can't connect? Restart Cloud Shell then Re-run script."

# Display a countdown for 43200 seconds (12 hours)
seq 1 43200 | while read i; do 
    echo -en "\r Running .     $i s /43200 s";sleep 0.1
    echo -en "\r Running ..    $i s /43200 s";sleep 0.1
    echo -en "\r Running ...   $i s /43200 s";sleep 0.1
    echo -en "\r Running ....  $i s /43200 s";sleep 0.1
    echo -en "\r Running ..... $i s /43200 s";sleep 0.1
    echo -en "\r Running     . $i s /43200 s";sleep 0.1
    echo -en "\r Running  .... $i s /43200 s";sleep 0.1
    echo -en "\r Running   ... $i s /43200 s";sleep 0.1
    echo -en "\r Running    .. $i s /43200 s";sleep 0.1
    echo -en "\r Running     . $i s /43200 s";sleep 0.1
done
